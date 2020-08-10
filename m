Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6A1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DBE1206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Q7MSp+6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHJWSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHJWSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:18:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148AAC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 15:18:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 2so810547pjx.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vBIQCcYBYKE0CK0O3JpZQF/aDW336DAnKM6R6BbGj7s=;
        b=Q7MSp+6ZeJHNiLkPjUGr27POOQJapymBm+bWfnrg7JjPU2IOhuG0rjzJcgwrsnCZf3
         o7kRE3EtutAIoom++pDXYgEYbAVTHvEyyn5iZE0qpifrLum2nytjCPfGafkpr4PbKYMQ
         ET/ILf4IJcGITVrOeX/FDpL5yRVQ+q5n3YBHvwSoeWBVXyspmmizhpw0BIg6Kbr244es
         4L9fzG2DiJaVNQcS42UsP7ZFm3meuelftPbhw8Fk1HkxIXdGcU4Fx+mwaX/OhMdxoK8s
         0QgsZI3jOolUvzXWqpQLFXcMDDAVnfWs9LWtuagyzEL3NqIv6VFeEQhjR7ZjuUDMEFVn
         VRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vBIQCcYBYKE0CK0O3JpZQF/aDW336DAnKM6R6BbGj7s=;
        b=Y1y6V4ucWwJSpZeHdWngvVA4Wn9i2ToTuL5/32aNdhMskEBTLjZ1g4fmt6t+8VRsT6
         pY9gcZLiUYrqcM22fnPimYmcB1vCTn7lk3F5nbIrO0YXqeVA5gttEz8GA7MkdmVIiOPg
         t1SPCAeIXK0Walrau1jsLO4oZ9Ct74xLby9ZleCSMmAAiE1+XCtqQX+qI67XCck6lUeN
         tBYZnnhHkDdj60lZCAKJTXBZ3MTWBqkKxZNczh0Ecjj5JN/M5ZH4JnjqpTznpVYv3UYE
         JyFjr1rkKF4gP+97HfCef59Hb0JIEcvfUW8cCL6uiRnERDSemLWIqXpWpNEKiliyVOUf
         Eomg==
X-Gm-Message-State: AOAM533ukTOWMlojTBgLCtwPJzuzb1stt6CZgXTRErdx5gBmJemx9nHl
        sRT63tbUqb1kqb0iEAseK+9ywDHV77g=
X-Google-Smtp-Source: ABdhPJwsV7V0NSLQKQ7xjhZ4JJpUKz4dZj+ie2tUgdeIEyL7BWjueK/+zdWZ27iCa1NMdqyQ4rhkcQ==
X-Received: by 2002:a17:902:ac82:: with SMTP id h2mr26126281plr.300.1597097881464;
        Mon, 10 Aug 2020 15:18:01 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 63sm22311820pfu.196.2020.08.10.15.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:18:00 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64: dts: meson: odroid-n2: update sound card
Date:   Mon, 10 Aug 2020 15:17:58 -0700
Message-Id: <159709786936.10576.16096406991867503196.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701094556.194498-1-jbrunet@baylibre.com>
References: <20200701094556.194498-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 11:45:54 +0200, Jerome Brunet wrote:
> This patchset adds the support for the TDM loopback and audio on the jack
> output using the internal codec.
> 
> Jerome Brunet (2):
>   arm64: dts: meson: odroid-n2: enable audio loopback
>   arm64: dts: meson: odroid-n2: add jack audio output support
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: meson: odroid-n2: enable audio loopback
      (no commit info)
[2/2] arm64: dts: meson: odroid-n2: add jack audio output support
      (no commit info)

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
