Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766ADC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4303120715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FWyzVgBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgGFUBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgGFUBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:01:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C735C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sPXLrF6v1EW/G4OklQNjGY3jiaGXKko0xM2/IPZO3Pg=; b=FWyzVgBlQGLyC1ikfPyxZ1y2ys
        lFS+gXIkg62w1GiIVU12yhFx7clWAI6JpIzjrgfVIVHjGtcBmwYWVCkSIAfQ77pgxu+kPntZrSd2I
        6LgBNRf8Grwfxze4VUYfuA/GyRWSjQAs0bDRoelBwoGFO7oP/mLDSjMWUl2zfp25AVmXaLHLcWLSG
        +CwKn6y0Z+OOdlOquR8shWEAdFla1o2DkEwN4lKrItNuIJ3cpFn8NBHwFk+pWe14Ig4od08GI1V00
        LG37JtKm0Llk2a/xpxST9nJTqPes0mDCDrANID4cAJkvHYOVOcTI2jAQHsaQW3WR3mRiR0fpEyJvY
        wP8IfsgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsXIH-0002ct-P7; Mon, 06 Jul 2020 20:00:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4480D980DD2; Mon,  6 Jul 2020 22:00:49 +0200 (CEST)
Date:   Mon, 6 Jul 2020 22:00:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2][RFC] Makes sd->flags sysctl writable
Message-ID: <20200706200049.GB5523@worktop.programming.kicks-ass.net>
References: <cover.1594062828.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594062828.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 03:36:13AM +0800, Chen Yu wrote:
> It was found that recently the flags of sched domain could
> not be customized via sysctl, which might make it a little
> inconenient for performance tuning/debugging.

What specific goals do you have? This is a debug interface.
