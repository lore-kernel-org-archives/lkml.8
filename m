Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB412C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6170206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="AC8ZVjcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHJLTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgHJLTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:19:39 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31C6C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 04:19:38 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n129so2244848qkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 04:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=jBoqTcJjXqs5aO9SnK52GQyuo0v59XIXZ4pSXxs8r7w=;
        b=AC8ZVjcVv/L1gU8pXCKrOqaZ6vVq6XYgBjH2Hnm+JxbKrX1w5Fuuq8tGRaPTmcrs/f
         mJIHbtSmH/nnaQMZS4xirhZfVsoXp5JvBB21U5dnsFG9ZvZTPC38v77lG6WG92amYQGK
         yYE4WLzofc8nU/u3+NcZZLV+J7FAU2IjheLHFddS9jMSJqzabuU1T7hSyVoiT1+2ljAu
         54004XHqK+k/qXzk487itILNgkbds1WB/yUrp5q6w9OpnK/rUe1AJYkaY0PDQ3EZBybm
         /2lxTwtsKaKphX0xEVrMryVTz//L94l9ZRi2id7gCcyoPX8zF5wwyB62zfkgJ+toO/w4
         PkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=jBoqTcJjXqs5aO9SnK52GQyuo0v59XIXZ4pSXxs8r7w=;
        b=g96h7uwKOJLly74Bj+sg195/H7e+bQ6b18o6CRjdu0neoE4jAdewlCyxLkaX47yeh9
         d+wapDSSjpuUUwj4sI4ugC+jSD1FRN7eK6OvSXj5aZRdaRrDUs82FNwDO2Qi49lnwyYj
         8MOCi2mPXO764f7pHtiv227NLPYRL0zQqu4PEhv1Bp6ZMaWqCobz+XGVSobeftd14Dn9
         1GBAqugvLl7H21/GIPWmMvPYuJ6gIhDN8hlSdarNkYES7bKPu1OKQEGOnm+rQAP29gPX
         4H7WNvZMdPN2dA4eiwOwnnyK21ka4GLPVWSa+pPSUzsozlLEFoKdiunFcSYznAFS0pa/
         hBEQ==
X-Gm-Message-State: AOAM5333oWp0XbwBvH/L5tNNP32yJdNTZoeW9z1QS6kby3DnQVx21nrv
        8CKLPn06xPo1fhOIl8KpRU1culSsPvgdzQ==
X-Google-Smtp-Source: ABdhPJxbYWJL54iYtvN7kseO1/qs8NUOF49R1djsu38CnnLAFIRAGsxnqDfsY9uF6MEN5J7f/NaM2w==
X-Received: by 2002:a05:620a:142:: with SMTP id e2mr25276476qkn.418.1597058378182;
        Mon, 10 Aug 2020 04:19:38 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 78sm13980983qke.81.2020.08.10.04.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 04:19:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/5] kasan: add workqueue and timer stack for generic KASAN
Date:   Mon, 10 Aug 2020 07:19:35 -0400
Message-Id: <B873B364-FF03-4819-8F9C-79F3C4EF47CE@lca.pw>
References: <20200810072115.429-1-walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20200810072115.429-1-walter-zh.wu@mediatek.com>
To:     Walter Wu <walter-zh.wu@mediatek.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 10, 2020, at 3:21 AM, Walter Wu <walter-zh.wu@mediatek.com> wrote:
>=20
> =EF=BB=BFSyzbot reports many UAF issues for workqueue or timer, see [1] an=
d [2].
> In some of these access/allocation happened in process_one_work(),
> we see the free stack is useless in KASAN report, it doesn't help
> programmers to solve UAF on workqueue. The same may stand for times.
>=20
> This patchset improves KASAN reports by making them to have workqueue
> queueing stack and timer queueing stack information. It is useful for
> programmers to solve use-after-free or double-free memory issue.
>=20
> Generic KASAN will record the last two workqueue and timer stacks,
> print them in KASAN report. It is only suitable for generic KASAN.
>=20
> In order to print the last two workqueue and timer stacks, so that
> we add new members in struct kasan_alloc_meta.
> - two workqueue queueing work stacks, total size is 8 bytes.
> - two timer queueing stacks, total size is 8 bytes.
>=20
> Orignial struct kasan_alloc_meta size is 16 bytes. After add new
> members, then the struct kasan_alloc_meta total size is 32 bytes,
> It is a good number of alignment. Let it get better memory consumption.

Getting debugging tools complicated surely is the best way to kill it. I wou=
ld argue that it only make sense to complicate it if it is useful most of th=
e time which I never feel or hear that is the case. This reminds me your rec=
ent call_rcu() stacks that most of time just makes parsing the report cumber=
some. Thus, I urge this exercise to over-engineer on special cases need to s=
top entirely.

>=20
> [1]https://groups.google.com/g/syzkaller-bugs/search?q=3D%22use-after-free=
%22+process_one_work
> [2]https://groups.google.com/g/syzkaller-bugs/search?q=3D%22use-after-free=
%22%20expire_timers
> [3]https://bugzilla.kernel.org/show_bug.cgi?id=3D198437
>=20
> Walter Wu (5):
> timer: kasan: record and print timer stack
> workqueue: kasan: record and print workqueue stack
> lib/test_kasan.c: add timer test case
> lib/test_kasan.c: add workqueue test case
> kasan: update documentation for generic kasan
>=20
> Documentation/dev-tools/kasan.rst |  4 ++--
> include/linux/kasan.h             |  4 ++++
> kernel/time/timer.c               |  2 ++
> kernel/workqueue.c                |  3 +++
> lib/test_kasan.c                  | 54 +++++++++++++++++++++++++++++++++++=
+++++++++++++++++++
> mm/kasan/generic.c                | 42 +++++++++++++++++++++++++++++++++++=
+++++++
> mm/kasan/kasan.h                  |  6 +++++-
> mm/kasan/report.c                 | 22 ++++++++++++++++++++++
> 8 files changed, 134 insertions(+), 3 deletions(-)
>=20
> --=20
> You received this message because you are subscribed to the Google Groups "=
kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an e=
mail to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid=
/kasan-dev/20200810072115.429-1-walter-zh.wu%40mediatek.com.
