Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2168DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 01:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC938206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 01:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aA8eGYCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgF2Bw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 21:52:26 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3165 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgF2BwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 21:52:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef9494c0000>; Sun, 28 Jun 2020 18:52:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 28 Jun 2020 18:52:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 28 Jun 2020 18:52:25 -0700
Received: from [10.2.63.78] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jun
 2020 01:52:25 +0000
Subject: Re: [PATCH 01/26] mm: Do page fault accounting in handle_mm_fault
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20200626223130.199227-1-peterx@redhat.com>
 <20200626223130.199227-2-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <370e06f7-a93b-21c9-c58e-57ad6ed8f8a8@nvidia.com>
Date:   Sun, 28 Jun 2020 18:52:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626223130.199227-2-peterx@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593395533; bh=Rz1nE12V3N62BhR2rCZZnTzF6cf3LlLcyVGD3/T8LPE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=aA8eGYCqH+nGNEmB4YVnq2xfMsd9UzR0xpNbBXfmv0hvRMnLHgonBkV9++25ouP1O
         /FRu8P+J+X5rpwfshoiCZSBKaUiwRBSBtf62jDvak58zsnROrGlDKSFvhU+ahZdrq0
         FgVl67tBeVJnESSRdsyYAYNwEicOUSxGStu5nrYQ6RaLIoakVz839NCXMTHMb69gtA
         s0d8y22uEpKcbMt0lEVAjEd1cAR6FcOJwY0YgIVZ/+cgJLVPSc7JeY0IXxM+t4a4L8
         hoY0Z1jnuSPSVgmp1+dPWzVkBncVyTnrg41T5NGQkrQBRiBAWsOA5YMUxKwb4o6IIV
         d9G91loChpsBQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-26 15:31, Peter Xu wrote:
> This is a preparation patch to move page fault accountings into the general
> code in handle_mm_fault().  This includes both the per task flt_maj/flt_min
> counters, and the major/minor page fault perf events.  To do this, the pt_regs
> pointer is passed into handle_mm_fault().
> 
> PERF_COUNT_SW_PAGE_FAULTS should still be kept in per-arch page fault handlers.
> 
> So far, all the pt_regs pointer that passed into handle_mm_fault() is NULL,
> which means this patch should have no intented functional change.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   arch/alpha/mm/fault.c         |  2 +-
>   arch/arc/mm/fault.c           |  2 +-
>   arch/arm/mm/fault.c           |  2 +-
>   arch/arm64/mm/fault.c         |  2 +-
>   arch/csky/mm/fault.c          |  3 +-
>   arch/hexagon/mm/vm_fault.c    |  2 +-
>   arch/ia64/mm/fault.c          |  2 +-
>   arch/m68k/mm/fault.c          |  2 +-
>   arch/microblaze/mm/fault.c    |  2 +-
>   arch/mips/mm/fault.c          |  2 +-
>   arch/nds32/mm/fault.c         |  2 +-
>   arch/nios2/mm/fault.c         |  2 +-
>   arch/openrisc/mm/fault.c      |  2 +-
>   arch/parisc/mm/fault.c        |  2 +-
>   arch/powerpc/mm/copro_fault.c |  2 +-
>   arch/powerpc/mm/fault.c       |  2 +-
>   arch/riscv/mm/fault.c         |  2 +-
>   arch/s390/mm/fault.c          |  2 +-
>   arch/sh/mm/fault.c            |  2 +-
>   arch/sparc/mm/fault_32.c      |  4 +--
>   arch/sparc/mm/fault_64.c      |  2 +-
>   arch/um/kernel/trap.c         |  2 +-
>   arch/unicore32/mm/fault.c     |  2 +-
>   arch/x86/mm/fault.c           |  2 +-
>   arch/xtensa/mm/fault.c        |  2 +-
>   drivers/iommu/amd_iommu_v2.c  |  2 +-

The above file is renamed, as of a couple weeks ago, via
commit ad8694bac410 ("iommu/amd: Move AMD IOMMU driver into
subdirectory").

Also there are a number of changes to mm/gup.c (not a concern for this
patch, but it is for the overall series). So I'm hoping you're going to
post a version that is rebased against 5.8-rc*.

thanks,
-- 
John Hubbard
NVIDIA
