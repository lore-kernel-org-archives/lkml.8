Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB9EC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0ADC20C56
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dOOiQwAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgH1I2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgH1I2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:28:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B084EC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zDJCSRQqxmuBzOdim0ZpsVxleqNgwLrnL8/KvPnBAls=; b=dOOiQwAcq3nJ3bgpPCwenUa8f1
        YpLTHHYkj1LeEyI4SnmRJD6I4ujdK6hL0IDc/HKiP5Y8RfHhlVpiJ3urGYbc8qVx+ExCJTfGmAOrh
        akplHkQb6bgwHIbNLkVs9/XR24D1pSHHIBLQt0yPdtoBLsT2pXvG6fM4YiJap2QjZubrrS0Dx7YL0
        dQ+4xFOtoH0Inkj/ZFqnNRB6k68vPA3PCGs2rH7fHSCBGYBJi+uKNKFzqxbQn5HyLYaAf3gOXSsJc
        G9avJRKDplvU1MZKVgAq0R3vEMhmxbnwcrKtCJXJWslLZ9tXz/MSA4s1TfuDU24shiXaqGeRFzLOP
        XSokx2oA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBZjo-0003QP-Ac; Fri, 28 Aug 2020 08:27:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F22D30015A;
        Fri, 28 Aug 2020 10:27:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40F022C5F134A; Fri, 28 Aug 2020 10:27:54 +0200 (CEST)
Date:   Fri, 28 Aug 2020 10:27:54 +0200
From:   peterz@infradead.org
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/5] seqlock: Use unique prefix for seqcount_t
 property accessors
Message-ID: <20200828082754.GN1362448@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200828010710.5407-1-a.darwish@linutronix.de>
 <20200828010710.5407-3-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828010710.5407-3-a.darwish@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:07:07AM +0200, Ahmed S. Darwish wrote:
> Differentiate the first group by using "__seqcount_t_" as prefix. This
> also conforms with the rest of seqlock.h naming conventions.

>  #define __seqprop_case(s, locktype, prop)				\
>  	seqcount_##locktype##_t: __seqcount_##locktype##_##prop((void *)(s))
>  
>  #define __seqprop(s, prop) _Generic(*(s),				\
> -	seqcount_t:		__seqcount_##prop((void *)(s)),		\
> +	seqcount_t:		__seqcount_t_##prop((void *)(s)),	\
>  	__seqprop_case((s),	raw_spinlock,	prop),			\
>  	__seqprop_case((s),	spinlock,	prop),			\
>  	__seqprop_case((s),	rwlock,		prop),			\

If instead you do:

#define __seqprop_case(s, _lockname, prop) \
	seqcount##_lockname##_t: __seqcount##_lockname##_##prop((void *)(s))

You can have:

	__seqprop_case((s),	,		prop),
	__seqprop_case((s),	_raw_spinlock,	prop),
	__seqprop_case((s),	_spinlock,	prop),
	__seqprop_case((s),	_rwlock,	prop),
	__seqprop_case((s),	_mutex,		prop),
	__seqprop_case((s),	_ww_mutex,	prop),

And it's all good again.

Although arguably we should do something like s/__seqcount/__seqprop/
over this lot.


