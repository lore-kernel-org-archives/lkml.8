Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B172C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3846A21D7D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGHc1jCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgBQRCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:02:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54448 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726781AbgBQRCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581958952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LTLhp/XySgncTqhbXJWLE8j6Db6J/GYHmTmc6aeppi0=;
        b=UGHc1jCjn5OUaBjjMnq/okgZbmw+zk4vmeL9+nIghgpa5BICypSiH7bYiHaRJSBlU46mQd
        V8ibIJ0HEBmFkHCzBD/Q9M9YpA7OMVYeYluC8pXnM5iO39GSAnqpNixcGFRBkjIDX2sl2q
        kdxiU5EYubSYF5z1NDXyIcOvdFZWypc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-zfv8qWHbOiuIzNGWLEaa4g-1; Mon, 17 Feb 2020 12:02:30 -0500
X-MC-Unique: zfv8qWHbOiuIzNGWLEaa4g-1
Received: by mail-wr1-f70.google.com with SMTP id s13so9241696wrb.21
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 09:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LTLhp/XySgncTqhbXJWLE8j6Db6J/GYHmTmc6aeppi0=;
        b=gJiNPZJGgfgz84hm7cbj5L3ZDvDARKtNq7jvJuAqc42BHRIUbRaJdnyWrsABvKjvUA
         9R3iVKVuiDVuC6LB9bsWTEMlLur86yqq9jnk9N+b/plcF0iPaq9Q2mjFoqSwvUir6qw3
         w4kNpf2cJT0iy07Bi7nuJmJ2muxYwAzHb5a4PtTXjMrqS13Y11ZzYHG2aDobdaaPWTBU
         MHGpMVtiNq/ryHit+r2i/m1L/C86fsYYldCAT5sQsBd3AxUSf1bugM0ZTsxzL3T7bfCx
         qAHbTgpn5AhUfuV1s1kviDP/kuq75DGYQefOvUUfz0IXOWapiZbEAqSQGrI2YzEKei+W
         xYRw==
X-Gm-Message-State: APjAAAUU4S/AxBltFyr/oxIDsYJxi0aRux9YpxN1Vctg/QI3U//QZUMz
        8cpsnUU4ntzUrTohr7A4f4BsQAUNxbVZKCuujFl2/+BG7ikao+eFyHxxrC9hQhsP/18kr4UTCzY
        7sPAi+rW40/Lgb9IyX7AkHFVT
X-Received: by 2002:a05:600c:217:: with SMTP id 23mr13731wmi.124.1581958949316;
        Mon, 17 Feb 2020 09:02:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfY3yBAKQqpVX29xpVAGynUaOiw/rNs+FoKhmA06VZKtYmd9qlKU+Q7eq6SR2DhKzSa15CBQ==
X-Received: by 2002:a05:600c:217:: with SMTP id 23mr13718wmi.124.1581958949051;
        Mon, 17 Feb 2020 09:02:29 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q14sm1753448wrj.81.2020.02.17.09.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 09:02:28 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: apic: remove unused function apic_lvt_vector()
In-Reply-To: <2fb684de-30c1-ed67-600f-08168e64d6c7@oracle.com>
References: <1581561464-3893-1-git-send-email-linmiaohe@huawei.com> <2fb684de-30c1-ed67-600f-08168e64d6c7@oracle.com>
Date:   Mon, 17 Feb 2020 18:02:27 +0100
Message-ID: <87blpx9mfw.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krish Sadhukhan <krish.sadhukhan@oracle.com> writes:

> On 2/12/20 6:37 PM, linmiaohe wrote:
>> From: Miaohe Lin <linmiaohe@huawei.com>
>>
>> The function apic_lvt_vector() is unused now, remove it.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   arch/x86/kvm/lapic.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
>> index eafc631d305c..0b563c280784 100644
>> --- a/arch/x86/kvm/lapic.c
>> +++ b/arch/x86/kvm/lapic.c
>> @@ -294,11 +294,6 @@ static inline int apic_lvt_enabled(struct kvm_lapic *apic, int lvt_type)
>>   	return !(kvm_lapic_get_reg(apic, lvt_type) & APIC_LVT_MASKED);
>>   }
>>   
>> -static inline int apic_lvt_vector(struct kvm_lapic *apic, int lvt_type)
>> -{
>> -	return kvm_lapic_get_reg(apic, lvt_type) & APIC_VECTOR_MASK;
>> -}
>> -
>>   static inline int apic_lvtt_oneshot(struct kvm_lapic *apic)
>>   {
>>   	return apic->lapic_timer.timer_mode == APIC_LVT_TIMER_ONESHOT;
>
> There is one place, lapic_timer_int_injected(), where this function be 
> used :
>
>          struct kvm_lapic *apic = vcpu->arch.apic;
> -       u32 reg = kvm_lapic_get_reg(apic, APIC_LVTT);
>
>          if (kvm_apic_hw_enabled(apic)) {
>
> -                int vec = reg & APIC_VECTOR_MASK;
>
> +               int vec = apic_lvt_vector(APIC_LVTT);
>                   void *bitmap = apic->regs + APIC_ISR;
>
>
> But since that's the only place I can find, we probably don't need a 
> separate function.
>

I like the alternative suggestion more than the original patch)

Also, apic_lvt_enabled() is only used once with APIC_LVTT as the second
argument so I'd suggest we also do:

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index afcd30d44cbb..d85463ff4a6f 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -289,14 +289,14 @@ static inline void kvm_apic_set_x2apic_id(struct kvm_lapic *apic, u32 id)
        recalculate_apic_map(apic->vcpu->kvm);
 }
 
-static inline int apic_lvt_enabled(struct kvm_lapic *apic, int lvt_type)
+static inline int apic_lvtt_enabled(struct kvm_lapic *apic)
 {
-       return !(kvm_lapic_get_reg(apic, lvt_type) & APIC_LVT_MASKED);
+       return !(kvm_lapic_get_reg(apic, APIC_LVTT) & APIC_LVT_MASKED);
 }
 
-static inline int apic_lvt_vector(struct kvm_lapic *apic, int lvt_type)
+static inline int apic_lvtt_vector(struct kvm_lapic *apic)
 {
-       return kvm_lapic_get_reg(apic, lvt_type) & APIC_VECTOR_MASK;
+       return kvm_lapic_get_reg(apic, APIC_LVTT) & APIC_VECTOR_MASK;
 }

in addition to the above.

-- 
Vitaly

