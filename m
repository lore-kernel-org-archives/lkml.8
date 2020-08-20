Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325EFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086332078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmUXcJvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgHTLxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728469AbgHTLw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597924377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sl1A0GJYyx/PpdeVM1m/fCfkzRMyvSRC51l7PfeNxkY=;
        b=AmUXcJvBXqFfFdl4vkih78OTpfyMXSd2na1rWfCd+kbgg+r8eHE3Gr756JiVzm49eGOcmx
        b8GSsNWnvjAQtdR4nlDiXpW37q+9wUcIxsm060bzK3a1ukR2e8RzbAgCcgtyyUDXLJ8gLw
        2T9tkGtCOjdcjaIaG1WtiJ2YzE16qbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-OVb8DL8xOeOkVLLilJhpGw-1; Thu, 20 Aug 2020 07:52:55 -0400
X-MC-Unique: OVb8DL8xOeOkVLLilJhpGw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22407801AE5;
        Thu, 20 Aug 2020 11:52:54 +0000 (UTC)
Received: from starship (unknown [10.35.206.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F36167A40D;
        Thu, 20 Aug 2020 11:52:46 +0000 (UTC)
Message-ID: <36a13760db3cb439eb47057c763845f61449cbcc.camel@redhat.com>
Subject: Re: [PATCH 2/8] KVM: nSVM: rename nested 'vmcb' to vmcb_gpa in few
 places
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
Date:   Thu, 20 Aug 2020 14:52:45 +0300
In-Reply-To: <3effc656-20e8-40c9-d0e3-5c700d9b5572@redhat.com>
References: <20200820091327.197807-1-mlevitsk@redhat.com>
         <20200820091327.197807-3-mlevitsk@redhat.com>
         <f6bf9494-f337-2e53-6e6c-e0b8a847ec8d@redhat.com>
         <608fe03082dc5e4db142afe3c0eb5f7c165f342b.camel@redhat.com>
         <2e8185af-08fc-18c3-c1ca-fa1f7d4665dd@redhat.com>
         <2b8faaead6f7744dc10b4701bd1583a2b494d4f4.camel@redhat.com>
         <3effc656-20e8-40c9-d0e3-5c700d9b5572@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-20 at 12:56 +0200, Paolo Bonzini wrote:
> On 20/08/20 12:23, Maxim Levitsky wrote:
> > I fully agree that adding local variable is a good idea anyway.
> > 
> > I was just noting that svm->nested.vmcb is already about the nested
> > (e.g vmcb12) thus I was thinking that naming this field vmcb12 would be
> > redundant and not accepted this way.
> 
> We want to have both svm->nested.vmcb12 and svm->nested.vmcb02 in there,
> and hsave is also a VMCB of sort (somewhat like a vmcb01 that is only
> used while running a nested guest).  So it is clearer to write _which_
> vmcb it is, and it also helps by making terminology consistent between
> VMX and SVM.
This makes sense.
Best regards,
	Maxim Levitsky

> 
> Paolo
> 


