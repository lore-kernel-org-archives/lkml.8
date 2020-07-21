Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA653C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B1A2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGUBvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgGUBvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:51:18 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF74D20658;
        Tue, 21 Jul 2020 01:51:16 +0000 (UTC)
Date:   Mon, 20 Jul 2020 21:51:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 01/24] Documentation: locking: Describe seqlock
 design and usage
Message-ID: <20200720215115.4c5276db@oasis.local.home>
In-Reply-To: <20200720214400.5ec6a028@oasis.local.home>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
        <20200720155530.1173732-1-a.darwish@linutronix.de>
        <20200720155530.1173732-2-a.darwish@linutronix.de>
        <20200720214400.5ec6a028@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 21:44:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > - * This is not as cache friendly as brlock. Also, this may not work well
> > - * for data that contains pointers, because any writer could
> > - * invalidate a pointer that a reader was following.
> > + * See Documentation/locking/seqlock.rst  
> 
> I absolutely hate it when I see this.
> 
> I much rather have the documentation next to the code. Because
> honestly, I trust that comments next to the code will get updated if
> the code changes much more likely than comments buried in the
> Documentation directory.
> 
> It's also more likely that I wont even bother looking at the doc
> (because I wont trust it to be up to date) and just read the code and
> try to figure it out. Or look at how others have used it.

Never mind,

I see that kerneldoc is added in patch 5, which helps.

-- Steve
