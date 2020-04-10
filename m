Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600FBC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F55220CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDJPor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgDJPor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:44:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CC7020679;
        Fri, 10 Apr 2020 15:44:46 +0000 (UTC)
Date:   Fri, 10 Apr 2020 11:44:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 8/9] block: genhd: export-GPL generic disk device
 type
Message-ID: <20200410114444.73be173a@gandalf.local.home>
In-Reply-To: <20200410063357.GA1663942@kroah.com>
References: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
        <20200409193543.18115-9-mathieu.desnoyers@efficios.com>
        <20200410063357.GA1663942@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020 08:33:57 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> I understand your need here, however we do not export things for
> modules, when there are no in-kernel module users, sorry.

This "we don't cater to out-of-tree modules" even when they are GPL seems
to always baffle me. Especially since we have a high bar of accepting out
of tree modules especially if they duplicate some functionality of an
existing infrastructure of the kernel. I like choice, and coming from
someone that spent over a decade working on code that has been out of tree,
I'm a little sympathetic to the cause ;-)

I guess we should be open to allowing LTTng modules in the kernel as well,
even though it is yet another tracing framework. It's not like its going
away. And perhaps by doing so, ftrace and perf could start taking advantage
of anything that LTTng brings.

-- Steve
