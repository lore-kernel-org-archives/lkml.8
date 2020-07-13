Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D749FC433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B7A2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lH6BvB4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgGMNX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:23:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52345 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbgGMNXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:23:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200713132350euoutp02fec10d651dd03c4a8ef850e0976dc445~hUqlqfJNJ0776507765euoutp02G
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 13:23:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200713132350euoutp02fec10d651dd03c4a8ef850e0976dc445~hUqlqfJNJ0776507765euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594646630;
        bh=fNdpX2odgKVBawGRmV4rb/Qbvgl0SrWBl4V+4J4Ee5Q=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=lH6BvB4qLvHwm2Bbk0e83J45/SrWfkeGuPyjK/NdBiqQoagl4xMxlesTgyHcBc5oe
         K98AfdmVcX56OMleSMnWcDNH4EzI4XQCYWWcZcAbW1D48nPjCmj32sw5xe3Ghxu7rz
         fMy3lBNyyHeAynTPcIoEWPG2A0M3bT162jdFtLBE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200713132350eucas1p2bae88f863493f264bc2372e211e4b26f~hUqlWkvkX1958919589eucas1p2I;
        Mon, 13 Jul 2020 13:23:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B5.DC.06318.6606C0F5; Mon, 13
        Jul 2020 14:23:50 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200713132349eucas1p1a67db68787c171d5a4b676b5f97900d9~hUqk-Zj4o0272502725eucas1p1r;
        Mon, 13 Jul 2020 13:23:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200713132349eusmtrp2933489ade48f21526a3ff51744d9195e~hUqk_tC8F2572925729eusmtrp2e;
        Mon, 13 Jul 2020 13:23:49 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-1f-5f0c6066e551
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 10.6E.06314.5606C0F5; Mon, 13
        Jul 2020 14:23:49 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200713132349eusmtip24756ee22791cf003cc7b5f9f0b30a753~hUqkbg7030859108591eusmtip2Q;
        Mon, 13 Jul 2020 13:23:49 +0000 (GMT)
Subject: Re: [RFC PATCH] ARM: dts: exynos: partial revert of Adjust bus
 related OPPs to the values correct for Exynos5422 Odroids
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <147bc7a2-b8bd-83b5-17b3-2c1beedcf387@samsung.com>
Date:   Mon, 13 Jul 2020 15:23:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200703132054.re3kcgxrb7rciidy@macmini.local>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2845OzOnn9PwzSxxVJCg5uXHgdRU/LE/UUQQCDlnHi+pU3a8
        pP1Iy6xWaDdTl2WKpVm6XN5JwUtZLLdUNJOKnFp4I8QUMy85T5b/nud9npf3eeClhdJ60omO
        VSWzapUyXkZZEQ2vfxndo8KtFQeLLtsytYU6kinpMpJM3uiUkDGZnosY/eggyfS3FFNMoalN
        wFxq7RIxC2/MKFAsb9Z+Fsn1VVcp+Yvy8/Lcuiokn9PvOUaGWvlFsvGxqazaMyDcKqbOUEol
        jbuenchOy0TFzhokpgH7wkrbXUqDrGgprkQwXlEt4MlPBGZzLsmTOQRN97LR5op+qQLxQgWC
        lz2LQosgxT8QVOrjLII9vojAUKknLMQBDwlAo8vccFHYCzQzGsqCJTgA5q4928AE3geazr4N
        zw4cBrqJRgHvsYO3RWOEBYuxHxTdniQtWIhdoHGmWMhjRxgeK9kIDrhFBDrjsIDPGgJrg7MU
        j+1hsrtOxGNnWGveXFiPOmKsFvHkOoL+C4V/mx6CT8al9W16/cQB0LV48uMgmHqgE1jGgG1g
        aMaOD2EDtxoKhPxYAldypLx7P2i7a/6dbX/PdwQsh8GnedQN5KrdUlO7pZp2SzXt/wwPEVGF
        HNkULiGa5XxUbJoHp0zgUlTRHqcTE/Ro/ZkMq93zTahtOaIDYRrJrCVw1FohJZWpXHpCBwJa
        KHOQBPcYwqSSSGV6BqtOVKhT4lmuA+2iCZmjxKds4pQURyuT2TiWTWLVm6qAFjtlolcnPhp8
        R1eCRxq8pzu3T++2nbXhiMq9ieLQLpcUrff8gDm/vua7zyBBZ6Vl3Sy4kxli+tJYmIO9yXdu
        KpPJP/9bWfvJooju+MbesW1Bj9b6emsPt55ZMPtHxZZ7LfeVmmSrj+9HTH74uuh55MlxKJst
        r3ffORLoq2j6PXDOxiFDRnAxSi83oZpT/gHm9y7lSAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xe7qpCTzxBj/PGllsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+TReveI+wW3048YnTg9Ng56y67x6ZVnWwem5fU
        e/RtWcXo8XmTXABrlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpO
        Zllqkb5dgl7GltML2QqeKla8bClvYJwj08XIySEhYCKx6ddyxi5GLg4hgaWMEvMu/WSCSMhI
        nJzWwAphC0v8udbFBlH0llHi+NyNrCCOsEAzo8TpFZtYQBwRgRtMEh9vHGaBKOtnlLh1+R87
        SD+bgKFE11uQfk4OXgE7ic/da8BsFgFVia7Dl5hBbFGBOInlW+azQ9QISpyc+YQFxOYUsJGY
        OfkV2B3MAmYS8zY/ZIaw5SW2v50DZYtL3Hoyn2kCo+AsJO2zkLTMQtIyC0nLAkaWVYwiqaXF
        uem5xYZ6xYm5xaV56XrJ+bmbGIExt+3Yz807GC9tDD7EKMDBqMTDK+HPEy/EmlhWXJl7iFGC
        g1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4HpoO8knhDU0NzC0tDc2NzYzML
        JXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MNqYPAjZ0JrufKeyc3S1kv/Tm0z8ZX3qXbzlb
        +TDGqz/j/RSDx/8KzvHNunhv9qkrD7c/7pvLMP//eku+uzce6eZ5r3vOqG+zRfOn2q9LVhbz
        7y1QWOS0UVtyVdr8p/LXVA0nxSke9s0RT7vDyb5+9vcNQqULL//t6LdYuOXDln+9kxREEm5+
        zFBiKc5INNRiLipOBADZ6HENzwIAAA==
X-CMS-MailID: 20200713132349eucas1p1a67db68787c171d5a4b676b5f97900d9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200703132101eucas1p208d5f57ffd28acf6ce4662d5e9081d6c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200703132101eucas1p208d5f57ffd28acf6ce4662d5e9081d6c
References: <CGME20200703132101eucas1p208d5f57ffd28acf6ce4662d5e9081d6c@eucas1p2.samsung.com>
        <20200703132054.re3kcgxrb7rciidy@macmini.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On 03.07.2020 15:20, Willy Wolff wrote:
> On Odroid XU3/4 board, since 5.6 with 1019fe2c728003f89ee11482cf8ec81dbd8f15ba,
> the network is not working properly.
>
> After properly booting, when trying to connect to the board via ssh, the board
> hang for a while and this message happen:
>
> [  211.111967] ------------[ cut here ]------------
> [  211.117520] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:443 dev_watchdog+0x3ac/0x3e0
> [  211.125636] NETDEV WATCHDOG: eth0 (smsc95xx): transmit queue 0 timed out
> [  211.132058] Modules linked in:
> [  211.134815] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0-rc3-00082-gcdd3bb54332f-dirty #1
> [  211.143518] Hardware name: Samsung Exynos (Flattened Device Tree)
> [  211.149458] [<c0112290>] (unwind_backtrace) from [<c010d1ac>] (show_stack+0x10/0x14)
> [  211.157287] [<c010d1ac>] (show_stack) from [<c051b93c>] (dump_stack+0xac/0xd8)
> [  211.164416] [<c051b93c>] (dump_stack) from [<c0127a50>] (__warn+0xd0/0x108)
> [  211.171301] [<c0127a50>] (__warn) from [<c0127e60>] (warn_slowpath_fmt+0x94/0xb8)
> [  211.178824] [<c0127e60>] (warn_slowpath_fmt) from [<c0929b38>] (dev_watchdog+0x3ac/0x3e0)
> [  211.187043] [<c0929b38>] (dev_watchdog) from [<c01c791c>] (call_timer_fn+0xd4/0x420)
> [  211.194698] [<c01c791c>] (call_timer_fn) from [<c01c86ec>] (run_timer_softirq+0x620/0x784)
> [  211.202980] [<c01c86ec>] (run_timer_softirq) from [<c0101408>] (__do_softirq+0x1e0/0x664)
> [  211.211123] [<c0101408>] (__do_softirq) from [<c0130924>] (irq_exit+0x158/0x16c)
> [  211.218467] [<c0130924>] (irq_exit) from [<c01a1ef0>] (__handle_domain_irq+0x80/0xec)
> [  211.226304] [<c01a1ef0>] (__handle_domain_irq) from [<c0536eac>] (gic_handle_irq+0x58/0x9c)
> [  211.234626] [<c0536eac>] (gic_handle_irq) from [<c0100af0>] (__irq_svc+0x70/0xb0)
> [  211.241982] Exception stack(0xc1101f10 to 0xc1101f58)
> [  211.246789] 1f00:                                     ffffffff ffffffff 00000001 0008f0bd
> [  211.255230] 1f20: ffffe000 c1108eec c1108f30 00000001 00000000 c0df311c 00000000 c1076028
> [  211.262303] exynos5-hsi2c 12ca0000.i2c: tx timeout
> [  211.263351] 1f40: 00000000 c1101f60 c01097f8 c01097fc 600f0113 ffffffff
> [  211.263649] [<c0100af0>] (__irq_svc) from [<c01097fc>] (arch_cpu_idle+0x24/0x44)
> [  211.263771] [<c01097fc>] (arch_cpu_idle) from [<c01640c8>] (do_idle+0x214/0x2c0)
> [  211.289414] [<c01640c8>] (do_idle) from [<c0164528>] (cpu_startup_entry+0x18/0x1c)
> [  211.296999] [<c0164528>] (cpu_startup_entry) from [<c1000e54>] (start_kernel+0x4e8/0x520)
> [  211.305822] irq event stamp: 585972
> [  211.308637] hardirqs last  enabled at (585984): [<c0100b0c>] __irq_svc+0x8c/0xb0
> [  211.316470] hardirqs last disabled at (585993): [<c019ed9c>] console_unlock+0xd4/0x654
> [  211.324282] softirqs last  enabled at (585920): [<c0130640>] irq_enter_rcu+0x7c/0x84
> [  211.332072] softirqs last disabled at (585921): [<c0130924>] irq_exit+0x158/0x16c
> [  211.339329] ---[ end trace 5726ca773f159ae9 ]---
>
> After that, the board continue working from serial console only, but the board
> doesn't pong anymore.
>
> Reverting some change fix the issue.

Okay, I've finally found some time to analyze this. Your proposed change 
simply disables devfreq for fsys-bus and it looks that it wasn't working 
from the begging, due to some misunderstanding what is 'shared-opp'.

When one OPP table has such 'shared-opp' property, when one bus sets the 
OPP (in our case the FSYS_APB bus), framework assumes that this means 
that the OPP for the other bus that shares it is also automatically set, 
so framework will not call clk_set_rate for the FSYS bus related clock. 
This is okay if two busses shares OPPs and the same clock, but here we 
have two busses 'sharing' OPPs, but with different clocks.

I remember that You have tries different frequencies for FSYS bus, but 
in all cases it sooner or later caused USB host crash. I think that the 
best way to fix this issue would be simply to remove the FSYS-bus 
devfreq, as scaling its frequency breaks USB host operation on some boards.

I will prepare a patch removing FSYS bus entry with the above 
description and your 'reported-by' tag.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

