Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B221C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2904C204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQ0JQ2yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFJUmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJUmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:42:14 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554D1C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:42:14 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s88so1387821pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zDf5Pi3PpqVDBjSXu6QkKtfqMe90etFyb7ygOrEMTmE=;
        b=oQ0JQ2ypI0pwj0vlx//W0xdL/YAOF0Kn2kWs0pp4ZOMn4VlSXQKPFpUYihLk4Dts2t
         McWC0u0YmGVzpR6PcIvmjyLIgRgdSyJiiHT0VZVgAz5HqYAfwLEaxK9QEPug7OO3aU16
         rkt5JdfNzCUtGafeqEVPkgcf8qVAY2nvUt7LdhM4D0Wkkq36+gqPH8vfHLct+etejuaj
         vOqSJJmPdaad7DPkuYiqvrEXoJ3Nan20cgaYRZaau7mFrVnm0W78q8yuvnCEKnBVlgg+
         UBUye9lwXHMcOwLVZ2aYUMUsL4ljlhRc+qGEI9mv8/ZLw3yGMTnjlVw+d5tjrNQaos7K
         j8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=zDf5Pi3PpqVDBjSXu6QkKtfqMe90etFyb7ygOrEMTmE=;
        b=L9S/+mYF9DmY/xAo2WRG0udK5B2n+DeQgjtzDV+utusboE/Dat+psOa3vb0OyeQ/b/
         xhevv0AZRMeKmZ2BVSVL/UppQacfraFCMpO7Y0A5Lk6hmspyFA56Hn9GGo+rh++uKs0i
         UzXpnOIl32qXzDxvDOMsY/sBKarkkJv1v8tS6GTVq9W+cHPtzzYsQyIAzClDHWKFaVYZ
         Pd4GY1lYiNGq/BGBLCGd7XsAcxqqC8MFhPkS6cMrLyuaJwsaNuiNPdgGu3pFX6sHz3dk
         JYmBbQmrhlXp5T7zBODyWjkr/H3xPJ4+AyeSVE6y9n+9z/sGHGhE5xIvdTolchyZEv2h
         0nyA==
X-Gm-Message-State: AOAM533Fqq9Cx5IFMb5j/ArmfdRIsn9bTRaZ20Bs614Tjm06+WUA9SNJ
        s+LgLny9voIAKIE8XTp4aAtkbtLx
X-Google-Smtp-Source: ABdhPJyahpiX4pyuFdNGUoMcxHUIjL3BeFic8rY68fOnoi9Wf1L68cFnWhNs2QoNljFMOrP+ngoF/g==
X-Received: by 2002:a17:90a:6e2:: with SMTP id k89mr4950039pjk.74.1591821733824;
        Wed, 10 Jun 2020 13:42:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fa13sm544714pjb.39.2020.06.10.13.42.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jun 2020 13:42:13 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:42:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm: consolidate pte_index() and pte_offset_*()
 definitions
Message-ID: <20200610204212.GA4595@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 09:33:10PM -0700, Mike Rapoport wrote:
> All architectures define pte_index() as
> 
> 	(address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)
> 
> and all architectures define pte_offset_kernel() as an entry in the array
> of PTEs indexed by the pte_index().
> 
> For the most architectures the pte_offset_kernel() implementation relies
> on the availability of pmd_page_vaddr() that converts a PMD entry value to
> the virtual address of the page containing PTEs array.
> 
> Let's move x86 definitions of the PTE accessors to the generic place in
> <linux/pgtable.h> and then simply drop the respective definitions from the
> other architectures.
> 
> The architectures that didn't provide pmd_page_vaddr() are updated to have
> that defined.
> 
> The generic implementation of pte_offset_kernel() can be overridden by an
> architecture and alpha makes use of this because it has special ordering
> requirements for its version of pte_offset_kernel().
> 
> [rppt@linux.ibm.com: v2]
>   Link: http://lkml.kernel.org/r/20200514170327.31389-11-rppt@kernel.org
> [rppt@linux.ibm.com: update]
>   Link: http://lkml.kernel.org/r/20200514170327.31389-12-rppt@kernel.org
> [rppt@linux.ibm.com: update]
>   Link: http://lkml.kernel.org/r/20200514170327.31389-13-rppt@kernel.org
> [akpm@linux-foundation.org: fix x86 warning]
> [sfr@canb.auug.org.au: fix powerpc build]
>   Link: http://lkml.kernel.org/r/20200607153443.GB738695@linux.ibm.com
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ ... ]
> Link: http://lkml.kernel.org/r/20200514170327.31389-10-rppt@kernel.org
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---

Building sparc32:defconfig ... failed
--------------
Error log:
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
In file included from include/linux/mm.h:32,
                 from include/linux/memblock.h:13,
                 from arch/sparc/mm/srmmu.c:14:
include/linux/pgtable.h:74:27: error: redefinition of 'pte_offset_kernel'
   74 | #define pte_offset_kernel pte_offset_kernel
      |                           ^~~~~~~~~~~~~~~~~
arch/sparc/mm/srmmu.c:144:8: note: in expansion of macro 'pte_offset_kernel'
  144 | pte_t *pte_offset_kernel(pmd_t *dir, unsigned long address)
      |        ^~~~~~~~~~~~~~~~~
include/linux/pgtable.h:70:22: note: previous definition of 'pte_offset_kernel' was here
   70 | static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
      |                      ^~~~~~~~~~~~~~~~~

Bisct log attached.

Guenter

---
# bad: [5b14671be58d0084e7e2d1cc9c2c36a94467f6e0] Merge tag 'fuse-update-5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse
# good: [abfbb29297c27e3f101f348dc9e467b0fe70f919] Merge tag 'rproc-v5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc
git bisect start 'HEAD' 'abfbb29297c2'
# bad: [595a56ac1b0d5f0a16a89589ef55ffd35c1967a2] Merge tag 'linux-kselftest-kunit-5.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
git bisect bad 595a56ac1b0d5f0a16a89589ef55ffd35c1967a2
# bad: [d8ed45c5dcd455fc5848d47f86883a1b872ac0d0] mmap locking API: use coccinelle to convert mmap_sem rwsem call sites
git bisect bad d8ed45c5dcd455fc5848d47f86883a1b872ac0d0
# good: [2deebe4d56d638269a4a728086d64de5734b460a] sh: add loglvl to printk_address()
git bisect good 2deebe4d56d638269a4a728086d64de5734b460a
# good: [77819daf247aad16beaeb537ae77d1d6d0697ca2] kdb: don't play with console_loglevel
git bisect good 77819daf247aad16beaeb537ae77d1d6d0697ca2
# good: [e73240be691e1b081190125da67cd38822b8d5f8] m68k/mm/motorola: move comment about page table allocation funcitons
git bisect good e73240be691e1b081190125da67cd38822b8d5f8
# bad: [974b9b2c68f3d35a65e80af9657fe378d2439b60] mm: consolidate pte_index() and pte_offset_*() definitions
git bisect bad 974b9b2c68f3d35a65e80af9657fe378d2439b60
# good: [88107d330de4f175705a3ea03147feb0d7e68499] x86/mm: simplify init_trampoline() and surrounding logic
git bisect good 88107d330de4f175705a3ea03147feb0d7e68499
# good: [e05c7b1f2bc4b7b28199b9a7572f73436d97317e] mm: pgtable: add shortcuts for accessing kernel PMD and PTE
git bisect good e05c7b1f2bc4b7b28199b9a7572f73436d97317e
# first bad commit: [974b9b2c68f3d35a65e80af9657fe378d2439b60] mm: consolidate pte_index() and pte_offset_*() definitions
