Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFA5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A74208FE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vIYTYR0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgGBS5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgGBS5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:57:40 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F8BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 11:57:40 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f2so11654051plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 11:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=hz4Mj/iQWQ1Gm0J6ofti89mpz3pTQ7LpeTX5svYgVDU=;
        b=vIYTYR0m8trV9lrGh8PSvAGnzTxA5G6rFm/vi7ItU7DM4fvPTm/3Rl6ME1n7it2B1M
         T30gPbuZtIE6zll34iGAqLPSdG6bmMkAT7qZrHG23Iy2IrCRlFaNzAsYQxUBUtDS7maR
         lsMpgjIPLbqvPDQlAxBB7JqNjvFBayTSyW6uH39IJTaZMduCtQ7pwgshj2ZogHfR0AYK
         rC+JXeUG8Ftfy0mqFWAjEeGKNCPSA+bU+DULdd9p41k1p8IbO6nixuAiWR3klbBC35vM
         ims47ez4t1jO7VNTh6Q4ji0M92+FQztMbbM3vX5S4RlQYC9J2EyktcqMDI2JKUeROJQS
         ApcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hz4Mj/iQWQ1Gm0J6ofti89mpz3pTQ7LpeTX5svYgVDU=;
        b=cexo+GpSiqeoefb3kboLb2hb20nillkRQrDCwpfCme27gNEkDgj3VeLFkWKXG/iuWs
         /7fqPlagKYu2F4//OCd2MWfbjEO0y/I/iWqWWCeTEKldnBW9kpt3Hj2oR5eK4OnYid0e
         SqJnKw+dA33EPWrog6ynabSKJa/nvhBEAOVrxO3A57kvAaXpu2/xpF2sI6iWtk0zmnPA
         J9dtBJEg0FGAj6GRXGT/ovoejewXWqNvV4G9gT8bGCQaPzrOpU52MDgg4IdcxhgsbjBX
         1maY5a50h3See+hC5KF8sgXST4uwSSXcxPoNKolIGjqUW3VBqqSAVSkO3ehqWjPt+oEl
         a9YQ==
X-Gm-Message-State: AOAM533zJyd4JHBi1N6XfTYdnHMKHcT2Ko1cfzi3EDwaKjBb2QSFORVD
        N8HYA4YyXpbtG8mmVtE62beo5Q==
X-Google-Smtp-Source: ABdhPJy7+DRCrQWC1YEAlkN5Qs9h2rvj2F4QBQqw8k6R6J/7z34EhuVEi87Gs/fBbFtsm5CKS4/LNw==
X-Received: by 2002:a17:90a:f695:: with SMTP id cl21mr35145208pjb.86.1593716260173;
        Thu, 02 Jul 2020 11:57:40 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id c71sm7396890pje.32.2020.07.02.11.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 11:57:39 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Cc:     jianxin.pan@amlogic.com, Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] drm/meson: add support for Amlogic Video FBC
In-Reply-To: <20200702074759.32356-1-narmstrong@baylibre.com>
References: <20200702074759.32356-1-narmstrong@baylibre.com>
Date:   Thu, 02 Jul 2020 11:57:38 -0700
Message-ID: <7himf5iw2l.fsf@baylibre.com>
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
> At least two layout are supported :
> - Basic: composed of a body and a header
> - Scatter: the buffer is filled with a IOMMU scatter table referring
>   to the encoder current memory layout. This mode if more efficient in terms
>   of memory allocation but frames are not dumpable and only valid during until
>   the buffer is freed and back in control of the encoder
>
> At least two options are supported :
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

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
