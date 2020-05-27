Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACCCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78EE620B80
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Y+vOgomL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgE0EVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 00:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgE0EVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 00:21:03 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D7FC03E97B;
        Tue, 26 May 2020 21:21:03 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1003)
        id 49WyLj3GH6z9sSn; Wed, 27 May 2020 14:21:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1590553261; bh=LuXoMj6P54e5QxwVC+3xCxjAdWePyW9Cgdi4Q0bcS1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+vOgomLr6ESV/IJP7UO0AaXuz/DuXxNtue37EXI8dBVu7nQizh6dPqM13DMY4Xot
         2Q0a3sMEwLN2dZVj+YYn6wT65hE5ztVdWE5U3QsIzlO6NKWthROchj188cmcehgnLC
         78E8ff33tvHuAaN8ovmpMXfU2JK0NyCN77HTz2NsQh8d3+elhTBehkDmXG+ZmPrasS
         RYyUDLxZH/7owlxyQJbCNUc+gUkjrgVGesWtgB+OmvpGx7qQIsVfPxyFdUmJBastdX
         PEupmA6lBUNmssjgyTfDWtyEob1mJX6LKewQVZoVp7dENIfz1hNnsshLIdnCg+kA8w
         phOvtndHgXIRw==
Date:   Wed, 27 May 2020 14:19:22 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, aik@ozlabs.ru,
        paulmck@kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kvm/book3s64/vio: fix some RCU-list locks
Message-ID: <20200527041922.GE293451@thinks.paulus.ozlabs.org>
References: <20200510051834.2011-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510051834.2011-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 01:18:34AM -0400, Qian Cai wrote:
> It is unsafe to traverse kvm->arch.spapr_tce_tables and
> stt->iommu_tables without the RCU read lock held. Also, add
> cond_resched_rcu() in places with the RCU read lock held that could take
> a while to finish.
> 
>  arch/powerpc/kvm/book3s_64_vio.c:76 RCU-list traversed in non-reader section!!
> 
>  other info that might help us debug this:
> 
>  rcu_scheduler_active = 2, debug_locks = 1
>  no locks held by qemu-kvm/4265.
> 
>  stack backtrace:
>  CPU: 96 PID: 4265 Comm: qemu-kvm Not tainted 5.7.0-rc4-next-20200508+ #2
>  Call Trace:
>  [c000201a8690f720] [c000000000715948] dump_stack+0xfc/0x174 (unreliable)
>  [c000201a8690f770] [c0000000001d9470] lockdep_rcu_suspicious+0x140/0x164
>  [c000201a8690f7f0] [c008000010b9fb48] kvm_spapr_tce_release_iommu_group+0x1f0/0x220 [kvm]
>  [c000201a8690f870] [c008000010b8462c] kvm_spapr_tce_release_vfio_group+0x54/0xb0 [kvm]
>  [c000201a8690f8a0] [c008000010b84710] kvm_vfio_destroy+0x88/0x140 [kvm]
>  [c000201a8690f8f0] [c008000010b7d488] kvm_put_kvm+0x370/0x600 [kvm]
>  [c000201a8690f990] [c008000010b7e3c0] kvm_vm_release+0x38/0x60 [kvm]
>  [c000201a8690f9c0] [c0000000005223f4] __fput+0x124/0x330
>  [c000201a8690fa20] [c000000000151cd8] task_work_run+0xb8/0x130
>  [c000201a8690fa70] [c0000000001197e8] do_exit+0x4e8/0xfa0
>  [c000201a8690fb70] [c00000000011a374] do_group_exit+0x64/0xd0
>  [c000201a8690fbb0] [c000000000132c90] get_signal+0x1f0/0x1200
>  [c000201a8690fcc0] [c000000000020690] do_notify_resume+0x130/0x3c0
>  [c000201a8690fda0] [c000000000038d64] syscall_exit_prepare+0x1a4/0x280
>  [c000201a8690fe20] [c00000000000c8f8] system_call_common+0xf8/0x278
> 
>  ====
>  arch/powerpc/kvm/book3s_64_vio.c:368 RCU-list traversed in non-reader section!!
> 
>  other info that might help us debug this:
> 
>  rcu_scheduler_active = 2, debug_locks = 1
>  2 locks held by qemu-kvm/4264:
>   #0: c000201ae2d000d8 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0xdc/0x950 [kvm]
>   #1: c000200c9ed0c468 (&kvm->srcu){....}-{0:0}, at: kvmppc_h_put_tce+0x88/0x340 [kvm]
> 
>  ====
>  arch/powerpc/kvm/book3s_64_vio.c:108 RCU-list traversed in non-reader section!!
> 
>  other info that might help us debug this:
> 
>  rcu_scheduler_active = 2, debug_locks = 1
>  1 lock held by qemu-kvm/4257:
>   #0: c000200b1b363a40 (&kv->lock){+.+.}-{3:3}, at: kvm_vfio_set_attr+0x598/0x6c0 [kvm]
> 
>  ====
>  arch/powerpc/kvm/book3s_64_vio.c:146 RCU-list traversed in non-reader section!!
> 
>  other info that might help us debug this:
> 
>  rcu_scheduler_active = 2, debug_locks = 1
>  1 lock held by qemu-kvm/4257:
>   #0: c000200b1b363a40 (&kv->lock){+.+.}-{3:3}, at: kvm_vfio_set_attr+0x598/0x6c0 [kvm]
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Thanks, applied to my kvm-ppc-next branch, with the cond_resched_rcu()
in kvmppc_tce_validate removed.

Paul.
