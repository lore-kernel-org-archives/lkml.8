Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C398C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0342220787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D6XVPjQC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZhTW850k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbgGVSFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:05:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51030 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGVSFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:05:24 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595441122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HatAk6RLCg4BmgwgUUTlkbbDJ6PjhNZBQ9Tw9yFbT4I=;
        b=D6XVPjQCLKSWZPpdI6cMRuDA9c/iFta9Hfe/N1dPr6/12SHs+OIA610WTO40fMTDT8z6ge
        /RSxszDgWdBIe799CF4MT8UstcEUOjilZhXdTVMDCtHgBF49wKhzs+SX1twfEd1A+j0yUL
        5iNnObdWMRql4ZklLvAd0b4nsx+W9xAFA/K9ZEDoRbhRTH9MwAdKrglBp+0fj1daIz4DrX
        mI26ifz6kZLk8C17WN0sSlmJNPHNhRgk2VX74Qmu95rjX4q+6pY4QV0Z1WXkJdIWdzqnoY
        5fU87CNL8G/bikUObRBX5loS26/YRmfX5giqK5yLUdGDOMUW7aGjBmprriSjEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595441122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HatAk6RLCg4BmgwgUUTlkbbDJ6PjhNZBQ9Tw9yFbT4I=;
        b=ZhTW850ki2WWzZ/FyUzSmrmqxZoHdvwjEDV12BXjtl4VwAvQTYr1aerN3GKu9kzCRfeuXu
        UhUMe1c0p5Oo4zAg==
To:     qianjun.kernel@gmail.com, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org, urezki@gmail.com
Cc:     laoar.shao@gmail.com, jun qian <qianjun.kernel@gmail.com>
Subject: Re: [RFC PATCH v2] Softirq:avoid large sched delay from the pending softirqs
In-Reply-To: <1595250506-9769-1-git-send-email-qianjun.kernel@gmail.com>
References: <1595250506-9769-1-git-send-email-qianjun.kernel@gmail.com>
Date:   Wed, 22 Jul 2020 20:05:22 +0200
Message-ID: <87eep32zod.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qianjun.kernel@gmail.com writes:
> +
> +		end = ktime_get();
> +		delta = ktime_to_us(end - start);

What's the point of this conversion? That's a division for no value
because you can simply define the maximum time in nanoseconds with the
same effect, i.e.

	ktime_t end = ktime_get() + MAX_SOFTIRQ_TIME_NS;

	if (need_resched() && ktime_get() > end)
		break;

So you can spare all that start, delta and conversion dance and keep the
code simple.

Also notice that need_resched() wants to be evaluated first because
there is no point to do the more expensive time read if need_resched()
is false.

Thanks,

        tglx
