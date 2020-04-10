Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3ABC2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC8320857
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SigXccs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgDJPcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:32:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35221 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726049AbgDJPcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586532761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JLUYil4vS5Pi2voMRT5GlnG+2xlYeMU6lI0hTtfZyHg=;
        b=SigXccs2K9pe/9Xdcri1ZWeflKwaSbwDLUxXPhphAn/LrkbIkAWp7BiHE1ehL7HE4iP0OK
        4m/fZUFSynhaSM99z0J/XQn81yZ5puKc5+FrpqpKIUmWhPvsktlbXVWqAdjPYyz3GgI9XH
        vCxi+doHBvQEftj+BQFEw6wXDfW0XcY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-dxXpj57eNduAYlS-2spIzg-1; Fri, 10 Apr 2020 11:32:38 -0400
X-MC-Unique: dxXpj57eNduAYlS-2spIzg-1
Received: by mail-qt1-f200.google.com with SMTP id x4so2063606qti.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 08:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JLUYil4vS5Pi2voMRT5GlnG+2xlYeMU6lI0hTtfZyHg=;
        b=QxQxeaaPqg56Dzdi7sPQERHMsBmnDP5koHyu5fxNkB5uXKjX3yILjWa/p4Z5TZjHfq
         EE+HuzL5BZLrAq4wFS293SzB5kiwNawWIRfqLMneHgKgIHS978R+MaSmTLaVbT6qBgtG
         g31vi6b6QNuX9PLtdsiAPu1LXccABsBieD0Ku9djgbLC9VUeEX+b+rx7ml85NsHzFuCT
         RlP7TLYVF/peVS7zN2o527X/dS4+fv6Wm1saK9VWuOXOeo25RNeVYt050fpW/797JMdE
         g6+zyoHg+BGOQSzU51QAap7V76VBNNpr1lhe56SoFqBOt/Zl4YL516lLUXodc8f0fGDr
         9T2Q==
X-Gm-Message-State: AGi0Pua0O7S58PaY1VnEkq/qJ9lT1+Mzs2+XmNYfJan4Hz7o6ya+Ykug
        amxgAN9t/2vZe2wJHyfaOCyMku4SPnfu+DdA4pcWe1GdfRZcdzEJXTRWHRNrYX99rdZbWSb62XZ
        7yQaT0MrkoX0UpplBZRIC8hh0
X-Received: by 2002:ac8:3665:: with SMTP id n34mr2692985qtb.227.1586532757740;
        Fri, 10 Apr 2020 08:32:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypJNTP/hRSUYK1gpIDXWD5qj/bfCDgNQdDXyuxcvwIhEitGO6BGt9wACWBPTyIeIwHtWKc3Lrw==
X-Received: by 2002:ac8:3665:: with SMTP id n34mr2692949qtb.227.1586532757277;
        Fri, 10 Apr 2020 08:32:37 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id y126sm1838024qke.28.2020.04.10.08.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 08:32:36 -0700 (PDT)
Date:   Fri, 10 Apr 2020 11:32:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: f45ec5ff16 ("userfaultfd: wp: support swap and page migration"):
 [  140.777858] BUG: Bad rss-counter state mm:b278fc66 type:MM_ANONPAGES
 val:1
Message-ID: <20200410153234.GB3172@xz-x1>
References: <20200410002518.GG8179@shao2-debian>
 <20200410073209.11164-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200410073209.11164-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hillf,

On Fri, Apr 10, 2020 at 03:32:09PM +0800, Hillf Danton wrote:
> 
> On Fri, 10 Apr 2020 08:25:18 +0800
> > Greetings,
> > 
> > 0day kernel testing robot got the below dmesg and the first bad commit is
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > 
> > commit f45ec5ff16a75f96dac8c89862d75f1d8739efd4
> > Author:     Peter Xu <peterx@redhat.com>
> > AuthorDate: Mon Apr 6 20:06:01 2020 -0700
> > Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> > CommitDate: Tue Apr 7 10:43:39 2020 -0700
> > 
> >     userfaultfd: wp: support swap and page migration
> >     
> >     For either swap and page migration, we all use the bit 2 of the entry to
> >     identify whether this entry is uffd write-protected.  It plays a similar
> >     role as the existing soft dirty bit in swap entries but only for keeping
> >     the uffd-wp tracking for a specific PTE/PMD.
> >     
> >     Something special here is that when we want to recover the uffd-wp bit
> >     from a swap/migration entry to the PTE bit we'll also need to take care of
> >     the _PAGE_RW bit and make sure it's cleared, otherwise even with the
> >     _PAGE_UFFD_WP bit we can't trap it at all.
> >     
> >     In change_pte_range() we do nothing for uffd if the PTE is a swap entry.
> >     That can lead to data mismatch if the page that we are going to write
> >     protect is swapped out when sending the UFFDIO_WRITEPROTECT.  This patch
> >     also applies/removes the uffd-wp bit even for the swap entries.
> >
> Have trouble understanding the last sentence in the paragraph above and
> particularly linking it to the first one.

This patch handles the swap entry tracking for userfault-wp.  I wanted
to express the fact that we didn't do that before.  Sorry if my
wording is confusing.

> 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > [child3:925] eventfd (323) returned ENOSYS, marking as inactive.
> > [  132.014801] can: request_module (can-proto-2) failed.
> > [  132.063717] can: request_module (can-proto-2) failed.
> > [  137.186037] trinity-c2 (943) used greatest stack depth: 5804 bytes left
> > [  140.771486] MCE: Killing trinity-c2:956 due to hardware memory corruption fault at 8bd2060
> > [  140.777858] BUG: Bad rss-counter state mm:b278fc66 type:MM_ANONPAGES val:1
> > [  140.778736] BUG: Bad rss-counter state mm:b278fc66 type:MM_SHMEMPAGES val:2
> > [  141.589424] MCE: Killing trinity-c3:940 due to hardware memory corruption fault at 8a8c860
> > [  141.590730] swap_info_get: Bad swap file entry 700b8216

Should be a 32bit guest, swap type == 11100b.  I guess this also means
MAX_SWAPFILES is bigger than 11100b.

> > [  141.591400] BUG: Bad page map in process trinity-c3  pte:17042c3c pmd:b1809067
> > [  141.592304] addr:08bcf000 vm_flags:00100073 anon_vma:f1f29528 mapping:00000000 index:8bcf
> > [  141.593399] file:(null) fault:0x0 mmap:0x0 readpage:0x0
> > [  141.594065] CPU: 0 PID: 940 Comm: trinity-c3 Not tainted 5.6.0-11490-gf45ec5ff16a75 #1
> > [  141.595055] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > [  141.596093] Call Trace:
> > [  141.596443]  dump_stack+0x16/0x18
> > [  141.596868]  print_bad_pte+0x13f/0x159
> > [  141.597367]  unmap_page_range+0x2a7/0x3e7
> > [  141.597893]  unmap_single_vma+0x53/0x5d
> > [  141.598383]  unmap_vmas+0x2c/0x3b
> > [  141.598811]  exit_mmap+0x81/0xfc
> > [  141.599238]  __mmput+0x25/0x8d
> > [  141.599633]  mmput+0x28/0x2b
> > [  141.600007]  do_exit+0x2f0/0x84a
> > [  141.600449]  ? ___might_sleep+0x3f/0x11f
> > [  141.600949]  do_group_exit+0x86/0x86
> > [  141.601421]  __ia32_sys_exit_group+0x15/0x15
> > [  141.601965]  do_fast_syscall_32+0x86/0xbf
> > [  141.602481]  entry_SYSENTER_32+0xaf/0x101
> 
> 
> Because is_swap_pte(oldpte) != IS_ENABLED(CONFIG_MIGRATION)), restore the
> old behavior by modifying uffd_wp only for pte that is __not__ swap entry,
> as the commit log says.
> 
> --- b/mm/mprotect.c
> +++ c/mm/mprotect.c
> @@ -139,7 +139,7 @@ static unsigned long change_pte_range(st
>  			}
>  			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
>  			pages++;
> -		} else if (is_swap_pte(oldpte)) {
> +		} else if (IS_ENABLED(CONFIG_MIGRATION)) {
>  			swp_entry_t entry = pte_to_swp_entry(oldpte);
>  			pte_t newpte;
>  
> @@ -154,7 +154,9 @@ static unsigned long change_pte_range(st
>  					newpte = pte_swp_mksoft_dirty(newpte);
>  				if (pte_swp_uffd_wp(oldpte))
>  					newpte = pte_swp_mkuffd_wp(newpte);
> -			} else if (is_write_device_private_entry(entry)) {
> +			}
> +
> +			if (is_write_device_private_entry(entry)) {
>  				/*
>  				 * We do not preserve soft-dirtiness. See
>  				 * copy_one_pte() for explanation.
> @@ -163,11 +165,18 @@ static unsigned long change_pte_range(st
>  				newpte = swp_entry_to_pte(entry);
>  				if (pte_swp_uffd_wp(oldpte))
>  					newpte = pte_swp_mkuffd_wp(newpte);
> -			} else {
> -				newpte = oldpte;
>  			}
>  
> -			if (uffd_wp)
> +			/*
> +			 * do nothing for changing uffd_wp if oldpte is a
> +			 * swap entry.
> +			 * That can lead to data mismatch if the page we
> +			 * are going to write protect is swapped out when
> +			 * sending the UFFDIO_WRITEPROTECT.
> +			 */
> +			if (is_swap_pte(oldpte))
> +				newpte = oldpte;
> +			else if (uffd_wp)
>  				newpte = pte_swp_mkuffd_wp(newpte);
>  			else if (uffd_wp_resolve)
>  				newpte = pte_swp_clear_uffd_wp(newpte);

I'm not sure this is correct.  As I mentioned, the commit wanted to
apply the uffd-wp bit even for the swap entries so that even the swap
entries got swapped in, the page will still be write protected.  So
IIUC think we can't remove that.

Above report happened at __swap_info_get() where we should have
triggered type >= READ_ONCE(nr_swapfiles) in swap_type_to_swap_info(),
which, iiuc, means the type is considered wrong.  The mistery to me is
how did the swap type went wrong.  E.g., iiuc the
"is_swap_pte(oldpte)" replacement to "IS_ENABLED(CONFIG_MIGRATION)"
shouldn't affect this, because even if MIGRATION is not enabled, both
is_write_migration_entry() and is_write_device_private_entry() should
return constant zero after all, so they shouldn't be thouching the
swap type.

I'm still trying to digest on what's happened... It would be good too
if more information on the test could be given, e.g., what is the
behavior of trinity-c2. A reproducer is of course even better.

Thanks,

-- 
Peter Xu

