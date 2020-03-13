Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFB1C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FE82074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ba9ga6dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgCMV0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:26:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52798 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMV0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=6G8s1T+GZ3P8r3F6F1F/EpnEULgc6g/30mc+g7rqZr4=; b=Ba9ga6dttaNNgbz+Sr5soV2Ykr
        RueY7hooO5ZKBSibZK2CL1EkMwUHTFU3rE9DCCNrITWjH3eB42Rf76AFanuK5uHe11ov4EEpivTmK
        KCDFZ9pla/p21BZxZpuOkUoe6rdM7Xh5w6x6HH91cru7jMLX9e1Du7PdO6R89hDdk0wtZGdONguiT
        Q+ExgRY804XZKESZFyuO1i4twz/7kNSwsYWslC1xWQqFyB5Yykr0yj5Oumx8Ato1pj3gyi2HdgdPY
        j6DrQeHQlQzvBjdt4kj3hVWMaiOjJr1mhunoLQjivT1Qg2xijTOivBDHghjYKp7vc5dFwoZYO6Pay
        dyTsFVBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCrp1-00072l-6x; Fri, 13 Mar 2020 21:26:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 241CE98112D; Fri, 13 Mar 2020 22:26:20 +0100 (CET)
Date:   Fri, 13 Mar 2020 22:26:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        rostedt@goodmis.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] timer: silenct a lockdep splat with debugobjects
Message-ID: <20200313212620.GA2452@worktop.programming.kicks-ass.net>
References: <20200313154221.1566-1-cai@lca.pw>
 <20200313180811.GD12521@hirez.programming.kicks-ass.net>
 <4FFD109D-EAC1-486F-8548-AA1F5E024120@lca.pw>
 <20200313201314.GE5086@worktop.programming.kicks-ass.net>
 <D3115315-12A9-43A9-9209-09553CF2C71C@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D3115315-12A9-43A9-9209-09553CF2C71C@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 05:00:41PM -0400, Qian Cai wrote:
> > On Mar 13, 2020, at 4:13 PM, Peter Zijlstra <peterz@infradead.org> wrote:

> > 
> > Or, fix that random crud to do the wakeup outside of the lock.
> 
> That is likely to be difficult until we can find a creative way to not “uglifying" the
> random code by dropping locks in the middle etc just because of debugojects.

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=random/fast

Doesn't look difficult at all.
