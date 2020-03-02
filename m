Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAD4C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E847D24682
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCBOAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:00:08 -0500
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:60038 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgCBOAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:00:08 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 25330181D2FC2;
        Mon,  2 Mar 2020 14:00:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bite50_580e7f13ad457
X-Filterd-Recvd-Size: 3161
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon,  2 Mar 2020 14:00:04 +0000 (UTC)
Message-ID: <4cac10d3e2c03e4f21f1104405a0a62a853efb4e.camel@perches.com>
Subject: Re: [PATCH v2 2/3] binder: do not initialize locals passed to
 copy_from_user()
From:   Joe Perches <joe@perches.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Todd Kjos <tkjos@google.com>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 02 Mar 2020 05:58:33 -0800
In-Reply-To: <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com>
References: <20200302130430.201037-1-glider@google.com>
         <20200302130430.201037-2-glider@google.com>
         <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
         <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-02 at 14:25 +0100, Alexander Potapenko wrote:
> On Mon, Mar 2, 2020 at 2:11 PM Joe Perches <joe@perches.com> wrote:
> > On Mon, 2020-03-02 at 14:04 +0100, glider@google.com wrote:
> > > Certain copy_from_user() invocations in binder.c are known to
> > > unconditionally initialize locals before their first use, like e.g. in
> > > the following case:
> > []
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > []
> > > @@ -3788,7 +3788,7 @@ static int binder_thread_write(struct binder_proc *proc,
> > > 
> > >               case BC_TRANSACTION_SG:
> > >               case BC_REPLY_SG: {
> > > -                     struct binder_transaction_data_sg tr;
> > > +                     struct binder_transaction_data_sg tr __no_initialize;
> > > 
> > >                       if (copy_from_user(&tr, ptr, sizeof(tr)))
> > 
> > I fail to see any value in marking tr with __no_initialize
> > when it's immediately written to by copy_from_user.
> 
> This is being done exactly because it's immediately written to by copy_to_user()
> Clang is currently unable to figure out that copy_to_user() initializes memory.
> So building the kernel with CONFIG_INIT_STACK_ALL=y basically leads to
> the following code:
> 
>   struct binder_transaction_data_sg tr;
>   memset(&tr, 0xAA, sizeof(tr));
>   if (copy_from_user(&tr, ptr, sizeof(tr))) {...}
> 
> This unnecessarily slows the code down, so we add __no_initialize to
> prevent the compiler from emitting the redundant initialization.

So?  CONFIG_INIT_STACK_ALL by design slows down code.

This marking would likely need to be done for nearly all
3000+ copy_from_user entries.

Why not try to get something done on the compiler side
to mark the function itself rather than the uses?



