Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C082FC3402D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 22:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970F32070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 22:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="KF+57Z91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgBQWbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 17:31:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33673 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgBQWbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 17:31:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so20638048lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 14:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=juI3iyWfnRJJM93b6hL4nBUlEynDiqxQtkuCLJ6MlQc=;
        b=KF+57Z91ExlwgBnswQNveUKQZV1enKonyvw5Gy/RBrBb47hkKuZ3nC1fMqqidCIHYg
         e66EGlvZ5FBwZ/ApaAPeONX0RuWKvO1KsFedec3Qfq1A0nNbpKizDzIAbeJ1n91WadG3
         PRi8VNYPuIMIk+EeMRbf11pQjR29oNVN//tz3H5gBmhscnkq1TSuG7xDHA3N1GPV0Lh9
         VM1f4heqYShgAMnBHP2RhpQgdtmFYk/mLZKazmyVA5icPN8dMxa5nSUpa8TgMyYpJD7r
         x8IFopCViLQOaiUfkdsopH+YR00hBSkmc+WDABDiqibn6GN2U2JSpWlidjrEzwWnpbpD
         20rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=juI3iyWfnRJJM93b6hL4nBUlEynDiqxQtkuCLJ6MlQc=;
        b=TkZTY8O6H313h4itSg7MUafukm++jbf0YegqA8ZkF9Xy9G1fpQcuwrd1XXiegPcc0b
         SWbmp8199la0/IvPpP9PHEXZBkhhQt7Xap1aGQzTc2CfMKltyXJasEibZd+93z3yPrOH
         +lNCWH4dSE4zkX4/eVMNooYtaZNDPiA4vINsxP760xhy3sjXlSUa0aThCkPhTS3S3QJk
         jOFcPqw+bv2dfZioTtz6bZ75XxhYYnOrJaes0Hyo5AOhWDZ3Ygfchn0iOrQ+XqXMt7cd
         R/VJQQJLDQLopUl7t5+Jnsih/GtPHbTYKLpPUbljSIsmNZgUAH0F4gA9+lJi2AsRZ0tr
         YQ9Q==
X-Gm-Message-State: APjAAAU8UXt902kHxdbydQMa71JK8bOX4T1vwJ8BpfDgOwpZ5CtvlSrf
        XUH8ogmJVP3/OQZU9VGifMXkRQ==
X-Google-Smtp-Source: APXvYqyIaUTaKLQ0YEWHzqJn8cP00A+jet2TyIAkRU1NbzczVnqY5BGR41baozXGlQnK41bdTEwcxw==
X-Received: by 2002:a05:651c:3c4:: with SMTP id f4mr10653268ljp.5.1581978674013;
        Mon, 17 Feb 2020 14:31:14 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v26sm1341203ljh.90.2020.02.17.14.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 14:31:13 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5FB12100F89; Tue, 18 Feb 2020 01:31:38 +0300 (+03)
Date:   Tue, 18 Feb 2020 01:31:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fork: annotate a data race in vm_area_dup()
Message-ID: <20200217223138.doaph66iwprbwhw5@box>
References: <1581712403-27243-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581712403-27243-1-git-send-email-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 03:33:23PM -0500, Qian Cai wrote:
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
> The write is holding mmap_sem while changing vm_area_struct.shared.rb.
> Even though the read is lockless while making a copy, the clone will
> have its own shared.rb reinitialized. Thus, mark it as an intentional
> data race using the data_race() macro.

I'm confused. AFAICS both sides hold mmap_sem on write:

 - vm_mmap_pgoff() takes mmap_sem for the write on the write side

 - do_mprotect_pkey() takes mmap_sem for the write on the read side


What do I miss?

-- 
 Kirill A. Shutemov
