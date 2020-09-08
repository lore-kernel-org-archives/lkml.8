Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE77C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5984C21D82
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UXvL9Rot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgIHMac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 08:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730111AbgIHLwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:52:30 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3D8C061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 04:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mlE2/43kRhjxn1Z1hO/rPDDB/G74PkkXDKI8s9YvWBQ=; b=UXvL9Rot2MWeGJU8jkHsp/N6c+
        jDOLBS8BHyKI98wT87JtF7YoBKspEcF+3WfHMvN67LUNuZjseHG/vVePuu9UqOEK0flpsyb1c1FPg
        8RQOYMqqBKPoElFOBSvbDZCh3nX1j71qwNek0RFDt5Tm05R8z2kUfLDPc2+loxmfII6oq9oefWLL6
        RcRP02FzQpfzNfZ3EhlzP6rF5zwJZCXcVrLzyEZlkUAQDWRC6P1JiBU4Cyq3G0mkQG4vZIArCCoCh
        ZzxkZMCtZJ5eigwUS4bJo51AJGYJilfZeOk9DNeTMZ8P7v1S0WcS8G0CJVxlGdkGtKNbBKc8tEuVo
        p+C5kDJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFc0O-0005jL-F8; Tue, 08 Sep 2020 11:41:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 14390300130;
        Tue,  8 Sep 2020 13:41:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED28E23649287; Tue,  8 Sep 2020 13:41:42 +0200 (CEST)
Date:   Tue, 8 Sep 2020 13:41:42 +0200
From:   peterz@infradead.org
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] seqlock: Use unique prefix for seqcount_t
 property accessors
Message-ID: <20200908114142.GR1362448@hirez.programming.kicks-ass.net>
References: <20200904153231.11994-1-a.darwish@linutronix.de>
 <20200904153231.11994-3-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904153231.11994-3-a.darwish@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 05:32:28PM +0200, Ahmed S. Darwish wrote:

>  static __always_inline seqcount_t *					\
> -__seqcount_##lockname##_ptr(seqcount_##lockname##_t *s)			\
> +__seqprop_seqcount_##lockname##_ptr(seqcount_##lockname##_t *s)		\

I did s/__seqprop_seqcount_/__seqprop_/g on all this.

seqprop is a contraction of seqcount property, no need to put in yet
another seqcount I feel.
