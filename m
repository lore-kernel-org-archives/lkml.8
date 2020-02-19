Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF29C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6BA24654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgBSMj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:39:57 -0500
Received: from ozlabs.org ([203.11.71.1]:46065 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbgBSMjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:39:54 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48My3W5Zfyz9sSL; Wed, 19 Feb 2020 23:39:51 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f2b67ef90b0d5eca0f2255e02cf2f620bc0ddcdb
In-Reply-To: <90ec56a2315be602494619ed0223bba3b0b8d619.1580997007.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/hugetlb: Fix 512k hugepages on 8xx with 16k page size
Message-Id: <48My3W5Zfyz9sSL@ozlabs.org>
Date:   Wed, 19 Feb 2020 23:39:51 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-06 at 13:50:28 UTC, Christophe Leroy wrote:
> Commit 55c8fc3f4930 ("powerpc/8xx: reintroduce 16K pages with HW
> assistance") redefined pte_t as a struct of 4 pte_basic_t, because
> in 16K pages mode there are four identical entries in the
> page table. But the size of hugepage tables is calculated based
> of the size of (void *). Therefore, we end up with page tables
> of size 1k instead of 4k for 512k pages.
> 
> As 512k hugepage tables are the same size as standard page tables,
> ie 4k, use the standard page tables instead of PGT_CACHE tables.
> 
> Fixes: 3fb69c6a1a13 ("powerpc/8xx: Enable 512k hugepage support with HW assistance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/f2b67ef90b0d5eca0f2255e02cf2f620bc0ddcdb

cheers
