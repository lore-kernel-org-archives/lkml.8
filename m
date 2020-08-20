Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DA2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4461207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZnw+bKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgHTMKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:10:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54589 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729947AbgHTJ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597917471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YoVO4gW0BRJ7HVJTZG7bVtpLlKCCH4sMRqpGZB6/kqg=;
        b=NZnw+bKVBtcN0VVABxGJQcCszueZ0Cf73pcVgPZ2SHw2wMiEQWj+F6zAlegPT28Cn8hlzV
        HeNFhEMpQn9Fxg9F4aJqdARHdTJHxsH00KlUrg1PXWK4AoZKKuwIgFjLC1tYtfCodlmil1
        52HeOjzsNzSYQJKXv3Y5qk/AR6JX8bI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-JbrHxTMeO-Cw-DjQMoCjVQ-1; Thu, 20 Aug 2020 05:57:47 -0400
X-MC-Unique: JbrHxTMeO-Cw-DjQMoCjVQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01C018030A3;
        Thu, 20 Aug 2020 09:57:46 +0000 (UTC)
Received: from starship (unknown [10.35.206.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8129A5E1DD;
        Thu, 20 Aug 2020 09:57:42 +0000 (UTC)
Message-ID: <d09c5cff2557bb6bb2102c57860c65f673bb72f0.camel@redhat.com>
Subject: Re: [PATCH 8/8] KVM: nSVM: read only changed fields of the nested
 guest data area
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Date:   Thu, 20 Aug 2020 12:57:41 +0300
In-Reply-To: <766e669d-9b0b-aad6-b1d2-19ef77cbb791@redhat.com>
References: <20200820091327.197807-1-mlevitsk@redhat.com>
         <20200820091327.197807-9-mlevitsk@redhat.com>
         <766e669d-9b0b-aad6-b1d2-19ef77cbb791@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-20 at 11:55 +0200, Paolo Bonzini wrote:
> On 20/08/20 11:13, Maxim Levitsky wrote:
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 06668e0f93e7..f0bb7f622dca 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -3924,7 +3924,7 @@ static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
> >  		if (kvm_vcpu_map(&svm->vcpu, gpa_to_gfn(vmcb_gpa), &map) == -EINVAL)
> >  			return 1;
> >  
> > -		load_nested_vmcb(svm, map.hva, vmcb);
> > +		load_nested_vmcb(svm, map.hva, vmcb_gpa);
> >  		ret = enter_svm_guest_mode(svm);
> >  
> 
> Wrong patch?

Absolutely. I reordered the refactoring patches to be at the beginning,
and didn't test this enough.

Best regards,
	Maxim Levitsky

> 
> Paolo
> 


