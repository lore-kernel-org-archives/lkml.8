Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E0AC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0161214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="NU7TC4TH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgCEA5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 19:57:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39698 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgCEA5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 19:57:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id j20so1446086pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 16:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=u1LASJZHEVADOcgCDErgATidiR4fKstgpk4kWwW4dDc=;
        b=NU7TC4THpMmt27fu9J0XRc2lkNgYkkyprlqOo+Zx0eGQ+wbNpGEHaXLxzKsgJoiBeY
         AvZbKO2rU0wTRPymd2zNp5FPtFqcx/mz8qAvmx8tO70Aw3LEXkNJSxGHWxTbEAV20bcq
         NeYR+BfL2WV5Y8QtzZb6H++oNqWCgbLdO3bQ4utNTY9pnovDuExJdkZGLif2VPnTdHXn
         brdvf+hIi6q5I6+WZtf+T4KtEKj0/+YiKzy7eOOOS0ZLvKfel4wnKNkVIUsYA1nYBv4w
         bjoJJqcel0FVm/FoUC+bqSyUsxAEEygbFYZeM0swufJ1JY0xGjOlV1iwBu1Xpi01MmSv
         Rcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=u1LASJZHEVADOcgCDErgATidiR4fKstgpk4kWwW4dDc=;
        b=UHOOL1h8DEQmOEXxh+G97eKOa7dUsXEol4EPQjrgYEKGFZTE6LN4XpEgLMokTJ5Qim
         tO5ki2gH/AWHR/XHDV5zyQ4GDafqG6fzTvaK2A0OzQAqATyf1LwDVwOaPIWhy29abPSI
         +gnObOQDY5AZFtoa7kGazC4MpgDee59on5l5gmrNrvvpHBf2HS9WlQoRs0x+jz0va72u
         zRNqgetye5EnBA2Oj5jecEIcHqKQ/i2c/l90hJ3+gP+8GvsjZ+ORIqRk9uVVlghNRZIX
         IwK/6EoSyun8hNV8yLv93Xd5rNsqXtsVAqFAbTTKXod3GXVGAC0o852M5H7LLXQ69XHF
         FOug==
X-Gm-Message-State: ANhLgQ0HFEmiix/zFNQzy/tXBKnzglNklplfBcg0aX9vC8hyI3cmC9Pi
        L2L9IAX/dY22rBpenjtYxrQAMQ==
X-Google-Smtp-Source: ADFU+vverMZoqPuEecOMVFwavY2c+li6RNYIA+/Iy1kyOle4EI+6N0/Ipmcoo8ibuRSPUPD2jyUjLQ==
X-Received: by 2002:a17:902:7796:: with SMTP id o22mr5305888pll.315.1583369867017;
        Wed, 04 Mar 2020 16:57:47 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id v123sm2738273pfb.85.2020.03.04.16.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 16:57:45 -0800 (PST)
Date:   Wed, 04 Mar 2020 16:57:45 -0800 (PST)
X-Google-Original-Date: Wed, 04 Mar 2020 16:34:28 PST (-0800)
Subject:     Re: [PATCH 3/8] riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
In-Reply-To: <20200217083223.2011-4-zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-d2350cb4-e02f-4ee4-b093-6020e7a3d1bb@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 00:32:18 PST (-0800), zong.li@sifive.com wrote:
> ARCH_SUPPORTS_DEBUG_PAGEALLOC provides a hook to map and unmap
> pages for debugging purposes. Implement the __kernel_map_pages
> functions to fill the poison pattern.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/Kconfig       |  3 +++
>  arch/riscv/mm/pageattr.c | 13 +++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 07bf1a7c0dd2..f524d7e60648 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -132,6 +132,9 @@ config ARCH_SELECT_MEMORY_MODEL
>  config ARCH_WANT_GENERAL_HUGETLB
>  	def_bool y
>
> +config ARCH_SUPPORTS_DEBUG_PAGEALLOC
> +	def_bool y
> +
>  config SYS_SUPPORTS_HUGETLBFS
>  	def_bool y
>
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 7be6cd67e2ef..728759eb530a 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -172,3 +172,16 @@ int set_direct_map_default_noflush(struct page *page)
>
>  	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
>  }
> +
> +void __kernel_map_pages(struct page *page, int numpages, int enable)
> +{
> +	if (!debug_pagealloc_enabled())
> +		return;
> +
> +	if (enable)
> +		__set_memory((unsigned long)page_address(page), numpages,
> +			     __pgprot(_PAGE_PRESENT), __pgprot(0));
> +	else
> +		__set_memory((unsigned long)page_address(page), numpages,
> +			     __pgprot(0), __pgprot(_PAGE_PRESENT));
> +}

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
