Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8653C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F5420826
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="blOTHPml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgETAHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgETAHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:07:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9C1C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:07:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k22so579117pls.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B1c0jUXz486+RagbFwDxd+sCq0lsYsmvP2f98G6U3js=;
        b=blOTHPmlZx4GfKOEV01mwt1fb2y8BBOOyMdVTyMjtZX92rrDcpb80U2b7a2VVbC7fk
         3h9M1dtqhrTXK3/nedw7/rkc/XiMNe0BCyBwr2xa2ohQ4Ke0D7JYYdEu/WN4Qhf6TXS4
         jV6rk/VqZJCTP8sxaPzJZrWS4mUGgwBCXhuhaFARh9vVb6ORLbtqYI+p7C6vxxSolo7z
         F6s6XDCfwfwNI7ZD24RYmSZYGggfpEVV2UEQ8wLidhB7yWOCnh9Gn5TRrTV4xjv3NBc/
         K2JtUu5z5vj30NuPBBijpYQCnGhQgnW5OZD9OpQCLhE5dMR9gek9vc/p5aC0CVtCe5AE
         8EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1c0jUXz486+RagbFwDxd+sCq0lsYsmvP2f98G6U3js=;
        b=cMvvtk6k7PAUGVz+kE2SlIU9YoZyNjoY1c6CaDIMAMBtO8DuBCwlR5cuj7mWG42gNi
         8AI2FR5J5O4UQKV2RRzgfC3lDh8+ntH8oNDzxOhtsbLWefJexZZTqnf5kck8qiaxR1jN
         SktzeBWSos9TuuyuxJMVirb1c8KuHQIQmEGTGmz2Wl0q8vvgXfgcxbWqMIFJCv+wMZcy
         CEav/XuO0lnF0Ba0dxoFRrY82FpzvrX2W+K+f0H/KrIgDkh4v/hTvgSFyVg9olTo9drz
         yS66D31oLrZUnnalRBJ7DsK8jPm/d9YYuWjYBX669ssKxHO8fcrnxzS6ugvC+89Cod9x
         V/TA==
X-Gm-Message-State: AOAM5315a5WDd68GllVyewrKC39kEusFy2wu3MZdnr+c4qmpiJVwbkCg
        U3zP9X8xkN+obillgujG8EpIYA==
X-Google-Smtp-Source: ABdhPJwRg3C6e5l8lZIpfVpBtp8Q15l/WvuHFOKB6j8KRjl0PT2Y5zYN0N3CqoydGjhxrt37hyXpGw==
X-Received: by 2002:a17:90b:3118:: with SMTP id gc24mr2074289pjb.41.1589933269389;
        Tue, 19 May 2020 17:07:49 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id z13sm517136pjz.42.2020.05.19.17.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 17:07:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: add ethernet interrupt to wetek dtsi
Date:   Tue, 19 May 2020 17:07:43 -0700
Message-Id: <158993320300.34448.14097191629208785856.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518025451.16401-1-christianshewitt@gmail.com>
References: <20200518025451.16401-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 02:54:51 +0000, Christian Hewitt wrote:
> Add Ethernet interrupt details to the WeTek Hub/Play2 dtsi to resolve
> an issue with Ethernet probing in mainline u-boot.

Applied, thanks!

[1/1] arm64: dts: meson: add ethernet interrupt to wetek dtsi
      commit: 647e1643d61312ce08172e466fa1c8d8a5c8fbc8

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
