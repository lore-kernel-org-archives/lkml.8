Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C82C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BD12074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895709AbgDOJh1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:37:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:23394 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2895690AbgDOJhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:37:23 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-1-XtsVSEfsO_y1qqpAWokTxw-1; Wed, 15 Apr 2020 10:37:18 +0100
X-MC-Unique: XtsVSEfsO_y1qqpAWokTxw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 15 Apr 2020 10:37:18 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 15 Apr 2020 10:37:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
CC:     Muchun Song <songmuchun@bytedance.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] seqlock: Use while instead of if+goto in
 __read_seqcount_begin
Thread-Topic: [PATCH] seqlock: Use while instead of if+goto in
 __read_seqcount_begin
Thread-Index: AQHWEkybWw93IV8740KKVjKbqtEcg6h57WOQ
Date:   Wed, 15 Apr 2020 09:37:18 +0000
Message-ID: <75b4b9ff3a31432c913b521a98259123@AcuMS.aculab.com>
References: <20200409134558.90863-1-songmuchun@bytedance.com>
 <20200410115658.GB24814@willie-the-truck>
 <20200414110516.GO20713@hirez.programming.kicks-ass.net>
In-Reply-To: <20200414110516.GO20713@hirez.programming.kicks-ass.net>
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

From: Peter Zijlstra
> Sent: 14 April 2020 12:05
> On Fri, Apr 10, 2020 at 12:56:58PM +0100, Will Deacon wrote:
> > On Thu, Apr 09, 2020 at 09:45:58PM +0800, Muchun Song wrote:
> > > The creators of the C language gave us the while keyword. Let's use
> > > that instead of synthesizing it from if+goto.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  include/linux/seqlock.h | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > > index 8b97204f35a77..7bdea019814ce 100644
> > > --- a/include/linux/seqlock.h
> > > +++ b/include/linux/seqlock.h
> > > @@ -125,12 +125,8 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
> > >  {
> > >  	unsigned ret;
> > >
> > > -repeat:
> > > -	ret = READ_ONCE(s->sequence);
> > > -	if (unlikely(ret & 1)) {
> > > +	while (unlikely((ret = READ_ONCE(s->sequence)) & 1))
> > >  		cpu_relax();
> > > -		goto repeat;
> > > -	}
> > >  	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
> > >  	return ret;
> >
> > Patch looks fine to me, but I'll leave it to Peter as I don't have a
> > preference either way.
> 
> Linus sometimes prefers the goto variant as that better expresses the
> exception model. But like Will, I don't particularly care. That said,
> Will, would it make sense to use smp_cond_load_relaxed() here ?

gcc also has a nasty habit of converting:
	while (foo)
		bar;
into:
	if (foo) {
		do
			bar;
		while (foo);
	}
with all the code bloat that entails - especially when 'foo'
is non-trivial.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

