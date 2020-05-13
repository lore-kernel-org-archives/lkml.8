Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C562C2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 03:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC5A207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 03:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgEMDd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 23:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725929AbgEMDd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 23:33:58 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BECC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 20:33:57 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYi9V-007ApT-Mq; Wed, 13 May 2020 03:33:49 +0000
Date:   Wed, 13 May 2020 04:33:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Potapenko <glider@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, sunhaoyl@outlook.com
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in
 fill_thread_core_info()
Message-ID: <20200513033349.GR23230@ZenIV.linux.org.uk>
References: <20200419100848.63472-1-glider@google.com>
 <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
 <202004201540.01C8F82B@keescook>
 <20200421034249.GB23230@ZenIV.linux.org.uk>
 <CAG_fn=VZZ7yUxtOGzuTLkr7wmfXWtKK9BHHYawj=rt9XWnCYvg@mail.gmail.com>
 <20200512010901.GQ23230@ZenIV.linux.org.uk>
 <20200512034400.GA1537486@ZenIV.linux.org.uk>
 <CAG_fn=Xopqwu8qpdH2xDHmGSy1utp7uyPn7s6btm0hdaV7JVRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=Xopqwu8qpdH2xDHmGSy1utp7uyPn7s6btm0hdaV7JVRg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:20:21AM +0200, Alexander Potapenko wrote:
> On Tue, May 12, 2020 at 5:44 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Tue, May 12, 2020 at 02:09:01AM +0100, Al Viro wrote:
> > > On Tue, Apr 21, 2020 at 10:14:25AM +0200, Alexander Potapenko wrote:
> > > > > Not lately and I would also like to hear the details; which regset it is?
> > > > > Should be reasonably easy to find - just memset() the damn thing to something
> > > > > recognizable, do whatever triggers that KMSAN report and look at that
> > > > > resulting coredump.
> > > >
> > > > The bug is easily triggerable by the following program:
> > > >
> > > > ================================================
> > > > int main() {
> > > >   volatile char *c = 0;
> > > >   (void)*c;
> > > >   return 0;
> > > > }
> > > > ================================================
> > > >
> > > > in my QEMU after I do `ulimit -c 10000`.
> > >
> > > .config, please - I hadn't been able to reproduce that on mine.
> > > Coredump obviously does happen, but not a trace of the poison
> > > is there - with your memset(data, 0xae, size) added, that is.
> >
> > Actually, more interesting question would be your /proc/cpuinfo...
> 
> See both attached.
> I was also able to reproduce the bug on my desktop using the attached
> dump.sh script.

xsaves is the critical part here.  FWIW, the breakage first appeared in

commit 91c3dba7dbc199191272f4a9863f86ea3bfd679f
Author: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date:   Fri Jun 17 13:07:17 2016 -0700

    x86/fpu/xstate: Fix PTRACE frames for XSAVES
    
    XSAVES uses compacted format and is a kernel instruction. The kernel
    should use standard-format, non-supervisor state data for PTRACE.

The b0rken part is
+       for (i = 0; i < XFEATURE_MAX; i++) {
+               /*
+                * Copy only in-use xstates:
+                */
+               if ((header.xfeatures >> i) & 1) {
+                       void *src = __raw_xsave_addr(xsave, 1 << i);
+
+                       offset = xstate_offsets[i];
+                       size = xstate_sizes[i];
+
+                       ret = xstate_copyout(offset, size, kbuf, ubuf, src, 0, count);
+
+                       if (ret)
+                               return ret;
+
+                       if (offset + size >= count)
+                               break;
+               }
+
+       }

The skipped parts are left uninitialized.  I'm not sure what's the best
way to deal with that.  Sure, we can zero the buffer passed to ->get().
However, most of the instances (and I'd looked through quite a few)
do _not_ leave uninitialized chunks.  So I would rather have
xstateregs_get() zero the gaps explicitly.  I'll try to put together
a sane fix when I get some sleep.

FWIW, what I'm going to do is
	* make all callers of copy_regset_to_user() pass 0 as pos
(there are very few exceptions - one on arm64, three on sparc32
and five on sparc64; I hadn't dealt with arm64 one yet, but all
cases on sparc are handled)
	* switch copy_regset_to_user() to doing all copyout at
once - allocate a buffer, pass it to ->get(), then copy_to_user()
the entire thing, same as coredump does
	* introduce
struct membuf {
	void *p;
	size_t left;
};
static inline int membuf_zero(struct membuf *s, size_t size)
static inline void membuf_align(struct membuf *s, int n)
static inline int membuf_write(struct membuf *s, const void *v, size_t size)
and membuf_store(s, v) (basically, write the value of v to the damn thing,
with sizeof(v) for size).
	* introduce
typedef int user_regset_get2_fn(struct task_struct *target,
				const struct user_regset *regset,
				struct membuf to);
and
	user_regset_get2_fn             *get2;
in user_regset, replacing ->get().  Instances would be using the
membuf_...() primitives for actual copying.
	* convert the instances.  I've done that for several architectures,
and it's _much_ cleaner than the current mess with ->get().
	* get rid of user_regset_copyout() et.al. once there's no
callers left.

This bug clearly needs to be fixed in a way that would be easy
to backport, so it has go in front of that queue.  I'll try to
come up with a clean fix and post it (hopefully tomorrow)...
