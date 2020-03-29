Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7172AC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 17:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436A82076E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 17:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgC2R5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 13:57:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36410 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgC2R5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 13:57:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIcBj-005bPI-H1; Sun, 29 Mar 2020 17:57:35 +0000
Date:   Sun, 29 Mar 2020 18:57:35 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC][PATCH 01/22] x86 user stack frame reads: switch to
 explicit __get_user()
Message-ID: <20200329175735.GC23230@ZenIV.linux.org.uk>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com>
 <20200328115936.GA23230@ZenIV.linux.org.uk>
 <20200329092602.GB93574@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329092602.GB93574@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 11:26:02AM +0200, Ingo Molnar wrote:

> > We'll get there; the tricky part is the ones that come in pair with 
> > something other than access_ok() in the first place (many of those are 
> > KVM-related, but not all such are).
> > 
> > This part had been more about untangling uaccess_try stuff,,,
> 
> It's much appreciated! In my previous mail I just wanted to inquire about 
> the long term plan, whether we are going to get rid of all uses of 
> __get_user() - to which the answer appears to be "yes". :-)

It is.  FWIW, __get_user() and friends are not good interfaces; that goes
for __copy_from_user_inatomic(), etc. - the whole pile should eventually
go away.

The reason why we can't just do a blanket "convert the entire pile to
get_user() et.al." is that in some cases access_ok() is *not* what
we want.  Currently they are very hard to distinguish - access_ok()
might've been done much earlier, so locating it can be tricky.  And
we do have such beasts - look for example at KVM-related code.

Another fun issue is that e.g. ppc will need at some point (preferably -
over the next cycle) get their analogue of stac/clac lifted into
user_access_begin/user_access_end.  The same goes for several other
architectures.  And we are almost certainly will need to change
the user_access_begin()/user_access_end() calling conventions to
cover that; there had been several subthreads discussing the ways
to do it, but those will need to be resurrected and brought to some
conclusion.  Until that's done I really don't want to do bulk conversions
of __get_user() to unsafe_get_user() - right now we have relatively
few user_access_begin/user_access_end blocks, but if we get a lot
of those from the stuff like e.g. comedi crap[*], any changes of calling
conventions will be a lot more noisy and painful.

[*] IMO compat_alloc_user_space() should die; this "grab some space on
user stack, copy the 32bit data structure into 64bit equivalent there,
complete with pointer chasing and creating 64bit equivalents of everything
that's referenced from that struct, then call native ioctl, then do the
reverse conversion" is just plain wrong.  That native ioctl is going to
bring the structures we'd constructed back into the kernel space and
work with them there; we might as well separate the function that work
with the copied struct (usually we do have those anyway) and call those
instead the native ioctl.  And skip the damn "copy the structures we'd
built into temp allocation on user stack, then have it copied back"
part.  We have relatively few callers, thankfully.

I mean, take a look at compat get_mempolicy(2).
COMPAT_SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
                       compat_ulong_t __user *, nmask,
                       compat_ulong_t, maxnode,
                       compat_ulong_t, addr, compat_ulong_t, flags)
{
        long err;
        unsigned long __user *nm = NULL;
        unsigned long nr_bits, alloc_size;
        DECLARE_BITMAP(bm, MAX_NUMNODES);

        nr_bits = min_t(unsigned long, maxnode-1, nr_node_ids);
        alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;

        if (nmask)
                nm = compat_alloc_user_space(alloc_size);
Allocated the one on userland stack.

        err = kernel_get_mempolicy(policy, nm, nr_bits+1, addr, flags);

Called native variant, asking it to put its result in that temp object.

        if (!err && nmask) {
... and if it hasn't failed, copy the sucker back into the kernel space
                unsigned long copy_size;
                copy_size = min_t(unsigned long, sizeof(bm), alloc_size);
                err = copy_from_user(bm, nm, copy_size);
... and convert-and-copy it where the user asked.
                /* ensure entire bitmap is zeroed */
                err |= clear_user(nmask, ALIGN(maxnode-1, 8) / 8);
                err |= compat_put_bitmap(nmask, bm, nr_bits);
        }

        return err;
}

OK, but kernel_get_mempolicy() only touches its second argument in the
very end:

        if (nmask)
                err = copy_nodes_to_user(nmask, maxnode, &nodes);

        return err;
with nodes being a local variable and copy_nodes_to_user() being
{
        unsigned long copy = ALIGN(maxnode-1, 64) / 8;
        unsigned int nbytes = BITS_TO_LONGS(nr_node_ids) * sizeof(long);

        if (copy > nbytes) {
                if (copy > PAGE_SIZE)
                        return -EINVAL;
                if (clear_user((char __user *)mask + nbytes, copy - nbytes))
                        return -EFAULT;
                copy = nbytes;
        }
        return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
}

So we have local variable in kernel_get_mempolicy() filled (by call of
do_get_mempolicy()), then copied out to temp userland allocation, then
copied back into the local variable in the caller of kernel_get_mempolicy(),
then copied-with-conversion...  I don't know about you, but I really
don't like that kind of code.  And untangling it is not that hard, really -
something like (completely untested) delta below would deal with that one:

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 977c641f78cf..2901462da099 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1611,28 +1611,29 @@ COMPAT_SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
 		       compat_ulong_t, maxnode,
 		       compat_ulong_t, addr, compat_ulong_t, flags)
 {
-	long err;
-	unsigned long __user *nm = NULL;
-	unsigned long nr_bits, alloc_size;
-	DECLARE_BITMAP(bm, MAX_NUMNODES);
+	int err;
+	int uninitialized_var(pval);
+	nodemask_t nodes;
 
-	nr_bits = min_t(unsigned long, maxnode-1, nr_node_ids);
-	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
+	if (nmask != NULL && maxnode < nr_node_ids)
+		return -EINVAL;
 
-	if (nmask)
-		nm = compat_alloc_user_space(alloc_size);
+	addr = untagged_addr(addr);
+
+	err = do_get_mempolicy(&pval, &nodes, addr, flags);
+	if (err)
+		return err;
 
-	err = kernel_get_mempolicy(policy, nm, nr_bits+1, addr, flags);
+	if (policy && put_user(pval, policy))
+		return -EFAULT;
 
-	if (!err && nmask) {
-		unsigned long copy_size;
-		copy_size = min_t(unsigned long, sizeof(bm), alloc_size);
-		err = copy_from_user(bm, nm, copy_size);
+	if (nmask) {
+		unsigned long nr_bits;
 		/* ensure entire bitmap is zeroed */
+		nr_bits = min_t(unsigned long, maxnode-1, nr_node_ids);
 		err |= clear_user(nmask, ALIGN(maxnode-1, 8) / 8);
-		err |= compat_put_bitmap(nmask, bm, nr_bits);
+		err |= compat_put_bitmap(nmask, nodes_addr(nodes), nr_bits);
 	}
-
 	return err;
 }
 
