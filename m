Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A8AC11D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8AE2467A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="LxfK9xwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgBTMzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:55:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40430 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgBTMzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:55:52 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18so4089256ljo.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 04:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+DRsaTqEK5nsNqn790WfhY6ctsNbT89zfUUUM83iioM=;
        b=LxfK9xwMlL1Sa2i6EUu6CcDdcjWDVxb6Bts+nN9/UoeVse7vT0RiNtmHBc7gdaAa2+
         ueQmo7k0bsOfZshABNhzY00iH/HPY08UghihEIg5Pmumn/4Eef1MiIBsn70fp43zcOkM
         kKcRlKdDIXPuI4ynO4Kz0phUluLFm8Wc0wexemibwMumT5tmzTwYnLvaqyxcSYVdcFgR
         piacsu0qWaQfgEfw7BZ79qrKiNJ+w19ggNN13r4HXkuDez4bLPzlEXUL4dkFRd+MGGDE
         yeI2vlskoIh7D1dV/UEwHngDyZ2mS8rppIB/G+SMBQfrtm+il+qBCdHwqekKY2vXIzkt
         lRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+DRsaTqEK5nsNqn790WfhY6ctsNbT89zfUUUM83iioM=;
        b=NYxDACBxTGqkr122p4wfK3JywwCr3rNvA5iBiLz4qw5J+qjXKcBFQ7miSJGsauD1nk
         t6Ir+yBfu1/i3qRGYnQ4TnpWu2iod+VFtpHxTFSt7y99BOUBqHe9qlA5Qv5IpK+i1tZh
         2VKMTkuponHVi9vzWlk0HDaQeSnNVUm/QhLkae/RyqC/1TJ/oMH+NvtrwFoW2Ct73DMO
         FhVsW5DfSywYBo5LNA7WcuqDxSFzgV/ECLDFRtU7RIGK7MYjJQ7LssOxityek0yM4T6F
         ngiX66Tk11gTmv4op+HUizLv+iDNIehkA1XEFxJZVMYfMR++gr43M6mVHsi475VP+24E
         GfTw==
X-Gm-Message-State: APjAAAWNGsZFREOy9igDEZuXtqQQSvehF9c/y0mPW1d6PAJC5dQJGkoP
        sN2v28Iuy9I+0YFbetosxl/Siw==
X-Google-Smtp-Source: APXvYqxxYxSwkTEH5S43pu5FkPhBj48B96YRDECTaclr9+lcdudJbpqLcMvOemqKREfvtlqPKa0rUQ==
X-Received: by 2002:a2e:8e70:: with SMTP id t16mr19036539ljk.73.1582203349910;
        Thu, 20 Feb 2020 04:55:49 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b20sm1763423ljp.20.2020.02.20.04.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 04:55:49 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 478CC100FBB; Thu, 20 Feb 2020 15:56:18 +0300 (+03)
Date:   Thu, 20 Feb 2020 15:56:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Qian Cai <cai@lca.pw>
Cc:     paulmck@kernel.org, akpm@linux-foundation.org, elver@google.com,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] fork: annotate a data race in vm_area_dup()
Message-ID: <20200220125618.o2p6be2hjfgatynw@box>
References: <1582122495-12885-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582122495-12885-1-git-send-email-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 09:28:15AM -0500, Qian Cai wrote:
> struct vm_area_struct could be accessed concurrently as noticed by
> KCSAN,
> 
>  write to 0xffff9cf8bba08ad8 of 8 bytes by task 14263 on cpu 35:
>   vma_interval_tree_insert+0x101/0x150:
>   rb_insert_augmented_cached at include/linux/rbtree_augmented.h:58
>   (inlined by) vma_interval_tree_insert at mm/interval_tree.c:23
>   __vma_link_file+0x6e/0xe0
>   __vma_link_file at mm/mmap.c:629
>   vma_link+0xa2/0x120
>   mmap_region+0x753/0xb90
>   do_mmap+0x45c/0x710
>   vm_mmap_pgoff+0xc0/0x130
>   ksys_mmap_pgoff+0x1d1/0x300
>   __x64_sys_mmap+0x33/0x40
>   do_syscall_64+0x91/0xc44
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  read to 0xffff9cf8bba08a80 of 200 bytes by task 14262 on cpu 122:
>   vm_area_dup+0x6a/0xe0
>   vm_area_dup at kernel/fork.c:362
>   __split_vma+0x72/0x2a0
>   __split_vma at mm/mmap.c:2661
>   split_vma+0x5a/0x80
>   mprotect_fixup+0x368/0x3f0
>   do_mprotect_pkey+0x263/0x420
>   __x64_sys_mprotect+0x51/0x70
>   do_syscall_64+0x91/0xc44
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> vm_area_dup() blindly copies all fields of original VMA to the new one.
> This includes coping vm_area_struct::shared.rb which is normally
> protected by i_mmap_lock. But this is fine because the read value will
> be overwritten on the following __vma_link_file() under proper
> protection. Thus, mark it as an intentional data race and insert a few
> assertions for the fields that should not be modified concurrently.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
