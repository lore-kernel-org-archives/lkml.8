Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225A6C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F1220661
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3q+n/Q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgD1Gne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:43:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34677 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726357AbgD1Gnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588056208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I20Le+zDz/GoSa5b4+DNj+hc3tlKHqfAX93iQiHOkEs=;
        b=A3q+n/Q0XZyZ7cJosWXK2cWfzUMK0W7LtB/X14twNxefKQjY7IIcNpe/ILlfQ5ag4cpcOP
        NEXp5BtTc6Ht+4OLU4NwFuc96VE8nGmHqOhWI5/tXUkf1zhAcb44132J7D00pMFEKOLJnC
        qkmdE7CSOK+GJMBNVjD1H3NFzmVaB6s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-GC0LCi9HNDeUIsFfzxRM4g-1; Tue, 28 Apr 2020 02:43:26 -0400
X-MC-Unique: GC0LCi9HNDeUIsFfzxRM4g-1
Received: by mail-wm1-f70.google.com with SMTP id s12so662939wmj.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 23:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=I20Le+zDz/GoSa5b4+DNj+hc3tlKHqfAX93iQiHOkEs=;
        b=hU5tpUnewrWkTRO8UKEk+cl96KRp8uoP2bslZoTeqO3U5wq+ETDJlzk2MfL/1cSIzh
         IkQp0m65WQGCJCux9QjjIowQhAo9LApMkpkcCr3hnIel9twthsOlA6M0a8o62mwHwP7t
         bMOZAjuTOqvNntguCcMYAEIG+tsZ2gO5TRceivDxbywSSosuPIhHTQotHV81RGrbzNtc
         zypwlhUaUe1p9W62OJwdYfiP25DYuAioOre4X+R3Fv7ARc0Y1rzjth9G2MQxCH5zVWTF
         Pg2kKSm708EnT6SX6HClTfDqncjkg5CBil0AGchslIIwfLaLf8APPfQJGb2d5H3XFajb
         c34Q==
X-Gm-Message-State: AGi0PuaCt1GKiYCAro+DiWRMx8aUk/NlKSxA82JYL7MNZRVtpqFibCES
        nnAwRPDnaHy9py5GQpLYgYyJeJ+W5TvdgzgBqB2RN+sV4RiPPEXtZooDnM2ksNqleIMgtKdJd+t
        FrY/dn315WkMewSpD3sYzqN5U
X-Received: by 2002:adf:df8c:: with SMTP id z12mr33709550wrl.116.1588056205026;
        Mon, 27 Apr 2020 23:43:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypLAzGZy08/XGyr+vgIGi5rctiY8xcTcBztOPc4kq23XEtT5oIt+GkNV9OzCkSXVi0gI8HnVvQ==
X-Received: by 2002:adf:df8c:: with SMTP id z12mr33709528wrl.116.1588056204727;
        Mon, 27 Apr 2020 23:43:24 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t2sm2003789wmt.15.2020.04.27.23.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 23:43:24 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/idt: Keep spurious entries unset in system_vectors
In-Reply-To: <87ftcopl4p.fsf@nanos.tec.linutronix.de>
References: <20200424122535.1212732-1-vkuznets@redhat.com> <87ftcopl4p.fsf@nanos.tec.linutronix.de>
Date:   Tue, 28 Apr 2020 08:43:23 +0200
Message-ID: <87ees8hzzo.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>> Commit dc20b2d52653 ("x86/idt: Move interrupt gate initialization to IDT
>> code") had a side-effect of 'set_bit(i, used_vectors)' for unused entries
>
> That was not a side effect. That was intentional.
>
>> which are being mapped to spurious entries. (user_vectors were later
>
> user_vectors?

*used*

>
>> renamed to system_vectors).
>>
>> Previously, we used to count on system_vectors in arch_show_interrupts()
>
> We used to? Maybe you used to. I did not.

I was referring to 

commit 9d87cd61a6b71ee00b7576a3ebc10208becdbea1
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Tue Jul 7 18:26:13 2015 +0200

    x86/irq: Hide 'HYP:' line in /proc/interrupts when not on Xen/Hyper-V

and right you are, it lacks your Signed-off-by :-)

>
>> to not print unexisting entries in /proc/interrupts. E.g. 'Hypervisor
>> callback interrupts' should not be printed on bare metal. This is
>> currently broken.
>
> That was definitely unintended, but that's a purely cosmetic issue.
>
>> Setting bits in system_vectors for all unused entries also makes
>> alloc_intr_gate() fail in case someone decides to do it later. It seems
>> this is not currently an issue because all alloc_intr_gate() users are
>> calling it early, before we call idt_setup_apic_and_irq_gates() but
>> this also seems wrong.
>
> No, that's not wrong. There is absolutely no reason to allocate an
> interrupt gate later.
>
> The only thing what's wrong is that alloc_intr_gate() lacks an __init
> annotation and a sanity check to reject attempts which come in late
> after idt_setup_apic_and_irq_gates() was invoked.
>
> With that addressed we can remove the set_bit() for unused vectors to
> cure the /proc/interrupts cosmetics.
>
> Talking about side effects. This also reflects the actual number of
> system vectors which are assigned in the debugfs interface as that was
> 'broken' as well.

Ok, I was only aiming at fixing the cosmetics but making
alloc_intr_gate() __init seems to make sense too.

>
> Thanks,
>
>         tglx
>
> 8<--------------------
>  arch/x86/kernel/idt.c            |   20 ++++++++++++++++----
>  drivers/xen/events/events_base.c |   24 +++++++++++++++---------
>  2 files changed, 31 insertions(+), 13 deletions(-)
>
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -51,6 +51,9 @@ struct idt_data {
>  #define TSKG(_vector, _gdt)				\
>  	G(_vector, NULL, DEFAULT_STACK, GATE_TASK, DPL0, _gdt << 3)
>  
> +
> +static __initdata bool idt_setup_done;
> +
>  /*
>   * Early traps running on the DEFAULT_STACK because the other interrupt
>   * stacks work only after cpu_init().
> @@ -318,11 +321,16 @@ void __init idt_setup_apic_and_irq_gates
>  
>  #ifdef CONFIG_X86_LOCAL_APIC
>  	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
> -		set_bit(i, system_vectors);
> +		/*
> +		 * Don't set the non assigned system vectors in the
> +		 * system_vectors bitmap. Otherwise they show up in
> +		 * /proc/interrupts.
> +		 */
>  		entry = spurious_entries_start + 8 * (i - FIRST_SYSTEM_VECTOR);
>  		set_intr_gate(i, entry);
>  	}
>  #endif
> +	idt_setup_done = true;
>  }
>  
>  /**
> @@ -352,6 +360,7 @@ void idt_invalidate(void *addr)
>  	load_idt(&idt);
>  }
>  
> +/* This goes away once ASYNC_PF is sanitized */

Rumor has it that the work is ongoing...

>  void __init update_intr_gate(unsigned int n, const void *addr)
>  {
>  	if (WARN_ON_ONCE(!test_bit(n, system_vectors)))
> @@ -359,9 +368,12 @@ void __init update_intr_gate(unsigned in
>  	set_intr_gate(n, addr);
>  }
>  
> -void alloc_intr_gate(unsigned int n, const void *addr)
> +void __init alloc_intr_gate(unsigned int n, const void *addr)
>  {
> -	BUG_ON(n < FIRST_SYSTEM_VECTOR);
> -	if (!test_and_set_bit(n, system_vectors))
> +	if (WARN_ON(n < FIRST_SYSTEM_VECTOR))
> +		return;
> +	if (WARN_ON(idt_setup_done))
> +		return;
> +	if (!WARN_ON(test_and_set_bit(n, system_vectors)))
>  		set_intr_gate(n, addr);
>  }
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -1639,26 +1639,32 @@ EXPORT_SYMBOL_GPL(xen_set_callback_via);
>  /* Vector callbacks are better than PCI interrupts to receive event
>   * channel notifications because we can receive vector callbacks on any
>   * vcpu and we don't need PCI support or APIC interactions. */
> -void xen_callback_vector(void)
> +static void xen_callback_vector(void)
>  {
> -	int rc;
>  	uint64_t callback_via;
>  
>  	if (xen_have_vector_callback) {
>  		callback_via = HVM_CALLBACK_VECTOR(HYPERVISOR_CALLBACK_VECTOR);
> -		rc = xen_set_callback_via(callback_via);
> -		if (rc) {
> +		if (xen_set_callback_via(callback_via)) {
>  			pr_err("Request for Xen HVM callback vector failed\n");
>  			xen_have_vector_callback = 0;
> -			return;
>  		}
> -		pr_info_once("Xen HVM callback vector for event delivery is enabled\n");
> -		alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR,
> -				xen_hvm_callback_vector);
>  	}
>  }
> +
> +static __init void xen_init_callback_vector(void)
> +{
> +	xen_callback_vector();

I don't quite like the 'xen_callback_vector()' name, it sounds like it
is the irq handler but it's not. If we are to split the
alloc_intr_gate() part I'd suggest the following:

xen_alloc_callback_vector() -> alloc_intr_gate()
xen_setup_callback_vector() -> hypercall

Juergen, what do you think?

> +	if (!xen_have_vector_callback)
> +		return;
> +
> +	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, xen_hvm_callback_vector);
> +	pr_info("Xen HVM callback vector for event delivery is enabled\n");
> +}
> +
>  #else
>  void xen_callback_vector(void) {}
> +static inline void xen_init_callback_vector(void) {}
>  #endif
>  
>  #undef MODULE_PARAM_PREFIX
> @@ -1693,7 +1699,7 @@ void __init xen_init_IRQ(void)
>  			pci_xen_initial_domain();
>  	}
>  	if (xen_feature(XENFEAT_hvm_callback_vector))
> -		xen_callback_vector();
> +		xen_init_callback_vector();
>  
>  	if (xen_hvm_domain()) {
>  		native_init_IRQ();
>

Ok, I'll split this into several patches, write 'to-be-massaged'
changelogs and send v2 out. Thanks!

-- 
Vitaly

