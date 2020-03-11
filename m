Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56476C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D12120758
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583969885;
	bh=tYse/b2VgvRrHBIlQlCMRUOHJDMPsP7MDl/1tT5CHKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QEewpgYvJdBVt8zQYpivnufzYG+SkNr4wQmg2V6gmgeUnFIrfbUJJJyQCaquFz6si
	 Mf90b9tkcCPsoH3AFMGWAqwviPwsDAxJtDMKFQeYuOkp9qUc9c7h5CU5rGs5W2vREP
	 BJ3Wv4CFv7lga5UWYxfCYfukxBFVXK1uAdZssFe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbgCKXiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:38:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCKXiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:38:03 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61D4A20754;
        Wed, 11 Mar 2020 23:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583969881;
        bh=tYse/b2VgvRrHBIlQlCMRUOHJDMPsP7MDl/1tT5CHKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fRsZjvD6guoPFk2BEwdeTGQoG+yB0UFjHX5rYzIeElepPrrkmGa8tHDNkI/3bJcjw
         c6HaCi4KjYzlUuyPlnw5PKl3e2cpomqfzDKAFyF0Ka8sRL4rq/8GhcXDVckxbfx5x/
         ++T4pZu93SiPDvEq388UoOwzyE2RnNP1+OiqA2Z0=
Date:   Wed, 11 Mar 2020 16:38:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Subject: Re: [PATCH -next] kasan: fix -Wstringop-overflow warning
Message-Id: <20200311163800.a264d4ec8f26cca7bb5046fb@linux-foundation.org>
In-Reply-To: <20200311134244.13016-1-walter-zh.wu@mediatek.com>
References: <20200311134244.13016-1-walter-zh.wu@mediatek.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 21:42:44 +0800 Walter Wu <walter-zh.wu@mediatek.com> wrote:

> Compiling with gcc-9.2.1 points out below warnings.
> 
> In function 'memmove',
>     inlined from 'kmalloc_memmove_invalid_size' at lib/test_kasan.c:301:2:
> include/linux/string.h:441:9: warning: '__builtin_memmove' specified
> bound 18446744073709551614 exceeds maximum object size
> 9223372036854775807 [-Wstringop-overflow=]
> 
> Why generate this warnings?
> Because our test function deliberately pass a negative number in memmove(),
> so we need to make it "volatile" so that compiler doesn't see it.
> 
> ...
>
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -289,6 +289,7 @@ static noinline void __init kmalloc_memmove_invalid_size(void)
>  {
>  	char *ptr;
>  	size_t size = 64;
> +	volatile size_t invalid_size = -2;
>  
>  	pr_info("invalid size in memmove\n");
>  	ptr = kmalloc(size, GFP_KERNEL);
> @@ -298,7 +299,7 @@ static noinline void __init kmalloc_memmove_invalid_size(void)
>  	}
>  
>  	memset((char *)ptr, 0, 64);
> -	memmove((char *)ptr, (char *)ptr + 4, -2);
> +	memmove((char *)ptr, (char *)ptr + 4, invalid_size);
>  	kfree(ptr);
>  }

Huh.  Why does this trick suppress the warning?

Do we have any guarantee that this it will contiue to work in future
gcc's?


