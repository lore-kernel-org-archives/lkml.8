Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01E7C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90754207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G5l2pmbY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jxsYNZSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgIHGXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgIHGXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:23:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A76C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 23:23:05 -0700 (PDT)
Date:   Tue, 8 Sep 2020 08:23:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599546179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=solYDsAWQ3Z2NouER2vl0Kq8nq+z9YdyDRNNdI9kFhc=;
        b=G5l2pmbYt4mwM11DUFABkUpW0KihCDaqLX1WJFEV3q1aAXF98B4CZL2n1vSYLaA/WjuuM1
        xhkE1bM+Uy681+FUvs1cVcxw++vskj/5CLoFIRIpwFVUGkqddUe4vBxZ4G2KXGDrv0FhTP
        q7odUUZBpkzZpwIaUopa5xS74tiSkXMTO+E4iZEqF3Ag02TAxxkmIeWtlaK35YyrXM/JiQ
        Iux1OuN/7zIQU8TzCVAzL5uoiIKrB74zRh/2weOeaK6hzpPBU7Iawxi8So611ZWhdWonIp
        mdZnHZYajhaxVHWFm+8TOaLN9FmhMOJ1swibbPXUBVhGslDDIVApsNZWm4FP8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599546179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=solYDsAWQ3Z2NouER2vl0Kq8nq+z9YdyDRNNdI9kFhc=;
        b=jxsYNZSKR0Px4+LgGrAWos94dn/i8ogcGD5fv3yl0i0eRyDjj40K3r6PyUxjyCzkoLsWnP
        JbKGdGYKAYqId8Cw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     peterz@infradead.org
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 6/8] x86/tsc: Use seqcount_latch_t
Message-ID: <20200908062326.GA422817@lx-t490>
References: <20200827114044.11173-1-a.darwish@linutronix.de>
 <20200827114044.11173-7-a.darwish@linutronix.de>
 <20200904074142.GL2674@hirez.programming.kicks-ass.net>
 <20200904080312.GZ35926@hirez.programming.kicks-ass.net>
 <20200907162913.GA178765@lx-t490>
 <20200907173047.GO1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907173047.GO1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 07:30:47PM +0200, peterz@infradead.org wrote:
...
>
> Don't look at this function in isolation, look at native_sched_clock()
> where it's used as a whole.
>
...
> What happened (afaict) is that the change caused it to use more
> registers and ended up spiling crap on the stack.
>
...
>
> Anyway, I frobbed the patch to use the this_cpu variant, and I've queued
> the lot.

Perfect. Thanks a lot ;-)
