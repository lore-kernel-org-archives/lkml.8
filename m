Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1724EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E242C204EF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0UayAtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgFDRpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:45:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31715 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730144AbgFDRpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591292741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qDo8p9BXXIxSVFgSR/pGZb84AN0JbtfR3XCYvCIeiuU=;
        b=d0UayAtAkIpYAVTM02tedcydLs23PaKRexgLTm1y8q2WoDGm3G4X0y0LjjwO3qtqsujTyz
        F9kBzNwGRpSfancsTCnsi4djbUp8N2tx5M0Y+qISIDWsoCTkMjA/VPke1rJ+92ibVhwFGT
        hzz0nlI9EYmkYXkYk3wFXwuY7ioM1P4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-6Fol4DoTOHqdfoN9prVAzw-1; Thu, 04 Jun 2020 13:45:37 -0400
X-MC-Unique: 6Fol4DoTOHqdfoN9prVAzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3056D107ACF5;
        Thu,  4 Jun 2020 17:45:35 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-122.rdu2.redhat.com [10.10.114.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEF5B7B5ED;
        Thu,  4 Jun 2020 17:45:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4E25C223B92; Thu,  4 Jun 2020 13:45:34 -0400 (EDT)
Date:   Thu, 4 Jun 2020 13:45:34 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] KVM: x86: Interrupt-based mechanism for
 async_pf 'page present' notifications
Message-ID: <20200604174534.GB99235@redhat.com>
References: <20200525144125.143875-1-vkuznets@redhat.com>
 <3be1df67-2e39-c7b7-b666-66cd4fe61406@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3be1df67-2e39-c7b7-b666-66cd4fe61406@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 01:04:55PM +0200, Paolo Bonzini wrote:
> On 25/05/20 16:41, Vitaly Kuznetsov wrote:
> > Concerns were expressed around (ab)using #PF for KVM's async_pf mechanism,
> > it seems that re-using #PF exception for a PV mechanism wasn't a great
> > idea after all. The Grand Plan is to switch to using e.g. #VE for 'page
> > not present' events and normal APIC interrupts for 'page ready' events.
> > This series does the later.
> > 
> > Changes since v1:
> > - struct kvm_vcpu_pv_apf_data's fields renamed to 'flags' and 'token',
> >   comments added [Vivek Goyal]
> > - 'type1/2' names for APF events dropped from everywhere [Vivek Goyal]
> > - kvm_arch_can_inject_async_page_present() renamed to 
> >   kvm_arch_can_dequeue_async_page_present [Vivek Goyal]
> > - 'KVM: x86: deprecate KVM_ASYNC_PF_SEND_ALWAYS' patch added.
> > 
> > v1: https://lore.kernel.org/kvm/20200511164752.2158645-1-vkuznets@redhat.com/
> > QEMU patches for testing: https://github.com/vittyvk/qemu.git (async_pf2_v2 branch)
> 
> I'll do another round of review and queue patches 1-7; 8-9 will be
> queued later and separately due to the conflicts with the interrupt
> entry rework, but it's my job and you don't need to do anything else.

Hi Paolo,

I seee 1-7 got merged for 5.8. When you say patch 8-9 will be queue later,
you mean later in 5.8 or it will held till 5.9 merge window opens.

Thanks
Vivek

