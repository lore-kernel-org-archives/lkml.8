Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24691C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A58820700
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgDYItd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 04:49:33 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:51872 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgDYItc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:49:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 31955608311C;
        Sat, 25 Apr 2020 10:49:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8xViT_4CWA4e; Sat, 25 Apr 2020 10:49:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DEA3861A7014;
        Sat, 25 Apr 2020 10:49:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mWtVVDGsOz3j; Sat, 25 Apr 2020 10:49:28 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id B9C0B608311C;
        Sat, 25 Apr 2020 10:49:28 +0200 (CEST)
Date:   Sat, 25 Apr 2020 10:49:28 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     davidgow <davidgow@google.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <557123184.155536.1587804568614.JavaMail.zimbra@nod.at>
In-Reply-To: <b86f5469f9b888942b7a6f9862ec98c909121375.camel@sipsolutions.net>
References: <20200425042814.132920-1-davidgow@google.com> <b86f5469f9b888942b7a6f9862ec98c909121375.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Fix "time-internal.h" include in xor.h
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix "time-internal.h" include in xor.h
Thread-Index: xqvJN+eh3NmyhE7yiAAl00GWkgit3Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Johannes Berg" <johannes@sipsolutions.net>
> An: "davidgow" <davidgow@google.com>, "anton ivanov" <anton.ivanov@cambridgegreys.com>, "richard" <richard@nod.at>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Samstag, 25. April 2020 10:26:04
> Betreff: Re: [PATCH] um: Fix "time-internal.h" include in xor.h

> On Fri, 2020-04-24 at 21:28 -0700, David Gow wrote:
>> It looks like the wrong header was included in xor.h, breaking make
>> allyesconfig on UML (or, more specifically, kunit.py run --alltests).
>> 
>> ----------------------
>> In file included from crypto/xor.c:17:
>> ./arch/um/include/asm/xor.h:3:10: fatal error: shared/timer-internal.h: No such
>> file or directory
>>     3 | #include <shared/timer-internal.h>
>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~
>> ----------------------
>> 
>> Replacing this with "linux/time-internal.h" builds fine.
>> 
>> Fixes: d65197ad5249 ("um: fix time-travel=inf-cpu with xor/raid6")
> 
> Yeah, sorry about that. Some patches overlapped here, i.e. were pending
> from separate branches I had.
> 
> I sent Richard a fix quite about three weeks ago:
> 
> https://patchwork.ozlabs.org/project/linux-um/patch/20200405213357.b6ce1024b276.I7c370e20580d3122c58df5727ee2d6fb53545576@changeid/
> 
> but I guess he hasn't applied it yet.

That's right. I'll prepare a PR with fixes soon.

Thanks,
//richard
