Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41514C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E2820735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="eFHH3MTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgCWNl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:41:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34172 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgCWNl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:41:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id 10so11617528qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 06:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RWEMsAq/+XLss9TP3GVBV0diihb8uFfSINxMxzbojVg=;
        b=eFHH3MTJxF4N8vOPclMg2B/jc+85NefoQmfJy4ghyuFxQ/hOVCPY0E81S4ItaVptdC
         JnKpPkviHd05PGdiAeBCd4LneLmJ2UgeCaU7TZVwWxjg4mvg9YJss3Q67Pi5Y0m87+IC
         A2iv8QLf9r0dcOz+mYs6qbObxwN2M2KyGXRx1kP9gGtV5xPmZo6tBorUJf1IBY5S/tFF
         kdW8UZcfzWR6LQaq2rr6c5MrWpQheTKg4wX1fZLd8n9dgN3IC0ZfaGCt69WCCeSPtRqm
         TFz0wtg3p2tMZNXe0PR9EGXJ71IcgDGk4101J3HYU6nfFjR0nc7wXN4dKcVllMgMpTWK
         RwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RWEMsAq/+XLss9TP3GVBV0diihb8uFfSINxMxzbojVg=;
        b=dTlTUzE/kSMDNOYlrsVgOKImOV0fQz7rlYZdj8FtY1RJ1qSk2GlJsGSWmfNEFdF9E1
         trn6z5QghTt55xQWC/D16TNhBJfxb6bGKzE5yx53pgvpU50mWYduqw5HTUNEVnl0MpA6
         amupt2XTEbAeLmfXLvduf7Evc8u/eZHyOQIDq6NBJGMeh7D9ceLi93OZe5xEbTGN1MWh
         8ACZw9XyvQuzJw1lesY5YyAemOUBtdzusf1SXUJqKuu77c7ILfXOMt2A0TWKKDra3vtc
         P7NsGzYzF+Ef+xe4dwLYVU7PV9A0hY+qqAi6mtA819exlp2KSnc1UR+FQf4s2BO2+7Sg
         D72Q==
X-Gm-Message-State: ANhLgQ3QjD3/mo3KG+RD4ul77FNeKPrCbylXwRQmsjpG7cp/KDypjLGj
        Y7kWjsDQi9diLh5nN7u8ZVSa7w==
X-Google-Smtp-Source: ADFU+vsRnLPlUtzFttn3P+PF1egAKgXYVhqoo7GVbVEH0JNpoJMn5wKic2Hhqth6jZKs8+inmRypeA==
X-Received: by 2002:ac8:45c9:: with SMTP id e9mr16542083qto.185.1584970915166;
        Mon, 23 Mar 2020 06:41:55 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o186sm2049969qke.39.2020.03.23.06.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2020 06:41:54 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] timer: silenct a lockdep splat with debugobjects
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <47A499D0-D1F5-4B72-A99D-6FBC8E3DD8AD@lca.pw>
Date:   Mon, 23 Mar 2020 09:41:53 -0400
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        hannes@cmpxchg.org, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EBB4D2B4-1EDF-4EDF-B667-81FDFA1F4AF2@lca.pw>
References: <20200313154221.1566-1-cai@lca.pw>
 <20200313180811.GD12521@hirez.programming.kicks-ass.net>
 <4FFD109D-EAC1-486F-8548-AA1F5E024120@lca.pw>
 <20200313201314.GE5086@worktop.programming.kicks-ass.net>
 <D3115315-12A9-43A9-9209-09553CF2C71C@lca.pw>
 <20200313212620.GA2452@worktop.programming.kicks-ass.net>
 <47A499D0-D1F5-4B72-A99D-6FBC8E3DD8AD@lca.pw>
To:     Andy Lutomirski <luto@amacapital.net>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 13, 2020, at 10:53 PM, Qian Cai <cai@lca.pw> wrote:
>=20
>=20
>=20
>> On Mar 13, 2020, at 5:26 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>=20
>> On Fri, Mar 13, 2020 at 05:00:41PM -0400, Qian Cai wrote:
>>>> On Mar 13, 2020, at 4:13 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>=20
>>>>=20
>>>> Or, fix that random crud to do the wakeup outside of the lock.
>>>=20
>>> That is likely to be difficult until we can find a creative way to =
not =E2=80=9Cuglifying" the
>>> random code by dropping locks in the middle etc just because of =
debugojects.
>>=20
>> =
https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=3Dra=
ndom/fast
>>=20
>> Doesn't look difficult at all.
>=20
> Great. I cherry-picked the first two patches,
>=20
> random: Consolidate entropy batches for u32 and u64
> random: Remove batched entropy locking
>=20
> which solved the issue here as well.
>=20
> Andy, may I ask what your plan to post those?

Andy, do you mind me posting those 2 patches to Ted on your behalf if =
you have
no plan to do this in the near future?

