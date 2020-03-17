Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDD8C0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EA2206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584406595;
	bh=iMkAmgNXieAuOOkhf4wwje4T8Wth45+DAToJLEuzCUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nF8iuYBnB/yjNu9VoXFrRk2OPDN5RPUFTQukNv0s5SV8q3XigGAUEFGxX4z2UBnjf
	 8O4X//HKrkEHCV/8U4FiS/fSTpRxB3teQO8Wi78GtVD57ZlS45g5IACfT1EJ9Owi1x
	 DOU/QHXHFjdi4uej8ZWGnYbpCYEIoo361a8k3frU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733272AbgCQA4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 20:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733119AbgCQA4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:56:33 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A7A120679;
        Tue, 17 Mar 2020 00:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584406592;
        bh=iMkAmgNXieAuOOkhf4wwje4T8Wth45+DAToJLEuzCUs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fKjYTXlV/1dxFeHGm6qtdbW/F2boTLOVlEJj9Aci5wK4DWLWT+QOJXvEPQ3YGPox5
         rC3/f2KDJ0BUh+mKn19GmqBZl7Iq0gviINKq+7MKGNIEQpDrPgYxiMacAUBbhGVYtS
         /lUNyw5XPf6Npm7amT58XVIE+/f9rYzyxVh1Hadk=
Date:   Tue, 17 Mar 2020 09:56:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [RFC][PATCH 00/16] objtool: vmlinux.o and noinstr validation
Message-Id: <20200317095628.4f3690afe24e059a146a4b6f@kernel.org>
In-Reply-To: <20200312162337.GU12561@hirez.programming.kicks-ass.net>
References: <20200312134107.700205216@infradead.org>
        <20200312162337.GU12561@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020 17:23:37 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Mar 12, 2020 at 02:41:07PM +0100, Peter Zijlstra wrote:
> > Hi all,
> > 
> > These patches extend objtool to be able to run on vmlinux.o and validate
> > Thomas's proposed noinstr annotation:
> > 
> >   https://lkml.kernel.org/r/20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org
> > 
> >  "That's why we want the sections and the annotation. If something calls
> >   out of a noinstr section into a regular text section and the call is not
> >   annotated at the call site, then objtool can complain and tell you. What
> >   Peter and I came up with looks like this:
> > 
> >   noinstr foo()
> > 	do_protected(); <- Safe because in the noinstr section
> > 	instr_begin();  <- Marks the begin of a safe region, ignored
> > 			   by objtool
> > 	do_stuff();     <- All good
> > 	instr_end();    <- End of the safe region. objtool starts
> > 			   looking again
> > 	do_other_stuff();  <- Unsafe because do_other_stuff() is
> > 			      not protected
> > 
> >   and:
> > 
> >   noinstr do_protected()
> > 	bar();          <- objtool will complain here
> >   "
> > 
> > It should be accompanied by something like the below; which you'll find in a
> > series by Thomas.
> > 
> 
> So one of the problem i've ran into while playing with this and Thomas'
> patches is that it is 'difficult' to deal with indirect function calls.
> 
> objtool basically gives up instantly.

Can we introduce a "safe-call" wrapper function instead of indirect
call, and if objtool found an indirect call without safe-call function,
it can make it an error?

static int __noinstr safe_indirect_callback(int (*fn)(...), real-args)
{
	if (!is_instr_text(fn))
		return -ERANGE;
	return fn(real-args)
}

BTW, out of curiously, if BUG*() or WARN*() cases happens in the noinstr
section, do we also need to move them (register dump, stack unwinding,
printk, console output, etc.) all into noinstr section?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
