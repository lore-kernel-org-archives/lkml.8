Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B87AC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 15:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64762206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 15:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgCKPHM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 11:07:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:45810 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729954AbgCKPHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:07:11 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-239-v-FOvOPCOYOtCUtaloZQVw-1; Wed, 11 Mar 2020 15:07:08 +0000
X-MC-Unique: v-FOvOPCOYOtCUtaloZQVw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 11 Mar 2020 15:07:07 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 11 Mar 2020 15:07:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andi Kleen' <ak@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Cannon Matthews <cannonmatthews@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] mm: clear 1G pages with streaming stores on x86
Thread-Topic: [PATCH] mm: clear 1G pages with streaming stores on x86
Thread-Index: AQHV9ijM3XjXd8DH7k20GvQVG1posahDf+RQ
Date:   Wed, 11 Mar 2020 15:07:07 +0000
Message-ID: <ee18a6c4bb684b24afa4ae980de5c878@AcuMS.aculab.com>
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box> <20200309090630.GC8447@dhcp22.suse.cz>
 <20200309153831.GK1454533@tassilo.jf.intel.com>
In-Reply-To: <20200309153831.GK1454533@tassilo.jf.intel.com>
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

From: Andi Kleen
> Sent: 09 March 2020 15:39
...
> There's a cautious tale of the old crappy RAID5 XOR assembler functions which
> were optimized a long time ago for the Pentium1, and stayed around,
> even though the compiler could actually do a better job.

Or the amd64 asm loop for doing the IP checksum.
I doubt it was even the fastest version when it was written.
A whole set of Intel cpus can run twice as fast as that version
with less loop unrolling (and associated code for 'odd' lengths).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

