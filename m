Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DD7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216532075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgGJV4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:56:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgGJV4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:56:06 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 646B920725;
        Fri, 10 Jul 2020 21:56:04 +0000 (UTC)
Date:   Fri, 10 Jul 2020 17:56:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 06/17] static_call: Add basic static call
 infrastructure
Message-ID: <20200710175602.1a84c355@oasis.local.home>
In-Reply-To: <20200710134336.500117453@infradead.org>
References: <20200710133831.943894387@infradead.org>
        <20200710134336.500117453@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 15:38:37 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> From: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Static calls are a replacement for global function pointers.  They use
> code patching to allow direct calls to be used instead of indirect
> calls.  They give the flexibility of function pointers, but with
> improved performance.  This is especially important for cases where
> retpolines would otherwise be used, as retpolines can significantly
> impact performance.
> 
> The concept and code are an extension of previous work done by Ard
> Biesheuvel and Steven Rostedt:
> 
>   https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.org
>   https://lkml.kernel.org/r/20181006015110.653946300@goodmis.org
> 
> There are two implementations, depending on arch support:
> 
>  1) out-of-line: patched trampolines (CONFIG_HAVE_STATIC_CALL)
>  2) basic function pointers
> 
> For more details, see the comments in include/linux/static_call.h.
> 
> [peterz: simplified interface]
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
