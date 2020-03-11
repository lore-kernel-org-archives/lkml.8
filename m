Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A151EC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7650D208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgCKKcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:32:15 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:46324 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgCKKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:32:15 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jByeg-0013Bw-GU; Wed, 11 Mar 2020 11:32:02 +0100
Message-ID: <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Date:   Wed, 11 Mar 2020 11:32:00 +0100
In-Reply-To: <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com> (sfid-20200306_010352_481400_662BF174)
References: <20200226004608.8128-1-trishalfonso@google.com>
         <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
         (sfid-20200306_010352_481400_662BF174)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Hi all, I just want to bump this so we can get all the comments while
> this is still fresh in everyone's minds. I would love if some UML
> maintainers could give their thoughts!

I'm not the maintainer, and I don't know where Richard is, but I just
tried with the test_kasan.ko module, and that seems to work. Did you
test that too? I was surprised to see this because you said you didn't
test modules, but surely this would've been the easiest way?

Anyway, as expected, stack (and of course alloca) OOB access is not
detected right now, but otherwise it seems great.

Here's the log:
https://p.sipsolutions.net/ca9b4157776110fe.txt

I'll repost my module init thing as a proper patch then, I guess.


I do see issues with modules though, e.g. 
https://p.sipsolutions.net/1a2df5f65d885937.txt

where we seem to get some real confusion when lockdep is storing the
stack trace??

And https://p.sipsolutions.net/9a97e8f68d8d24b7.txt, where something
convinces ASAN that an address is a user address (it might even be
right?) and it disallows kernel access to it?


Also, do you have any intention to work on the stack later? For me,
enabling that doesn't even report any issues, it just hangs at 'boot'.

johannes

