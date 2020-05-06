Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07ABC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29AC2073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgEFMvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbgEFMvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:51:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5816020575;
        Wed,  6 May 2020 12:51:43 +0000 (UTC)
Date:   Wed, 6 May 2020 08:51:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Guo Ren <guoren@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Security Officers <security@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: ensure that uprobe->offset and
 ->ref_ctr_offset are properly aligned
Message-ID: <20200506085141.723673f1@gandalf.local.home>
In-Reply-To: <20200506052955.GA8259@linux.vnet.ibm.com>
References: <CAHk-=whQt69ApMkZF8b2Q2idMDgPpPETZeeOuZg59CrOO4025w@mail.gmail.com>
        <20200428091149.GB19958@linux.vnet.ibm.com>
        <20200428123914.GA27920@redhat.com>
        <20200504164724.GA28697@redhat.com>
        <20200506052955.GA8259@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 10:59:55 +0530
Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> * Oleg Nesterov <oleg@redhat.com> [2020-05-04 18:47:25]:
> 
> > uprobe_write_opcode() must not cross page boundary; prepare_uprobe()
> > relies on arch_uprobe_analyze_insn() which should validate "vaddr" but
> > some architectures (csky, s390, and sparc) don't do this.
> > 
> > We can remove the BUG_ON() check in prepare_uprobe() and validate the
> > offset early in __uprobe_register(). The new IS_ALIGNED() check matches
> > the alignment check in arch_prepare_kprobe() on supported architectures,
> > so I think that all insns must be aligned to UPROBE_SWBP_INSN_SIZE.
> > 
> > Another problem is __update_ref_ctr() which was wrong from the very
> > beginning, it can read/write outside of kmap'ed page unless "vaddr" is
> > aligned to sizeof(short), __uprobe_register() should check this too.
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>  
> 
> Thanks Oleg.
> 
> Looks good to me.
> 
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > ---  
> 

Thanks Oleg, Srikar and Sven.

As this is in the kernel/events/ directory, I'm guessing it should be taken
through the tip tree?

-- Steve
