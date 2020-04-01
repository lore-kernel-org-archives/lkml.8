Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E23EC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664262077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbgDAKYA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:24:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:52016 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbgDAKYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:24:00 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-22-QSeBAbmuOtiRMVlLTjHioQ-1; Wed, 01 Apr 2020 11:23:56 +0100
X-MC-Unique: QSeBAbmuOtiRMVlLTjHioQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 1 Apr 2020 11:23:55 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 1 Apr 2020 11:23:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Maciej W. Rozycki'" <macro@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "hpa@zytor.com" <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        "jailhouse-dev@googlegroups.com" <jailhouse-dev@googlegroups.com>
Subject: RE: [PATCH] x86/smpboot: Remove 486-isms from the modern AP boot path
Thread-Topic: [PATCH] x86/smpboot: Remove 486-isms from the modern AP boot
 path
Thread-Index: AQHWB7UNIHnKX6bM4USvtOwoEXANa6hkDYfw
Date:   Wed, 1 Apr 2020 10:23:55 +0000
Message-ID: <23147db6f0c548259357babfc22a87d3@AcuMS.aculab.com>
References: <20200325101431.12341-1-andrew.cooper3@citrix.com>
 <601E644A-B046-4030-B3BD-280ABF15BF53@zytor.com>
 <87r1xgxzy6.fsf@nanos.tec.linutronix.de>
 <alpine.LFD.2.21.2004010001460.3939520@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.21.2004010001460.3939520@eddie.linux-mips.org>
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

From: Maciej W. Rozycki
> Sent: 01 April 2020 00:35
> On Wed, 25 Mar 2020, Thomas Gleixner wrote:
> 
> > >>@@ -1118,7 +1121,7 @@ static int do_boot_cpu(int apicid, int cpu,
> > >>struct task_struct *idle,
> > >> 		}
> > >> 	}
> > >>
> > >>-	if (x86_platform.legacy.warm_reset) {
> > >>+	if (!APIC_INTEGRATED(boot_cpu_apic_version)) {
> > >> 		/*
> > >> 		 * Cleanup possible dangling ends...
> > >> 		 */
> > >
> > > We don't support SMP on 486 and haven't for a very long time. Is there
> > > any reason to retain that code at all?
> >
> > Not that I'm aware off.
> 
>  For the record: this code is for Pentium really, covering original P5
> systems, which lacked integrated APIC, as well as P54C systems that went
> beyond dual (e.g. ALR made quad-SMP P54C systems).  They all used external
> i82489DX APICs for SMP support.  Few were ever manufactured and getting
> across one let alone running Linux might be tough these days.  I never
> managed to get one for myself, which would have been helpful for
> maintaining this code.

I remember ICL trying to get SVR4.2MP working on similar vintage hardware.
I wasn't directly involved (doing SMP sparc ethernet drivers) but ISTR
that the SMP support silicon they were using (or rather trying to use)
was basically broken.
By the time they got it (nearly) working single cpu systems were faster.

>  Even though we supported them by spec I believe we never actually ran MP
> on any 486 SMP system (Alan Cox might be able to straighten me out on
> this); none that I know of implemented the MPS even though actual hardware
> might have used the APIC architecture.  Compaq had its competing solution
> for 486 and newer SMP, actually deployed, the name of which I long forgot.
> We never supported it due to the lack of documentation combined with the
> lack of enough incentive for someone to reverse-engineer it.

I also remember one of those Compaq dual 486 boxes.
We must have has SVR4/Unixware running on it.

I suspect that any such systems would also be too slow and not have
enough memory to actually run anything recent.

OTOH there are modern 486 (like) systems than might have a reasonable
amount of memory and clock speed.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

