Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC6EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E909F2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JG6kBeCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgGUIiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGUIiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:38:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128EAC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YjXdkcialCHHTslIUxZppGWPfxGY86d3pVwVQzGRFxs=; b=JG6kBeCPB8nK5ZvMP2xPH0QUBF
        ciKSp4h49uh4d9269k51SaDz4dWqMPzjW3y4n/GutafvKzZdypnoZWiXyNsjxMn0pzguXzw6LMgDH
        edhIytrnsPRGNZeSHybFp8T+W5d8ZMhPkHaa0bh0G5dVhN6xY9tMUeuoc6wPVvBp0lbAu4DBWnvk3
        HTnzJSHDeWE5/YNCgV6LLkd5seJKSXej7of2Gii1g/q6yIL2kWUwfmr+Au4iz2tx4IdYYpmQtSSna
        wI1tfyDT3btza9I5MI4FRpGIu/Ox9r9xQXiZYwZDwTvqIDosISEl1/FEInQix1qCOH5T/O6la92ye
        yhkV24OA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxnmd-0007b5-6q; Tue, 21 Jul 2020 08:37:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7AB04300446;
        Tue, 21 Jul 2020 10:37:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66FCE23426BA1; Tue, 21 Jul 2020 10:37:53 +0200 (CEST)
Date:   Tue, 21 Jul 2020 10:37:53 +0200
From:   peterz@infradead.org
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200721083753.GH119549@hirez.programming.kicks-ass.net>
References: <20200718171406.GB16791@redhat.com>
 <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
 <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com>
 <20200720082657.GC6612@redhat.com>
 <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
 <20200720105924.GE43129@hirez.programming.kicks-ass.net>
 <20200720140224.GD6612@redhat.com>
 <20200720142105.GR10769@hirez.programming.kicks-ass.net>
 <20200721045251.GA28481@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721045251.GA28481@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 12:52:52AM -0400, Paul Gortmaker wrote:
> [Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917] On 20/07/2020 (Mon 16:21) Peter Zijlstra wrote:
> 
> > On Mon, Jul 20, 2020 at 04:02:24PM +0200, Oleg Nesterov wrote:
> > > I have to admit, I do not understand the usage of prev_state in schedule(),
> > > it looks really, really subtle...
> > 
> > Right, so commit dbfb089d360 solved a problem where schedule() re-read
> > prev->state vs prev->on_rq = 0. That is, schedule()'s dequeue and
> > ttwu()'s enqueue disagreed over sched_contributes_to_load. and as a
> > result load-accounting went wobbly.
> > 
> > Now, looking at that commit again, I might've solved the problem twice
> > :-P
> 
> [...]
> 
> > That said, in a crossed email, I just proposed we could simplify all
> > this like so.. but now I need to go ask people to re-validate that
> > loadavg muck again :-/
> 
> After a two hour "quick" sanity test I then gave it a full 7h run (which
> always seemed to break before dbfb089d360) and I didn't see any stuck
> load average with master from today + this change.
> 
> Paul.
> 
> root@t5610:/home/paul/git/linux-head#
> [1]+  Done                    nohup tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 24 --duration 420 --configs TREE03 --trust-make > /tmp/kvm.sh.out 2>&1
> root@t5610:/home/paul/git/linux-head# cat /proc/version
> Linux version 5.8.0-rc6-00001-g5714ee50bb43-dirty (paul@t5610) (gcc (Ubuntu 9.3.0-10ubuntu2) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #3 SMP Mon Jul 20 12:30:33 EDT 2020
> root@t5610:/home/paul/git/linux-head# uptime
>  00:49:18 up  7:41,  2 users,  load average: 0.01, 0.00, 0.63
> root@t5610:/home/paul/git/linux-head# 
> 
> --

Thanks a lot for re-testing that Paul, much appreciated!

Let me go write a Changelog for this then...
