Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BCAC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F0920658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fT/lg/Lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgCPIdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:33:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49505 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730025AbgCPIdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584347634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Dg7qn9jAmmQ+Q4EHBQ5doPvYZxhBs48JydmR2W4pa0=;
        b=fT/lg/LrxLsY+ihXHzZvFa6uoy+BarDxAF/qxaTzTVaHym3kjL+AG2THjKjxccUNUCB9Xa
        tqaAIGfDAQmGBJcyYlprjavpBHG1fCLBVyyTbbSKSZE6pnkv4mEYGrCV4XPV4iHM+bSl3f
        HUoE9nYZdDt0/plQwYS8fvAS57w7Ia0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-NrbjNREPPTSSE-aphoQChQ-1; Mon, 16 Mar 2020 04:33:53 -0400
X-MC-Unique: NrbjNREPPTSSE-aphoQChQ-1
Received: by mail-wm1-f71.google.com with SMTP id r23so5504543wmn.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 01:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4Dg7qn9jAmmQ+Q4EHBQ5doPvYZxhBs48JydmR2W4pa0=;
        b=rp7fVFoIVeFBjUlaqhgEdR5Hf/MwhoeJMr8m8texes6JfUpkLykcWffwTaPury5HOO
         VT7FP4BATNnvnJzD4gzY3hjmkEw469PhNvw84nWOeZTSM7ZCbkCjRySyiuwc3s5NNrge
         MqwBs83m1ViNL4d/i6YGZMRyMDkDAZrw8iZbrDrKTTvqPiuxVcRbZaDmleUdNSzCsaMt
         yg8PpIC2xhJPvcCeD4WyjiyAYOLZIstFHSE7F48+xn4QenbdC2sqrXq6A0iDsrrJyNGZ
         hkCzfiMgLza568G8+dmD7MWOi6dGysyJOv+QB170qJX9gBxN/Nt+o9aWCWeQ5QYa2kxd
         vh6w==
X-Gm-Message-State: ANhLgQ1X+1+yd6d5ZFzii7w1oKUis+6oZEIwHRzxVto7n3nwdAlyxwb0
        EcDnGO2x8dwMH5TQ4sVFOLrJow4H09CAAY2iLNtIohRzx7WvKKszCNM9Tj7coIqsejioEsfk21V
        +ktuzrRpIaytVcSpLw1lRmr/K
X-Received: by 2002:a1c:6387:: with SMTP id x129mr26739572wmb.58.1584347631921;
        Mon, 16 Mar 2020 01:33:51 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsBK9XwYLhjvpKzVGJjmbGp9jcF+cp/eYqWwn2d+jEyZvqCLcknP0FBYuAncJ7EVmcWPeU6PQ==
X-Received: by 2002:a1c:6387:: with SMTP id x129mr26739557wmb.58.1584347631712;
        Mon, 16 Mar 2020 01:33:51 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 31sm8703050wrr.5.2020.03.16.01.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 01:33:51 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linmiaohe@huawei.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: X86: correct meaningless kvm_apicv_activated() check
In-Reply-To: <1584185480-3556-1-git-send-email-pbonzini@redhat.com>
References: <1584185480-3556-1-git-send-email-pbonzini@redhat.com>
Date:   Mon, 16 Mar 2020 09:33:50 +0100
Message-ID: <878sk0n1g1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> After test_and_set_bit() for kvm->arch.apicv_inhibit_reasons, we will
> always get false when calling kvm_apicv_activated() because it's sure
> apicv_inhibit_reasons do not equal to 0.
>
> What the code wants to do, is check whether APICv was *already* active
> and if so skip the costly request; we can do this using cmpxchg.
>
> Reported-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a7cb85231330..49efa4529662 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8049,19 +8049,26 @@ void kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
>   */
>  void kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
>  {
> +	unsigned long old, new, expected;
> +
>  	if (!kvm_x86_ops->check_apicv_inhibit_reasons ||
>  	    !kvm_x86_ops->check_apicv_inhibit_reasons(bit))
>  		return;
>  
> -	if (activate) {
> -		if (!test_and_clear_bit(bit, &kvm->arch.apicv_inhibit_reasons) ||
> -		    !kvm_apicv_activated(kvm))
> -			return;
> -	} else {
> -		if (test_and_set_bit(bit, &kvm->arch.apicv_inhibit_reasons) ||
> -		    kvm_apicv_activated(kvm))
> -			return;
> -	}
> +	old = READ_ONCE(kvm->arch.apicv_inhibit_reasons);
> +	do {
> +		expected = new = old;
> +		if (activate)
> +			__clear_bit(bit, &new);
> +		else
> +			__set_bit(bit, &new);
> +		if (new == old)
> +			break;
> +		old = cmpxchg(&kvm->arch.apicv_inhibit_reasons, expected, new);
> +	} while (old != expected);

'expected' here is a bit confusing as it's not what we expect to get as
the result but rather what we expect to see pre-change. I don't have a
better suggestion though.

> +
> +	if ((old == 0) == (new == 0))
> +		return;

This is a very laconic expression I personally find hard to read :-)

	/* Check if WE actually changed APICv state */
        if ((!old && !new) || (old && new))
		return;

would be my preference (not strong though, I read yours several times
and now I feel like I understand it just fine :-)

>  
>  	trace_kvm_apicv_update_request(activate, bit);
>  	if (kvm_x86_ops->pre_update_apicv_exec_ctrl)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

