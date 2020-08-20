Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE10C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4CD62078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o1H86muR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OviB5U4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgHTLp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:45:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46886 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbgHTLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:43:51 -0400
Date:   Thu, 20 Aug 2020 13:43:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597923829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fs0xszonojcxQiSCiP7VDj8LwAaS4MgGm0Y2Kh2q/PU=;
        b=o1H86muR4hb+hGBg29QvEgQXTUYPEspL9XyX7ftP8D9lM4wPWEoGQnsoNoJs/v8oWoSt0g
        HLMGZ0DLfc7D1AFoxOxnZf/65VUwjiB5WzfQ7QUKN3abdkboeCWSCKUV13hWrQd4fwFrhN
        Upsg4L/kkYYNi8a2IyUOpQSNFphSR768Glc21m9zJCsEYR+dDnz5ODC51/yuv2dBJtACO2
        vJtyD2oT5DcniX8zCD/kIXUXMq1D2zzPrKQVNu5P+0KhmPJlAemNtMlm3L4IQ/LlfJXUjo
        q4SYWW3C5fDBxxL2l8CVe9pczAwLKi4cHiISPpVxRxYiVkUGeEOr0afkD32ycw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597923829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fs0xszonojcxQiSCiP7VDj8LwAaS4MgGm0Y2Kh2q/PU=;
        b=OviB5U4azqInvU74q0dhnJp2baFL61iRzz7mJ6+BRU3RKWOO4ybPCrOpPoJFAnDkZ6Jdiv
        4wY0gMoY4A38HSDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, tglx@linutronix.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH] lockdep: Do no validate wait context for novalidate class
Message-ID: <20200820114348.giwwlbihjwpl4kxz@linutronix.de>
References: <20200629201529.1017485-1-bigeasy@linutronix.de>
 <20200820114036.GQ2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820114036.GQ2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-20 13:40:36 [+0200], peterz@infradead.org wrote:
> Anyway, all 3 users should have the same wait context, so where is the
> actual problem?

I have one in RT which is a per-CPU spinlock within local_bh_disable()
to act as a per-CPU BLK like mainline.

Sebastian
