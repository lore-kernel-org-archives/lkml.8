Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96969C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76750206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586861695;
	bh=xFUIZbH4BsMb5b7OW+ZPT+Rdm2ffQ8mGwuPjUuQdWTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Yoi6JG5eAtIgCXPCh/i7aKqA+Embg+SFR+146+2S2+T/8yoXOT2g/VCD2Kg4W0tsK
	 KhcksjfEf7CRNd4NEcJyv2VqgVdSNQtaKcQeo1NjBc8fqVSC+DLwfCBOC/bjL67U5g
	 8GNs5BJxgdxfpqbvOXf4BKb9gv+HcyTXo3TjwXUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438690AbgDNKyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438668AbgDNKyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:54:24 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B89F5206D5;
        Tue, 14 Apr 2020 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586861660;
        bh=xFUIZbH4BsMb5b7OW+ZPT+Rdm2ffQ8mGwuPjUuQdWTQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fc/LMjA9ksRxtgC05kP1DEhmyrhWWuxz0ZFh9ZoPsYbw1EHTL/8mPb9NocwA75h+t
         xNXeTRBParT4VdvVX1hzfdLEM9lyP6cCbxLOpORbZnYpL+JqedeJ3dfWJen18yaPE+
         jup9HN8GQRTkR4FzVGqjCIneRQiwgLD0OhQjMxeQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jOJCs-0037HZ-SM; Tue, 14 Apr 2020 11:54:19 +0100
Date:   Tue, 14 Apr 2020 11:54:17 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     <kvmarm@lists.cs.columbia.edu>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>,
        <wanghaibin.wang@huawei.com>, <yezengruan@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] KVM: arm64: vgic-v3: Retire all pending LPIs on
 vcpu destroy
Message-ID: <20200414115417.451f8b66@why>
In-Reply-To: <20200414030349.625-2-yuzenghui@huawei.com>
References: <20200414030349.625-1-yuzenghui@huawei.com>
        <20200414030349.625-2-yuzenghui@huawei.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, wanghaibin.wang@huawei.com, yezengruan@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 11:03:47 +0800
Zenghui Yu <yuzenghui@huawei.com> wrote:

Hi Zenghui,

> It's likely that the vcpu fails to handle all virtual interrupts if
> userspace decides to destroy it, leaving the pending ones stay in the
> ap_list. If the un-handled one is a LPI, its vgic_irq structure will
> be eventually leaked because of an extra refcount increment in
> vgic_queue_irq_unlock().
> 
> This was detected by kmemleak on almost every guest destroy, the
> backtrace is as follows:
> 
> unreferenced object 0xffff80725aed5500 (size 128):
> comm "CPU 5/KVM", pid 40711, jiffies 4298024754 (age 166366.512s)
> hex dump (first 32 bytes):
> 00 00 00 00 00 00 00 00 08 01 a9 73 6d 80 ff ff ...........sm...
> c8 61 ee a9 00 20 ff ff 28 1e 55 81 6c 80 ff ff .a... ..(.U.l...
> backtrace:
> [<000000004bcaa122>] kmem_cache_alloc_trace+0x2dc/0x418
> [<0000000069c7dabb>] vgic_add_lpi+0x88/0x418
> [<00000000bfefd5c5>] vgic_its_cmd_handle_mapi+0x4dc/0x588
> [<00000000cf993975>] vgic_its_process_commands.part.5+0x484/0x1198
> [<000000004bd3f8e3>] vgic_its_process_commands+0x50/0x80
> [<00000000b9a65b2b>] vgic_mmio_write_its_cwriter+0xac/0x108
> [<0000000009641ebb>] dispatch_mmio_write+0xd0/0x188
> [<000000008f79d288>] __kvm_io_bus_write+0x134/0x240
> [<00000000882f39ac>] kvm_io_bus_write+0xe0/0x150
> [<0000000078197602>] io_mem_abort+0x484/0x7b8
> [<0000000060954e3c>] kvm_handle_guest_abort+0x4cc/0xa58
> [<00000000e0d0cd65>] handle_exit+0x24c/0x770
> [<00000000b44a7fad>] kvm_arch_vcpu_ioctl_run+0x460/0x1988
> [<0000000025fb897c>] kvm_vcpu_ioctl+0x4f8/0xee0
> [<000000003271e317>] do_vfs_ioctl+0x160/0xcd8
> [<00000000e7f39607>] ksys_ioctl+0x98/0xd8
> 
> Fix it by retiring all pending LPIs in the ap_list on the destroy path.
> 
> p.s. I can also reproduce it on a normal guest shutdown. It is because
> userspace still send LPIs to vcpu (through KVM_SIGNAL_MSI ioctl) while
> the guest is being shutdown and unable to handle it. A little strange
> though and haven't dig further...

What userspace are you using? You'd hope that the VMM would stop
processing I/Os when destroying the guest. But we still need to handle
it anyway, and I thing this fix makes sense.

> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  virt/kvm/arm/vgic/vgic-init.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
> index a963b9d766b7..53ec9b9d9bc4 100644
> --- a/virt/kvm/arm/vgic/vgic-init.c
> +++ b/virt/kvm/arm/vgic/vgic-init.c
> @@ -348,6 +348,12 @@ void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu)
>  {
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>  
> +	/*
> +	 * Retire all pending LPIs on this vcpu anyway as we're
> +	 * going to destroy it.
> +	 */
> +	vgic_flush_pending_lpis(vcpu);
> +
>  	INIT_LIST_HEAD(&vgic_cpu->ap_list_head);
>  }
>  

I guess that at this stage, the INIT_LIST_HEAD() is superfluous, right?

Otherwise, looks good. If you agree with the above, I can fix that
locally, no need to resend this patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
