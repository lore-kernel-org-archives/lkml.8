Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96153C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B869208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgDQMdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:33:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:32854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729053AbgDQMda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:33:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B293AABEF;
        Fri, 17 Apr 2020 12:33:25 +0000 (UTC)
Date:   Fri, 17 Apr 2020 14:33:24 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        jthierry@redhat.com, alexandre.chartre@oracle.com
Subject: Re: [PATCH v5 00/17] objtool: vmlinux.o and noinstr validation
In-Reply-To: <20200416114706.625340212@infradead.org>
Message-ID: <alpine.LSU.2.21.2004171432360.7737@pobox.suse.cz>
References: <20200416114706.625340212@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020, Peter Zijlstra wrote:

> As should be familiar by now; these patches implement the noinstr
> (no-instrument) validation in objtool as requested by Thomas, to ensure
> critical code (entry for now, idle later) run no unexpected code.
> 
> Functions are marked with: noinstr, which implies notrace, noinline and sticks
> things in the .noinstr.text section. Such functions can then use instr_begin()
> and instr_end() to allow calls to code outside of this section in sanctioned
> areas.
> 
> On the way of getting there, it also fixes the x86/ftrace trampiline ORC
> unwind.

I think I've already done that, but there are some changes, so

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
