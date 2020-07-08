Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285A7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4F220786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z4AU5VEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbgGHQQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbgGHQQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:16:17 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30807C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=egaKUCkqm/F8Lgo+G+BbyrSEcoTM/F4vaLTAZkfOYLI=; b=Z4AU5VErCCxwC9Veqb25AFvDkM
        /0L54C/QHYwu9Q6rzceSamw1O+pAgfVCFUShkR4eCIEITaWktFY7zY1xRKANlPSChTSWhyKgJtX0E
        0ktNksfjJk8o/J8ePcA330r41mnqI8yjrATlUAay61b3IZp9kn6MyIKU6jNS775no69yJxHcRVZBd
        VDPbnOuBRQVReQWoW2xJl+HZFnIlipoa2JDPWHl0scWEKqDiWpB1ZveEwox7SCNSrXsvatwRhZ159
        QJ0tigVE0x4ytWorRDWklz79lHnhZ9YMM4bY5Tg0zBkg5RA9nvOxF4ljux+88i0sizyx8IIl6OVmh
        YXbfp3EQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtCk0-0000KU-9v; Wed, 08 Jul 2020 16:16:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 627493006D0;
        Wed,  8 Jul 2020 18:16:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E68BF214ECDAA; Wed,  8 Jul 2020 18:16:08 +0200 (CEST)
Date:   Wed, 8 Jul 2020 18:16:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/20] seqlock: Extend seqcount API with associated
 locks
Message-ID: <20200708161608.GS4800@hirez.programming.kicks-ass.net>
References: <20200630054452.3675847-7-a.darwish@linutronix.de>
 <20200706212148.GE5523@worktop.programming.kicks-ass.net>
 <20200707084024.GA4097637@debian-buster-darwi.lab.linutronix.de>
 <20200707130410.GO4800@hirez.programming.kicks-ass.net>
 <20200707143726.GO117543@hirez.programming.kicks-ass.net>
 <20200708103314.GB4151780@debian-buster-darwi.lab.linutronix.de>
 <20200708122938.GQ4800@hirez.programming.kicks-ass.net>
 <20200708150930.GA147323@debian-buster-darwi.lab.linutronix.de>
 <20200708153522.GR4800@hirez.programming.kicks-ass.net>
 <20200708155813.GA147953@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708155813.GA147953@debian-buster-darwi.lab.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 05:58:13PM +0200, Ahmed S. Darwish wrote:
> On Wed, Jul 08, 2020 at 05:35:22PM +0200, Peter Zijlstra wrote:
> ...
> >
> > And while the gcc-4.8 code is horrendous crap, the rest should be pretty
> > straight forward and concentrates on the pieces where there are
> > differences.
> >
> 
> Is there any possibility of upgrading the minimum gcc version to 4.9? Is
> there any supported architecture that is still stuck on 4.8?

Upgrading also got mention here:

  https://lkml.kernel.org/r/CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com

But it didn't get much response.
