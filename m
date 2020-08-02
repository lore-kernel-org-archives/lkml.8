Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F40C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 13:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4EE02065C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 13:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgHBNfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 09:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgHBNfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 09:35:05 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE1AC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 06:35:05 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BKMT23ScKz9sTX; Sun,  2 Aug 2020 23:35:02 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>
Cc:     Petr Tesarik <ptesarik@suse.cz>, Nayna Jain <nayna@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Pingfan Liu <piliu@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dave Young <dyoung@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <159602259854.575379.16910915605574571585.stgit@hbathini>
References: <159602259854.575379.16910915605574571585.stgit@hbathini>
Subject: Re: [PATCH v6 00/11] ppc64: enable kdump support for kexec_file_load syscall
Message-Id: <159637523806.42190.10916857383137134464.b4-ty@ellerman.id.au>
Date:   Sun,  2 Aug 2020 23:35:02 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 17:08:44 +0530, Hari Bathini wrote:
> Sorry! There was a gateway issue on my system while posting v5, due to
> which some patches did not make it through. Resending...
> 
> This patch series enables kdump support for kexec_file_load system
> call (kexec -s -p) on PPC64. The changes are inspired from kexec-tools
> code but heavily modified for kernel consumption.
> 
> [...]

Applied to powerpc/next.

[01/11] kexec_file: Allow archs to handle special regions while locating memory hole
        https://git.kernel.org/powerpc/c/f891f19736bdf404845f97d8038054be37160ea8
[02/11] powerpc/kexec_file: Mark PPC64 specific code
        https://git.kernel.org/powerpc/c/19031275a5881233b4fc31b7dee68bf0b0758bbc
[03/11] powerpc/kexec_file: Add helper functions for getting memory ranges
        https://git.kernel.org/powerpc/c/180adfc532a83c1d74146449f7385f767d4b8059
[04/11] powerpc/kexec_file: Avoid stomping memory used by special regions
        https://git.kernel.org/powerpc/c/b8e55a3e5c208862eacded5aad822184f89f85d9
[05/11] powerpc/drmem: Make LMB walk a bit more flexible
        https://git.kernel.org/powerpc/c/adfefc609e55edc5dce18a68d1526af6d70aaf86
[06/11] powerpc/kexec_file: Restrict memory usage of kdump kernel
        https://git.kernel.org/powerpc/c/7c64e21a1c5a5bcd651d895b8faa68e9cdcc433d
[07/11] powerpc/kexec_file: Setup backup region for kdump kernel
        https://git.kernel.org/powerpc/c/1a1cf93c200581c72a3cd521e1e0a1a3b5d0077d
[08/11] powerpc/kexec_file: Prepare elfcore header for crashing kernel
        https://git.kernel.org/powerpc/c/cb350c1f1f867db16725f1bb06be033ece19e998
[09/11] powerpc/kexec_file: Add appropriate regions for memory reserve map
        https://git.kernel.org/powerpc/c/6ecd0163d36049b5f2435a8658f1320c9f3f2924
[10/11] powerpc/kexec_file: Fix kexec load failure with lack of memory hole
        https://git.kernel.org/powerpc/c/b5667d13be8d0928a02b46e0c6f7ab891d32f697
[11/11] powerpc/kexec_file: Enable early kernel OPAL calls
        https://git.kernel.org/powerpc/c/2e6bd221d96fcfd9bd1eed5cd9c008e7959daed7

cheers
