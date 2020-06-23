Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04E4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A46E20768
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMoowhms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbgFWLN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:13:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26904 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732422AbgFWLNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592910834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvUBdJ0TDQrWcFygpaWTMSHERx8u64732APgLFi7a5I=;
        b=TMoowhms7QwY30cDLWr6lkfQktR+891rZ8soue5LuUpgl+Q+8ZO48QRAzUnOck3ChOdMqw
        HffzvcXOp7sHe3BUyJrbwTGy+EiWZtXY3wLwo4mVHXtLg67ortddBEZun1H9whY0ezsJtn
        ODOqGXEvoJAIppOpwRtxfhXfk82PIfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-Rk8Oj6GQPzysWOyMqpvILQ-1; Tue, 23 Jun 2020 07:13:49 -0400
X-MC-Unique: Rk8Oj6GQPzysWOyMqpvILQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FEA08018AC;
        Tue, 23 Jun 2020 11:13:48 +0000 (UTC)
Received: from localhost (unknown [10.40.208.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E7A57166A;
        Tue, 23 Jun 2020 11:13:46 +0000 (UTC)
Date:   Tue, 23 Jun 2020 13:13:43 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, kvm@vger.kernel.org, wanpengli@tencent.com
Subject: Re: [PATCH] kvm: lapic: fix broken vcpu hotplug
Message-ID: <20200623131343.01842ee5@redhat.com>
In-Reply-To: <c00acf88-0655-686e-3b8c-7aad03791f20@redhat.com>
References: <20200622160830.426022-1-imammedo@redhat.com>
        <c00acf88-0655-686e-3b8c-7aad03791f20@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 18:47:57 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 22/06/20 18:08, Igor Mammedov wrote:
> > Guest fails to online hotplugged CPU with error
> >   smpboot: do_boot_cpu failed(-1) to wakeup CPU#4
> > 
> > It's caused by the fact that kvm_apic_set_state(), which used to call
> > recalculate_apic_map() unconditionally and pulled hotplugged CPU into
> > apic map, is updating map conditionally [1] on state change which doesn't
> > happen in this case and apic map update is skipped.
> > 
> > Note:
> > new CPU during kvm_arch_vcpu_create() is not visible to
> > kvm_recalculate_apic_map(), so all related update calls endup
> > as NOP and only follow up kvm_apic_set_state() used to trigger map
> > update that counted in hotplugged CPU.
> > Fix issue by forcing unconditional update from kvm_apic_set_state(),
> > like it used to be.
> > 
> > 1)
> > Fixes: (4abaffce4d25a KVM: LAPIC: Recalculate apic map in batch)
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > PS:
> > it's alternative to full revert of [1], I've posted earlier
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2205600.html
> > so fii free to pick up whatever is better by now
> > ---
> >  arch/x86/kvm/lapic.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > index 34a7e0533dad..5696831d4005 100644
> > --- a/arch/x86/kvm/lapic.c
> > +++ b/arch/x86/kvm/lapic.c
> > @@ -2556,6 +2556,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
> >  	struct kvm_lapic *apic = vcpu->arch.apic;
> >  	int r;
> >  
> > +	apic->vcpu->kvm->arch.apic_map_dirty = true;
> >  	kvm_lapic_set_base(vcpu, vcpu->arch.apic_base);
> >  	/* set SPIV separately to get count of SW disabled APICs right */
> >  	apic_set_spiv(apic, *((u32 *)(s->regs + APIC_SPIV)));
> >   
> 
> Queued, but it's better to set apic_map_dirty just before the call to
> kvm_recalculate_apic_map, or you can have a variant of the race that you
> pointed out.

Here I was worried about failure path as well that is just before normal
kvm_recalculate_apic_map(), and has its own kvm_recalculate_apic_map().

but I'm not sure if we should force map update in that case.

> 
> Paolo
> 

