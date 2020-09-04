Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB2C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F55206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bsGK+tO3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="joCesu+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgIDHah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:30:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59172 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgIDHad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:30:33 -0400
Date:   Fri, 4 Sep 2020 09:30:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599204631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AGsqav/G04K0AiRxGEvN/gAq23YOTfEZGjj/fzeicqE=;
        b=bsGK+tO36lGp25e3yuzDFSYbMDHLx+Rp5nxpS6+i45XR40alyWNc1Tr+Xcw3jNniUEO2zN
        +IYi6IM7PFc23PsBYzVzuVstQ21dAVqJAOvzvoiydd0oNfaC3OOhLdguRTdtpcTyi+YUnh
        wjJp0w5ffYosgxYb5DCyHlLKtb6qvzxJ78EHD8syabBm92WkpLoFCTRKshAXj4XcbFHJw/
        mJp6AvhQbpSNwj1b9BNQsIzU3iNLSGtJYYqVGYjbi/seL7FNSkN9OPIV5I9qZnRCbBsKko
        V4ZBeRcAWKjUQTunLkPuP0JwOCQiRD4SaAsFt9G7r/mD8Cg2argm2zStgpORkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599204631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AGsqav/G04K0AiRxGEvN/gAq23YOTfEZGjj/fzeicqE=;
        b=joCesu+zjnahqrPze7TIYCY/HqKH82z1+w+z7XY4cuLPXfdKjeN6ZdC/Rv30dFGWNeembG
        VqYK8nR1f8mEczAg==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     peterz@infradead.org
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] seqlock: Introduce PREEMPT_RT support
Message-ID: <20200904073057.GA255188@lx-t490>
References: <20200828010710.5407-1-a.darwish@linutronix.de>
 <20200904065245.GK2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904065245.GK2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 08:52:45AM +0200, peterz@infradead.org wrote:
>
> FWIW, can you please start a new thread with ever posting? I lost this
> one because it got stuck onto some ancient thread.
>

Yeah, I used an old send-mail script, sorry.
