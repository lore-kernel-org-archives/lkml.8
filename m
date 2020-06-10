Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9219CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1C3207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eszh8+zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgFJUgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFJUgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:36:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F39C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:36:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 64so1608593pfv.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ySojxU/vlWhxHgsiwOmtzcHxDLuwMINKN+vR5oYu1Rk=;
        b=eszh8+zkPiNJdM2q5MSvsXhQ0krZSUfW1RxrB5iFj0B8ZKk/vVPVZRAhV2DUIVpWPU
         qhdQ3Z5S9bnkyhOpuNm9hlsGagwEg67U8nqE1FfhGSBLRH0Sra3G8JCyitgpVvw+CmOX
         jQCNKCwX6eTvIiyoKbBv5ZOgep8DxAGbZGtldSJuULg2Ya+Z/rVWG3UTY3Fkw7gV0JMn
         Fc1i0hzETo3MNWly3aBHZFM0Rfoc8ja++RTIPDDsZ+pwXSuE115ZtM5JoXvc/jayfxSj
         l8VKwG6tz6c2Kg45AxLMo48mdisuoGoy0YnwUm9vj9acONDKzo56HZXiOJV8MKTzLlks
         NCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ySojxU/vlWhxHgsiwOmtzcHxDLuwMINKN+vR5oYu1Rk=;
        b=OjxYWUccdBdv1v88+Td1VB7FzAfZMlncXIYlDC36Se9/IQR4X5xcvYDhPEKTFDQ4zX
         +4HyilCblkILwiwHYOps9xqjaiAoAEHrrjz/xC219hwWwZLbedtojQs5L3++k5aLSvVH
         DCRh7tMn/tImi1rAH8KC3xYVJP4uBPbEvx5G0F7GbYT1Y/boByptM1PqPxhzEYIu/TgV
         E2AGub764GC+QosNQK9PYWutwHiRLYuykVZrfPvUIT+3C+sWkwgpAvKDWvpMwaeZ+y9h
         LOtoOhG0mWOasyFjy8gAdBQhxPc9mg/7tezviqJJ6pNFqfkabU3vJddlpVj8ZvIw3zNp
         3u0g==
X-Gm-Message-State: AOAM532FhSy0iN3MVQd7Xg8xcqmxiIxHVr7xPD66IZxa0SnL4YYqfm99
        IiUTHswYsnfTZRUcRDrClGmVeqzF
X-Google-Smtp-Source: ABdhPJxQm66N95jIsQFFN0tqtrqEAV9POxuPZMDUW4KfHrVvo/1P6TLpZisdiJp5TnyTN6fUTK0TLg==
X-Received: by 2002:a63:1946:: with SMTP id 6mr3901567pgz.287.1591821410373;
        Wed, 10 Jun 2020 13:36:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2sm778897pfc.7.2020.06.10.13.36.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jun 2020 13:36:49 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:36:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm: pgtable: add shortcuts for accessing kernel PMD and
 PTE
Message-ID: <20200610203649.GA259074@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 09:33:05PM -0700, Mike Rapoport wrote:
> The powerpc 32-bit implementation of pgtable has nice shortcuts for
> accessing kernel PMD and PTE for a given virtual address.  Make these
> helpers available for all architectures.
> 
> [rppt@linux.ibm.com: microblaze: fix page table traversal in setup_rt_frame()]
>   Link: http://lkml.kernel.org/r/20200518191511.GD1118872@kernel.org
> [akpm@linux-foundation.org: s/pmd_ptr_k/pmd_off_k/ in various powerpc places]
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ ... ]
> Link: http://lkml.kernel.org/r/20200514170327.31389-9-rppt@kernel.org
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Building powerpc:tqm8xx_defconfig ... failed
--------------
Error log:
arch/powerpc/mm/pgtable.c: In function 'set_huge_pte_at':
arch/powerpc/mm/pgtable.c:267:15: error: implicit declaration of function 'pmd_ptr'

bisect log attached.

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
# bad: [e05c7b1f2bc4b7b28199b9a7572f73436d97317e] mm: pgtable: add shortcuts for accessing kernel PMD and PTE
git bisect bad e05c7b1f2bc4b7b28199b9a7572f73436d97317e
# first bad commit: [e05c7b1f2bc4b7b28199b9a7572f73436d97317e] mm: pgtable: add shortcuts for accessing kernel PMD and PTE
