Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91ABC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995B92067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BfpHJimG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGMTDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgGMTDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:03:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F00FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:03:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 1so6409632pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cxvIt7oMcO1BT79Wsiw8Q1qnT5txfws4FlG9t77T9c0=;
        b=BfpHJimGE7qUmYJVs1EA7aE9Rx33XRBpTkMJ2V1aEgTbAV/h16a2cmRV2CGoHP657N
         qg9OgSyj1sAZVCOFFYipNALOiydy1xPOHjA28ab91/JUvnndU/jNzVXVCtNY4YAyQ8VT
         3ayLxkiHayuJMGBdy6I14+SHaTPyH0bWp/mY7We0iwdqeD5W2BEAJJLCI7YgFJO/QoDO
         EZjlxwQISbYqHHdHzi4kB0MPiEm2cpADsW6j3yAmCMkYZtg2vTy5rsYmLf6GxPfOV3sg
         d7VzCigAdIQ2Upitrm0qFKinv5oiPKUmzHCJi2JrR9ZfFmCGWe3tjbnz9lAsMNqqSEsm
         lUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cxvIt7oMcO1BT79Wsiw8Q1qnT5txfws4FlG9t77T9c0=;
        b=YCUrgUeU+AfKZ4MyAmsEhrZKljnjjnKaWaSriw5QHAymjPtLeMRs5w89klkFFDwvbS
         u4lX9s9NepnvqT0Iigg06g8TafXl1Al0QY5c+o8+13mZjsJmLZb/Jl75n4/W/FBeN6vR
         /Ka1/LK13DZWq2fcc1nEIjW4LTL2KbM8Kb9GL8bY4FLmuvOX2dcrQeyPOKOMUoVj+SBE
         Z5HSC7WKPSTdbc3FTd+jSFDtQ+YDeRqPvJSyRs2Hp4S+IlvittHJXn+Q/RqvSiKgGd6/
         f9r1mcf3a3rhhNZKXwpghgb1vdMNoptIjd3sRKJEx9jlD3FujSrW+uoLAIF8/M3Ear8y
         AOdQ==
X-Gm-Message-State: AOAM533p4+OaTfN65yAYbh+5EiXn6hteEGz86/fRIGYvi20Oqi0SUCvV
        g/K0mkd/NuLQPgW/bJgIpEElUgCprGVOXg==
X-Google-Smtp-Source: ABdhPJzkZfffeazfxUUKT/KX5KVZg/NU11I6xsUM7dCUL1k/5c+oHCs7ac26AzXT3No02tfuMMAdOg==
X-Received: by 2002:a65:6448:: with SMTP id s8mr416300pgv.405.1594667017044;
        Mon, 13 Jul 2020 12:03:37 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id w1sm14553021pfq.53.2020.07.13.12.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:03:36 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch
Subject: Re: [PATCH v2] arm64: dts: amlogic: Add the Ethernet "timing-adjustment" clock
Date:   Mon, 13 Jul 2020 12:03:32 -0700
Message-Id: <159466696386.22745.2608870599482313734.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200620162347.26159-1-martin.blumenstingl@googlemail.com>
References: <20200620162347.26159-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jun 2020 18:23:47 +0200, Martin Blumenstingl wrote:
> Add the "timing-adjustment" clock now that we know how it is connected
> to the PRG_ETHERNET registers. It is used internally to generate the
> RGMII RX delay on the MAC side (if needed).

Applied, thanks!

[1/1] arm64: dts: amlogic: Add the Ethernet "timing-adjustment" clock
      (no commit info)

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
