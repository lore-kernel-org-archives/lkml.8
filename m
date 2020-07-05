Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F18C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3CA220737
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCD0MNCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgGEP5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 11:57:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49011 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727843AbgGEP5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 11:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593964627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/GJsuCT73gLGt03xxtSABG0dllJoj9gjPgi6ZNtIWaw=;
        b=MCD0MNCQB6C8hD7A3Y+NMtqLp6v2BM6VmS3LT4xGgJcKJgYrLnELMMnzWFOSTvj+WXnvUA
        ZKY5GvdH8iD1iZDVO64esmcSAp16VtGOmsAZWc6Pbtm+NngjS3bpguTlCih5+8Zy/a0KYJ
        TkPX9ShEMBQquLc+/opIUihQm44lQP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-XTFwP_eyMtGf0BAc5FQEdw-1; Sun, 05 Jul 2020 11:57:03 -0400
X-MC-Unique: XTFwP_eyMtGf0BAc5FQEdw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9145918FE860;
        Sun,  5 Jul 2020 15:57:00 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-238.rdu2.redhat.com [10.10.112.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 752B87BED0;
        Sun,  5 Jul 2020 15:56:57 +0000 (UTC)
Subject: Re: [PATCH v3] x86/speculation/l1tf: Add KConfig for setting the L1D
 cache flush mode
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Doug Anderson <dianders@google.com>
Cc:     Abhishek Bhardwaj <abhishekbh@google.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        x86 <x86@kernel.org>
References: <20200702221237.2517080-1-abhishekbh@google.com>
 <e7bc00fc-fe53-800e-8439-f1fbdca5dd26@redhat.com>
 <CAN_oZf2t+gUqXe19Yo1mTzAgk2xNhssE-9p58EvH-gw5jpuvzA@mail.gmail.com>
 <CA+noqoj6u9n_KKohZw+QCpD-Qj0EgoCXaPEsryD7ABZ7QpqQfg@mail.gmail.com>
 <20200703114037.GD2999146@linux.ibm.com>
 <CAD=FV=XRbrFqSbR619h+9HXNyrYNbqfBF2e-+iUZco9qQ8Wokg@mail.gmail.com>
 <20200705152304.GE2999146@linux.ibm.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <5d2ccf3d-b473-cf30-b863-e29bb33b7284@redhat.com>
Date:   Sun, 5 Jul 2020 11:56:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200705152304.GE2999146@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/20 11:23 AM, Mike Rapoport wrote:
>> Nothing prevents people from continuing to use the command line
>> options if they want, right?  This just allows a different default.
>> So if a distro is security focused and decided that it wanted a slower
>> / more secure default then it could ship that way but individual users
>> could still override, right?
> Well, nothing prevents you from continuing to use the command line as
> well;-)
>
> I can see why whould you want an ability to select compile time default
> for an option, but I'm really not thrilled by the added ifdefery.
>   

It turns out that CONFIG_KVM_VMENTRY_L1D_FLUSH values match the enum 
vmx_l1d_flush_state values. So one way to reduce the ifdefery is to do, 
for example,

+#ifdef CONFIG_KVM_VMENTRY_L1D_FLUSH
+#define VMENTER_L1D_FLUSH_DEFAULT CONFIG_KVM_VMENTRY_L1D_FLUSH
+#else
+#define VMENTER_L1D_FLUSH_DEFAULT      VMENTER_L1D_FLUSH_AUTO
#endif
-enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
+enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_DEFAULT;

Of course, we may need to add a comment on enum vmx_l1d_flush_state 
definition to highlight the dependency of CONFIG_KVM_VMENTRY_L1D_FLUSH 
on it to avoid future mismatch.

Cheers,
Longman

