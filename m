Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B10C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3FD206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgCaHoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:44:12 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56756 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgCaHoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 03:44:12 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jJBZ3-008Kx7-9S; Tue, 31 Mar 2020 09:44:01 +0200
Message-ID: <19cf82d3c3d76ad62a47beee162fa9ff768a3a01.camel@sipsolutions.net>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     David Gow <davidgow@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um <linux-um@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Date:   Tue, 31 Mar 2020 09:43:59 +0200
In-Reply-To: <CABVgOSnz2heYvXytvhwA3RO_3dX=8vKrC+b8a6GLZV8eD3Fcow@mail.gmail.com> (sfid-20200331_081511_061239_730E62F6)
References: <20200226004608.8128-1-trishalfonso@google.com>
         <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
         <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
         <674ad16d7de34db7b562a08b971bdde179158902.camel@sipsolutions.net>
         <CACT4Y+bdxmRmr57JO_k0whhnT2BqcSA=Jwa5M6=9wdyOryv6Ug@mail.gmail.com>
         <ded22d68e623d2663c96a0e1c81d660b9da747bc.camel@sipsolutions.net>
         <CACT4Y+YzM5bwvJ=yryrz1_y=uh=NX+2PNu4pLFaqQ2BMS39Fdg@mail.gmail.com>
         <2cee72779294550a3ad143146283745b5cccb5fc.camel@sipsolutions.net>
         <CACT4Y+YhwJK+F7Y7NaNpAwwWR-yZMfNevNp_gcBoZ+uMJRgsSA@mail.gmail.com>
         <a51643dbff58e16cc91f33273dbc95dded57d3e6.camel@sipsolutions.net>
         <CABVgOSnz2heYvXytvhwA3RO_3dX=8vKrC+b8a6GLZV8eD3Fcow@mail.gmail.com>
         (sfid-20200331_081511_061239_730E62F6)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-30 at 23:14 -0700, David Gow wrote:
> 
> I spent a little time playing around with this, and was able to get
> mac80211 

mac80211, or mac80211-hwsim? I can load a few modules, but then it
crashes on say the third (usually, but who knows what this depends on).

> loading if I force-enabled CONFIG_KASAN_VMALLOC (alongside
> bumping up the shadow memory address).

Not sure I tried that combination though.

> The test-bpf module was still failing, though — which may or may not
> have been related to how bpf uses vmalloc().

I think I got some trouble also with just stack unwinding and other
random things faulting in the vmalloc and/or shadow space ...

> I do like the idea of trying to push the shadow memory allocation
> through UML's PTE code, but confess to not understanding it
> particularly well. 

Me neither. I just noticed that all the vmalloc and kasan-vmalloc do all
the PTE handling, so things might easily clash if you have
CONFIG_KASAN_VMALLOC, which we do want eventually.

> I imagine it'd require pushing the KASAN
> initialisation back until after init_physmem, and having the shadow
> memory be backed by the physmem file? Unless there's a clever way of
> allocating the shadow memory early, and then hooking it into the page
> tables/etc when those are initialised (akin to how on x86 there's a
> separate early shadow memory stage while things are still being set
> up, maybe?)

Pretty sure we should be able to hook it up later, but I haven't really
dug deeply yet.

johannes

