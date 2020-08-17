Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DC0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 433A420674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgHQVPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:15:51 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:48070 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgHQVPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:15:45 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7mTk-001Bwu-Sg; Mon, 17 Aug 2020 15:15:40 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7mTk-00074A-6O; Mon, 17 Aug 2020 15:15:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Witten <mfwitten@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, John Levon <john.levon@joyent.com>,
        John Levon <levon@movementarian.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <c6fda26e8d134264b04fadc3386d6c32@gmail.com>
        <20200816175303.GB1236603@ZenIV.linux.org.uk>
        <20200817204223.GB12414@amd>
Date:   Mon, 17 Aug 2020 16:12:09 -0500
In-Reply-To: <20200817204223.GB12414@amd> (Pavel Machek's message of "Mon, 17
        Aug 2020 22:42:24 +0200")
Message-ID: <87lfid6kpi.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k7mTk-00074A-6O;;;mid=<87lfid6kpi.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1//ZQ9z85heRXtRqSwjyTMi/k4mhCF2Zkk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] Makefile: Yes. Finally remove '-Wdeclaration-after-statement'
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> > This is not just a matter of style; this is a matter of semantics,
>> > especially with regard to:
>> > 
>> >   * const Correctness.
>> >     A const-declared variable must be initialized when defined.
>> > 
>> >   * Conditional Compilation.
>> >     When there is complex interaction between compile-time
>> >     configuration options, it's essential to be able to
>> >     make declarations where needed; otherwise unnecessary
>> >     gymnastics are required to silence the compiler.
>> > 
>> > Gentleman... Just let people say exactly what they mean to say.
> ..
>
>> You obviously need every bit of help in that task, judging by the amount
>> of clarity (or thoughts, for that matter) visible in the spew above...
>> 
>> NAK.  And as for letting people say exactly what they mean to say...
>> I am tempted to take you on that invitation, but that would be cruel
>> to gregkh - he would have to reply to inevitable screeds about
>> CoC-violating postings on l-k.
>
> We should really get rid of CoC, because I'd really like to see you
> _not_ resist that temptation.
>
> But... he's right.
>
> With rust-like programming style with widespread consts, this warning
> has to go. And it is causing additional/ugly #ifdefs in some cases.
>
> Maybe author can show examples in kernel .c where disabling the
> warning would lead to nicer code. I believe we should give it a try.


This change came in with 535231e8252e ("[PATCH] add
-Wdeclaration-after-statement").  AKA
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=535231e8252eea14abf4f14d28f6c1c03f5e0f02

Does anyone remember why we added this warning?  I had always thought
it's purpose was to ensure we stayed within our chosen dialect of C.
The actual commit says that it was in reaction to gcc miscompiling proc.
Which is a far more serious thing.

With all of the our bumping of our gcc version lately perhaps it is safe
to remove this warning.

Eric
