Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67E1C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97DC221841
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSenJWRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgEHPcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:32:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20207 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbgEHPcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588951937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0DyykdflDVUki0L9BuRfwBnn/zEUOvBXEj/RVUNAsOM=;
        b=KSenJWRiQNmirmSHdiGDPBaI3fIEs3rBM+aWfzAOxnqPeRT3An2uy3puj29e8aZ8uDbXq/
        LQv3+K0s5mR+rTjezWM2xQDJ5PZHV7kWEyP0WM5M+wFtgKq+rcbWnHcZf20Dfl3kXfNFZn
        Bc9SaVcuZbT901uk8S7ZI98EmcrC9dY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-zqy86_ozPiixTt4HVADlQg-1; Fri, 08 May 2020 11:32:13 -0400
X-MC-Unique: zqy86_ozPiixTt4HVADlQg-1
Received: by mail-qv1-f71.google.com with SMTP id ck5so2099900qvb.18
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 08:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0DyykdflDVUki0L9BuRfwBnn/zEUOvBXEj/RVUNAsOM=;
        b=j1RuRS97dLAEV3bSHY7kzNKZ5xGGIHUJT94TNNaDLFAy1PUICfLWwef/ugFugBvYlN
         LB0Zmdb6T0KLiRRw5xjpAx+iyZdrtO9WRpeu5jiFqO2BF9/dQFUrQXP5nfTCDumR9PnH
         bvqBahVAOtkK3bDGpV19sCUwqukZFIVf3POuRwQpgFs00sqNfuJidH+TEUQPmd7iVfrf
         2I02/cqN8NP1BEbQ0IPZrJgv7BLsoKGjzBGUG+6PO/X3iPFg/SXxzUqdLIAEfYX/IRlQ
         q+lfSkeMnnCDtnikE/0US+HVRivZPIVch84KFJfZ5qhstQebR3RqoNY3X79O0JGQ2rbR
         zJAg==
X-Gm-Message-State: AGi0PuZs0ClF3iznyuPpozctkAmTGMObAPUWbUrGsD1oBdYtKSQh6/r3
        iKo4UvSXFf0c9fnLADvasg7dm5+h+c9QcyU6ILbm6upXlhfI0Rs8VvzJJuPpgmfQkR7Hm5h8+GH
        60MtTJFnKA99OZ2N5CAfqEa0f
X-Received: by 2002:ad4:4d06:: with SMTP id l6mr3440391qvl.34.1588951933140;
        Fri, 08 May 2020 08:32:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypKTUxfYKuj8cTaLbMJPJDpg+HZLLUYd2UvsYRdIdNjT8g6WJWzBB/nG1RdQZ6kL7p6i2SbCbQ==
X-Received: by 2002:ad4:4d06:: with SMTP id l6mr3440362qvl.34.1588951932758;
        Fri, 08 May 2020 08:32:12 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id u7sm1422893qkc.1.2020.05.08.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 08:32:12 -0700 (PDT)
Date:   Fri, 8 May 2020 11:32:10 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 8/9] KVM: x86, SVM: isolate vcpu->arch.dr6 from
 vmcb->save.dr6
Message-ID: <20200508153210.GZ228260@xz-x1>
References: <20200507115011.494562-1-pbonzini@redhat.com>
 <20200507115011.494562-9-pbonzini@redhat.com>
 <20200507192808.GK228260@xz-x1>
 <dd8eb45b-4556-6aaa-0061-11b9124020b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd8eb45b-4556-6aaa-0061-11b9124020b1@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 12:33:57AM +0200, Paolo Bonzini wrote:
> On 07/05/20 21:28, Peter Xu wrote:
> >> -	svm->vcpu.arch.dr6 = dr6;
> >> +	WARN_ON(svm->vcpu.arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT);
> >> +	svm->vcpu.arch.dr6 &= ~(DR_TRAP_BITS | DR6_RTM);
> >> +	svm->vcpu.arch.dr6 |= dr6 & ~DR6_FIXED_1;
> > I failed to figure out what the above calculation is going to do... 
> 
> The calculation is merging the cause of the #DB with the guest DR6.
> It's basically the same effect as kvm_deliver_exception_payload. The
> payload has DR6_RTM flipped compared to DR6, so you have the following
> simplfications:
> 
> 	payload = (dr6 ^ DR6_RTM) & ~DR6_FIXED_1;
> 	/* This is kvm_deliver_exception_payload: */
>         vcpu->arch.dr6 &= ~DR_TRAP_BITS;
>         vcpu->arch.dr6 |= DR6_RTM;
> 	/* copy dr6 bits other than RTM */
>         vcpu->arch.dr6 |= payload;
> 	/* copy flipped RTM bit */
>         vcpu->arch.dr6 ^= payload & DR6_RTM;
> 
> ->
> 
> 	payload = (dr6 ^ DR6_RTM) & ~DR6_FIXED_1;
> 	/* clear RTM here, so that we can OR it below */
>         vcpu->arch.dr6 &= ~(DR_TRAP_BITS | DR6_RTM);
> 	/* copy dr6 bits other than RTM */
>         vcpu->arch.dr6 |= payload & ~DR6_RTM;
> 	/* copy flipped RTM bit */
>         vcpu->arch.dr6 |= (payload ^ DR6_RTM) & DR6_RTM;
> 
> ->
> 
> 	/* we can drop the double XOR of DR6_RTM */
> 	dr6 &= ~DR6_FIXED_1;
>         vcpu->arch.dr6 &= ~(DR_TRAP_BITS | DR6_RTM);
>         vcpu->arch.dr6 |= dr6 & ~DR6_RTM;
>         vcpu->arch.dr6 |= dr6 & DR6_RTM;
> 
> ->
> 
> 	/* we can do the two ORs with a single operation */
>         vcpu->arch.dr6 &= ~(DR_TRAP_BITS | DR6_RTM);
>         vcpu->arch.dr6 |= dr6 & ~DR6_FIXED_1;

Oh that's quite some math. :) Thanks Paolo!

Shall we introduce a helper for both kvm_deliver_exception_payload and here
(e.g. kvm_merge_dr6)?  Also, wondering whether this could be a bit easier to
follow by defining:

/*
 * These bits could be kept being set until the next #DB if not
 * explicitly cleared.
 */
#define  DR6_CARRY_OVER_BITS  (DR6_BT | DR6_BS | DR6_BD)

Then the imho above calculation could also become:

    vcpu->arch.dr6 = (vcpu->arch.dr6 & DR6_CARRY_OVER_BITS) | save.dr6;

What do you think?

> 
> > E.g., I
> > think the old "BT|BS|BD" bits in the old arch.dr6 cache will be leftover even
> > if none of them is set in save.dr6, while we shouldn't?
> 
> Those bits should be kept; this is covered for example by the "hw
> breakpoint (test that dr6.BS is not cleared)" testcase in kvm-unit-tests
> x86/debug.c.

Right.  Thanks!

-- 
Peter Xu

