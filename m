Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84124C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538DB206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgC3HoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:44:14 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:50258 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgC3HoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:44:14 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jIp5V-005JU9-00; Mon, 30 Mar 2020 09:44:01 +0200
Message-ID: <2cee72779294550a3ad143146283745b5cccb5fc.camel@sipsolutions.net>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Date:   Mon, 30 Mar 2020 09:43:58 +0200
In-Reply-To: <CACT4Y+YzM5bwvJ=yryrz1_y=uh=NX+2PNu4pLFaqQ2BMS39Fdg@mail.gmail.com> (sfid-20200320_161845_514535_9A0BEF71)
References: <20200226004608.8128-1-trishalfonso@google.com>
         <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
         <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
         <674ad16d7de34db7b562a08b971bdde179158902.camel@sipsolutions.net>
         <CACT4Y+bdxmRmr57JO_k0whhnT2BqcSA=Jwa5M6=9wdyOryv6Ug@mail.gmail.com>
         <ded22d68e623d2663c96a0e1c81d660b9da747bc.camel@sipsolutions.net>
         <CACT4Y+YzM5bwvJ=yryrz1_y=uh=NX+2PNu4pLFaqQ2BMS39Fdg@mail.gmail.com>
         (sfid-20200320_161845_514535_9A0BEF71)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-20 at 16:18 +0100, Dmitry Vyukov wrote:
> 
> > Wait ... Now you say 0x7fbfffc000, but that is almost fine? I think you
> > confused the values - because I see, on userspace, the following:
> 
> Oh, sorry, I copy-pasted wrong number. I meant 0x7fff8000. 

Right, ok.

> Then I would expect 0x1000 0000 0000 to work, but you say it doesn't...

So it just occurred to me - as I was mentioning this whole thing to
Richard - that there's probably somewhere some check about whether some
space is userspace or not.

I'm beginning to think that we shouldn't just map this outside of the
kernel memory system, but properly treat it as part of the memory that's
inside. And also use KASAN_VMALLOC.

We can probably still have it at 0x7fff8000, just need to make sure we
actually map it? I tried with vm_area_add_early() but it didn't really
work once you have vmalloc() stuff...

I dunno.

johannes


