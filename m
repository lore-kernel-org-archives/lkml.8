Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCDFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507392068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NkPiGT0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgFOIa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgFOIaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:30:23 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3A4C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JxaUqA2i25qe67HPi/CGvDDCit7p13vGokAFsGjTlaw=; b=NkPiGT0mZMs3UyUxA7xRhOOm3B
        YNj3XS7c7uAhEuuATUHMXN1/x/3y8QDnqBISuZN1jNHmmBcaEojq72njhJsjYduHOV4qVyC7Lbs+i
        W5SGdiuBCis7ZZpzA0hhjar1SgeGSjkceazntgcEncFue3z012nJlGHTj7uKEWvwNfam50ald5mKj
        n4xKwFxMNJFR23ndWVpHI2gIiNHU9GERdggpGg6iwxePO2lc0iLWly6CadxRy863IDY8cHSZdL4Qa
        a+bgFqlwABYDMF3ZZaRKqkjU7LdE3Klo7PLBsI3HShBxZoo6hyPFP5pbv6X6+alwIbHidmVzinffv
        LmJvow2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkkV5-0006SQ-9C; Mon, 15 Jun 2020 08:29:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7FBEE301A32;
        Mon, 15 Jun 2020 10:29:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4161621059C0A; Mon, 15 Jun 2020 10:29:49 +0200 (CEST)
Date:   Mon, 15 Jun 2020 10:29:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: BUG: kernel NULL pointer dereference from check_preempt_wakeup()
Message-ID: <20200615082949.GL2497@hirez.programming.kicks-ass.net>
References: <20200605141607.GB4455@paulmck-ThinkPad-P72>
 <20200605184159.GA4062@paulmck-ThinkPad-P72>
 <20200606005126.GA21507@paulmck-ThinkPad-P72>
 <20200606172942.GA30594@paulmck-ThinkPad-P72>
 <20200607185732.GA18906@paulmck-ThinkPad-P72>
 <20200609154016.GA17196@paulmck-ThinkPad-P72>
 <20200613024829.GA12958@paulmck-ThinkPad-P72>
 <87ftazctov.fsf@nanos.tec.linutronix.de>
 <20200613145719.GA2723@paulmck-ThinkPad-P72>
 <20200613234030.GA25146@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613234030.GA25146@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 04:40:30PM -0700, Paul E. McKenney wrote:

> So Peter's patch is fully in the clear:
> 
> Tested-by: Paul E. McKenney <paulmck@kernel.org>

Awesome!, now I get to explain how the lack of that leads to the
observed NULL pointer :-)

