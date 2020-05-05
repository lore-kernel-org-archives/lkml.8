Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB29C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD56720735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0ZpsJPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgEEOTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:19:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32523 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730081AbgEEOQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588688180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s1Gnhsex7IEz73A8ZB5poIdfMPTSBcM675dHjORTals=;
        b=O0ZpsJPdU5JMWeB1bvmn0A0EGd1yYmQzfVvr9FnbkWU8b7BsEHtfagIDZnP30x0JbGqqQe
        tv0vW+FC52+RirflELHCvAlzfO5pYxuXBJ0BBoCo/C08tKXtV7p8WUbAVOQQ4oBfwbTSvF
        8H3FSgR0t1olra8HIZn6gSfm979AAPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-nheUdfDqPmaV8UOOzq7zCg-1; Tue, 05 May 2020 10:16:06 -0400
X-MC-Unique: nheUdfDqPmaV8UOOzq7zCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D272872FE0;
        Tue,  5 May 2020 14:16:04 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-211.rdu2.redhat.com [10.10.116.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F0495D9D5;
        Tue,  5 May 2020 14:16:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 59771222F75; Tue,  5 May 2020 10:16:03 -0400 (EDT)
Date:   Tue, 5 May 2020 10:16:03 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH RFC 1/6] Revert "KVM: async_pf: Fix #DF due to inject
 "Page not Present" and "Page Ready" exceptions simultaneously"
Message-ID: <20200505141603.GA7155@redhat.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com>
 <20200429093634.1514902-2-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429093634.1514902-2-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:36:29AM +0200, Vitaly Kuznetsov wrote:
> Commit 9a6e7c39810e (""KVM: async_pf: Fix #DF due to inject "Page not
> Present" and "Page Ready" exceptions simultaneously") added a protection
> against 'page ready' notification coming before 'page not ready' is
> delivered.

Hi Vitaly,

Description of the commit seems to suggest that it is solving double
fault issue. That is both "page not present" and "page ready" exceptions
got queued and on next vcpu entry, it will result in double fault.

It does not seem to solve the issue of "page not ready" being delivered
before "page ready". That guest can handle already and its not an issue.

> This situation seems to be impossible since commit 2a266f23550b
> ("KVM MMU: check pending exception before injecting APF) which added
> 'vcpu->arch.exception.pending' check to kvm_can_do_async_pf.

This original commit description is confusing too. It says.

"For example, when two APF's for page ready happen after one exit and
 the first one becomes pending, the second one will result in #DF.
 Instead, just handle the second page fault synchronously."

So it seems to be trying to protect against that two "page ready"
exceptions don't get queued simultaneously. But you can't fall back
to synchronous mechanism once you have started the async pf prototocol.
Once you have started async page fault protocol by sending "page not
reay", you have to send "page ready". So I am not sure how above commit
solved the issue of two "page ready" not being queued at the same time.

I am wondering what problem did this commit solve. It looks like it
can avoid queueing two "page not ready" events. But can that even happen?

> 
> On x86, kvm_arch_async_page_present() has only one call site:
> kvm_check_async_pf_completion() loop and we only enter the loop when
> kvm_arch_can_inject_async_page_present(vcpu) which when async pf msr
> is enabled, translates into kvm_can_do_async_pf().

kvm_check_async_pf_completion() skips injecting "page ready" if fault
can't be injected now. Does that mean we leave it queued and it will
be injected after next exit.

If yes, then previous commit kind of makes sense. When it will not
queue up two exceptions at the same time but will wait for queuing
up the exception after next exit. But commit description still seems
to be wrong in the sense it is not falling back to synchronous page
fault for "page ready" events.

try_async_pf() also calls kvm_can_do_async_pf(). And IIUC, it will
fall back to synchrounous fault if injecting async_pf is not possible
at this point of time. So that means despite the fact that async pf
is enabled, all the page faults might not take that route and some
will fall back to synchrounous faults. I am concerned that how will
this work for reporting errors back to guest (for virtiofs use case).
If we are relying on async pf mechanism to also be able to report
errors back, then we can't afford to do synchrounous page faults becase
we don't have a way to report errors back to guest and it will hang (if
page can't be faulted in).

So either we need a way to report errors back while doing synchrounous
page faults or we can't fall back to synchorounous page faults while
async page faults are enabled. 

While we are reworking async page mechanism, want to make sure that
error reporting part has been taken care of as part of design. Don't
want to be dealing with it after the fact.

Thanks
Vivek


> 
> There is also one problem with the cancellation mechanism. We don't seem
> to check that the 'page not ready' notification we're cancelling matches
> the 'page ready' notification so in theory, we may erroneously drop two
> valid events.
> 
> Revert the commit. apf_get_user() stays as we will need it for the new
> 'page ready notifications via interrupt' mechanism.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c5835f9cb9ad..b93133ee07ba 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10430,7 +10430,6 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>  				 struct kvm_async_pf *work)
>  {
>  	struct x86_exception fault;
> -	u32 val;
>  
>  	if (work->wakeup_all)
>  		work->arch.token = ~0; /* broadcast wakeup */
> @@ -10439,19 +10438,7 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>  	trace_kvm_async_pf_ready(work->arch.token, work->cr2_or_gpa);
>  
>  	if (vcpu->arch.apf.msr_val & KVM_ASYNC_PF_ENABLED &&
> -	    !apf_get_user(vcpu, &val)) {
> -		if (val == KVM_PV_REASON_PAGE_NOT_PRESENT &&
> -		    vcpu->arch.exception.pending &&
> -		    vcpu->arch.exception.nr == PF_VECTOR &&
> -		    !apf_put_user(vcpu, 0)) {
> -			vcpu->arch.exception.injected = false;
> -			vcpu->arch.exception.pending = false;
> -			vcpu->arch.exception.nr = 0;
> -			vcpu->arch.exception.has_error_code = false;
> -			vcpu->arch.exception.error_code = 0;
> -			vcpu->arch.exception.has_payload = false;
> -			vcpu->arch.exception.payload = 0;
> -		} else if (!apf_put_user(vcpu, KVM_PV_REASON_PAGE_READY)) {
> +	    !apf_put_user(vcpu, KVM_PV_REASON_PAGE_READY)) {
>  			fault.vector = PF_VECTOR;
>  			fault.error_code_valid = true;
>  			fault.error_code = 0;
> @@ -10459,7 +10446,6 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>  			fault.address = work->arch.token;
>  			fault.async_page_fault = true;
>  			kvm_inject_page_fault(vcpu, &fault);
> -		}
>  	}
>  	vcpu->arch.apf.halted = false;
>  	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
> -- 
> 2.25.3
> 

