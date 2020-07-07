Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CEFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B722620739
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaqvuE4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgGGLgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:36:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30354 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgGGLgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594121767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FbmIz8NhZcLfFDuTmQc7QPHmWye0lSv/TRDqeAjSsg4=;
        b=HaqvuE4YDPsUFmOLyCc5DKMEWRD44dPNw9xrdS5FGtMIg5dwHWzkir3sP5ouXyCtnPH/m9
        hDBWxf0FiJVKvj2iB+oZG97M5A3zBZAq5QxBIbbyY6ywiTC1U4Xq5UWKp5UjPPhKJiOwaS
        j+epZq9jAzA4fzI+1vU+rBroBXD9MAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-k2ElBQeHNV-fbuAwkNlZ7g-1; Tue, 07 Jul 2020 07:36:06 -0400
X-MC-Unique: k2ElBQeHNV-fbuAwkNlZ7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84405800D5C;
        Tue,  7 Jul 2020 11:36:04 +0000 (UTC)
Received: from starship (unknown [10.35.206.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31DA610013D7;
        Tue,  7 Jul 2020 11:36:00 +0000 (UTC)
Message-ID: <f3c243b06b5acfea9ed4e4242d8287c7169ef1be.camel@redhat.com>
Subject: Re: [PATCH] kvm: x86: rewrite kvm_spec_ctrl_valid_bits
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>
Date:   Tue, 07 Jul 2020 14:35:59 +0300
In-Reply-To: <20200707081444.GA7417@linux.intel.com>
References: <20200702174455.282252-1-mlevitsk@redhat.com>
         <20200702181606.GF3575@linux.intel.com>
         <3793ae0da76fe00036ed0205b5ad8f1653f58ef2.camel@redhat.com>
         <20200707061105.GH5208@linux.intel.com>
         <7c1d9bbe-5f59-5b86-01e9-43c929b24218@redhat.com>
         <20200707081444.GA7417@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-07 at 01:14 -0700, Sean Christopherson wrote:
> Aren't you supposed to be on vacation? :-)
> 
> On Tue, Jul 07, 2020 at 10:04:22AM +0200, Paolo Bonzini wrote:
> > On 07/07/20 08:11, Sean Christopherson wrote:
> > > One oddity with this whole thing is that by passing through the MSR, KVM is
> > > allowing the guest to write bits it doesn't know about, which is definitely
> > > not normal.  It also means the guest could write bits that the host VMM
> > > can't.
> > 
> > That's true.  However, the main purpose of the kvm_spec_ctrl_valid_bits
> > check is to ensure that host-initiated writes are valid; this way, you
> > don't get a #GP on the next vmentry's WRMSR to MSR_IA32_SPEC_CTRL.
> > Checking the guest CPUID bit is not even necessary.
> 
> Right, what I'm saying is that rather than try and decipher specs to
> determine what bits are supported, just throw the value at hardware and
> go from there.  That's effectively what we end up doing for the guest writes
> anyways.
> 
> Actually, the current behavior will break migration if there are ever legal
> bits that KVM doesn't recognize, e.g. guest writes a value that KVM doesn't
> allow and then migration fails when the destination tries to stuff the value
> into KVM.

After thinking about this, I am thinking that we should apply similiar logic
as done with the 'cpu-pm' related features.
This way the user can choose between passing through the IA32_SPEC_CTRL,
(and in this case, we can since the user choose it, pass it right away, and thus
avoid using kvm_spec_ctrl_valid_bits completely), and between correctness,
in which case we can always emulate this msr, and therefore check all the bits,
both regard to guest and host supported values.
Does this makes sense, or do you think that this is overkill?

One thing for sure, we currently have a bug about wrong #GP in case STIBP is supported,
but IBRS isn't. I don't mind fixing it in any way that all of you agree upon.

Best regards,
	Maxim Levitsky


