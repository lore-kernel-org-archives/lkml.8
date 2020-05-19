Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985B2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7005620708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgESMUV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:20:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:37604 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728772AbgESMUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:20:21 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-29-jY0heaD8NKa0eBvVES2eBg-1; Tue, 19 May 2020 13:20:17 +0100
X-MC-Unique: jY0heaD8NKa0eBvVES2eBg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 19 May 2020 13:20:16 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 19 May 2020 13:20:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sasha Levin' <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v12 10/18] x86/fsgsbase/64: Enable FSGSBASE instructions
 in helper functions
Thread-Topic: [PATCH v12 10/18] x86/fsgsbase/64: Enable FSGSBASE instructions
 in helper functions
Thread-Index: AQHWLVJcG1AiHrfpmEaP5P6pVvKjjqivU+Wg
Date:   Tue, 19 May 2020 12:20:16 +0000
Message-ID: <238a6e2609eb4e0497b13fbe5f531917@AcuMS.aculab.com>
References: <20200511045311.4785-11-sashal@kernel.org>
 <87v9ktw1ev.fsf@nanos.tec.linutronix.de> <20200518202435.GD33628@sasha-vm>
In-Reply-To: <20200518202435.GD33628@sasha-vm>
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

From: Sasha Levin
> Sent: 18 May 2020 21:25
> Thank you for taking the time to review this.
> 
> On Mon, May 18, 2020 at 08:20:08PM +0200, Thomas Gleixner wrote:
> >Sasha Levin <sashal@kernel.org> writes:
> >> +unsigned long x86_gsbase_read_cpu_inactive(void)
> >> +{
> >> +	unsigned long gsbase;
> >> +
> >> +	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
> >> +		bool need_restore = false;
> >> +		unsigned long flags;
> >> +
> >> +		/*
> >> +		 * We read the inactive GS base value by swapping
> >> +		 * to make it the active one. But we cannot allow
> >> +		 * an interrupt while we switch to and from.
> >> +		 */
> >> +		if (!irqs_disabled()) {
> >> +			local_irq_save(flags);
> >> +			need_restore = true;
> >> +		}
> >> +
> >> +		native_swapgs();
> >> +		gsbase = rdgsbase();
> >> +		native_swapgs();

Does local_irq_save() even do anything useful here.
You need to actually execute CLI, not just set a
flag that indicates interrupts shouldn't happen.
(Which is what I think local_irq_save() might do.)

You also (probably) need to disable NMIs.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

