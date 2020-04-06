Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DB9C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEB2206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgDFJzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:55:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgDFJzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:55:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 70C75AE17;
        Mon,  6 Apr 2020 09:55:39 +0000 (UTC)
Date:   Mon, 6 Apr 2020 11:55:39 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Peter Zijlstra <peterz@infradead.org>, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org
Subject: Re: [PATCH] module: Harden STRICT_MODULE_RWX
In-Reply-To: <20200403165631.hrxxm3pnzqa4vxln@treble>
Message-ID: <alpine.LSU.2.21.2004061146590.26870@pobox.suse.cz>
References: <20200403163716.GV20730@hirez.programming.kicks-ass.net> <20200403165631.hrxxm3pnzqa4vxln@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Apr 2020, Josh Poimboeuf wrote:

> On Fri, Apr 03, 2020 at 06:37:16PM +0200, Peter Zijlstra wrote:
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < hdr->e_shnum; i++) {
> > +		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE))
> > +			return -ENOEXEC;
> 
> I think you only want the error when both are set?
> 
> 		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE) == (SHF_EXECINSTR|SHF_WRITE))

A section with SHF_EXECINSTR and SHF_WRITE but without SHF_ALLOC would be 
strange though, no? It wouldn't be copied to the final module later 
anyway.

Looking at layout_sections()... a section with 
SHF_EXECINSTR|SHF_WRITE|SHF_ALLOC would not be counted at all. However, 
move_module() later copies everything with SHF_ALLOC flag to the final 
module. If there is WXA section, there would be a bug because the 
allocation there would not get the correct size. In that case it is 
important to error out early as you're proposing.

Am I missing something?

Miroslav
