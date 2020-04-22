Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BE3C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4331D20776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNBYRL8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgDVQEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:04:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24094 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726358AbgDVQE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587571467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=amvTuf5wEMJvqdESpaeyMURJivlfDh/jRY31BzCdBPU=;
        b=fNBYRL8dIeMWPKdRPaKlOIJjQrpAuXtCf735spMH9LOVsLfEFBv3PmJd7Ys5mIcH3m10Bq
        VFwQkWVH4v0Hy+SJJBt+w3STHbUggtUbDwljx3fQV7JdJy0jMr+u/ICwbzOiNHE+KBJ/ab
        laHtT1HvX46c4HrPwTBGCPIJX0lchD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-5-QqutxDOl-cVj9GG-2gZA-1; Wed, 22 Apr 2020 12:04:23 -0400
X-MC-Unique: 5-QqutxDOl-cVj9GG-2gZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6898E107ACC9;
        Wed, 22 Apr 2020 16:04:19 +0000 (UTC)
Received: from gondolin (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE51B19C70;
        Wed, 22 Apr 2020 16:04:05 +0000 (UTC)
Date:   Wed, 22 Apr 2020 18:04:03 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        pbonzini@redhat.com, tsbogend@alpha.franken.de, paulus@ozlabs.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org,
        frankja@linux.ibm.com, david@redhat.com, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, christoffer.dall@arm.com,
        peterx@redhat.com, thuth@redhat.com, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] KVM: s390: clean up redundant 'kvm_run'
 parameters
Message-ID: <20200422180403.03f60b0c.cohuck@redhat.com>
In-Reply-To: <dc5e0fa3-558b-d606-bda9-ed281cf9e9ae@de.ibm.com>
References: <20200422125810.34847-1-tianjia.zhang@linux.alibaba.com>
        <20200422125810.34847-2-tianjia.zhang@linux.alibaba.com>
        <20200422154543.2efba3dd.cohuck@redhat.com>
        <dc5e0fa3-558b-d606-bda9-ed281cf9e9ae@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 17:58:04 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 22.04.20 15:45, Cornelia Huck wrote:
> > On Wed, 22 Apr 2020 20:58:04 +0800
> > Tianjia Zhang <tianjia.zhang@linux.alibaba.com> wrote:
> >   
> >> In the current kvm version, 'kvm_run' has been included in the 'kvm_vcpu'
> >> structure. Earlier than historical reasons, many kvm-related function  
> > 
> > s/Earlier than/For/ ?
> >   
> >> parameters retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time.
> >> This patch does a unified cleanup of these remaining redundant parameters.
> >>
> >> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> >> ---
> >>  arch/s390/kvm/kvm-s390.c | 37 ++++++++++++++++++++++---------------
> >>  1 file changed, 22 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> >> index e335a7e5ead7..d7bb2e7a07ff 100644
> >> --- a/arch/s390/kvm/kvm-s390.c
> >> +++ b/arch/s390/kvm/kvm-s390.c
> >> @@ -4176,8 +4176,9 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
> >>  	return rc;
> >>  }
> >>  
> >> -static void sync_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> >> +static void sync_regs_fmt2(struct kvm_vcpu *vcpu)
> >>  {
> >> +	struct kvm_run *kvm_run = vcpu->run;
> >>  	struct runtime_instr_cb *riccb;
> >>  	struct gs_cb *gscb;
> >>  
> >> @@ -4235,7 +4236,7 @@ static void sync_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> >>  		}
> >>  		if (vcpu->arch.gs_enabled) {
> >>  			current->thread.gs_cb = (struct gs_cb *)
> >> -						&vcpu->run->s.regs.gscb;
> >> +						&kvm_run->s.regs.gscb;  
> > 
> > Not sure if these changes (vcpu->run-> => kvm_run->) are really worth
> > it. (It seems they amount to at least as much as the changes advertised
> > in the patch description.)
> > 
> > Other opinions?  
> 
> Agreed. It feels kind of random. Maybe just do the first line (move kvm_run from the
> function parameter list into the variable declaration)? Not sure if this is better.
> 

There's more in this patch that I cut... but I think just moving
kvm_run from the parameter list would be much less disruptive.

