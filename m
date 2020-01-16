Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EF6C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5628920748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgAPJUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:20:36 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:50284 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgAPJUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:20:36 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1is1KF-00BgMa-LC; Thu, 16 Jan 2020 10:20:27 +0100
Message-ID: <2092169e6dd1f8d15f1db4b3787cc9fe596097b7.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, David Gow <davidgow@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        anton.ivanov@cambridgegreys.com
Date:   Thu, 16 Jan 2020 10:20:26 +0100
In-Reply-To: <CACT4Y+brqD-o-u3Vt=C-PBiS2Wz+wXN3Q3RqBhf3XyRYaRoZJw@mail.gmail.com> (sfid-20200116_101838_954522_B05BB78D)
References: <20200115182816.33892-1-trishalfonso@google.com>
         <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
         <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
         <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net>
         <b55720804de8e56febf48c7c3c11b578d06a8c9f.camel@sipsolutions.net>
         <CACT4Y+brqD-o-u3Vt=C-PBiS2Wz+wXN3Q3RqBhf3XyRYaRoZJw@mail.gmail.com>
         (sfid-20200116_101838_954522_B05BB78D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-01-16 at 10:18 +0100, Dmitry Vyukov wrote:
> 
> Looking at this problem and at the number of KASAN_SANITIZE := n in
> Makefiles (some of which are pretty sad, e.g. ignoring string.c,
> kstrtox.c, vsprintf.c -- that's where the bugs are!), I think we
> initialize KASAN too late. I think we need to do roughly what we do in
> user-space asan (because it is user-space asan!). Constructors run
> before main and it's really good, we need to initialize KASAN from
> these constructors. Or if that's not enough in all cases, also add own
> constructor/.preinit array entry to initialize as early as possible.

We even control the linker in this case, so we can put something into
the .preinit array *first*.

> All we need to do is to call mmap syscall, there is really no
> dependencies on anything kernel-related.

OK. I wasn't really familiar with those details.

> This should resolve the problem with constructors (after they
> initialize KASAN, they can proceed to do anything they need) and it
> should get rid of most KASAN_SANITIZE (in particular, all of
> lib/Makefile and kernel/Makefile) and should fix stack instrumentation
> (in case it does not work now). The only tiny bit we should not
> instrument is the path from constructor up to mmap call.

That'd be great :)

johannes

