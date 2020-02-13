Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40255C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E16E2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgBMJCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:02:16 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:58306 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMJCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:02:16 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j2ANq-008F19-Gs; Thu, 13 Feb 2020 10:02:06 +0100
Message-ID: <817580a4bcfbd3ef3ce31dfc5876bb99c3fca832.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Date:   Thu, 13 Feb 2020 10:02:05 +0100
In-Reply-To: <CACT4Y+ZB3QwzeogxVFVXW_z=eE2n5fQxj7iYq9-Jw68zdS=mUA@mail.gmail.com> (sfid-20200213_094451_311672_27C02820)
References: <20200210225806.249297-1-trishalfonso@google.com>
         <13b0ea0caff576e7944e4f9b91560bf46ac9caf0.camel@sipsolutions.net>
         <CAKFsvUKaixKXbUqvVvjzjkty26GS+Ckshg2t7-+erqiN2LVS-g@mail.gmail.com>
         <e8a45358b273f0d62c42f83d99c1b50a1608929d.camel@sipsolutions.net>
         <CACT4Y+ZB3QwzeogxVFVXW_z=eE2n5fQxj7iYq9-Jw68zdS=mUA@mail.gmail.com>
         (sfid-20200213_094451_311672_27C02820)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-13 at 09:44 +0100, Dmitry Vyukov wrote:

> > Right, but again like below - that's just mapped, not actually used. But
> > as far as I can tell, once you actually start running and potentially
> > use all of your mem=1024 (MB), you'll actually also use another 128MB on
> > the KASAN shadow, right?
> > 
> > Unlike, say, a real x86_64 machine where if you just have 1024 MB
> > physical memory, the KASAN shadow will have to fit into that as well.
> 
> Depends on what you mean by "real" :)

:)

> Real user-space ASAN will also reserve 1/8th of 47-bit VA on start
> (16TB).

Ah, but I was thinking of actual memory *used*, not just VA.

And of KASAN, not user-space, but yeah, good point.

> This implementation seems to be much closer to user-space ASAN
> rather than to x86_64 KASAN (in particular it seems to be mostly
> portable across archs and is not really x86-specific, which is good).

Indeed.

> I think it's reasonable and good, but the implementation difference
> with other kernel arches may be worth noting somewhere in comments.

Right, I guess that's the broader point. I was thinking mostly of the
memory consumption: if you run with UML KASAN, your UML virtual machine
will use around 12.5% more memory than before, unlike if you say have a
KVM virtual machine - whatever you reserve outside will be what it can
use inside, regardless of KASAN being enabled or not.

This is totally fine, I just thought it should be documented somewhere,
perhaps in the Kconfig option, though I guess there isn't a UML specific
one for this... Not sure where then.

johannes

