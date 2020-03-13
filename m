Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B72C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C252072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgCMOBB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:01:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:30395 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbgCMOBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:01:01 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-28-VcqWgJnvMmuVCZnmJ3ehoA-1; Fri, 13 Mar 2020 14:00:57 +0000
X-MC-Unique: VcqWgJnvMmuVCZnmJ3ehoA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 13 Mar 2020 14:00:56 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 13 Mar 2020 14:00:56 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vitaly Kuznetsov' <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Subject: RE: [PATCH 06/10] KVM: nVMX: Convert local exit_reason to u16 in
 ...enter_non_root_mode()
Thread-Topic: [PATCH 06/10] KVM: nVMX: Convert local exit_reason to u16 in
 ...enter_non_root_mode()
Thread-Index: AQHV+T8ZWkEdJwzmyEmywl6tM5YljqhGjOmA
Date:   Fri, 13 Mar 2020 14:00:56 +0000
Message-ID: <f440af10303e408d9d7f3211aa680918@AcuMS.aculab.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com>
 <20200312184521.24579-7-sean.j.christopherson@intel.com>
 <87pndgnyud.fsf@vitty.brq.redhat.com>
In-Reply-To: <87pndgnyud.fsf@vitty.brq.redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov
> Sent: 13 March 2020 13:56
...
> >  	load_vmcs12_host_state(vcpu, vmcs12);
> > -	vmcs12->vm_exit_reason = exit_reason | VMX_EXIT_REASONS_FAILED_VMENTRY;
> > +	vmcs12->vm_exit_reason = VMX_EXIT_REASONS_FAILED_VMENTRY | exit_reason;
> 
> My personal preference would be to do
>  (u32)exit_reason | VMX_EXIT_REASONS_FAILED_VMENTRY
> instead but maybe I'm just not in love with implicit type convertion in C.

I look at the cast and wonder what is going on :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

