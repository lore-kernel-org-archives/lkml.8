Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18316C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4DB72078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NiEZq/uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbgFIOy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbgFIOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:54:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74085C03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 07:54:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h5so21673114wrc.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 07:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=gejxJi50IAlBWLUl0QwogqgVYpxXpSQbraYHpVsLRqw=;
        b=NiEZq/ukPyXU22K7LVp0m+r0RSMtNOwTqKt6aP1iSq0smXw4wcda1UFih4tdLiJpOV
         njmkzC6jYqVbBJcMmPlUuYcjd4O1KZtnUYl3FTNu3b0H5sEJzXEF8hkH0aH+CxMFaXTF
         m0iEsiqvFbVJ8Cav0uoTsbAk1t062PDuF37egpU9e6kx4QM4qF71J4wfHXC6G1ROxxRY
         JMs5QOxV4WFTAtQiEra3rsosSlJqi2YwDqpgjga+JgAKlk5SFrztqT2zf6hhcMMJ/o9W
         /99JDMGh3FZ/6WjPNINfrDjPPyvsEocvbA7qE1JmjjQz6h3l0iJp3NLXfrP9gD134TtP
         tpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gejxJi50IAlBWLUl0QwogqgVYpxXpSQbraYHpVsLRqw=;
        b=Jq9G3t3WlJMeHCDtOjuKJQshon7rfSXBr1xMYo6xWlzAO8Va2pQ1SMevSugwaPorHp
         8MVyymag3Jxp4ejejggwioeHuSYzvEq0/7S1nQLYKqSvqGT44jDlCVNDv4LKATTN1nib
         etqRFCiw7pkYIIGdqMRvHLsdV959ubBehQ5poNArPWETE3Wv48lUw92F0zuMIvkm9pGL
         1rWp7G0DsXzfsqZkdCGPP5qL5ECU/+ufTlbvSSdx5P9aNFU5HmZ61aUwXvxGq39UDmIq
         Ryi0EZjVnvY1lOV8F9Jf1V09rdM1lnX4etQCXPzb7V77jH/Ul0EQEQC6QF19J9jw7VKd
         18Iw==
X-Gm-Message-State: AOAM532HTynXNlPCh7Htg3KCH12kxBXyuROGN3nqAP1bMzh7EMqYMeAX
        iUe9UNLNjA9MEC0eWgCaqUhlJA==
X-Google-Smtp-Source: ABdhPJx0g0ITtVIgCVlfIpmzgRxBsMtKoHziqrcBUDg+BtiyrsHIhGb+DPpRsoxOg3ZMlcgjF7+SZw==
X-Received: by 2002:adf:9481:: with SMTP id 1mr4875326wrr.396.1591714463791;
        Tue, 09 Jun 2020 07:54:23 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id f185sm3241153wmf.43.2020.06.09.07.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 07:54:23 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Art Nikpal <art@khadas.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: limit segments to 1 when dram-access-quirk is needed
In-Reply-To: <20200608084458.32014-1-narmstrong@baylibre.com>
References: <20200608084458.32014-1-narmstrong@baylibre.com>
Date:   Tue, 09 Jun 2020 07:54:20 -0700
Message-ID: <7hmu5cguhv.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The actual max_segs computation leads to failure while using the broadcom
> sdio brcmfmac/bcmsdh driver, since the driver tries to make usage of scatter
> gather.
>
> But with the dram-access-quirk we use a 1,5K SRAM bounce buffer, and the
> max_segs current value of 3 leads to max transfers to 4,5k, which doesn't work.
>
> This patch sets max_segs to 1 to better describe the hardware limitation,
> and fix the SDIO functionnality with the brcmfmac/bcmsdh driver on Amlogic
> G12A/G12B SoCs on boards like SEI510 or Khadas VIM3.
>
> Reported-by: Art Nikpal <art@khadas.com>
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Fixes: acdc8e71d9bb ("mmc: meson-gx: add dram-access-quirk")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
