Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B3AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC22F206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgEOJDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:03:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:48782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgEOJDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:03:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 01848B042;
        Fri, 15 May 2020 09:03:22 +0000 (UTC)
Date:   Fri, 15 May 2020 11:03:19 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH -tip urgent] x86/unwind/orc: Fix error handling in
 __unwind_start()
In-Reply-To: <d6ac7215a84ca92b895fdd2e1aa546729417e6e6.1589487277.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.21.2005151034220.15222@pobox.suse.cz>
References: <d6ac7215a84ca92b895fdd2e1aa546729417e6e6.1589487277.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020, Josh Poimboeuf wrote:

> The unwind_state 'error' field is used to inform the reliable unwinding
> code that the stack trace can't be trusted.  Set this field for all
> errors in __unwind_start().
> 
> Also, move the zeroing out of the unwind_state struct to before the ORC
> table initialization check, to prevent the caller from reading
> uninitialized data if the ORC table is corrupted.
> 
> Fixes: af085d9084b4 ("stacktrace/x86: add function for detecting reliable stack traces")
> Fixes: d3a09104018c ("x86/unwinder/orc: Dont bail on stack overflow")
> Fixes: 98d0c8ebf77e ("x86/unwind/orc: Prevent unwinding before ORC initialization")
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
