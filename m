Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D496C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C422076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411912AbgDOTez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:34:55 -0400
Received: from baldur.buserror.net ([165.227.176.147]:35726 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634460AbgDOTeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:34:18 -0400
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1jOnl5-0007BU-K5; Wed, 15 Apr 2020 14:31:41 -0500
Message-ID: <f91c90fde203ed87dcf206e795ee55ed67b5f641.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        christophe.leroy@c-s.fr, benh@kernel.crashing.org,
        paulus@samba.org, npiggin@gmail.com, keescook@chromium.org,
        kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, zhaohongjiang@huawei.com,
        dja@axtens.net
Date:   Wed, 15 Apr 2020 14:31:38 -0500
In-Reply-To: <20200330022023.3691-1-yanaijie@huawei.com>
References: <20200330022023.3691-1-yanaijie@huawei.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: yanaijie@huawei.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com, christophe.leroy@c-s.fr, benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com, keescook@chromium.org, kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org, zhaohongjiang@huawei.com, dja@axtens.net
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v5 0/6] implement KASLR for powerpc/fsl_booke/64
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-30 at 10:20 +0800, Jason Yan wrote:
> This is a try to implement KASLR for Freescale BookE64 which is based on
> my earlier implementation for Freescale BookE32:
> 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=131718&state=*
> 
> The implementation for Freescale BookE64 is similar as BookE32. One
> difference is that Freescale BookE64 set up a TLB mapping of 1G during
> booting. Another difference is that ppc64 needs the kernel to be
> 64K-aligned. So we can randomize the kernel in this 1G mapping and make
> it 64K-aligned. This can save some code to creat another TLB map at
> early boot. The disadvantage is that we only have about 1G/64K = 16384
> slots to put the kernel in.
> 
>     KERNELBASE
> 
>           64K                     |--> kernel <--|
>            |                      |              |
>         +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
>         |  |  |  |....|  |  |  |  |  |  |  |  |  |....|  |  |
>         +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
>         |                         |                        1G
>         |----->   offset    <-----|
> 
>                               kernstart_virt_addr
> 
> I'm not sure if the slot numbers is enough or the design has any
> defects. If you have some better ideas, I would be happy to hear that.
> 
> Thank you all.
> 
> v4->v5:
>   Fix "-Werror=maybe-uninitialized" compile error.
>   Fix typo "similar as" -> "similar to".
> v3->v4:
>   Do not define __kaslr_offset as a fixed symbol. Reference __run_at_load
> and
>     __kaslr_offset by symbol instead of magic offsets.
>   Use IS_ENABLED(CONFIG_PPC32) instead of #ifdef CONFIG_PPC32.
>   Change kaslr-booke32 to kaslr-booke in index.rst
>   Switch some instructions to 64-bit.
> v2->v3:
>   Fix build error when KASLR is disabled.
> v1->v2:
>   Add __kaslr_offset for the secondary cpu boot up.
> 
> Jason Yan (6):
>   powerpc/fsl_booke/kaslr: refactor kaslr_legal_offset() and
>     kaslr_early_init()
>   powerpc/fsl_booke/64: introduce reloc_kernel_entry() helper
>   powerpc/fsl_booke/64: implement KASLR for fsl_booke64
>   powerpc/fsl_booke/64: do not clear the BSS for the second pass
>   powerpc/fsl_booke/64: clear the original kernel if randomized
>   powerpc/fsl_booke/kaslr: rename kaslr-booke32.rst to kaslr-booke.rst
>     and add 64bit part
> 
>  Documentation/powerpc/index.rst               |  2 +-
>  .../{kaslr-booke32.rst => kaslr-booke.rst}    | 35 ++++++-
>  arch/powerpc/Kconfig                          |  2 +-
>  arch/powerpc/kernel/exceptions-64e.S          | 23 +++++
>  arch/powerpc/kernel/head_64.S                 | 13 +++
>  arch/powerpc/kernel/setup_64.c                |  3 +
>  arch/powerpc/mm/mmu_decl.h                    | 23 +++--
>  arch/powerpc/mm/nohash/kaslr_booke.c          | 91 +++++++++++++------
>  8 files changed, 147 insertions(+), 45 deletions(-)
>  rename Documentation/powerpc/{kaslr-booke32.rst => kaslr-booke.rst} (59%)
> 

Acked-by: Scott Wood <oss@buserror.net>

-Scott


