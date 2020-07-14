Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AC0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7307422510
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIFXQax8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgGNOMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:12:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39920 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725821AbgGNOMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594735921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZlccC2VgtZKkvdcQsdEfleuqF4KQO54hAbgkXaUNTPI=;
        b=JIFXQax8r0QKF6V/iwsZoNwXu+UGvinHzanNkfqPX2nt18kXwb4LFDrVtn5t7tAhXKZcro
        2te8/NCJn3CyPelW5tEeLUEc4kUO7kO6931TQ9J3LQnpwDMxwZnInCsFYuL083AMcoQxIQ
        g3dsDOnELnakPeuNagZ/Cs0/tvLDyjY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-i-ic_FI7NMerBl8QTUpgrw-1; Tue, 14 Jul 2020 10:11:56 -0400
X-MC-Unique: i-ic_FI7NMerBl8QTUpgrw-1
Received: by mail-wr1-f71.google.com with SMTP id b8so21928463wro.19
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZlccC2VgtZKkvdcQsdEfleuqF4KQO54hAbgkXaUNTPI=;
        b=NuO3pEvv9DlTKWZ7OzRNRcPHPY93qWjIfEV+bEdJnY4Qk2SKrZsYafsFfHZ73RiNOm
         KmlM0AUiNw3UgqjkbocOcAkdIIKP8Ah9PRRNItmkbIL82oOy5c4xC6qewlNJseGeTv2Y
         DtX9PW96ioILwNEll+9YmRFzToI89J33lLVzXLbeWsKmafyMVerasD1XIZ8C4F64uDJ4
         5rcTiWv3QKhdpIwFhnU7bO1RC2knLjoccdCQ6pNm/4VJ4IZqPVLtJvHX2rNDfqFtOjI2
         gjR74TsYtAbBc2BKC6HDgdDF1/3/S2wSpvC/whkCiyhrtBdwM7NkMyPsPr2BE5YPTjf8
         V4SQ==
X-Gm-Message-State: AOAM530xX07FJPMAmPypnZ1t1YPgZdZRmKEMGkKc4IlLJWH/PXBH6jUT
        dtUHtCCnNXdE2fHc8bpkbK0oQ+1oOvj9pyoLvYLFml6Ry8Yt9A3sKm81x1OF8ZYjzovQ1C3zntY
        jZxsCPgvF2gs0Dw30TDghifse
X-Received: by 2002:a5d:4d0b:: with SMTP id z11mr5778510wrt.24.1594735914908;
        Tue, 14 Jul 2020 07:11:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFEojZs2OzIsVnCpzb4g8z6CrvtNNpI2dcvnB21QDx6c3aUW+k3CIoXw7UXlBiYhbfOkNOJw==
X-Received: by 2002:a5d:4d0b:: with SMTP id z11mr5778479wrt.24.1594735914657;
        Tue, 14 Jul 2020 07:11:54 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b23sm5028357wmd.37.2020.07.14.07.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:11:52 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86: Don't attempt to load PDPTRs when 64-bit mode is enabled
In-Reply-To: <20200714132120.GA14404@linux.intel.com>
References: <20200714015732.32426-1-sean.j.christopherson@intel.com> <87wo36s3wb.fsf@vitty.brq.redhat.com> <20200714132120.GA14404@linux.intel.com>
Date:   Tue, 14 Jul 2020 16:11:50 +0200
Message-ID: <87tuyarxsp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Tue, Jul 14, 2020 at 02:00:04PM +0200, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> > index 95ef629228691..5f526d94c33f3 100644
>> > --- a/arch/x86/kvm/x86.c
>> > +++ b/arch/x86/kvm/x86.c
>> > @@ -819,22 +819,22 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
>> >  	if ((cr0 & X86_CR0_PG) && !(cr0 & X86_CR0_PE))
>> >  		return 1;
>> >  
>> > -	if (cr0 & X86_CR0_PG) {
>> >  #ifdef CONFIG_X86_64
>> > -		if (!is_paging(vcpu) && (vcpu->arch.efer & EFER_LME)) {
>> > -			int cs_db, cs_l;
>> > +	if ((vcpu->arch.efer & EFER_LME) && !is_paging(vcpu) &&
>> > +	    (cr0 & X86_CR0_PG)) {
>> 
>> it seems we have more than one occurance of "if (vcpu->arch.efer &
>> EFER_LME)" under "#ifdef CONFIG_X86_64" and we alredy have 
>> 
>> static inline int is_long_mode(struct kvm_vcpu *vcpu)
>> {
>> #ifdef CONFIG_X86_64
>>      return vcpu->arch.efer & EFER_LMA;
>> #else
>>      return 0;
>> #endif
>> }
>> 
>> so if we use this instead, the compilers will just throw away the
>> non-reachable blocks when !(#ifdef CONFIG_X86_64), right?
>
> EFER.LME vs. EFER.LMA.  The kvm_set_cr0() check is specifically looking at
> the case where EFER.LME=1, EFER.LMA=0, and CR0.PG is being toggled on, i.e.
> long mode is being enabled.  EFER_LMA won't be set until vmx_set_cr0() does
> enter_lmode().

Oops, shame on me :-(

Would it make sense to introduce something like is_long_mode()
(e.g. is_efer_lme()) for LME and #ifdef CONFIG_X86_64? I see the
same checks in vmx_set_cr0()/svm_set_cr0())?

-- 
Vitaly

