Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C349C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC8E20671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgETK0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETK0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:26:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7821C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 03:26:40 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jbLvm-00053v-Dk; Wed, 20 May 2020 12:26:34 +0200
Date:   Wed, 20 May 2020 12:26:34 +0200
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
Message-ID: <20200520102634.pin4mzyytmfqtuo2@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-9-bigeasy@linutronix.de>
 <B926444035E5E2439431908E3842AFD24AFEC5@DGGEMI525-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B926444035E5E2439431908E3842AFD24AFEC5@DGGEMI525-MBS.china.huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-19 21:46:06 [+0000], Song Bao Hua wrote:
> Hi Luis,
> In the below patch, in order to use the acomp APIs to leverage the power of hardware compressors. I have moved to mutex:
> https://marc.info/?l=linux-crypto-vger&m=158941285830302&w=2
> https://marc.info/?l=linux-crypto-vger&m=158941287930311&w=2
> 
> so once we get some progress on that one, I guess we don't need a special patch for RT any more.

If you convert this way from the current concept then we could drop it
from the series.
The second patch shows the following hunk:

|@@ -1075,11 +1124,20 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
| 
| 	/* compress */
| 	dst = get_cpu_var(zswap_dstmem);
|	acomp_ctx = *this_cpu_ptr(entry->pool->acomp_ctx);
|	put_cpu_var(zswap_dstmem);

So here you get per-CPU version of `dst' and `acomp_ctx' and then allow
preemption again.

|	mutex_lock(&acomp_ctx->mutex);
|
|	src = kmap(page);
|	sg_init_one(&input, src, PAGE_SIZE);
|	/* zswap_dstmem is of size (PAGE_SIZE * 2). Reflect same in sg_list */
|	sg_init_one(&output, dst, PAGE_SIZE * 2);

and here you use `dst' and `acomp_ctx' after the preempt_disable() has
been dropped so I don't understand why you used get_cpu_var(). It is
either protected by the mutex and doesn't require get_cpu_var() or it
isn't (and should have additional protection).

|	acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dlen);
|	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
|	dlen = acomp_ctx->req->dlen;
|	kunmap(page);
|
| 	if (ret) {
| 		ret = -EINVAL;
| 		goto put_dstmem;
|

Sebastian
