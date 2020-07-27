Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD60C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D39920738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgG0H1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:27:01 -0400
Received: from ozlabs.org ([203.11.71.1]:60029 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgG0H05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:26:57 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BFWb25p3jz9sTk; Mon, 27 Jul 2020 17:26:54 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mikey@neuling.org,
        mpe@ellerman.id.au
Cc:     mingo@kernel.org, miltonm@us.ibm.com, paulus@samba.org,
        jniethe5@gmail.com, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        rogealve@br.ibm.com, linuxppc-dev@lists.ozlabs.org,
        oleg@redhat.com, pedromfc@br.ibm.com, jolsa@kernel.org,
        npiggin@gmail.com, peterz@infradead.org, christophe.leroy@c-s.fr
In-Reply-To: <20200723090813.303838-1-ravi.bangoria@linux.ibm.com>
References: <20200723090813.303838-1-ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v5 00/10] powerpc/watchpoint: Enable 2nd DAWR on baremetal and powervm
Message-Id: <159583477476.602200.17205445120834427421.b4-ty@ellerman.id.au>
Date:   Mon, 27 Jul 2020 17:26:54 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 14:38:03 +0530, Ravi Bangoria wrote:
> Last series[1] was to add basic infrastructure support for more than
> one watchpoint on Book3S powerpc. This series actually enables the 2nd
> DAWR for baremetal and powervm. Kvm guest is still not supported.
> 
> v4: https://lore.kernel.org/r/20200717040958.70561-1-ravi.bangoria@linux.ibm.com
> 
> v4->v5:
>  - Using hardcoded values instead of macros HBP_NUM_ONE and HBP_NUM_TWO.
>    Comment above HBP_NUM_MAX changed to explain it's value.
>  - Included CPU_FTR_DAWR1 into CPU_FTRS_POWER10
>  - Using generic function feat_enable() instead of
>    feat_enable_debug_facilities_v31() to enable CPU_FTR_DAWR1.
>  - ISA still includes 512B boundary in match criteria. But that's a
>    documentation mistake. Mentioned about this in the last patch.
>  - Rebased to powerpc/next
>  - Added Jordan's Reviewed-by/Tested-by tags
> 
> [...]

Applied to powerpc/next.

[01/10] powerpc/watchpoint: Fix 512 byte boundary limit
        https://git.kernel.org/powerpc/c/3190ecbfeeb2ab17778887ce3fa964615d6460fd
[02/10] powerpc/watchpoint: Fix DAWR exception constraint
        https://git.kernel.org/powerpc/c/f6780ce619f8daa285760302d56e95892087bd1f
[03/10] powerpc/watchpoint: Fix DAWR exception for CACHEOP
        https://git.kernel.org/powerpc/c/f3c832f1350bcf1e6906113ee3168066f4235dbe
[04/10] powerpc/watchpoint: Enable watchpoint functionality on power10 guest
        https://git.kernel.org/powerpc/c/8f460a8175e6d85537d581734e9fa7ef97036b1a
[05/10] powerpc/dt_cpu_ftrs: Add feature for 2nd DAWR
        https://git.kernel.org/powerpc/c/dc1cedca54704d336c333b5398daaf13b23e391b
[06/10] powerpc/watchpoint: Set CPU_FTR_DAWR1 based on pa-features bit
        https://git.kernel.org/powerpc/c/8f45ca3f8b87c4810674fbfe65de6d041ee0baee
[07/10] powerpc/watchpoint: Rename current H_SET_MODE DAWR macro
        https://git.kernel.org/powerpc/c/6f3fe297f95134e9b2386dae0067bf530e1ddca0
[08/10] powerpc/watchpoint: Guest support for 2nd DAWR hcall
        https://git.kernel.org/powerpc/c/03f3e54abd95061ea11bdb4eedbe3cab6553704f
[09/10] powerpc/watchpoint: Return available watchpoints dynamically
        https://git.kernel.org/powerpc/c/deb2bd9bcc8428d4b65b6ba640ba8b57c1b20b17
[10/10] powerpc/watchpoint: Remove 512 byte boundary
        https://git.kernel.org/powerpc/c/3f31e49dc4588d396023028791e36c23235e1334

cheers
