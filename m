Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F31C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196B124655
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBRRwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:52:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgBRRv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:51:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7690824654;
        Tue, 18 Feb 2020 17:51:58 +0000 (UTC)
Date:   Tue, 18 Feb 2020 12:51:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Luigi Rizzo <lrizzo@google.com>, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] kretprobe: percpu support
Message-ID: <20200218125157.022b459a@gandalf.local.home>
In-Reply-To: <20200218165529.39e761c4be828285cc060279@kernel.org>
References: <20200218005659.91318-1-lrizzo@google.com>
        <20200218165529.39e761c4be828285cc060279@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 16:55:29 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Racy lock is the kretprobe_hash_lock(), I would like to replace it
> with ftrace's per-task shadow stack. But that will be available
> only if CONFIG_FUNCTION_GRAPH_TRACER=y (and instance has no own
> payload).

I need to start that work up again (soon) and get that finished. :-/

-- Steve
