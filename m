Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB28BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F75B207FD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YsWuJHAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgCFI3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:29:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCFI3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dUfwQLOj8gTmHvihfqzWXTVzRKkIcObRg1X77vA4m4w=; b=YsWuJHAKFg51vuQ+BgUeru9Mrv
        /TJPD2dWVY+tuHloYwNGrdRCUeGcm8ApCbKuGqwp3XrUAUWwtzYFPt+CPYB7/dqI6m35Gw+v7F72D
        LMjFOy3ItG3DNm0pVztV29IH+O2x3U5GOXpl3YReidZrHxyV4HViWezx1F3ghJqxp8vb2X4+6HHik
        A0p+EEQmCzLzp26psVDVfKRpMxYZAWJLaEiQZgCDZtB2tgTbyv1WclmISnaRloXQq4qK4N8a5pa0X
        nx9XSQ5t8E6iH1Yvpxia8roNnG9l8Qpp42mjP4CF3Uhxk5uQ0aT/jVS3t3cDX3CKvuk6oAZcJfGzq
        6e7HAh1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jA8Ln-0001iP-3S; Fri, 06 Mar 2020 08:28:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ADBD5300606;
        Fri,  6 Mar 2020 09:28:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 740A02009BA14; Fri,  6 Mar 2020 09:28:52 +0100 (CET)
Date:   Fri, 6 Mar 2020 09:28:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xi Wang <xii@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Paul Turner <pjt@google.com>
Subject: Re: [PATCH] sched: watchdog: Touch kernel watchdog in sched code
Message-ID: <20200306082852.GB12561@hirez.programming.kicks-ass.net>
References: <20200304213941.112303-1-xii@google.com>
 <20200305075742.GR2596@hirez.programming.kicks-ass.net>
 <87blpad6b2.fsf@nanos.tec.linutronix.de>
 <CAOBoifgHNag0P33PKg81iNoCjxenJHfBZG-t-8aEkr_Tjf7o_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOBoifgHNag0P33PKg81iNoCjxenJHfBZG-t-8aEkr_Tjf7o_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
