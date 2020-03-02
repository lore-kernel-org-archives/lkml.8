Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6071C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F6421556
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="B3X4puU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCBQZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:25:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44310 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgCBQZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:25:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id n7so418193wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 08:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DQCMbgMMKN4eMeJGo0Sh2/wZnBo8vQSRKLHwF2vzE7s=;
        b=B3X4puU1y9SmFMshbChsRmChUOK2azMe71Z6UNk1N9NDl6tMQa4PSHNF+osdrbJXHY
         wLD5KwG64BeOrgSRYxi/KRY7U9Nl6yD/Zqy1LV1yjLeKSQ+bQwT1O3spYrzbqA14zOpC
         WAI4GQmlEl4Wc5tpIjvpyTrGtZPFv/wxLch4Pr4Iq9Y5B2m+40bqPAz/0xfJyeRemzj7
         0GxWPqrZ0yjWODLO4bwgMiDbhJVSzI1HoZ1lMeY9rrvi2XBUarq7sSV0loFlK0iPK3c3
         dnIpKxLpNYJ2D99tIj2D/1HpIPR1RFvDWajdRmPOKU0UpLGNxs+OwFbatGARS0xCNo/O
         SA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DQCMbgMMKN4eMeJGo0Sh2/wZnBo8vQSRKLHwF2vzE7s=;
        b=e9ouYt5ghnWgUWmSnsmpUnZJR7LRsYAxCxyttxEcFk58LSBuV3RzDryHlQTv61j6Eg
         OJ37lF2vwbF9o2S81AR5lT8ZzceFoybchs+4qs1idE4KQsGD1rnjU6HUsWTnTIveTCfV
         YvJ8KxBf3v8TC67kpIsBD2aRLcYESylZSBXE1gt3tZ+8st81CVBvTn0lLd75ZLdw0ne5
         qQ1kOpcQwLNllpskigFdfi6kPiyHwxvfc091KspUVqM1tIQUZ6J9u8k5SzSFK+B6oe6/
         YbFFNcs7omdZnywKqllO4Tc8qPry6AJi4aGXLBPQ1RmK7tONKLTm3W93fHQ6lV+TsmUh
         btDw==
X-Gm-Message-State: ANhLgQ2Ni36n1wNJGCct8LflF9MmAG3ylaTeuvk6MQMwNiR0AwWExZdA
        mBhPaYdJr3DMcSBYYwN+sFbJGw==
X-Google-Smtp-Source: ADFU+vtZgwQFqSgV0Xi9k1YUBkP5b4vDb2TY6yuZe1HN/vcyZrgyFl5FHMyu4impez0lXe+ojRP0RA==
X-Received: by 2002:a05:6000:149:: with SMTP id r9mr335199wrx.147.1583166308694;
        Mon, 02 Mar 2020 08:25:08 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k7sm15851605wmi.19.2020.03.02.08.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 08:25:08 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] drm/meson: add support for Amlogic Video FBC
In-Reply-To: <20200220162758.13524-1-narmstrong@baylibre.com>
References: <20200220162758.13524-1-narmstrong@baylibre.com>
Date:   Mon, 02 Mar 2020 17:25:06 +0100
Message-ID: <7hy2sirafx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Amlogic uses a proprietary lossless image compression protocol and format
> for their hardware video codec accelerators, either video decoders or
> video input encoders.
>
> It considerably reduces memory bandwidth while writing and reading
> frames in memory.
>
> The underlying storage is considered to be 3 components, 8bit or 10-bit
> per component, YCbCr 420, single plane :
> - DRM_FORMAT_YUV420_8BIT
> - DRM_FORMAT_YUV420_10BIT
>
> This modifier will be notably added to DMA-BUF frames imported from the V4L2
> Amlogic VDEC decoder.
>
> At least two options are supported :
> - Scatter mode: the buffer is filled with a IOMMU scatter table referring
>   to the encoder current memory layout. This mode if more efficient in terms
>   of memory allocation but frames are not dumpable and only valid during until
>   the buffer is freed and back in control of the encoder
> - Memory saving: when the pixel bpp is 8b, the size of the superblock can
>   be reduced, thus saving memory.
>
> This serie adds the missing register, updated the FBC decoder registers
> content to be committed by the crtc code.
>
> The Amlogic FBC has been tested with compressed content from the Amlogic
> HW VP9 decoder on S905X (GXL), S905D2 (G12A) and S905X3 (SM1) in 8bit
> (Scatter+Mem Saving on G12A/SM1, Mem Saving on GXL) and 10bit
> (Scatter on G12A/SM1, default on GXL).
>
> It's expected to work as-is on GXM and G12B SoCs.

Tested on meson-sm1-sei610 with 4k@60p (VP9) streams.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
