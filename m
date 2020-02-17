Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC529C34035
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5ED920801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITVCh3hA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgBQQNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:13:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23016 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbgBQQNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581955979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y4BrwNB8Hj+0yioJs/TNbq3UIy2YcgCIxzyiFyjCQAg=;
        b=ITVCh3hA/VfLWg8J1fqnS1JZQaDL/u8SXPDXGUhildpom3Afs54Pwbd8mE1vX4uahhNtjQ
        b5Pvl/c8v63Dgh/ONruAjGzyVb9F9mKIT7lU1BLYZ9f+/ChhMN0RuIeaLWvyw0qXt5JqeF
        ggwfMDBc8oRrvVKAIVQkL/PSxIA2lI4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-HmvKlXF6Njux_PlaF6Uw4Q-1; Mon, 17 Feb 2020 11:12:57 -0500
X-MC-Unique: HmvKlXF6Njux_PlaF6Uw4Q-1
Received: by mail-wr1-f72.google.com with SMTP id n23so9161908wra.20
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 08:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Y4BrwNB8Hj+0yioJs/TNbq3UIy2YcgCIxzyiFyjCQAg=;
        b=MHlYS779GVQHi2gtWhfe+EY67/egP5oX16eOqAO4fXrK6EoOidYS5kEyb2VaqsPw5f
         NNkdIjfUhRMNgB9/dYuyxj/2nUDNAzEO14HioNLS5WJEUqCiCCLVWmxLewh1z9KwKZQG
         inb34fA9URMjrfsM7YvzLlQLzJiUYeP6Ps6u9rCcQmV9FZwuFQkGzW9t5PwSBel+tCAH
         NSVvXmVP7gKgNTe1uJXsoTo3GuZ/njxLIB/DyEcbXDnSnYL4fVqb2Mfek6ja/C3QGSXi
         A4eq3oBbd1g0EhPO1mI7cDI8Wc2y2WXUsbMfMuGGCEPF2u5V5176pm2AMORB2SMUCKgd
         Gs4w==
X-Gm-Message-State: APjAAAXaXHKPxcO6FE8izhcIFluArJlcTtNa7TnqQzsbwQT6bvZFw0MX
        kXVKfrxXxF7D66y20jeuAA/xBsk44myVIPEjIwAp/dD+k00vhWq7Jgoi3Z8Sx88zvt9q7DHwqNB
        f5aU5pdEobQ723b21GjMy/D6s
X-Received: by 2002:a1c:de55:: with SMTP id v82mr22788261wmg.48.1581955975790;
        Mon, 17 Feb 2020 08:12:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxtQWNKO6flhNFKqu/ZAXkV8yFXLY+LuFPsQB3R9PZdhyRgH7Tx8YdMlaBzAtJxLRXuRCwQg==
X-Received: by 2002:a1c:de55:: with SMTP id v82mr22788238wmg.48.1581955975563;
        Mon, 17 Feb 2020 08:12:55 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o15sm1596709wra.83.2020.02.17.08.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 08:12:54 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: x86: don't notify userspace IOAPIC on edge-triggered interrupt EOI
In-Reply-To: <1581647558-8216-1-git-send-email-linmiaohe@huawei.com>
References: <1581647558-8216-1-git-send-email-linmiaohe@huawei.com>
Date:   Mon, 17 Feb 2020 17:12:54 +0100
Message-ID: <87mu9h9oqh.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> Commit 13db77347db1 ("KVM: x86: don't notify userspace IOAPIC on edge
> EOI") said, edge-triggered interrupts don't set a bit in TMR, which means
> that IOAPIC isn't notified on EOI. And var level indicates level-triggered
> interrupt.
> But commit 3159d36ad799 ("KVM: x86: use generic function for MSI parsing")
> replace var level with irq.level by mistake. Fix it by changing irq.level
> to irq.trig_mode.
>
> Fixes: 3159d36ad799 ("KVM: x86: use generic function for MSI parsing")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/irq_comm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
> index 79afa0bb5f41..c47d2acec529 100644
> --- a/arch/x86/kvm/irq_comm.c
> +++ b/arch/x86/kvm/irq_comm.c
> @@ -417,7 +417,7 @@ void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu,
>  
>  			kvm_set_msi_irq(vcpu->kvm, entry, &irq);
>  
> -			if (irq.level &&
> +			if (irq.trig_mode &&
>  			    kvm_apic_match_dest(vcpu, NULL, APIC_DEST_NOSHORT,
>  						irq.dest_id, irq.dest_mode))
>  				__set_bit(irq.vector, ioapic_handled_vectors);

Assuming Radim's comment (13db77347db1) is correct, the change in
3159d36ad799 looks wrong and your patch restores the status
quo. Actually, kvm_set_msi_irq() always sets irq->level = 1 so checking
it is pointless.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

(but it is actually possible that there's a buggy userspace out there
which expects EOI notifications; we won't find out unless we try to fix
the bug).

-- 
Vitaly

