Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3754C2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C2F20771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtN+1vtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgC3TyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:54:07 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40699 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgC3TyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:54:06 -0400
Received: by mail-oi1-f195.google.com with SMTP id y71so16815116oia.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V83Ht0aTTTvrk6gECehE2hU1LiMNo8/5IhXZzQ6Rjgc=;
        b=NtN+1vtEs2VIxpdcBwXtuyFnPpStDFWK8k3Pd9DV2hfBmobHSNfo9+o1roc/Z+a0mH
         7e7d1nZ8h7lmKzsqUk49KeVNNn7rYUskClwpNIsDcIzXRzWdepTTIO1kXkcQEq99akin
         i4siO0GALw9cMwKmVQIc1Dde2F+deAUOLXokjWBPUXf6Mxc6uDGUeDG4sMNNAWRaoM91
         Hv2RKFYkD8XpSZh1h8B6gX+/pwPUbP4PNWXJvEahTkKK6J3soOOgEjlKgwWf/fGv4HmO
         fBkBeEM8BSFsUQSqdAdazNaTqxfiz08vin0ycfHTDKjA5EgvTQF4xVmDyDZyNyU69kWL
         tREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V83Ht0aTTTvrk6gECehE2hU1LiMNo8/5IhXZzQ6Rjgc=;
        b=Zae3643OQCBWn6f9DMx+HChACILVySJ0REQnipgFKbBRO5QU5qBhsogkGEaz+EbZT1
         uIqpqQ5+xAZQN3KDXnbjyBhdKCo6hiIs8teN/2GnxJuuaAEh3YG2fNd9MzCA9xCgAXAD
         6WBvBscZKhId+ghhIw9oGwO+AGaerzlYHpEYl9fh5qeqtUpW8zJwsKAIYjelBwqr7uxt
         0Rsk/LYKuv0gu7+O+bxOu1SGQrgtjP9afybt9FshTQhClsn5lt0K+5MdWPK7RhdCs+bU
         o2ph9bnBxeGrDLgLCQtUXu5Pql6V8vU0z1TMJEAny7amsWJBzylo0LoGhUdo+oIJ6l8E
         VccQ==
X-Gm-Message-State: ANhLgQ0N3ANZAGIC1nmwmxHzvPyzNtKf8e7P5VThc5GJmD9p4vx9F1RS
        wZ6nAMEVtQVGMvZfnox0PLE=
X-Google-Smtp-Source: ADFU+vuA4wtfVzS+cMemcwj4IgJfj2NH9vvD/9WbQ16zsULVN+XsR30Hvd+2WzMaWs0b5dMKgCu9dA==
X-Received: by 2002:aca:f541:: with SMTP id t62mr763942oih.172.1585598045532;
        Mon, 30 Mar 2020 12:54:05 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id s199sm4615222oos.27.2020.03.30.12.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 12:54:04 -0700 (PDT)
Date:   Mon, 30 Mar 2020 12:54:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [GIT PULL] Please pull HMM changes
Message-ID: <20200330195403.GA35797@ubuntu-m2-xlarge-x86>
References: <20200330175748.GA32709@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330175748.GA32709@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 02:57:48PM -0300, Jason Gunthorpe wrote:
> Hi Linus,
> 
> This series arose from a review of hmm_range_fault() by Christoph, Ralph and
> myself. Several bug fixes and some general clarity.
> 
> hmm_range_fault() is being used by these 'SVM' style drivers to
> non-destructively read the page tables. It is very similar to get_user_pages()
> except that the output is an array of PFNs and per-pfn flags, and it has
> various modes of reading.
> 
> This is necessary before RDMA ODP can be converted, as we don't want to have
> weird corner case regressions, which is still a looking forward item. Ralph
> has a nice tester for this routine, but it is waiting for feedback from the
> selftests maintainers.
> 
> Regards,
> Jason
> 
> The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:
> 
>   Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-hmm
> 
> for you to fetch changes up to 9cee0e8c6f1eb4b5e56d3eb7f5d47b05637bab4f:
> 
>   mm/hmm: return error for non-vma snapshots (2020-03-27 20:19:25 -0300)
> 
> ----------------------------------------------------------------
> hmm related patches for 5.7
> 
> This series focuses on corner case bug fixes and general clarity
> improvements to hmm_range_fault().
> 
> - 9 bug fixes
> 
> - Allow pgmap to track the 'owner' of a DEVICE_PRIVATE - in this case the
>   owner tells the driver if it can understand the DEVICE_PRIVATE page or
>   not. Use this to resolve a bug in nouveau where it could touch
>   DEVICE_PRIVATE pages from other drivers.
> 
> - Remove a bunch of dead, redundant or unused code and flags
> 
> - Clarity improvements to hmm_range_fault()
> 
> ----------------------------------------------------------------
> Christoph Hellwig (9):
>       mm/hmm: don't provide a stub for hmm_range_fault()
>       mm/hmm: remove the unused HMM_FAULT_ALLOW_RETRY flag
>       mm/hmm: simplify hmm_vma_walk_hugetlb_entry()
>       mm/hmm: don't handle the non-fault case in hmm_vma_walk_hole_()
>       mm: merge hmm_vma_do_fault into into hmm_vma_walk_hole_
>       memremap: add an owner field to struct dev_pagemap
>       mm: handle multiple owners of device private pages in migrate_vma
>       mm: simplify device private page handling in hmm_range_fault
>       mm/hmm: check the device private page owner in hmm_range_fault()
> 
> Jason Gunthorpe (17):
>       mm/hmm: add missing unmaps of the ptep during hmm_vma_handle_pte()
>       mm/hmm: do not call hmm_vma_walk_hole() while holding a spinlock
>       mm/hmm: add missing pfns set to hmm_vma_walk_pmd()
>       mm/hmm: add missing call to hmm_range_need_fault() before returning EFAULT
>       mm/hmm: reorganize how !pte_present is handled in hmm_vma_handle_pte()
>       mm/hmm: return -EFAULT when setting HMM_PFN_ERROR on requested valid pages
>       mm/hmm: add missing call to hmm_pte_need_fault in HMM_PFN_SPECIAL handling
>       mm/hmm: do not check pmd_protnone twice in hmm_vma_handle_pmd()
>       mm/hmm: remove pgmap checking for devmap pages
>       mm/hmm: return the fault type from hmm_pte_need_fault()
>       mm/hmm: remove unused code and tidy comments
>       mm/hmm: remove HMM_FAULT_SNAPSHOT
>       mm/hmm: remove the CONFIG_TRANSPARENT_HUGEPAGE #ifdef

This patch causes an error on arm32 all{mod,yes}config because pmd_pfn
is only defined when CONFIG_ARM_LPAE is set, which is a dependency of
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE and CONFIG_TRANSPARENT_HUGEPAGE.

$ make -j$(nproc) -s ARCH=arm CC=clang CROSS_COMPILE=arm-linux-gnueabi- O=out/arm32 distclean allyesconfig mm/hmm.o
mm/hmm.c:207:8: error: implicit declaration of function 'pmd_pfn'
[-Werror,-Wimplicit-function-declaration]
        pfn = pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
                      ^
1 error generated.

https://elixir.bootlin.com/linux/v5.6/source/arch/arm/include/asm/pgtable-3level.h#L236
https://elixir.bootlin.com/linux/v5.6/source/arch/arm/include/asm/pgtable.h#L29
https://elixir.bootlin.com/linux/v5.6/source/arch/arm/Kconfig#L1579

No idea how to rectify that but thought I would let you know.

Cheers,
Nathan
