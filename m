Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F1DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9440320729
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DHdB3tW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHJJsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJJsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:48:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E10AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 02:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IlQDR13HuxKJhI67djiwbAUoko3dA9XlpyaQNoTbkpo=; b=DHdB3tW+U1/KBBeCV3NzBr6wpg
        f0uG2Y1m//uIOts/nshNMI3i10rd27mz75MiLiZBjHMRlv4j+e0xWEK/MTHToEj6irE2x4JbAnaE2
        dIw4MxY4i9jsoZE2NkqrtfzdpuGJW4+tgFa1gnNs0mQk5NP5qlGPUxHfBmvGm+l4Q0VXVJk1Mn0j0
        zTm352qCeVpwaSNKQ2LDQYrBz39gA5TeFZCfP528X8LtGwc7nI0XPCEmHWKh9r71GzC3G0P9BIHl0
        wS/J9GnOQyjUydq6dpNrre+DByc1FgZBMIn6uRbKhQU1xPcv0rh78ovqah/Iku59HGBmV32JqKvnX
        hXuYDl9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k54Pn-0006vK-Pu; Mon, 10 Aug 2020 09:48:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2FBD4306CCF;
        Mon, 10 Aug 2020 11:48:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2359200D415C; Mon, 10 Aug 2020 11:48:20 +0200 (CEST)
Date:   Mon, 10 Aug 2020 11:48:20 +0200
From:   peterz@infradead.org
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/24] seqlock: lockdep assert non-preemptibility on
 seqcount_t write
Message-ID: <20200810094820.GO2674@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
 <20200720155530.1173732-9-a.darwish@linutronix.de>
 <20200808232122.GA176509@roeck-us.net>
 <20200809184251.GA94072@lx-t490>
 <20200810085954.GA1591892@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810085954.GA1591892@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:59:54AM +0200, Greg KH wrote:
> On Sun, Aug 09, 2020 at 08:42:51PM +0200, Ahmed S. Darwish wrote:

> > @Peter, I think let's revert this one for now?
> 
> Please do, it's blowing up my local builds as well :(

There's a bunch of patches queued here:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent

That should fix it all, but I'm not exactly sure when the pull request
for that will go out.
