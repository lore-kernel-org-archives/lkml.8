Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF0FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2FFF22CAE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgHECsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 22:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHECsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:48:14 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2986C06174A;
        Tue,  4 Aug 2020 19:48:13 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k39TL-009Y7j-1q; Wed, 05 Aug 2020 02:48:07 +0000
Date:   Wed, 5 Aug 2020 03:48:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     macro@wdc.com, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: ptrace: Use the correct API for `fcsr' access
Message-ID: <20200805024807.GM1236603@ZenIV.linux.org.uk>
References: <20200805020745.GL1236603@ZenIV.linux.org.uk>
 <mhng-cd1ff2e9-7d34-4d56-8d79-b2d02a239290@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-cd1ff2e9-7d34-4d56-8d79-b2d02a239290@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 07:20:05PM -0700, Palmer Dabbelt wrote:
> On Tue, 04 Aug 2020 19:07:45 PDT (-0700), viro@zeniv.linux.org.uk wrote:
> > On Tue, Aug 04, 2020 at 07:01:01PM -0700, Palmer Dabbelt wrote:
> > 
> > > > We currently have @start_pos fixed at 0 across all calls, which works as
> > > > a result of the implementation, in particular because we have no padding
> > > > between the FP general registers and the FP control and status register,
> > > > but appears not to have been the intent of the API and is not what other
> > > > ports do, requiring one to study the copy handlers to understand what is
> > > > going on here.
> > 
> > start_pos *is* fixed at 0 and it's going to go away, along with the
> > sodding user_regset_copyout() very shortly.  ->get() is simply a bad API.
> > See vfs.git#work.regset for replacement.  And ->put() is also going to be
> > taken out and shot (next cycle, most likely).
> 
> I'm not sure I understand what you're saying, but given that branch replaces
> all of this I guess it's best to just do nothing on our end here?

It doesn't replace ->put() (for now); it _does_ replace ->get() and AFAICS the
replacement is much saner:

static int riscv_fpr_get(struct task_struct *target,
                         const struct user_regset *regset,
                         struct membuf to)
{
	struct __riscv_d_ext_state *fstate = &target->thread.fstate;

	membuf_write(&to, fstate, offsetof(struct __riscv_d_ext_state, fcsr));
	membuf_store(&to, fstate->fcsr);
	return membuf_zero(&to, 4);     // explicitly pad
}

user_regset_copyout() calling conventions are atrocious and so are those of
regset ->get().  The best thing to do with both is to take them out of their
misery and be done with that.  Do you see any problems with riscv gdbserver
on current linux-next?  If not, I'd rather see that "API" simply go away...
If there are problems, I would very much prefer fixes on top of what's done
in that branch.
