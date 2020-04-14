Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E266C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 04:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57CDF206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 04:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XCSNgvSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405345AbgDNEbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 00:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728978AbgDNEbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 00:31:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B6DC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 21:31:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t4so4198665plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 21:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=zqo04Z3daGOEY5+xzurvNZidn/RF44ZVFwTm+A5P6Lw=;
        b=XCSNgvSRULnTF+kQ2OGlCXUpMD4ol0ZaWKYwZAek3HtQORb237vBkMND1i7+4I1nmW
         lidGJzHdMD/cLnrLUk6ky1ye9CbvzXQw0htHRy0oVAF7G7QM3Y1RI0k6Gzvp1gRml6GN
         UgiV6fjmI2S/2T4anXDQ1GCmk9OwEg3G70yz+/oFPhSTrf/PkS3CtTgNqIK0utys00bc
         7hq/4G9CXGPY+XSxanohtTGmZdOBj3uahGJjJ9/N1lbBPsvleP11/ImxczJH8B3tEeRR
         fozEH/Nwzyefaap9jjXpXYsS0Dg0jkjBzfm94R1hAR+MptUgI+xnjFfNvZTi/egEFBLT
         bgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=zqo04Z3daGOEY5+xzurvNZidn/RF44ZVFwTm+A5P6Lw=;
        b=E6u7yidvs69u6092xnxkI4dZ6FpqcHXK1LZ0afQzK3HWaq41HbXkD2mGdsQSYsvgwx
         LwKYHEfcqU0fBDGTNfoKPDtWzYPjdc46lhaCBpTlAxpb2HtgMn45c4z0IUczOc8iRRJp
         RLK3pRNOp+KXQ0DCroMp9la7O83ID8+nyvv9wN115+OXxzO7UfwOOp1THAMy6h+nalIl
         yyIVtzOMvYTNG2z+3X29owGg1Pi40C2wMcgJ5NqgGuwfjQTQ/zPycpDlZAqwLTc2nhF8
         eRivIdEUaNDV+emaP9LSmj+OYv6TsKX8ovfrUMJmxceo3JigxuZ7AIkV9YbS23tICHpZ
         lBLA==
X-Gm-Message-State: AGi0PuZQuzed5UhDsSOftTgjI6qxFo6eh4V9v8ty0juXt/FdU5aR4awI
        5NkfENXYEuGuitenar9Nez6P4m/yv6ihuQ==
X-Google-Smtp-Source: APiQypJGNPdQc1xipV81Hy9xmOXeZdKAth6FWb3HD9VJ5eTlZBqqDJhUD92kJH0PaYQ2fN4UpDZ3Qg==
X-Received: by 2002:a17:902:ba86:: with SMTP id k6mr21056259pls.47.1586838671059;
        Mon, 13 Apr 2020 21:31:11 -0700 (PDT)
Received: from [192.168.1.205] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id w75sm2289120pfc.156.2020.04.13.21.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 21:31:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jens Axboe <axboe@kernel.dk>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Date:   Mon, 13 Apr 2020 22:31:08 -0600
Message-Id: <1B14A912-22E9-434E-A7D4-079090C630B6@kernel.dk>
References: <20200414040717.22040-1-hdanton@sina.com>
Cc:     Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
In-Reply-To: <20200414040717.22040-1-hdanton@sina.com>
To:     Hillf Danton <hdanton@sina.com>
X-Mailer: iPhone Mail (17E255)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 13, 2020, at 10:07 PM, Hillf Danton <hdanton@sina.com> wrote:
>=20
> =EF=BB=BF
>> On Mon, 13 Apr 2020 18:06:21 -0400 Qian Cai wrote:
>>=20
>> BTW, I=3DE2=3D80=3D99ll be adding fuzzers to my daily linux-next routines=
 =3D
>> where it triggers this
>> io_uring/scheduler bug almost immediately, so hopefully would buy syzbot =3D=

>> some
>> time to resume on linux-next.
>>=20
>> [67493.516737][T211750] BUG: unable to handle page fault for address: =3D=

>> ffffffffffffffe8
>> [67493.557315][T211750] #PF: supervisor read access in kernel mode
>> [67493.586726][T211750] #PF: error_code(0x0000) - not-present page
>> [67493.614434][T211750] PGD f96e17067 P4D f96e17067 PUD f96e19067 PMD 0=3D=
20=3D
>>=20
>> [67493.644846][T211750] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
>> [67493.674127][T211750] CPU: 55 PID: 211750 Comm: trinity-c127 Tainted: =3D=

>> G    B        L    5.7.0-rc1-next-20200413 #4
>> [67493.722516][T211750] Hardware name: HP ProLiant DL380 Gen9/ProLiant =3D=

>> DL380 Gen9, BIOS P89 04/12/2017
>> [67493.764925][T211750] RIP: 0010:__wake_up_common+0x98/0x290
>> __wake_up_common at kernel/sched/wait.c:87
>> [67493.790675][T211750] Code: 40 4d 8d 78 e8 49 8d 7f 18 49 39 fd 0f 84 =3D=

>> 80 00 00 00 e8 6b bd 2b 00 49 8b 5f 18 45 31 e4 48 83 eb 18 4c 89 ff e8 =3D=

>> 08 bc 2b 00 <45> 8b 37 41 f6 c6 04 75 71 49 8d 7f 10 e8 46 bd 2b 00 49 =3D=

>> 8b 47 10
>> [67493.881650][T211750] RSP: 0018:ffffc9000adbfaf0 EFLAGS: 00010046
>> [67493.909854][T211750] RAX: 0000000000000000 RBX: ffffffffffffffe8 RCX: =3D=

>> ffffffffaa9636b8
>> [67493.947131][T211750] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: =3D=

>> ffffffffffffffe8
>> [67493.983829][T211750] RBP: ffffc9000adbfb40 R08: fffffbfff582c5fd R09: =3D=

>> fffffbfff582c5fd
>> [67494.020861][T211750] R10: ffffffffac162fe3 R11: fffffbfff582c5fc R12: =3D=

>> 0000000000000000
>> [67494.059249][T211750] R13: ffff888ef82b0960 R14: ffffc9000adbfb80 R15: =3D=

>> ffffffffffffffe8
>> [67494.099699][T211750] FS:  00007fdcba4c4740(0000) =3D
>> GS:ffff889033780000(0000) knlGS:0000000000000000
>> [67494.141858][T211750] CS:  0010 DS: 0000 ES: 0000 CR0: =3D
>> 0000000080050033
>> [67494.172660][T211750] CR2: ffffffffffffffe8 CR3: 0000000f776a0004 CR4: =3D=

>> 00000000001606e0
>> [67494.209760][T211750] Call Trace:
>> [67494.224720][T211750]  __wake_up_common_lock+0xea/0x150
>> (inlined by) __wake_up_common_lock at kernel/sched/wait.c:124
>> [67494.248753][T211750]  ? __wake_up_common+0x290/0x290
>> [67494.272014][T211750]  ? lockdep_hardirqs_on+0x16/0x2c0
>> [67494.296139][T211750]  __wake_up+0x13/0x20
>> [67494.314946][T211750]  io_cqring_ev_posted+0x75/0xe0
>> (inlined by) io_cqring_ev_posted at fs/io_uring.c:1160
>> [67494.337726][T211750]  io_ring_ctx_wait_and_kill+0x1c0/0x2f0
>> io_ring_ctx_wait_and_kill at fs/io_uring.c:7305
>> [67494.363840][T211750]  io_uring_create+0xa8d/0x13b0
>> [67494.386526][T211750]  ? io_req_defer_prep+0x990/0x990
>> [67494.410119][T211750]  ? __kasan_check_write+0x14/0x20
>> [67494.433646][T211750]  io_uring_setup+0xb8/0x130
>> [67494.454870][T211750]  ? io_uring_create+0x13b0/0x13b0
>> [67494.478342][T211750]  ? check_flags.part.28+0x220/0x220
>> [67494.502947][T211750]  ? lockdep_hardirqs_on+0x16/0x2c0
>> [67494.526965][T211750]  __x64_sys_io_uring_setup+0x31/0x40
>> [67494.551820][T211750]  do_syscall_64+0xcc/0xaf0
>> [67494.574829][T211750]  ? syscall_return_slowpath+0x580/0x580
>> [67494.604591][T211750]  ? lockdep_hardirqs_off+0x1f/0x140
>> [67494.628901][T211750]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
>> [67494.657616][T211750]  ? trace_hardirqs_off_caller+0x3a/0x150
>> [67494.683999][T211750]  ? trace_hardirqs_off_thunk+0x1a/0x1c
>> [67494.709982][T211750]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
>=20
>=20
> See if it makes your fuzzers happy.

It will, and we should probably do that separately too. I already posted ano=
ther fix that avoids the posted call that triggers it.

=E2=80=94=20
Jens Axboe

