Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AAEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D572075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgGMU0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgGMU0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 16:26:47 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A77C0207BC;
        Mon, 13 Jul 2020 20:26:45 +0000 (UTC)
Date:   Mon, 13 Jul 2020 16:26:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 11/17] static_call: Simple self-test
Message-ID: <20200713162644.56a2e7a1@oasis.local.home>
In-Reply-To: <20200711102702.GC597537@hirez.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
        <20200710134336.798619415@infradead.org>
        <20200710184229.3c3f5d8d@oasis.local.home>
        <20200711102702.GC597537@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jul 2020 12:27:02 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > static int __init test_static_call_init(void)
> > {
> > 	int i;
> > 
> > 	for (i = 0; i < ARRAY_SIZE(static_call_data); i++ ) {
> > 		if (static_call_data[i].func)
> > 			static_call_update(sc_selftest, static_call_data[i].func);
> > 		WARN_ON(run_static_call(static_call_data[i].val) != static_call_data[i].expect);
> > 	}
> > 
> > 	return 0;
> > }  
> 
> Lots of compile errors with that, fixed them all :-)

Hey, I wrote that all without compiling it. I would have been surprised
if it was clean.

-- Steve
