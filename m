Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960A5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642BC204EA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dKwb8xqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHXUhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXUg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:36:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFB4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 13:36:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id t9so1365794pfq.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 13:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=1KJJoI/nvslv9Gkh89DSDDuviv25t/TeB8gsOO3usDU=;
        b=dKwb8xqaWv5UZ7fpuIXA4NK3AbY3BNKNsCYxa4If/n9+18e6JlHkcck57uguVdS27N
         a2eEO9eATvS0aT06XaLk5j+7+0yl7lw1zcCdq8mwEDbhhrYQ00fdSZTZIhElahL+QC3y
         jLmX+X/A6QjlelCcCHWbn9GlBDUOr8ltSJKXUsnK6qKgBxJ0ti8i428XAJefDDdWh1oM
         LJ850oiIELLwrV8nqVsmpsf7JH0gedYfL3LZwthbQUOw18SrJsE5ke77BPQgrgEfaW24
         169q5TA6ocTCDnmewjw08xEjJvhgUs8aMJqZtf+L9wSOhXpQ/FMTg6C7wFVyt1lOzPJA
         oAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1KJJoI/nvslv9Gkh89DSDDuviv25t/TeB8gsOO3usDU=;
        b=CE5r7YeuoAhWlrxn9qiakHWMjy0VcUNPhtkhDPayhDTWqAhLxe3HZV699l796jySUF
         uYNgey8BAsVzCKoyYIhY6jpx3C+fn9malnnLs7IruZpvAu80O2DNv4QsQkRgnbBNSo3d
         +9QZfnul6OvQ7pTOefnGzohnK3YgPgcxbofL9JudXnK+l3n6O8xJhYQ/wY1GWj5pxNFq
         5yqceA/XfttOgf8MrVjhNxewnIgZRshdKVtdQeK6WwpZuXEuG0pI8FZZkMrXglCSCfIi
         EiPYUkV9uUN/70T/AwnNx47opgqlm9CSiPusFylRbtaI2dPJqc8vB2fF9IuetD5Yhqvk
         6bnw==
X-Gm-Message-State: AOAM531D3CAPzxiolhp6GP9vgPYRvWvKrIjEHLcOQh7IOnTk39dlIipe
        qMRUA8aSPi5vyvfrZp0fLMzhug==
X-Google-Smtp-Source: ABdhPJy2Xb5XpgDAC7S92NKuMLFb8qEH8tHvI4xQ2pB0Pt7gkAmYfk0h0dNLVPyr37j4PQLShYUCYg==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14mr1318808plo.42.1598301418731;
        Mon, 24 Aug 2020 13:36:58 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id v2sm5518805pfn.116.2020.08.24.13.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 13:36:58 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>
Subject: Re: [PATCH RESEND v1] ARM: dts: meson8: remove two invalid interrupt lines from the GPU node
In-Reply-To: <20200815181957.408649-1-martin.blumenstingl@googlemail.com>
References: <20200815181957.408649-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 24 Aug 2020 13:36:57 -0700
Message-ID: <7himd7u6fq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> The 3.10 vendor kernel defines the following GPU 20 interrupt lines:
>   #define INT_MALI_GP                 AM_IRQ(160)
>   #define INT_MALI_GP_MMU             AM_IRQ(161)
>   #define INT_MALI_PP                 AM_IRQ(162)
>   #define INT_MALI_PMU                AM_IRQ(163)
>   #define INT_MALI_PP0                AM_IRQ(164)
>   #define INT_MALI_PP0_MMU            AM_IRQ(165)
>   #define INT_MALI_PP1                AM_IRQ(166)
>   #define INT_MALI_PP1_MMU            AM_IRQ(167)
>   #define INT_MALI_PP2                AM_IRQ(168)
>   #define INT_MALI_PP2_MMU            AM_IRQ(169)
>   #define INT_MALI_PP3                AM_IRQ(170)
>   #define INT_MALI_PP3_MMU            AM_IRQ(171)
>   #define INT_MALI_PP4                AM_IRQ(172)
>   #define INT_MALI_PP4_MMU            AM_IRQ(173)
>   #define INT_MALI_PP5                AM_IRQ(174)
>   #define INT_MALI_PP5_MMU            AM_IRQ(175)
>   #define INT_MALI_PP6                AM_IRQ(176)
>   #define INT_MALI_PP6_MMU            AM_IRQ(177)
>   #define INT_MALI_PP7                AM_IRQ(178)
>   #define INT_MALI_PP7_MMU            AM_IRQ(179)
>
> However, the driver from the 3.10 vendor kernel does not use the
> following four interrupt lines:
> - INT_MALI_PP3
> - INT_MALI_PP3_MMU
> - INT_MALI_PP7
> - INT_MALI_PP7_MMU
>
> Drop the "pp3" and "ppmmu3" interrupt lines. This is also important
> because there is no matching entry in interrupt-names for it (meaning
> the "pp2" interrupt is actually assigned to the "pp3" interrupt line).
>
> Fixes: 7d3f6b536e72c9 ("ARM: dts: meson8: add the Mali-450 MP6 GPU")
> Reported-by: Thomas Graichen <thomas.graichen@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> re-send of v1 from [0] because it was never picked up

Oops, sorry this fell through the cracks.  Now Queued for v5.9-rc1.

Kevin
