Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8CEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1A520C09
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeOjlopP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389668AbgE0PRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:17:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34671 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389661AbgE0PRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590592670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qDCbXpJzNPAoB5fw7601W5Vqzwk6fSUzQmDBo8OEdQ=;
        b=KeOjlopPRjdvWbe8jLS8DDF2FvH+JfNeF3PiWgCpeQTRNfCnKiR3Q6EtlIfRiosjJx7/gd
        cpnbpkySSTkn/GgvIclnlySk+xa4lJZOug83T4qercAaoYyIZHM1GmYRwyiCIg2rFEq3Rq
        oQwBxCiwJQJzZNWvO4w3HPXn/msJY1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-08sS3-wQMVGGNRHyWkuK6A-1; Wed, 27 May 2020 11:17:46 -0400
X-MC-Unique: 08sS3-wQMVGGNRHyWkuK6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B794A800688;
        Wed, 27 May 2020 15:17:44 +0000 (UTC)
Received: from starship (unknown [10.35.206.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 322E279C55;
        Wed, 27 May 2020 15:17:40 +0000 (UTC)
Message-ID: <674dc359b794d0380f90dbb9c7d026b605d40c12.camel@redhat.com>
Subject: Re: [PATCH 0/2] Fix issue with not starting nesting guests on my
 system
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tao Xu <tao3.xu@intel.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jingqi Liu <jingqi.liu@intel.com>
Date:   Wed, 27 May 2020 18:17:40 +0300
In-Reply-To: <20200527011344.GB31696@linux.intel.com>
References: <20200523161455.3940-1-mlevitsk@redhat.com>
         <20200527011344.GB31696@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-26 at 18:13 -0700, Sean Christopherson wrote:
> On Sat, May 23, 2020 at 07:14:53PM +0300, Maxim Levitsky wrote:
> > On my AMD machine I noticed that I can't start any nested guests,
> > because nested KVM (everything from master git branches) complains
> > that it can't find msr MSR_IA32_UMWAIT_CONTROL which my system
> > doesn't support
> > at all anyway.
> > 
> > I traced it to the recently added UMWAIT support to qemu and kvm.
> > The kvm portion exposed the new MSR in KVM_GET_MSR_INDEX_LIST
> > without
> > checking that it the underlying feature is supported in CPUID.
> > It happened to work when non nested because as a precation kvm,
> > tries to read each MSR on host before adding it to that list,
> > and when read gets a #GP it ignores it.
> > 
> > When running nested, the L1 hypervisor can be set to ignore unknown
> > msr read/writes (I need this for some other guests), thus this
> > safety
> > check doesn't work anymore.
> > 
> > V2: * added a patch to setup correctly the X86_FEATURE_WAITPKG kvm
> > capability
> >     * dropped the cosmetic fix patch as it is now fixed in kvm/queue
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > Maxim Levitsky (2):
> >   kvm/x86/vmx: enable X86_FEATURE_WAITPKG in KVM capabilities
> >   kvm/x86: don't expose MSR_IA32_UMWAIT_CONTROL unconditionally
> 
> Standard scoping in the shortlog is "KVM: VMX:" and "KVM: x86:".
Noted and I will use it from now on.
Thanks!

Best regards,
	Maxim Levitsky

> 
> >  arch/x86/kvm/vmx/vmx.c | 3 +++
> >  arch/x86/kvm/x86.c     | 4 ++++
> >  2 files changed, 7 insertions(+)
> > 
> > -- 
> > 2.26.2
> > 
> > 

