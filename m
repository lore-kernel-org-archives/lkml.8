Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB3AC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9700E20673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgAJQNa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:13:30 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:31069 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728397AbgAJQNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:13:30 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-132-FDBerwKtMMiqDv2bYc1W-w-1; Fri, 10 Jan 2020 16:13:26 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 10 Jan 2020 16:13:25 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 10 Jan 2020 16:13:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sean Christopherson' <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: RE: [PATCH v2 2/2] KVM: x86/mmu: Micro-optimize nEPT's bad
 memptype/XWR checks
Thread-Topic: [PATCH v2 2/2] KVM: x86/mmu: Micro-optimize nEPT's bad
 memptype/XWR checks
Thread-Index: AQHVx8+0looGh+atVEOWwxZzFZ77z6fkEXjg
Date:   Fri, 10 Jan 2020 16:13:25 +0000
Message-ID: <ed06ad7ea1f147de83527357e81f95e9@AcuMS.aculab.com>
References: <20200109230640.29927-1-sean.j.christopherson@intel.com>
 <20200109230640.29927-3-sean.j.christopherson@intel.com>
 <878smfr18i.fsf@vitty.brq.redhat.com>
 <20200110160453.GA21485@linux.intel.com>
In-Reply-To: <20200110160453.GA21485@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: FDBerwKtMMiqDv2bYc1W-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>
> Sent: 10 January 2020 16:05
...
> Similar to your suggestion, but it avoids evaluating __is_bad_mt_xwr() if
> reserved bits are set, which is admittedly rare.
> 
> 	return __is_rsvd_bits_set(&mmu->guest_rsvd_check, gpte, level)
> #if PTTYPE == PTTYPE_EPT
> 	       || __is_bad_mt_xwr(&mmu->guest_rsvd_check, gpte)
> #endif
> 	       ;

Or:
	return __is_rsvd_bits_set(&mmu->guest_rsvd_check, gpte, level) ||
		(PTTYPE == PTTYPE_EPT && __is_bad_mt_xwr(&mmu->guest_rsvd_check, gpte));

Relying in the compiler to optimise it away.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

