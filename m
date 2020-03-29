Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21F2C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 19:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC16E2073E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 19:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgC2TMW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 15:12:22 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:32844 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbgC2TMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 15:12:22 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Mar 2020 15:12:21 EDT
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 251696094C4B;
        Sun, 29 Mar 2020 21:06:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QJ2GV9CvNgMe; Sun, 29 Mar 2020 21:06:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D9B5560D0873;
        Sun, 29 Mar 2020 21:06:05 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y4bO9EX9EtU0; Sun, 29 Mar 2020 21:06:05 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8D17C6089320;
        Sun, 29 Mar 2020 21:06:05 +0200 (CEST)
Date:   Sun, 29 Mar 2020 21:06:05 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        davidgow <davidgow@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <1606942453.56384.1585508765254.JavaMail.zimbra@nod.at>
In-Reply-To: <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
References: <20200226004608.8128-1-trishalfonso@google.com> <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com> <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: add support for KASAN under x86_64
Thread-Index: efampVW5tmWSwSdm2ja8syshwdMa9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Johannes Berg" <johannes@sipsolutions.net>
> An: "Patricia Alfonso" <trishalfonso@google.com>, "Jeff Dike" <jdike@addtoit.com>, "richard" <richard@nod.at>, "anton
> ivanov" <anton.ivanov@cambridgegreys.com>, "Andrey Ryabinin" <aryabinin@virtuozzo.com>, "Dmitry Vyukov"
> <dvyukov@google.com>, "Brendan Higgins" <brendanhiggins@google.com>, "davidgow" <davidgow@google.com>
> CC: "kasan-dev" <kasan-dev@googlegroups.com>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-um"
> <linux-um@lists.infradead.org>
> Gesendet: Mittwoch, 11. März 2020 11:32:00
> Betreff: Re: [PATCH] UML: add support for KASAN under x86_64

> Hi,
> 
>> Hi all, I just want to bump this so we can get all the comments while
>> this is still fresh in everyone's minds. I would love if some UML
>> maintainers could give their thoughts!
> 
> I'm not the maintainer, and I don't know where Richard is, but I just
> tried with the test_kasan.ko module, and that seems to work. Did you
> test that too? I was surprised to see this because you said you didn't
> test modules, but surely this would've been the easiest way?

Sorry for vanishing.

I read thought the discussion and it seems like the patch is not ready,
right?

Johannes, thanks a lot for pointing out all these issues.

Thanks,
//richard
