Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF66C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B6320656
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oqzjQJxi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NWICybjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgHJUSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHJUSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:18:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE7DC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:18:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597090712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MipIWmCfz+EbbW+HlVadROmknV5HQ2RLosQPnMEF508=;
        b=oqzjQJxi+4EcDxIZ9TU1nrguRGzCpmPnUTFUAM6jIA4xNysviZiL5sS29BHM1bqpXFjEB/
        /LHjM9cBRImWc18sPVukjnqihkNQfjOKVhy75c08Q0quj7MnV2jOtACaix54ER29RMfe/F
        s/grvw6lQoVzLR7aVsZ5Cy6NKwChXSebyb8wo8ok+VipdJgbY4cDU7mihtEsDyAtSi7mXe
        Ne8K+qiWXsg77A5uD/rd3+P7jPFYX9+II9SZC16v9ORT6Ydf1GJyjAfv/xGz3JpVuS9aXB
        1s9bT8YMo15EZ493pcrdBv3Lw/m/lsDneOJhPMhCg+JNXqAg/oGH2Xdy3ujvNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597090712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MipIWmCfz+EbbW+HlVadROmknV5HQ2RLosQPnMEF508=;
        b=NWICybjtsMz2c5z8VLivQZegGL5UcHOP1KeIBQcSDvohUIv56mOGmsE7G3BKvW4qcs7NDS
        vPTD8bhNRw6FBTBg==
To:     Marco Elver <elver@google.com>, elver@google.com,
        paulmck@kernel.org
Cc:     peterz@infradead.org, bp@alien8.de, mingo@kernel.org,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com
Subject: Re: [PATCH] kcsan: Treat runtime as NMI-like with interrupt tracing
In-Reply-To: <20200807090031.3506555-1-elver@google.com>
References: <20200807090031.3506555-1-elver@google.com>
Date:   Mon, 10 Aug 2020 22:18:31 +0200
Message-ID: <87pn7yxnjc.fsf@nanos>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Elver <elver@google.com> writes:
> Since KCSAN instrumentation is everywhere, we need to treat the hooks
> NMI-like for interrupt tracing. In order to present an as 'normal' as
> possible context to the code called by KCSAN when reporting errors, we
> need to update the IRQ-tracing state.
>
> Tested: Several runs through kcsan-test with different configuration
> (PROVE_LOCKING on/off), as well as hours of syzbot testing with the
> original config that caught the problem (without CONFIG_PARAVIRT=y,
> which appears to cause IRQ state tracking inconsistencies even when
> KCSAN remains off, see Link).
>
> Link: https://lkml.kernel.org/r/0000000000007d3b2d05ac1c303e@google.com
> Fixes: 248591f5d257 ("kcsan: Make KCSAN compatible with new IRQ state tracking")
> Reported-by: syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com
> Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> Patch Note: This patch applies to latest mainline. While current
> mainline suffers from the above problem, the configs required to hit the
> issue are likely not enabled too often (of course with PROVE_LOCKING on;
> we hit it on syzbot though). It'll probably be wise to queue this as
> normal on -rcu, just in case something is still off, given the
> non-trivial nature of the issue. (If it should instead go to mainline
> right now as a fix, I'd like some more test time on syzbot.)

I'd rather stick it into mainline before -rc1.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
