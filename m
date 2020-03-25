Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4FEC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C561B20740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgCYTDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:03:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:57126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgCYTDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:03:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 87CEFAC44;
        Wed, 25 Mar 2020 19:03:08 +0000 (UTC)
Date:   Wed, 25 Mar 2020 20:03:07 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH v4 00/13] objtool: vmlinux.o and moinstr validation
In-Reply-To: <20200325174525.772641599@infradead.org>
Message-ID: <alpine.LSU.2.21.2003252002230.3128@pobox.suse.cz>
References: <20200325174525.772641599@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020, Peter Zijlstra wrote:

> Hi all,
> 
> This lacks the first 17 patches of the v3 posting which are en-route to
> tip/core/objtool and should show up there somewhere later this evening.
> 
> As should be familiar by now; these patches implement the noinstr
> (no-instrument) validation in objtool as requested by Thomas, to ensure
> critical code (entry for now, idle later) run no unexpected code.
> 
> Functions are marked with: noinstr, which implies notrace, noinline and sticks
> things in the .noinstr.text section. Such functions can then use instr_begin()
> and instr_end() to allow calls to code outside of this section in sanctioned
> areas.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
