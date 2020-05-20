Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F1BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E6A4207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgETL5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgETL5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:57:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3709FC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:57:49 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jbNLx-00071O-Su; Wed, 20 May 2020 13:57:42 +0200
Date:   Wed, 20 May 2020 13:57:41 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Song Bao Hua <song.bao.hua@hisilicon.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH 8/8] mm/zswap: Use local lock to protect per-CPU data
Message-ID: <20200520115741.wy2qnmauxmjtrrzj@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-9-bigeasy@linutronix.de>
 <B926444035E5E2439431908E3842AFD24AFEC5@DGGEMI525-MBS.china.huawei.com>
 <20200520102634.pin4mzyytmfqtuo2@linutronix.de>
 <B926444035E5E2439431908E3842AFD24B2058@DGGEMI525-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B926444035E5E2439431908E3842AFD24B2058@DGGEMI525-MBS.china.huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-20 11:13:31 [+0000], Song Bao Hua wrote:
> For example, on cpu1, once you begin to compress, you hold the percpu acomp-ctx and percpu destination buffer of CPU1, the below code makes sure you get the acomp and dstmem from the same core by disabling preemption with get_cpu_var and put_cpu_var:
> dst = get_cpu_var(zswap_dstmem);
> acomp_ctx = *this_cpu_ptr(entry->pool->acomp_ctx);
> put_cpu_var(zswap_dstmem);
> 
> then there are two cases:
> 
> 1. after getting dst and acomp_ctx of cpu1, you might always work in cpu1, the mutex in per-cpu acomp-ctx will guarantee two compressions won't do at the same core in parallel, and it also makes certain compression and decompression won't do at the same core in parallel. Everything is like before.

For readability I suggest not to mix per-CPU and per-CTX variables like
that. If zswap_dstmem is protected by the mutex, please make it part of
acomp_ctx.

Sebastian
