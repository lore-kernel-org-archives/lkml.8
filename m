Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5239DC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F1E206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gIVBU7Bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgA3EUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 23:20:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35276 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgA3EUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 23:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JcdAYnVQLCb8oRIYH7JBoQDKxVGZLa/gBb3aPfXmOGY=; b=gIVBU7BfX+LKPHHjnSQP2L7xh
        xjrpq80QPZ4DPbhgYrO5KqDdaZkkJfN/V7HPDRUATYJtgYJnGholvI9i9i7oMbmWf9tMLIe2reWvc
        qeWXf2Sloh+l9bNS1nKEkDOf3w6mkZMl9bsPE9kXBoSg8CE9+BPAIlwYVdDWASRfI6BHEJA6jV881
        gDVqMr8gyaNT71X0lqPJVrXUkl9n9RThht/y2xxPTwQ2uO+L8apw4Ur5qatocUZjrmUNJ4M/xN4aQ
        L3LJxfrGUyVbOf8GFJhNAWQNa4ZgNWPUEzhJ0RbotBQH1hqrdYmvvTICgXRJjT67T+6wzIkpvhSzA
        os25Ch9Qw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ix1JL-0004TE-Fp; Thu, 30 Jan 2020 04:20:11 +0000
Date:   Wed, 29 Jan 2020 20:20:11 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/util: fix a data race in __vm_enough_memory()
Message-ID: <20200130042011.GI6615@bombadil.infradead.org>
References: <20200130025133.5232-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130025133.5232-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 09:51:33PM -0500, Qian Cai wrote:
> "vm_committed_as.count" could be accessed concurrently as reported by
> KCSAN,
> 
>  read to 0xffffffff923164f8 of 8 bytes by task 1268 on cpu 38:
>   __vm_enough_memory+0x43/0x280 mm/util.c:801
>   mmap_region+0x1b2/0xb90 mm/mmap.c:1726
>   do_mmap+0x45c/0x700
>   vm_mmap_pgoff+0xc0/0x130
>   vm_mmap+0x71/0x90
>   elf_map+0xa1/0x1b0
>   load_elf_binary+0x9de/0x2180
>   search_binary_handler+0xd8/0x2b0
>   __do_execve_file+0xb61/0x1080
>   __x64_sys_execve+0x5f/0x70
>   do_syscall_64+0x91/0xb47
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  write to 0xffffffff923164f8 of 8 bytes by task 1265 on cpu 41:
>   percpu_counter_add_batch+0x83/0xd0 lib/percpu_counter.c:91
>   exit_mmap+0x178/0x220 include/linux/mman.h:68
>   mmput+0x10e/0x270
>   flush_old_exec+0x572/0xfe0
>   load_elf_binary+0x467/0x2180
>   search_binary_handler+0xd8/0x2b0
>   __do_execve_file+0xb61/0x1080
>   __x64_sys_execve+0x5f/0x70
>   do_syscall_64+0x91/0xb47
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Since only the read is operating as lockless, fix it by using
> READ_ONLY() for it to avoid any possible false warning due to load

You mean READ_ONCE ...

>  {
>  	long allowed;
>  
> -	VM_WARN_ONCE(percpu_counter_read(&vm_committed_as) <
> +	VM_WARN_ONCE(READ_ONCE(vm_committed_as.count) <
>  			-(s64)vm_committed_as_batch * num_online_cpus(),

I'm really not a fan of exposing the internals of a percpu_counter outside
the percpu_counter.h file.  Why shouldn't this be fixed by putting the
READ_ONCE() inside percpu_counter_read()?
