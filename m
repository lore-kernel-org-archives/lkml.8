Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BEEC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290EB206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="We7vl55x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgEKNuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729641AbgEKNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:50:16 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9634C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fgDbuFVZ9wewyUbZc91a3JAySjT/mroMXUxBkr5SV4c=; b=We7vl55xbdvDV6CpsSaKopX2/X
        GfJv5BokO/TYre24xkZ+EY5LRDMPq0GfGWfZ53Aow+h5J1aDZCnmskvCt3oNSrrr+kyZdQqd0nE54
        sHaiB9J9OqR50fCw35lWgdjX4QosLNovaWXkbet8DzZAUCJSs6H8+Wn7svzeH6cMvdCFp0Vn2j5Ow
        KfyMueXvat/l3QggUfuFedJZt+xz/i5S54b7XRzkEMfLa4br1FZa5tUGoKeX7fn71S39OsZhIw3vQ
        lWmVa3kY3tQmz+/sXxtkIMDwtUSPKhg2smsjYtnqE1djGpPiraZGF9eLD9Mf9axMzqedc14S+0hgq
        vKsxZLtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jY8o9-0007TP-3J; Mon, 11 May 2020 13:49:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9E72A306831;
        Mon, 11 May 2020 15:49:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89C422870F2D3; Mon, 11 May 2020 15:49:21 +0200 (CEST)
Date:   Mon, 11 May 2020 15:49:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Allison Randal <allison@lohutok.net>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Muchun Song <smuchun@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH RFC] Add support for core-wide protection of IRQ and
 softirq
Message-ID: <20200511134921.GC2940@hirez.programming.kicks-ass.net>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200510234652.249917-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510234652.249917-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 07:46:52PM -0400, Joel Fernandes (Google) wrote:
> With current core scheduling patchset, non-threaded IRQ and softirq
> victims can leak data from its hyperthread to a sibling hyperthread
> running an attacker.
> 
> For MDS, it is possible for the IRQ and softirq handlers to leak data to
> either host or guest attackers. For L1TF, it is possible to leak to
> guest attackers. There is no possible mitigation involving flushing of
> buffers to avoid this since the execution of attacker and victims happen
> concurrently on 2 or more HTs.
> 
> The solution in this patch is to monitor the outer-most core-wide
> irq_enter() and irq_exit() executed by any sibling. In between these
> two, we mark the core to be in a special core-wide IRQ state.

Another possible option is force_irqthreads :-) That would cure it
nicely.

Anyway, I'll go read this.
