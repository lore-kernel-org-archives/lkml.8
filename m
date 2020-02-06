Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165BEC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86C621927
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBFTOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:14:39 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:40576 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFTOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:14:38 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1izmbg-005xA3-5k; Thu, 06 Feb 2020 20:14:32 +0100
Message-ID: <c264bc73e22be04c5e8422858b8eac97f006f16a.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     richard@nod.at, jdike@addtoit.com,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-um@lists.infradead.org, David Gow <davidgow@google.com>,
        aryabinin@virtuozzo.com, Dmitry Vyukov <dvyukov@google.com>,
        anton.ivanov@cambridgegreys.com
Date:   Thu, 06 Feb 2020 20:14:31 +0100
In-Reply-To: <CAKFsvUJu7NZpM0ER45zhSzte3ovkAvXBKx3Tppxci7O=0TwJMg@mail.gmail.com> (sfid-20200206_192212_045280_EBE78060)
References: <20200115182816.33892-1-trishalfonso@google.com>
         <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
         <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
         <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net>
         <b55720804de8e56febf48c7c3c11b578d06a8c9f.camel@sipsolutions.net>
         <CAKFsvUJu7NZpM0ER45zhSzte3ovkAvXBKx3Tppxci7O=0TwJMg@mail.gmail.com>
         (sfid-20200206_192212_045280_EBE78060)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patricia,

> I've looked at this quite extensively over the past week or so. I was
> able to initialize KASAN as one of the first things that gets executed
> in main(), but constructors are, in fact, needed before main().

They're called before main, by the dynamic loader, or libc, or whatever
magic is built into the binary, right? But what do you mean by "needed"?

> I
> think it might be best to reintroduce constructors in a limited way to
> allow KASAN to work in UML.

I guess I'd have to see that.

>  I have done as much testing as I can on my
> machine and this limited version seems to work, except when
> STATIC_LINK is set. I will send some patches of what I have done so
> far and we can talk more about it there. I would like to add your
> name, Johannes, as a co-developed-by on that patch. If there is a
> better way to give you credit for this, please let me know.

I think you give me way too much credit, but I'm not going to complain
either way :-)

I'll post in a minute what I had in mind.

johannes

