Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E545BCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C458E206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRF1fDAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgELPxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:53:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48573 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730636AbgELPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589298827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12YTEk/sqwvmTK3Y5qvGAKQ+4UZ0obOPFvJEZJMJP34=;
        b=QRF1fDAVnlVE7dSlrv3s8I7kAUWj+2Yrd5KUXbMzH0ozdQOo+HBTxi+P2+V35MKNEf74v6
        5ynvW7bgyY19B+4v03qoYqrN148mAiaFuT0ZJ/sRxKIQA6o1vytpRXSolUHKA2LNQ9KlSd
        L0sElGqefJxOeMeamxYHMLCogjKNlNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-WzQueWbcNdqkDSzcwG8RIg-1; Tue, 12 May 2020 11:53:42 -0400
X-MC-Unique: WzQueWbcNdqkDSzcwG8RIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C038107ACF2;
        Tue, 12 May 2020 15:53:40 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-85.rdu2.redhat.com [10.10.116.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7F885C1B2;
        Tue, 12 May 2020 15:53:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 76964220C05; Tue, 12 May 2020 11:53:39 -0400 (EDT)
Date:   Tue, 12 May 2020 11:53:39 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] KVM: x86: extend struct kvm_vcpu_pv_apf_data with
 token info
Message-ID: <20200512155339.GD138129@redhat.com>
References: <20200511164752.2158645-1-vkuznets@redhat.com>
 <20200511164752.2158645-3-vkuznets@redhat.com>
 <20200512152709.GB138129@redhat.com>
 <87o8qtmaat.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8qtmaat.fsf@vitty.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 05:40:10PM +0200, Vitaly Kuznetsov wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > On Mon, May 11, 2020 at 06:47:46PM +0200, Vitaly Kuznetsov wrote:
> >> Currently, APF mechanism relies on the #PF abuse where the token is being
> >> passed through CR2. If we switch to using interrupts to deliver page-ready
> >> notifications we need a different way to pass the data. Extent the existing
> >> 'struct kvm_vcpu_pv_apf_data' with token information for page-ready
> >> notifications.
> >> 
> >> The newly introduced apf_put_user_ready() temporary puts both reason
> >> and token information, this will be changed to put token only when we
> >> switch to interrupt based notifications.
> >> 
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> ---
> >>  arch/x86/include/uapi/asm/kvm_para.h |  3 ++-
> >>  arch/x86/kvm/x86.c                   | 17 +++++++++++++----
> >>  2 files changed, 15 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> >> index 2a8e0b6b9805..e3602a1de136 100644
> >> --- a/arch/x86/include/uapi/asm/kvm_para.h
> >> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> >> @@ -113,7 +113,8 @@ struct kvm_mmu_op_release_pt {
> >>  
> >>  struct kvm_vcpu_pv_apf_data {
> >>  	__u32 reason;
> >> -	__u8 pad[60];
> >> +	__u32 pageready_token;
> >
> > How about naming this just "token". That will allow me to deliver error
> > as well. pageready_token name seems to imply that this will always be
> > successful with page being ready.
> >
> > And reason will tell whether page could successfully be ready or
> > it was an error. And token will help us identify the task which
> > is waiting for the event.
> 
> I added 'pageready_' prefix to make it clear this is not used for 'page
> not present' notifications where we pass token through CR2. (BTW
> 'reason' also becomes a misnomer because we can only see
> 'KVM_PV_REASON_PAGE_NOT_PRESENT' there.)

Sure. I am just trying to keep names in such a way so that we could
deliver more events and not keep it too tightly coupled with only
two events (page not present, page ready).

> 
> I have no strong opinion, can definitely rename this to 'token' and add
> a line to the documentation to re-state that this is not used for type 1
> events.

I don't even know why are we calling "type 1" and "type 2" event. Calling
it KVM_PV_REASON_PAGE_NOT_PRESENT  and KVM_PV_REASON_PAGE_READY event
is much more intuitive. If somebody is confused about how event will
be delivered, that could be part of documentation. And "type1" and "type2"
does not say anything about delivery method anyway.

Also, type of event should not necessarily be tied to delivery method.
For example if we end up introducing say, "KVM_PV_REASON_PAGE_ERROR", then
I would think that event can be injected both using exception (#PF or #VE)
as well as interrupt (depending on state of system).

Thanks
Vivek

