Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD5AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DABA520656
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AElHnJZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgFOLIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:08:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56706 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728304AbgFOLIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592219318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SfFOpFNBb9aBzYgBSswuvFwjcvoni55lhtrClZ7fEug=;
        b=AElHnJZVfbQDDC9XZqpDr8/jm4mVVm6r5cwr31urD0gAA/IELKw9gwoU95diS80N7Fulz0
        oGrwfptjNnjoUK3IEF+BQNlozPS7DIV3LWk+tbfwpETRcTe4CZ3NB/UFJYYxwmVguuhj6I
        4enMpGeypu9iEyGvG6R022bS6qANoaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-62_Mr1v7PgesK8Si7NzmxQ-1; Mon, 15 Jun 2020 07:08:34 -0400
X-MC-Unique: 62_Mr1v7PgesK8Si7NzmxQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E76581009441;
        Mon, 15 Jun 2020 11:08:31 +0000 (UTC)
Received: from localhost (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD8FD70915;
        Mon, 15 Jun 2020 11:08:29 +0000 (UTC)
Date:   Mon, 15 Jun 2020 13:08:25 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bitmap: Add test for bitmap_cut()
Message-ID: <20200615130825.60283f1b@redhat.com>
In-Reply-To: <20200615094616.GS2428291@smile.fi.intel.com>
References: <cover.1592155364.git.sbrivio@redhat.com>
        <5fc45e6bbd4fa837cd9577f8a0c1d639df90a4ce.1592155364.git.sbrivio@redhat.com>
        <20200615094155.GQ2428291@smile.fi.intel.com>
        <20200615094616.GS2428291@smile.fi.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 12:46:16 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Jun 15, 2020 at 12:41:55PM +0300, Andy Shevchenko wrote:
> > On Sun, Jun 14, 2020 at 07:40:54PM +0200, Stefano Brivio wrote:  
> > > Inspired by an original patch from Yury Norov: introduce a test for
> > > bitmap_cut() that also makes sure functionality is as described for
> > > partially overlapping src and dst.  
> > 
> > Taking into account recent fixes for BE 64-bit, do we have test cases for a such?  
> 
> It might be enough to have only these, but perhaps s390 guys can help?

There's no behaviour difference due to endianness in this test itself --
just word size was a topic, hence that BITS_PER_LONG usage with
redundant values (checked on i686).

That is, if you have:
	{ 0x0000ffffUL, 0x5a5a5a5aUL, 0x5a5a5a5aUL, 0x5a5a5a5aUL },

then 1 as array subscript always denotes the second item (from the left)
there, it doesn't matter how and where different architectures store it.

Indeed, if bitmap_cut() directly addressed single bytes within the
words, I would need to pay special attention there. The values I picked
for these tests are also meant to show any issue in that sense.

> Alexander, can you apply this patch (w/o the first one, which is suppose to
> fix) and confirm that you have test case failure, followed by applying first
> one and confirm a fix?

I did that already on s390x (of course, I thought :)), I can confirm
that. Without patch 1/2 the test also fails there:

[   20.917848] test_bitmap: [lib/test_bitmap.c:666] bitmaps contents differ: expected "0-16,18-19,21,24,26-27,29", got "1,3-4,6,9,11-12,14,16,18-19,21,24,26-27,29"

If Alexander wants to test this on a z14 or z15, sure, it won't harm.

By the way, tests for 'parse', 'parse_user' and 'parselist' report
issues:

[   20.390401] test_bitmap: loaded.
[   20.394839] test_bitmap: parse: 4: input is 1, result is 0x100000000, expected 0x1
[   20.395011] test_bitmap: parse: 5: input is deadbeef, result is 0xdeadbeef00000000, expected 0xdeadbeef
[   20.395059] test_bitmap: parse: 6: input is 1,0, result is 0x1, expected 0x100000000
[   20.395099] test_bitmap: parse: 7: input is deadbeef,
               ,0,1, result is 0x1, expected 0xdeadbeef
[   20.396696] test_bitmap: parse: 8: input is deadbeef,1,0, result is 0x1, expected 0x100000000
[   20.396735] test_bitmap: parse: 9: input is baadf00d,deadbeef,1,0, result is 0x1, expected 0x100000000
[   20.396835] test_bitmap: parse: 10: input is badf00d,deadbeef,1,0, errno is -75, expected 0
[   20.396878] test_bitmap: parse: 11: input is badf00d,deadbeef,1,0, errno is -75, expected 0
[   20.396913] test_bitmap: parse: 12: input is   badf00d,deadbeef,1,0  , errno is -75, expected 0
[   20.396957] test_bitmap: parse: 13: input is  , badf00d,deadbeef,1,0 , , errno is -75, expected 0
[   20.396983] test_bitmap: parse: 14: input is  , badf00d, ,, ,,deadbeef,1,0 , , errno is -75, expected 0
[   20.397052] test_bitmap: parse: 16: input is 3,0, errno is 0, expected -75
[   20.397712] test_bitmap: parse_user: 4: input is 1, result is 0x100000000, expected 0x1
[   20.397832] test_bitmap: parse_user: 5: input is deadbeef, result is 0xdeadbeef00000000, expected 0xdeadbeef
[   20.397928] test_bitmap: parse_user: 6: input is 1,0, result is 0x1, expected 0x100000000
[   20.398022] test_bitmap: parse_user: 7: input is deadbeef,
               ,0,1, result is 0x1, expected 0xdeadbeef
[   20.398116] test_bitmap: parse_user: 8: input is deadbeef,1,0, result is 0x1, expected 0x100000000
[   20.398209] test_bitmap: parse_user: 9: input is baadf00d,deadbeef,1,0, result is 0x1, expected 0x100000000
[   20.398301] test_bitmap: parse_user: 10: input is badf00d,deadbeef,1,0, errno is -75, expected 0
[   20.398393] test_bitmap: parse_user: 11: input is badf00d,deadbeef,1,0, errno is -75, expected 0
[   20.398484] test_bitmap: parse_user: 12: input is   badf00d,deadbeef,1,0  , errno is -75, expected 0
[   20.398574] test_bitmap: parse_user: 13: input is  , badf00d,deadbeef,1,0 , , errno is -75, expected 0
[   20.398666] test_bitmap: parse_user: 14: input is  , badf00d, ,, ,,deadbeef,1,0 , , errno is -75, expected 0
[   20.398794] test_bitmap: parse_user: 16: input is 3,0, errno is 0, expected -75
[   20.399906] test_bitmap: parselist: 14: input is '0-2047:128/256' OK, Time: 2641
[   20.400914] test_bitmap: parselist_user: 14: input is '0-2047:128/256' OK, Time: 19961
[   20.421406] test_bitmap: all 1679 tests passed

and at a glance those *seem* to be bugs in the tests themselves, not in
the actual functions they test. Sure, they should be fixed, but I can't
take care of that right now.

-- 
Stefano

