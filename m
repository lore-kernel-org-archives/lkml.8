Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AA5C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D4E21927
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgBDKCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:02:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgBDKCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:02:36 -0500
Received: from oasis.local.home (unknown [212.187.182.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09C85217BA;
        Tue,  4 Feb 2020 10:02:33 +0000 (UTC)
Date:   Tue, 4 Feb 2020 05:02:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Amol Grover <frextrite@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] tracing: Annotate ftrace_graph_hash pointer with __rcu
Message-ID: <20200204050229.70e2cb0e@oasis.local.home>
In-Reply-To: <20200203163301.GB85781@google.com>
References: <20200201072703.17330-1-frextrite@gmail.com>
        <20200203163301.GB85781@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2020 11:33:01 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> >  	preempt_disable_notrace();
> >  
> > -	if (ftrace_hash_empty(ftrace_graph_hash)) {
> > +	hash = rcu_dereference_protected(ftrace_graph_hash, !preemptible());  
> 
> I think you can use rcu_dereference_sched() here? That way no need to pass
> !preemptible.
> 
> A preempt-disabled section is an RCU "sched flavor" section. Flavors are
> consolidated in the backend, but in the front end the dereference API still
> do have flavors.

Agreed, Amol, can you send an update?

-- Steve
