Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49147C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294F120724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCMMYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:24:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:50008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgCMMYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:24:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C2197AFD4;
        Fri, 13 Mar 2020 12:24:10 +0000 (UTC)
Date:   Fri, 13 Mar 2020 13:24:09 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 10/14] x86/unwind/orc: Prevent unwinding before ORC
 initialization
In-Reply-To: <5b3e0cbab4a5e6cf5e3cab87f18f2ae582ec01d7.1584033751.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.21.2003131321340.30076@pobox.suse.cz>
References: <cover.1584033751.git.jpoimboe@redhat.com> <5b3e0cbab4a5e6cf5e3cab87f18f2ae582ec01d7.1584033751.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020, Josh Poimboeuf wrote:

> If the unwinder is called before the ORC data has been initialized,
> orc_find() returns NULL, and it tries to fall back to using frame
> pointers.  This can cause some unexpected warnings during boot.
> 
> Move the 'orc_init' check from orc_find() to __unwind_init(), so that it

s/__unwind_init()/__unwind_start()/

>  void __unwind_start(struct unwind_state *state, struct task_struct *task,
>  		    struct pt_regs *regs, unsigned long *first_frame)
>  {
> +	if (!orc_init)
> +		goto done;
> +
>  	memset(state, 0, sizeof(*state));
>  	state->task = task;

Miroslav
