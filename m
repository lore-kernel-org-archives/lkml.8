Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAAFC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA4324677
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OjKh2HhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgB2Rs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 12:48:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35451 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgB2Rs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 12:48:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id r7so7305974wro.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 09:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ZayidFagez4Iqa0WdVqRCWWZUtND8cC6eqziUqJZJmc=;
        b=OjKh2HhHMq2rTYWzUbngs+vFkLG8b+mFteGPKRXj2T8+FCtDHOA9t7CIjqNkjDZdeZ
         J07gdZyMgyYsznuhl2xtq/NVdZ+MyiJYAhmSRgna9zX3H3BvHPGBWZ8wXfYycucO0Rfj
         jcpZWPfDNgA90xVKnKhXSZYmyQE/3K3WUFYEEXgxYxnIZ0HlOvnPryPXYGDgCZxNP0Nh
         tczhsu1tS3+nqYUYdVsFO3Oxnrcol4gZHAD2WnVQeqd9KPCkNehArtGUPigj3vF2lP42
         S3w5Ljjrs8HQARR/kpkYS4DwmnV5/9GTV12D9PpvthiFxPp0Z0gPfzfStH5gbS7iSOe7
         5GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZayidFagez4Iqa0WdVqRCWWZUtND8cC6eqziUqJZJmc=;
        b=TOOJ565cL5bLDFJo1/BNSPmJ1MJsIXXxwbYdQoydwap5JXDlTNmue02C8O7KNBH+ye
         VcfqdyXY8FDlLOI1oxRBONjgDTXu8IyytqX3hRSb/Nf1ZtQt3DTwWrlhMULcH4aRHoi0
         DGiOntedTc0TDnfx9fnktl/PusbY5+tt/LpKfKRcAjVwC+G+/GAfpU8Uu+NMa0CsYFAP
         gLgRyunsSnYzbWOIZnu8BLYNTa7nF5ezw99IAgeyJLmZzMOKEHVyzzWFLj181vlPZdxS
         7YLjCKmTVMu+i7V9Xc85KrFwfV+5AtUEw9b7MQr8Nf/E3RDNNgl8uQG+xJhrahAHth0A
         glZw==
X-Gm-Message-State: APjAAAXpHSFIC26qobPJpHHyGbj7VtuJcNmcSRIz/brWCkwkRDcrMJaK
        IhS90gd4XOyDwKnlkRjgtn50Cg==
X-Google-Smtp-Source: APXvYqzwdRDHCo+JK9WoMEpBpcMTaJ8faVAZvaZz5Q4T5r9MrCA1hC6MCXi/+N36SnaRFlbwkEMtXw==
X-Received: by 2002:adf:ed84:: with SMTP id c4mr11380334wro.24.1582998536137;
        Sat, 29 Feb 2020 09:48:56 -0800 (PST)
Received: from localhost (229.3.136.88.rev.sfr.net. [88.136.3.229])
        by smtp.gmail.com with ESMTPSA id r19sm2154532wmh.26.2020.02.29.09.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 09:48:55 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Art Nikpal <email2tema@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: fix gxm-khadas-vim2 wifi
In-Reply-To: <1582212790-11402-1-git-send-email-christianshewitt@gmail.com>
References: <1582212790-11402-1-git-send-email-christianshewitt@gmail.com>
Date:   Sat, 29 Feb 2020 18:48:54 +0100
Message-ID: <7htv399tdl.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> Fixes: adc52bf7ef16 ("arm64: dts: meson: fix mmc v2 chips max frequencies")

nit: Fixes tag should go at the end with the other trailers (see "git
interpret-trailers ")

I'll fix thet up when applying.

> before
>
> [6.418252] brcmfmac: F1 signature read @0x18000000=0x17224356
> [6.435663] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4356-sdio for chip BCM4356/2
> [6.551259] brcmfmac: brcmf_sdiod_ramrw: membytes transfer failed
> [6.551275] brcmfmac: brcmf_sdio_verifymemory: error -84 on reading 2048 membytes at 0x00184000
> [6.551352] brcmfmac: brcmf_sdio_download_firmware: dongle image file download failed
>
> after
>
> [6.657165] brcmfmac: F1 signature read @0x18000000=0x17224356
> [6.660807] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4356-sdio for chip BCM4356/2
> [6.918643] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4356-sdio for chip BCM4356/2
> [6.918734] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may have limited channels available
> [6.922724] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4356/2 wl0: Jun 16 2015 14:25:06 version 7.35.184.r1 (TOB) (r559293) FWID 01-b22ae69c
>
> Suggested-by: Art Nikpal <email2tema@gmail.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Queued as a fix for v5.6,

Thanks,

Kevin
