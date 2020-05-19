Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59587C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDD120874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgESVqS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:46:18 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2506 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbgESVqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:46:17 -0400
Received: from dggemi403-hub.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id A1673E410988D330014D;
        Wed, 20 May 2020 05:46:15 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.191]) by
 dggemi403-hub.china.huawei.com ([10.3.17.136]) with mapi id 14.03.0487.000;
 Wed, 20 May 2020 05:46:08 +0800
From:   Song Bao Hua <song.bao.hua@hisilicon.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 8/8] mm/zswap: Use local lock to protect per-CPU data
Thread-Topic: [PATCH 8/8] mm/zswap: Use local lock to protect per-CPU data
Thread-Index: AQHWLhsB19zOKbhSok+Mjvon7Zb2Y6iv78fA
Date:   Tue, 19 May 2020 21:46:06 +0000
Message-ID: <B926444035E5E2439431908E3842AFD24AFEC5@DGGEMI525-MBS.china.huawei.com>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-9-bigeasy@linutronix.de>
In-Reply-To: <20200519201912.1564477-9-bigeasy@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.125]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>

> zwap uses per-CPU compression. The per-CPU data pointer is acquired with
> get_cpu_ptr() which implicitly disables preemption. It allocates memory inside the preempt disabled region which conflicts with the PREEMPT_RT semantics.

> Replace the implicit preemption control with an explicit local lock.
> This allows RT kernels to substitute it with a real per CPU lock, which serializes the access but keeps the code section preemptible. On non RT kernels this maps to preempt_disable() as before, i.e. no functional change.

Hi Luis,
In the below patch, in order to use the acomp APIs to leverage the power of hardware compressors. I have moved to mutex:
https://marc.info/?l=linux-crypto-vger&m=158941285830302&w=2
https://marc.info/?l=linux-crypto-vger&m=158941287930311&w=2

so once we get some progress on that one, I guess we don't need a special patch for RT any more.

> [bigeasy: Use local_lock(), additional hunks, patch description]

> Cc: Seth Jennings <sjenning@redhat.com>
> Cc: Dan Streetman <ddstreet@ieee.org>
> Cc: Vitaly Wool <vitaly.wool@konsulko.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  mm/zswap.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)

Thanks
Barry


