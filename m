Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B185FC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E3D720A8B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9oVx5rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDTIrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:47:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59980 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726109AbgDTIrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587372441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HbB4dFblI4nSgTZkQmOILmsy2bt4PNUY80Flmj8Lzl0=;
        b=J9oVx5rlPiR7kiCpajZMxG0nR7KQu6KiT4Vw/M0L9rD4v6sTlHZKpymzXZOQgoFF+2973H
        T+jyogZoGpjJYWhOmj578N0ZwFCTglDhL1Qz2k8KsLu2zt4or94loLs8sZjEONh6LOlCpt
        7uVUR5Zp5nFY+hlFIJrO5nzWuzjqtgk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-_UWNaRBaMr6rySuFUgxItg-1; Mon, 20 Apr 2020 04:47:20 -0400
X-MC-Unique: _UWNaRBaMr6rySuFUgxItg-1
Received: by mail-wm1-f70.google.com with SMTP id t62so3925155wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HbB4dFblI4nSgTZkQmOILmsy2bt4PNUY80Flmj8Lzl0=;
        b=mLB7jIcDAKNelCYFrNpfslpCb0HsJ5LZ1HVqIT3WOtFojIOV3HN7/H0+wNBKqIosYP
         wxqj8J9C1xHpEsHdl6DLngsyhPafOOvc83EBhPe87wdhwRldmudAaZ6VfSp6CfKoAMHz
         ziFY4SMjyf1jPt1nd+HwP9TfNO8L+j7isr56UkFTb1TqzpsMczyJ95ZQB4J+eOPTABjo
         1IyZ9Q+zFT6bRQfUArF1uox1fiXNwNeCE1DYI44YZtx06pEEB0lyOKLy/MwTvAyc5Rvr
         t2k4SNMd5fwzt7nVC1G+VGU7rBvgjrlCqZ+2OC5xzLXp3ZYAaC0W6I5FAct53UfLG9d+
         B4kg==
X-Gm-Message-State: AGi0PuY6HeGSgYgaViveUeFsNNOt9fb3hu19hHgbguoQKiaReLbAsKoQ
        PMyt4VsHNq9nHI3DsN44UJxTOWrNDaBcmX/IYyWv0Vb9GPFq2bB9lZ7p3nikdvlQ8n0pvB0AP8O
        LOVuIIj6w+VHbbETY1rDkgiqK
X-Received: by 2002:adf:f084:: with SMTP id n4mr17933035wro.252.1587372438733;
        Mon, 20 Apr 2020 01:47:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypIQKIa8NoerU8Gs+f1YIbzGfr00jazQ0JAuCubChZ7eiigPoEuXv07nc8JJRA7S+0bhRS0rDw==
X-Received: by 2002:adf:f084:: with SMTP id n4mr17933020wro.252.1587372438535;
        Mon, 20 Apr 2020 01:47:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t16sm458850wmi.27.2020.04.20.01.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:47:18 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: x86: check_nested_events is never NULL
In-Reply-To: <20200417164413.71885-2-pbonzini@redhat.com>
References: <20200417164413.71885-1-pbonzini@redhat.com> <20200417164413.71885-2-pbonzini@redhat.com>
Date:   Mon, 20 Apr 2020 10:47:16 +0200
Message-ID: <87a736tugb.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Both Intel and AMD now implement it, so there is no need to check if the
> callback is implemented.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 59958ce2b681..0492baeb78ab 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7699,7 +7699,7 @@ static int inject_pending_event(struct kvm_vcpu *vcpu)
>  	 * from L2 to L1 due to pending L1 events which require exit
>  	 * from L2 to L1.
>  	 */
> -	if (is_guest_mode(vcpu) && kvm_x86_ops.check_nested_events) {
> +	if (is_guest_mode(vcpu)) {
>  		r = kvm_x86_ops.check_nested_events(vcpu);
>  		if (r != 0)
>  			return r;
> @@ -7761,7 +7761,7 @@ static int inject_pending_event(struct kvm_vcpu *vcpu)
>  		 * proposal and current concerns.  Perhaps we should be setting
>  		 * KVM_REQ_EVENT only on certain events and not unconditionally?
>  		 */
> -		if (is_guest_mode(vcpu) && kvm_x86_ops.check_nested_events) {
> +		if (is_guest_mode(vcpu)) {
>  			r = kvm_x86_ops.check_nested_events(vcpu);
>  			if (r != 0)
>  				return r;
> @@ -8527,7 +8527,7 @@ static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
>  
>  static inline bool kvm_vcpu_running(struct kvm_vcpu *vcpu)
>  {
> -	if (is_guest_mode(vcpu) && kvm_x86_ops.check_nested_events)
> +	if (is_guest_mode(vcpu))
>  		kvm_x86_ops.check_nested_events(vcpu);
>  
>  	return (vcpu->arch.mp_state == KVM_MP_STATE_RUNNABLE &&

While the callback is implemented for both VMX and SVM, it can still be
NULL when !nested (thus patch subject is a bit misleading) but
is_guest_mode() implies this is not the case.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

