Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5480C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01BC2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCMOAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:00:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:52298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgCMOAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:00:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7E952AC6B;
        Fri, 13 Mar 2020 14:00:43 +0000 (UTC)
Date:   Fri, 13 Mar 2020 15:00:42 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 00/14] x86/unwind/orc: ORC fixes
In-Reply-To: <cover.1584033751.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.21.2003131500100.30076@pobox.suse.cz>
References: <cover.1584033751.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020, Josh Poimboeuf wrote:

> Several ORC unwinder cleanups, fixes, and debug improvements.
> 
> Jann Horn (1):
>   x86/entry/64: Fix unwind hints in rewind_stack_do_exit()
> 
> Josh Poimboeuf (12):
>   x86/dumpstack: Add SHOW_REGS_IRET mode
>   objtool: Fix stack offset tracking for indirect CFAs
>   x86/entry/64: Fix unwind hints in register clearing code
>   x86/entry/64: Fix unwind hints in kernel exit path
>   x86/entry/64: Fix unwind hints in __switch_to_asm()
>   x86/unwind/orc: Convert global variables to static
>   x86/unwind: Prevent false warnings for non-current tasks
>   x86/unwind/orc: Prevent unwinding before ORC initialization
>   x86/unwind/orc: Fix error path for bad ORC entry type
>   x86/unwind/orc: Fix premature unwind stoppage due to IRET frames
>   x86/unwind/orc: Add more unwinder warnings
>   x86/unwind/orc: Add 'unwind_debug' cmdline option
> 
> Miroslav Benes (1):
>   x86/unwind/orc: Don't skip the first frame for inactive tasks
> 
>  .../admin-guide/kernel-parameters.txt         |   6 +
>  arch/x86/entry/calling.h                      |  40 ++--
>  arch/x86/entry/entry_64.S                     |  14 +-
>  arch/x86/include/asm/kdebug.h                 |   1 +
>  arch/x86/include/asm/unwind.h                 |   2 +-
>  arch/x86/kernel/dumpstack.c                   |  27 +--
>  arch/x86/kernel/dumpstack_64.c                |   3 +-
>  arch/x86/kernel/process_64.c                  |   7 +-
>  arch/x86/kernel/unwind_frame.c                |   3 +
>  arch/x86/kernel/unwind_orc.c                  | 185 ++++++++++++++----
>  tools/objtool/check.c                         |   2 +-
>  11 files changed, 201 insertions(+), 89 deletions(-)

Apart from the two nits I mentioned and Jann's comment on comment, it 
looks good to me.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
