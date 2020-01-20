Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D3FC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766822087E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579518857;
	bh=LjeqDYVVlFwt7OVCzrKj82V2lifqHq/YU2Jo/WgiTbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kF+8o5M0ZpztygxvX8RVEAj7JRQEc85ShA6ZmNnYrMsq7lnCgki/F4YMc2rFj5/Qk
	 xeMP5+/Lf6r7AHuQynMCw5e+OITxqOzlwB5+mKcL3Wy0BiI9DlWrxCtg+3V/e06rp7
	 K+TiX9FIQ2oHjxuqTK5TtdHFXwfbOp9dq3wYBxVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgATLOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:14:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56233 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgATLOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:14:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so14041827wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 03:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WTrlGhs59LAijTepaX8teYcfP4R2wr8PKeRF3cIoZ0k=;
        b=JgNLtcTUNsevH3Sr+vS8BrdFWuCiMHoPjCD2qP7Xj7xZDDNgE/ijDrW6ty3mlK8FKR
         W2+Vy4sbdWNr8vo0+uT9ULmBRk2m9OGwGoXtQHbSDoxQ6SgZKjVVWk3XgnSzy1+FOT88
         D9qyOclCJs7z19NUJ4erMz+hYGRQQeGdS9R8UZBxx55/1cvNsiFMIlFaY+RCKbYcCzvE
         PU+UPjGevuPHQspBeFT8N0tLHkVEpucDyMDwjmJctohv2oApC5qpusEwfp8oKXnrGSVu
         51IYYF9Twm1/BRkTlwmeS2yNqR3doOho5Q55f2QbyX4zo5pxcfPZ07N4w9UzuHTurf6y
         ZztA==
X-Gm-Message-State: APjAAAWUwdt0R+GXZAifkof77GpqNT2vxU9qeYKT9MnHHn9vg98c4VYF
        AOn3AY6yiIWu5ta6hgI9RTY=
X-Google-Smtp-Source: APXvYqxsxF2pkFMlDoibbwLhvA/mXy9eZXBCy9GDircNX9HUt/S5dO7+aPEtBqLj6E+TwiyjeuMmhQ==
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr17916690wml.28.1579518854095;
        Mon, 20 Jan 2020 03:14:14 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id u84sm75872wmg.10.2020.01.20.03.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 03:14:13 -0800 (PST)
Date:   Mon, 20 Jan 2020 12:14:11 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Axtens <dja@axtens.net>
Cc:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 4/5] [VERY RFC] mm: kmalloc(_node): return NULL
 immediately for SIZE_MAX
Message-ID: <20200120111411.GX18451@dhcp22.suse.cz>
References: <20200120074344.504-1-dja@axtens.net>
 <20200120074344.504-5-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200120074344.504-5-dja@axtens.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-01-20 18:43:43, Daniel Axtens wrote:
> kmalloc is sometimes compiled with an size that at compile time may be
> equal to SIZE_MAX.
> 
> For example, struct_size(struct, array member, array elements) returns the
> size of a structure that has an array as the last element, containing a
> given number of elements, or SIZE_MAX on overflow.
> 
> However, struct_size operates in (arguably) unintuitive ways at compile time.
> Consider the following snippet:
> 
> struct foo {
> 	int a;
> 	int b[0];
> };
> 
> struct foo *alloc_foo(int elems)
> {
> 	struct foo *result;
> 	size_t size = struct_size(result, b, elems);
> 	if (__builtin_constant_p(size)) {
> 		BUILD_BUG_ON(size == SIZE_MAX);
> 	}
> 	result = kmalloc(size, GFP_KERNEL);
> 	return result;
> }
> 
> I expected that size would only be constant if alloc_foo() was called
> within that translation unit with a constant number of elements, and the
> compiler had decided to inline it. I'd therefore expect that 'size' is only
> SIZE_MAX if the constant provided was a huge number.
> 
> However, instead, this function hits the BUILD_BUG_ON, even if never
> called.
> 
> include/linux/compiler.h:394:38: error: call to ‘__compiletime_assert_32’ declared with attribute error: BUILD_BUG_ON failed: size == SIZE_MAX

This sounds more like a bug to me. Have you tried to talk to compiler
guys?

> This is with gcc 9.2.1, and I've also observed it with an gcc 8 series
> compiler.
> 
> My best explanation of this is:
> 
>  - elems is a signed int, so a small negative number will become a very
>    large unsigned number when cast to a size_t, leading to overflow.
> 
>  - Then, the only way in which size can be a constant is if we hit the
>    overflow case, in which 'size' will be 'SIZE_MAX'.
> 
>  - So the compiler takes that value into the body of the if statement and
>    blows up.
> 
> But I could be totally wrong.
> 
> Anyway, this is relevant to slab.h because kmalloc() and kmalloc_node()
> check if the supplied size is a constant and take a faster path if so. A
> number of callers of those functions use struct_size to determine the size
> of a memory allocation. Therefore, at compile time, those functions will go
> down the constant path, specialising for the overflow case.
> 
> When my next patch is applied, gcc will then throw a warning any time
> kmalloc_large could be called with a SIZE_MAX size, as gcc deems SIZE_MAX
> to be too big an allocation.
> 
> So, make functions that check __builtin_constant_p check also against
> SIZE_MAX in the constant path, and immediately return NULL if we hit it.

I am not sure I am happy about an additional conditional path in the hot
path of the allocator. Especially when we already have a check for
KMALLOC_MAX_CACHE_SIZE.
-- 
Michal Hocko
SUSE Labs
