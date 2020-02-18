Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169BDC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 04:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D7320836
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 04:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582000424;
	bh=s+gskoGNYaBnlzh7fx25t6Ans0EyhxUhO9bArhIyTuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DVFL3wJmbatFPBhaZoHciZtn3JKMMFrNCjwJfEvUBpEt+WtXIQKZJnyD5L1QyQYoN
	 BjH9a8A6pdprZtyg764yU7UqrFteoImHYVlkI/HUl/QeB15JMnGtlK895xcLMXi/XH
	 gF77RINI0l8myDqhMzLT1oPp5WGcljCI2wwG0lNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgBREdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 23:33:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgBREdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 23:33:41 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7112820801;
        Tue, 18 Feb 2020 04:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582000420;
        bh=s+gskoGNYaBnlzh7fx25t6Ans0EyhxUhO9bArhIyTuM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qJXMQ5WuA0eI3rEIph5GUoTErtBNjlf9KXjTuL6c45YT7UDTh4GZWFEtvgcR6g14m
         I4WhG2roOoqMXQQDcTgAeR1QR9IdG8DSaipc3iVKNigkik3KSANhxlZTUBR18SZrwm
         z7GdcQiko55sStsAdhpS2GXJKem071HKn9ixdzWA=
Date:   Tue, 18 Feb 2020 13:33:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-Id: <20200218133335.c87d7b2399ee6532bf28b74a@kernel.org>
In-Reply-To: <20200217163112.GM2935@paulmck-ThinkPad-P72>
References: <20200213204444.GA94647@google.com>
        <20200213205442.GK2935@paulmck-ThinkPad-P72>
        <20200213211930.GG170680@google.com>
        <20200213163800.5c51a5f1@gandalf.local.home>
        <20200213215004.GM2935@paulmck-ThinkPad-P72>
        <20200213170451.690c4e5c@gandalf.local.home>
        <20200213223918.GN2935@paulmck-ThinkPad-P72>
        <20200214151906.b1354a7ed6b01fc3bf2de862@kernel.org>
        <20200215145934.GD2935@paulmck-ThinkPad-P72>
        <20200217175519.12a694a969c1a8fb2e49905e@kernel.org>
        <20200217163112.GM2935@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 08:31:12 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > BTW, if you consider the x86 specific code is in the generic file,
> > we can move NOKPROBE_SYMBOL() in arch/x86/kernel/traps.c.
> > (Sorry, I've hit this idea right now)
> 
> Might this affect other architectures with NMIs and probe-like things?
> If so, it might make sense to leave it where it is.

Yes, git grep shows that arm64 is using rcu_nmi_enter() in
debug_exception_enter().
OK, let's keep it, but maybe it is good to update the comment for
arm64 too. What about following?

+/*
+ * All functions in do_int3() on x86, do_debug_exception() on arm64 must be
+ * marked NOKPROBE before kprobes handler is called.
+ * ist_enter() on x86 and debug_exception_enter() on arm64 which is called
+ * before kprobes handle happens to call rcu_nmi_enter() which means
+ * that rcu_nmi_enter() must be marked NOKRPOBE.
+ */

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
