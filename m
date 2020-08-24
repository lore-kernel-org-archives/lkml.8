Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72614C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E12204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258768;
	bh=6dKXPbkOsXvYAwvbYQTU8pkwY4FYFgSClqrMNdZdVw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gy1J+JQ+50QHTvvNw+qc5xs+mgE9HfAmEcqIej3u451knXRS9gwPNDX8Fyjk71wkh
	 TKHE86RuweuQgI4W/fTH9VeUmeoZFekySYL2zkg6vHRRcq5zARcaBgMQDsS5d/d24E
	 /p9Qi28HqCqbsLvXuiXbgCqhcRKIlvykk6geqNSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgHXIqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbgHXIqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:46:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1895B206F0;
        Mon, 24 Aug 2020 08:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258762;
        bh=6dKXPbkOsXvYAwvbYQTU8pkwY4FYFgSClqrMNdZdVw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GvF1ygbGhlnF9CEMFBkufVmGiJU/gNLQLta4+1ILmEYNauYKwubLCu4Guq9a/oaPa
         2rn/LVXGOYF1BCM4jR0ZqqCTTF3Bz3reIXsoRzSY69S0CjP3wlaFtPZBG19EvidBeX
         qekCvWgHtY9bIkcD902nCk5B+qtYomptdYlPpEOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Xu Yu <xuyu@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH 5.4 035/107] mm/memory.c: skip spurious TLB flush for retried page fault
Date:   Mon, 24 Aug 2020 10:30:01 +0200
Message-Id: <20200824082406.860641951@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Shi <shy828301@gmail.com>

commit b7333b58f358f38d90d78e00c1ee5dec82df10ad upstream.

Recently we found regression when running will_it_scale/page_fault3 test
on ARM64.  Over 70% down for the multi processes cases and over 20% down
for the multi threads cases.  It turns out the regression is caused by
commit 89b15332af7c ("mm: drop mmap_sem before calling
balance_dirty_pages() in write fault").

The test mmaps a memory size file then write to the mapping, this would
make all memory dirty and trigger dirty pages throttle, that upstream
commit would release mmap_sem then retry the page fault.  The retried
page fault would see correct PTEs installed then just fall through to
spurious TLB flush.  The regression is caused by the excessive spurious
TLB flush.  It is fine on x86 since x86's spurious TLB flush is no-op.

We could just skip the spurious TLB flush to mitigate the regression.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Xu Yu <xuyu@linux.alibaba.com>
Debugged-by: Xu Yu <xuyu@linux.alibaba.com>
Tested-by: Xu Yu <xuyu@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Yang Shi <shy828301@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3886,6 +3886,9 @@ static vm_fault_t handle_pte_fault(struc
 				vmf->flags & FAULT_FLAG_WRITE)) {
 		update_mmu_cache(vmf->vma, vmf->address, vmf->pte);
 	} else {
+		/* Skip spurious TLB flush for retried page fault */
+		if (vmf->flags & FAULT_FLAG_TRIED)
+			goto unlock;
 		/*
 		 * This is needed only for protection faults but the arch code
 		 * is not yet telling us if this is a protection fault or not.


