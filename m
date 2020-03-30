Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B34C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFE1206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgC3J1W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:27:22 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:54504 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727376AbgC3J1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:27:22 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-95-EgmrUsT0M5yNaW66X6gYVQ-1; Mon, 30 Mar 2020 10:27:18 +0100
X-MC-Unique: EgmrUsT0M5yNaW66X6gYVQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 30 Mar 2020 10:27:17 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 30 Mar 2020 10:27:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Theodore Y. Ts'o'" <tytso@mit.edu>, George Spelvin <lkml@SDF.ORG>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
Subject: RE: [RFC PATCH v1 00/52] Audit kernel random number use
Thread-Topic: [RFC PATCH v1 00/52] Audit kernel random number use
Thread-Index: AQHWBS7wHKwkXcotX0GE2ObBbkw++6hffddggACdo1OAAMNccA==
Date:   Mon, 30 Mar 2020 09:27:17 +0000
Message-ID: <7923d2289ec044579a3eb00ca339a018@AcuMS.aculab.com>
References: <202003281643.02SGhPmY017434@sdf.org>
 <CAPcyv4iagZy5m3FpMrQqyOi=_uCzqh5MjbW+J_xiHU1Z1BmF=g@mail.gmail.com>
 <20200328182817.GE5859@SDF.ORG>
 <98bd30f23b374ccbb61dd46125dc9669@AcuMS.aculab.com>
 <20200329174122.GD4675@SDF.ORG> <20200329214214.GB768293@mit.edu>
In-Reply-To: <20200329214214.GB768293@mit.edu>
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

From: Theodore Y. Ts'o
> Sent: 29 March 2020 22:42
> On Sun, Mar 29, 2020 at 05:41:22PM +0000, George Spelvin wrote:
> > > Using xor was particularly stupid.
> > > The whole generator was then linear and trivially reversable.
> > > Just using addition would have made it much stronger.
> >
> > I considered changing it to addition (actually, add pairs and XOR the
> > sums), but that would break its self-test.  And once I'd done that,
> > there are much better possibilities.
> >
> > Actually, addition doesn't make it *much* stronger.  To start
> > with, addition and xor are the same thing at the lsbit, so
> > observing 113 lsbits gives you a linear decoding problem.
> 
> David,
> 
> If anyone is trying to rely on prandom_u32() as being "strong" in any
> sense of the word in terms of being reversable by attacker --- they
> shouldn't be using prandom_u32().  That's going to be true no matter
> *what* algorithm we use.

Indeed, but xor merging of 4 LFSR gives an appearance of an
improvements (over a single LFSR) but gives none and just
increases the complexity.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

