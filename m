Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8153C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C59214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="JomB970a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgEINB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 09:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgEINB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 09:01:56 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1102DC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 06:01:56 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id t3so4426524qkg.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 06:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jTuvTs2BUGfgevsdxkTl5Pz0n3BVDsnYhNL9VJKSs9o=;
        b=JomB970amfbS7tlmVt6Zk1DINDaC0AXdo6I2BycPXku8wEExjHK8J+LlTQPExHIrvs
         6vxm4SsS8vQsChgochARhojcSgstz0+4p4VQfm8SJRUawUXPc4UkmKDl4w0MsrlzdNG2
         w3Sd1qIktLEary+Oi7JpzA+VqnRI7N8G9sjpjgJ7kCZ6IMFvXKMICL/igec9kgRGLwFY
         FxwSAr0PJusFCUILo+7PEpfk1cwrRl9Vd1j/unXRc3t0RDM4u73eaZ+rZud2AXASZagY
         c+BoatdL4ncmyL1n1voA85i4RUo01v6tAIo0+JNJmrUiPjay51hWuM4feexL7PNuWCmu
         5U0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jTuvTs2BUGfgevsdxkTl5Pz0n3BVDsnYhNL9VJKSs9o=;
        b=JiI9xjylJIX71mAtoL74DZg21aglEjQ6Vz8RHngQLgnnAno2iUXxzqRWXORXdiTMUt
         tpOkTMZiXY9Ms0yXz4eTY1OUr8qFh7QBkVWY/eQZ1NAZuLdEnf1s7zjf8HMbPDj5Ao+s
         Av7bEP20WopZyrsYs3EiZWKT3Q6yTNxdJvhf0sSXC9kl2QmXOfi479iMso/GqwX/w86F
         Zs1PiZISFVspLMkBbJTet5h9K4jTZ8ZGkElPY+EwZiaJ8TFo1fbb7i3K75pBHqOVL/Sy
         W4HCXL7BFUKZpgoDxYPsdJiDbKBba4UNaZs0EKRXAU+oLT06APup9PkxHOT7h1jeFSvI
         FJjA==
X-Gm-Message-State: AGi0PuZ9vaJvRXUkeiMLhoEP5MYu5mMMMordjGcUHvOPfOjGxDDhEqG3
        HC5glc5k4YqbhO/FBaY2FgmqzYvnP8jT4w==
X-Google-Smtp-Source: APiQypIcDF4OVCmqBgPzFnueYXtvvdTzIF3VhS651bB8xJUYGq/I/Mm6ypwpzUKLgQZDRTM/8VpKSw==
X-Received: by 2002:ae9:dfc6:: with SMTP id t189mr6651875qkf.15.1589029315093;
        Sat, 09 May 2020 06:01:55 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c197sm3555474qkg.133.2020.05.09.06.01.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 May 2020 06:01:54 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH -next v2] locking/osq_lock: annotate a data race in
 osq_lock
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200509043308.GL2869@paulmck-ThinkPad-P72>
Date:   Sat, 9 May 2020 09:01:53 -0400
Cc:     Will Deacon <will@kernel.org>, Elver Marco <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9FBC2A17-2821-49F7-9A0F-5E41116BBC70@lca.pw>
References: <1581429255-12542-1-git-send-email-cai@lca.pw>
 <2C8BF141-5384-475F-B713-6D473557C65C@lca.pw>
 <20200509043308.GL2869@paulmck-ThinkPad-P72>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 9, 2020, at 12:33 AM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>=20
> On Fri, May 08, 2020 at 04:59:05PM -0400, Qian Cai wrote:
>>=20
>>=20
>>> On Feb 11, 2020, at 8:54 AM, Qian Cai <cai@lca.pw> wrote:
>>>=20
>>> prev->next could be accessed concurrently as noticed by KCSAN,
>>>=20
>>> write (marked) to 0xffff9d3370dbbe40 of 8 bytes by task 3294 on cpu =
107:
>>> osq_lock+0x25f/0x350
>>> osq_wait_next at kernel/locking/osq_lock.c:79
>>> (inlined by) osq_lock at kernel/locking/osq_lock.c:185
>>> rwsem_optimistic_spin
>>> <snip>
>>>=20
>>> read to 0xffff9d3370dbbe40 of 8 bytes by task 3398 on cpu 100:
>>> osq_lock+0x196/0x350
>>> osq_lock at kernel/locking/osq_lock.c:157
>>> rwsem_optimistic_spin
>>> <snip>
>>>=20
>>> Since the write only stores NULL to prev->next and the read tests if
>>> prev->next equals to this_cpu_ptr(&osq_node). Even if the value is
>>> shattered, the code is still working correctly. Thus, mark it as an
>>> intentional data race using the data_race() macro.
>>>=20
>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>=20
>> Hmm, this patch has been dropped from linux-next from some reasons.
>>=20
>> Paul, can you pick this up along with KCSAN fixes?
>>=20
>> =
https://lore.kernel.org/lkml/1581429255-12542-1-git-send-email-cai@lca.pw/=

>=20
> I have queued it on -rcu, but it is too late for v5.8 via the -rcu =
tree,
> so this is v5.9 at the earliest.  Plus I would need an ack from one of
> the locking folks.

Peter, Will, can you give an ACK? This v2 should incorporate all the =
feedback from Peter,

=
https://lore.kernel.org/lkml/20200211124753.GP14914@hirez.programming.kick=
s-ass.net/

V5.9 is fine. All I care about is it is always in linux-next (so the =
testing bots won=E2=80=99t trigger this over and over again) and to be =
in mainline at some point in the future.

>=20
> 							Thanx, Paul
>=20
>>> ---
>>>=20
>>> v2: insert some code comments.
>>>=20
>>> kernel/locking/osq_lock.c | 6 +++++-
>>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
>>> index 1f7734949ac8..f733bcd99e8a 100644
>>> --- a/kernel/locking/osq_lock.c
>>> +++ b/kernel/locking/osq_lock.c
>>> @@ -154,7 +154,11 @@ bool osq_lock(struct optimistic_spin_queue =
*lock)
>>> 	 */
>>>=20
>>> 	for (;;) {
>>> -		if (prev->next =3D=3D node &&
>>> +		/*
>>> +		 * cpu_relax() below implies a compiler barrier which =
would
>>> +		 * prevent this comparison being optimized away.
>>> +		 */
>>> +		if (data_race(prev->next =3D=3D node) &&
>>> 		    cmpxchg(&prev->next, node, NULL) =3D=3D node)
>>> 			break;
>>>=20
>>> --=20
>>> 1.8.3.1

