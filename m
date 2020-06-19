Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90173C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C3C20776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="kl2ZlXn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgFSBx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgFSBxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:53:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF94C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:53:24 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so3775698pge.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPjvsjb4L/XUk4DOVwf5+goE/PhKwDE2Q9XXqApM3gE=;
        b=kl2ZlXn3hm/jWCOkK+/c4/yU6rt1osi6hbdBD9PsIY0TCyc82pVsciWwLVu4W/b2fc
         SUea1ro4dFO3uW6VBz0McApVjegphmH2ffajl3ouM8Ft/1qoIa539aszdLZyXWk6Obx0
         95/gOm5q4I6Cf6rRbTyPiHkBWH+aEhFID0TLzBDl0aa6VGLWqc5FV19NKz1BzVg1j29A
         Mipk8fdjeej3Z+EKYGiqGNfQwA99JLdogQ9RoqHLICmS++v5lzTavQL4IoEFbjh8jTPn
         eVttfK+MldKECVUfMANymYs/ssjgAAnDsEOI3mEbPD7elZiMiyVWJsqlS63UKm5DGdY2
         2FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ZPjvsjb4L/XUk4DOVwf5+goE/PhKwDE2Q9XXqApM3gE=;
        b=uQOSkKBd4Lno9HPhz8eorvFGvZDCdoPNEHOoNGT+hGtnIP3G95GN9kl4ywp8Iksd2G
         SFz+DtNFBTLZydFvx1PRlk79VJYeYNfVxqew44w6FFf7AzGn1b8X8Y+fAdkYHXfI+Iyz
         MiEWHVbUWBKm9IvrHMzlLH4DCDAHo1JQiPTZpM3mfG2ae4j2jw4v0l6oz7QGP+H4Hr+q
         1t7NzCsv4e+f6HrroWo6DOe5QyNIQ/QOnYbkrjKZQgwJW+Leqgd2MXYvqbm7d9SmbGsl
         vKWM1R00WJsvmlRim50tkpt1zAYxA0zO31XBeq4XKYrEQR/a7LlfaabpxVMfo//myYVU
         QLbg==
X-Gm-Message-State: AOAM530JL8jBTDnHomrnHyEPZBtfXalyCWmJA370XPOzX7e5U/YnJcSd
        ryxI5QQaNZkaihmhiAa6OaJM3BU6D4aigg==
X-Google-Smtp-Source: ABdhPJxKJB5coooxn+ajBp9fp4eq1fOEfzkiahliTn7K1WAiK9Pf+Md0brBXhSbRl/WQAYcYd/UE7g==
X-Received: by 2002:a62:76c5:: with SMTP id r188mr6197043pfc.60.1592531603969;
        Thu, 18 Jun 2020 18:53:23 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p8sm3571243pgs.29.2020.06.18.18.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 18:53:23 -0700 (PDT)
Date:   Thu, 18 Jun 2020 18:53:23 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jun 2020 18:53:21 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Acquire mmap lock before invoking walk_page_range
In-Reply-To: <20200617203732.2076611-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        daniel.m.jordan@oracle.com, linux-riscv@lists.infradead.org,
        walken@google.com, rppt@linux.ibm.com,
        Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>,
        Will Deacon <willdeacon@google.com>
Message-ID: <mhng-c8581870-6152-43a6-9d9f-28a9cc5ce39e@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 13:37:32 PDT (-0700), Atish Patra wrote:
> As per walk_page_range documentation, mmap lock should be acquired by the
> caller before invoking walk_page_range. mmap_assert_locked gets triggered
> without that. The details can be found here.
>
> http://lists.infradead.org/pipermail/linux-riscv/2020-June/010335.html
>
> Fixes: 395a21ff859c(riscv: add ARCH_HAS_SET_DIRECT_MAP support)
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/mm/pageattr.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index ec2c70f84994..289a9a5ea5b5 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -151,6 +151,7 @@ int set_memory_nx(unsigned long addr, int numpages)
>
>  int set_direct_map_invalid_noflush(struct page *page)
>  {
> +	int ret;
>  	unsigned long start = (unsigned long)page_address(page);
>  	unsigned long end = start + PAGE_SIZE;
>  	struct pageattr_masks masks = {
> @@ -158,11 +159,16 @@ int set_direct_map_invalid_noflush(struct page *page)
>  		.clear_mask = __pgprot(_PAGE_PRESENT)
>  	};
>
> -	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
> +	mmap_read_lock(&init_mm);
> +	ret = walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
> +	mmap_read_unlock(&init_mm);
> +
> +	return ret;
>  }
>
>  int set_direct_map_default_noflush(struct page *page)
>  {
> +	int ret;
>  	unsigned long start = (unsigned long)page_address(page);
>  	unsigned long end = start + PAGE_SIZE;
>  	struct pageattr_masks masks = {
> @@ -170,7 +176,11 @@ int set_direct_map_default_noflush(struct page *page)
>  		.clear_mask = __pgprot(0)
>  	};
>
> -	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
> +	mmap_read_lock(&init_mm);
> +	ret = walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
> +	mmap_read_unlock(&init_mm);
> +
> +	return ret;
>  }
>
>  void __kernel_map_pages(struct page *page, int numpages, int enable)

+Will, who pointed out that we could avoid the lock by using apply_page_range.

Given that the bug doesn't reproduce for me, we don't otherwise use
apply_page_range, and the commit is somewhat suspect (I screwed up that PR, and
the original patch mentions avoiding caching invalid states) I'm going to just
take this as is and add it to the list of things to look at.

I've put this on fixes: walk_page_range() directly says you must take the lock
and I don't want to wait for pedantic reasons on a boot issue, even if it's one
that doesn't show up for me.

Thanks!
