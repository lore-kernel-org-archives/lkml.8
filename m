Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F67BC2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2EA20736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYdqwvGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgCKSto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:49:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41022 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730892AbgCKSto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583952582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YfBxpaAILUlLDcONCdOQOUUPmTwmQsDDi+kgpOYOtpc=;
        b=SYdqwvGM2qP1rlucV54JQ09PfOj2S+zAHe1VJ5DKv0NrmLJArrC0qSK6rdp/EADbRNm5ER
        Izo8y0sZqUO2Q5tJo541110vwwT2REIx+Cis5RfTtadLDywUKX/+bctZ88qKeTWM01+ecy
        z7FiCciXLF8SggrKEmTfY1jflU/mwhs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-IjFQuEB0N4KQrlif-VA8vA-1; Wed, 11 Mar 2020 14:49:41 -0400
X-MC-Unique: IjFQuEB0N4KQrlif-VA8vA-1
Received: by mail-wm1-f72.google.com with SMTP id n188so1237518wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 11:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YfBxpaAILUlLDcONCdOQOUUPmTwmQsDDi+kgpOYOtpc=;
        b=odftg97NzkzBSq5mc+dBLtxOZ9S6G1UWtKMlkMIDxiKawNXqUEZsevnOZN+nGI0KM6
         nt0RBdjdUHRXtPEyWPfck5qOh0673gz0IA2INm39NakVGJtRsEc4Z1tD8U/CP5AQqzGi
         5a2xdqKq+3fmmyX+m7WQwVCOn7wea/8K5WUTtTgbSTqpbAkx+IMtSj6JLkSfbUNcBk2m
         yxNF91qxIrS1s6i03sOO3ixgFgj2j6vz1SaE9bn5HZdEXw7se8PAtrEGi+EK/mgVPicL
         Gxym8CdLLlGxw2yH3itTAF3+b7/pJf082W8+6vIp7aAOWdJIEDFUmZX3qVnmY9iXcb1l
         U3ZA==
X-Gm-Message-State: ANhLgQ095VBgTyOeLCTjyg0HncWNH3xJ4N8/8bs10Pesku8fjRPlryQG
        cs5yKTjqZl3r+UBaSjvnog9wIZxJOJYV5FZ8LoG8ftd5PZVrToToJAWnLJqQFA2NYQXifuNkb5n
        fyWcLuOZmLP0qZF56NKs+JzFh
X-Received: by 2002:adf:b19d:: with SMTP id q29mr5774412wra.211.1583952579760;
        Wed, 11 Mar 2020 11:49:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvW8ZkWjSBV9LLgOlM23YlqBML0RJ6dwxVjP61v6JJHWW3ZRtss5/e2WmLmXCZ0v/RMNvtaQg==
X-Received: by 2002:adf:b19d:: with SMTP id q29mr5774388wra.211.1583952579533;
        Wed, 11 Mar 2020 11:49:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4887:2313:c0bc:e3a8? ([2001:b07:6468:f312:4887:2313:c0bc:e3a8])
        by smtp.gmail.com with ESMTPSA id z11sm9131811wmd.47.2020.03.11.11.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:49:38 -0700 (PDT)
Subject: Re: [Patch v1] KVM: x86: Initializing all kvm_lapic_irq fields
To:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com,
        vkuznets@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org
References: <1583951685-202743-1-git-send-email-nitesh@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c4370fce-1bc7-3a82-91a7-37fcd013bd77@redhat.com>
Date:   Wed, 11 Mar 2020 19:49:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583951685-202743-1-git-send-email-nitesh@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/20 19:34, Nitesh Narayan Lal wrote:
> Previously all fields of structure kvm_lapic_irq were not initialized
> before it was passed to kvm_bitmap_or_dest_vcpus(). Which will cause
> an issue when any of those fields are used for processing a request.
> This patch initializes all the fields of kvm_lapic_irq based on the
> values which are passed through the ioapic redirect_entry object.

Can you explain better how the bug manifests itself?

Thanks,

Paolo

> Fixes: 7ee30bc132c6("KVM: x86: deliver KVM IOAPIC scan request to target vCPUs")
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  arch/x86/kvm/ioapic.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> index 7668fed..3a8467d 100644
> --- a/arch/x86/kvm/ioapic.c
> +++ b/arch/x86/kvm/ioapic.c
> @@ -378,12 +378,15 @@ static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
>  		if (e->fields.delivery_mode == APIC_DM_FIXED) {
>  			struct kvm_lapic_irq irq;
>  
> -			irq.shorthand = APIC_DEST_NOSHORT;
>  			irq.vector = e->fields.vector;
>  			irq.delivery_mode = e->fields.delivery_mode << 8;
> -			irq.dest_id = e->fields.dest_id;
>  			irq.dest_mode =
>  			    kvm_lapic_irq_dest_mode(!!e->fields.dest_mode);
> +			irq.level = 1;
> +			irq.trig_mode = e->fields.trig_mode;
> +			irq.shorthand = APIC_DEST_NOSHORT;
> +			irq.dest_id = e->fields.dest_id;
> +			irq.msi_redir_hint = false;
>  			bitmap_zero(&vcpu_bitmap, 16);
>  			kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq,
>  						 &vcpu_bitmap);
> 

