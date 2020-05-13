Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B09CCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E56206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eThnwqsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733000AbgEMMwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:52:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55653 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732967AbgEMMwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589374366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z4DZDbfYuTCycrch+mpZwYdp9zUWZZwfCiX9pCkKnPY=;
        b=eThnwqszx3UWTzhtAc2HKGWl+t1UPLxgPvWsdlpYvrwzrRw37wQg5qvG0jOtMvIXIEGwW/
        0BBYPBvkoHVtEMXIftf1UR/oHKpBbj2GbOTQMkmV0/GbUe7xagFmPiJFii3JM1qO/XA51l
        6nkGJ0fdvKMMeSTUlhyNd/3kCJYRakI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-NWfPLhzvOBatMMtk9ec_og-1; Wed, 13 May 2020 08:52:44 -0400
X-MC-Unique: NWfPLhzvOBatMMtk9ec_og-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95B73801504;
        Wed, 13 May 2020 12:52:42 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-240.rdu2.redhat.com [10.10.115.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 529176E701;
        Wed, 13 May 2020 12:52:42 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A13B3220206; Wed, 13 May 2020 08:52:41 -0400 (EDT)
Date:   Wed, 13 May 2020 08:52:41 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] KVM: x86: extend struct kvm_vcpu_pv_apf_data with
 token info
Message-ID: <20200513125241.GA173965@redhat.com>
References: <20200511164752.2158645-1-vkuznets@redhat.com>
 <20200511164752.2158645-3-vkuznets@redhat.com>
 <20200512152709.GB138129@redhat.com>
 <87o8qtmaat.fsf@vitty.brq.redhat.com>
 <20200512155339.GD138129@redhat.com>
 <20200512175017.GC12100@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512175017.GC12100@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:50:17AM -0700, Sean Christopherson wrote:
> On Tue, May 12, 2020 at 11:53:39AM -0400, Vivek Goyal wrote:
> > On Tue, May 12, 2020 at 05:40:10PM +0200, Vitaly Kuznetsov wrote:
> > > Vivek Goyal <vgoyal@redhat.com> writes:
> > > 
> > > > On Mon, May 11, 2020 at 06:47:46PM +0200, Vitaly Kuznetsov wrote:
> > > >> Currently, APF mechanism relies on the #PF abuse where the token is being
> > > >> passed through CR2. If we switch to using interrupts to deliver page-ready
> > > >> notifications we need a different way to pass the data. Extent the existing
> > > >> 'struct kvm_vcpu_pv_apf_data' with token information for page-ready
> > > >> notifications.
> > > >> 
> > > >> The newly introduced apf_put_user_ready() temporary puts both reason
> > > >> and token information, this will be changed to put token only when we
> > > >> switch to interrupt based notifications.
> > > >> 
> > > >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > >> ---
> > > >>  arch/x86/include/uapi/asm/kvm_para.h |  3 ++-
> > > >>  arch/x86/kvm/x86.c                   | 17 +++++++++++++----
> > > >>  2 files changed, 15 insertions(+), 5 deletions(-)
> > > >> 
> > > >> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> > > >> index 2a8e0b6b9805..e3602a1de136 100644
> > > >> --- a/arch/x86/include/uapi/asm/kvm_para.h
> > > >> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> > > >> @@ -113,7 +113,8 @@ struct kvm_mmu_op_release_pt {
> > > >>  
> > > >>  struct kvm_vcpu_pv_apf_data {
> > > >>  	__u32 reason;
> > > >> -	__u8 pad[60];
> > > >> +	__u32 pageready_token;
> > > >
> > > > How about naming this just "token". That will allow me to deliver error
> > > > as well. pageready_token name seems to imply that this will always be
> > > > successful with page being ready.
> > > >
> > > > And reason will tell whether page could successfully be ready or
> > > > it was an error. And token will help us identify the task which
> > > > is waiting for the event.
> > > 
> > > I added 'pageready_' prefix to make it clear this is not used for 'page
> > > not present' notifications where we pass token through CR2. (BTW
> > > 'reason' also becomes a misnomer because we can only see
> > > 'KVM_PV_REASON_PAGE_NOT_PRESENT' there.)
> > 
> > Sure. I am just trying to keep names in such a way so that we could
> > deliver more events and not keep it too tightly coupled with only
> > two events (page not present, page ready).
> > 
> > > 
> > > I have no strong opinion, can definitely rename this to 'token' and add
> > > a line to the documentation to re-state that this is not used for type 1
> > > events.
> > 
> > I don't even know why are we calling "type 1" and "type 2" event. Calling
> > it KVM_PV_REASON_PAGE_NOT_PRESENT  and KVM_PV_REASON_PAGE_READY event
> > is much more intuitive. If somebody is confused about how event will
> > be delivered, that could be part of documentation. And "type1" and "type2"
> > does not say anything about delivery method anyway.
> > 
> > Also, type of event should not necessarily be tied to delivery method.
> > For example if we end up introducing say, "KVM_PV_REASON_PAGE_ERROR", then
> > I would think that event can be injected both using exception (#PF or #VE)
> > as well as interrupt (depending on state of system).
> 
> Why bother preserving backwards compatibility?

New machanism does not have to support old guests but old mechanism
should probably continue to work and deprecated slowly, IMHO. Otherwise
guests which were receiving async page faults will suddenly stop getting
it over hypervisor upgrade and possibly see drop in performance.

> AIUI, both KVM and guest
> will support async #PF iff interrupt delivery is enabled.  Why not make
> the interrupt delivery approach KVM_ASYNC_PF_V2 and completely redefine the
> ABI?

That makes sense to me. Probably leave existing ABI untouched and
deprecate it over a period of time and define V2 of ABI and new guests
use it.

> E.g. to make it compatible with reflecting !PRESENT faults without a
> VM-Exit via Intel's EPT Violation #VE?

IIUC, that's what paolo is planning, that is use #VE to inform guest
of page not present. It probably will be good if both #VE notification
and interrupt based page ready notifications happen at the same time
under V2 of ABI, IMHO.

Thanks
Vivek

