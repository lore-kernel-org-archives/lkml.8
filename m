Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14546C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D823221775
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgCBSvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:51:47 -0500
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:43130 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726451AbgCBSvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:51:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B5653A2D9;
        Mon,  2 Mar 2020 18:51:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jewel38_f20ac4926518
X-Filterd-Recvd-Size: 4745
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon,  2 Mar 2020 18:51:43 +0000 (UTC)
Message-ID: <18b0d6ea5619c34ca4120a6151103dbe9bfa0cbe.camel@perches.com>
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
Date:   Mon, 02 Mar 2020 10:50:11 -0800
In-Reply-To: <CAG_fn=XOyPGau9m7x8eCLJHy3m-H=nbMODewWVJ1xb2e+BPdFw@mail.gmail.com>
References: <20200302130430.201037-1-glider@google.com>
         <20200302130430.201037-2-glider@google.com>
         <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
         <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com>
         <4cac10d3e2c03e4f21f1104405a0a62a853efb4e.camel@perches.com>
         <CAG_fn=XOyPGau9m7x8eCLJHy3m-H=nbMODewWVJ1xb2e+BPdFw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-02 at 19:17 +0100, Alexander Potapenko wrote:
> On Mon, Mar 2, 2020 at 3:00 PM Joe Perches <joe@perches.com> wrote:
> > On Mon, 2020-03-02 at 14:25 +0100, Alexander Potapenko wrote:
> > > On Mon, Mar 2, 2020 at 2:11 PM Joe Perches <joe@perches.com> wrote:
> > > > On Mon, 2020-03-02 at 14:04 +0100, glider@google.com wrote:
> > > > > Certain copy_from_user() invocations in binder.c are known to
> > > > > unconditionally initialize locals before their first use, like e.g. in
> > > > > the following case:
> > > > []
> > > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > []
> > > > > @@ -3788,7 +3788,7 @@ static int binder_thread_write(struct binder_proc *proc,
> > > > > 
> > > > >               case BC_TRANSACTION_SG:
> > > > >               case BC_REPLY_SG: {
> > > > > -                     struct binder_transaction_data_sg tr;
> > > > > +                     struct binder_transaction_data_sg tr __no_initialize;
> > > > > 
> > > > >                       if (copy_from_user(&tr, ptr, sizeof(tr)))
> > > > 
> > > > I fail to see any value in marking tr with __no_initialize
> > > > when it's immediately written to by copy_from_user.
> > > 
> > > This is being done exactly because it's immediately written to by copy_to_user()
> > > Clang is currently unable to figure out that copy_to_user() initializes memory.
> > > So building the kernel with CONFIG_INIT_STACK_ALL=y basically leads to
> > > the following code:
> > > 
> > >   struct binder_transaction_data_sg tr;
> > >   memset(&tr, 0xAA, sizeof(tr));
> > >   if (copy_from_user(&tr, ptr, sizeof(tr))) {...}
> > > 
> > > This unnecessarily slows the code down, so we add __no_initialize to
> > > prevent the compiler from emitting the redundant initialization.
> > 
> > So?  CONFIG_INIT_STACK_ALL by design slows down code.
> Correct.
> 
> > This marking would likely need to be done for nearly all
> > 3000+ copy_from_user entries.
> Unfortunately, yes. I was just hoping to do so for a handful of hot
> cases that we encounter, but in the long-term a compiler solution must
> supersede them.
> 
> > Why not try to get something done on the compiler side
> > to mark the function itself rather than the uses?
> This is being worked on in the meantime as well (see
> http://lists.llvm.org/pipermail/cfe-dev/2020-February/064633.html)
> Do you have any particular requisitions about how this should look on
> the source level?

I presume something like the below when appropriate for
automatic variables when not already initialized or modified.
---
 include/linux/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 8a215c..3e034b5 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -138,7 +138,8 @@ _copy_to_user(void __user *, const void *, unsigned long);
 #endif
 
 static __always_inline unsigned long __must_check
-copy_from_user(void *to, const void __user *from, unsigned long n)
+copy_from_user(void __no_initialize *to, const void __user *from,
+	       unsigned long n)
 {
 	if (likely(check_copy_size(to, n, false)))
 		n = _copy_from_user(to, from, n);


