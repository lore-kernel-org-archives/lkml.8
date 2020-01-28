Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5B7C33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 03:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF7620678
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 03:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BxuCsT+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgA1DLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 22:11:14 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35739 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA1DLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 22:11:13 -0500
Received: by mail-qt1-f196.google.com with SMTP id t8so3725825qtr.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 19:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LOIYIqCCFHSha1FH0aa4/khvhD5szI599OmZrkoJ7kk=;
        b=BxuCsT+2qPMOe/Ostp02p2HonZyfFkam/I65XeI7+lBfaGReZlsl9LvTv+OuwuExFG
         gd5UlhxpUR0vxSzYfv591zyOPa6tlWDNCPAuUXY+krtaPE5tmWJVYZJTlS+cc/95rF8C
         Pf7UKflXY3vF17fTJEnGKgiMuPH7woIxr2dfu/a4DlPk9ZRqk7YyLgZzQHLySpnUIJ+V
         kqzuMS47Ecwr83/NUrDBgnhzvCkdVXoRP6ZaWr0w7VMosALwIFe09ShIG9W8G4jqqvdb
         srUjqpz7hsuYPFe4DQ5SXixcLLw5CDLg9T2aMCdWaWdm6737KlJRW1FyK8MlXM4gaDK+
         dMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LOIYIqCCFHSha1FH0aa4/khvhD5szI599OmZrkoJ7kk=;
        b=sQ7rG2xWs5rMBXJYKIc85FbM7b+K5wvqEWHywvt0lXMpVZ0nn63j0u9hxjxhjBw8mb
         uaXuPXHjn5q/Cd1iRjkFva4qXdIeoyBcc3QU8Q1Xak5bWVEOEup4yv/m16JVTU5c8ZsG
         ltZd3eSlc0EZKLu9tPkFe7/yd19QJOz4fbALuqyFwSPZ8iwNivrnZQBOXB5XjbC5dX+c
         AQEu6DApTnlFf/xV1Notxpqutv+oTj+dmSNcvOXeuoAKpGYnaEIMbFfjhPXYaVEUOw6W
         CbdbU5NLWljOLYnjuID996yXItaW5/KnvxF3HGE3QdENS0mx9Z9srMsd4RQvMeu722QV
         b0JA==
X-Gm-Message-State: APjAAAWDTXuvLt7FplF1c128bC4ojkCnbHfk8L4IY7KDM61Jh4R0fy+w
        uZvvp22O0CS6x/zEZ1c7U5j5dg==
X-Google-Smtp-Source: APXvYqxmP8t/mYHBeLdflRZEVZLiUjACF312C/eoPcaYqaDrzwk4qOf33cM0SNnj/Qmp4LDpThUXtg==
X-Received: by 2002:ac8:19b6:: with SMTP id u51mr12676666qtj.319.1580181072736;
        Mon, 27 Jan 2020 19:11:12 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s20sm11013777qkg.131.2020.01.27.19.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jan 2020 19:11:12 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200123093905.GU14914@hirez.programming.kicks-ass.net>
Date:   Mon, 27 Jan 2020 22:11:10 -0500
Cc:     Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "paul E. McKenney" <paulmck@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E722E6E0-26CB-440F-98D7-D182B57D1F43@lca.pw>
References: <20200122165938.GA16974@willie-the-truck>
 <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
 <20200122223851.GA45602@google.com>
 <A90E2B85-77CB-4743-AEC3-90D7836C4D47@lca.pw>
 <20200123093905.GU14914@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 23, 2020, at 4:39 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Wed, Jan 22, 2020 at 06:54:43PM -0500, Qian Cai wrote:
>> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
>> index 1f7734949ac8..832e87966dcf 100644
>> --- a/kernel/locking/osq_lock.c
>> +++ b/kernel/locking/osq_lock.c
>> @@ -75,7 +75,7 @@ osq_wait_next(struct optimistic_spin_queue *lock,
>>                 * wait for either @lock to point to us, through its =
Step-B, or
>>                 * wait for a new @node->next from its Step-C.
>>                 */
>> -               if (node->next) {
>> +               if (READ_ONCE(node->next)) {
>>                        next =3D xchg(&node->next, NULL);
>>                        if (next)
>>                                break;
>=20
> This could possibly trigger the warning, but is a false positive. The
> above doesn't fix anything in that even if that load is shattered the
> code will function correctly -- it checks for any !0 value, any byte
> composite that is !0 is sufficient.
>=20
> This is in fact something KCSAN compiler infrastructure could deduce.


Marco, any thought on improving KCSAN for this to reduce the false
positives?=
