Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CA7C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AA520757
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgF1SUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 14:20:49 -0400
Received: from smtprelay0188.hostedemail.com ([216.40.44.188]:47112 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726060AbgF1SUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 14:20:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 1FEA61AAE7;
        Sun, 28 Jun 2020 18:20:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: elbow02_571416026e68
X-Filterd-Recvd-Size: 4116
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 28 Jun 2020 18:20:46 +0000 (UTC)
Message-ID: <131b9e2f6caeb46770374ffcb743a9541b51c2ce.camel@perches.com>
Subject: Re: [PATCH] mm: util: update the kerneldoc for kstrdup_const()
From:   Joe Perches <joe@perches.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 28 Jun 2020 11:20:45 -0700
In-Reply-To: <CAMRc=MciqbwHBPJf1w2m3xa6ZxbX7=Ca9ucEeyVaKa+FWPzu7A@mail.gmail.com>
References: <20200628152500.17916-1-brgl@bgdev.pl>
         <693db5a878ac09994e2a27c64cb14c0e552f3f50.camel@perches.com>
         <CAMRc=MciqbwHBPJf1w2m3xa6ZxbX7=Ca9ucEeyVaKa+FWPzu7A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-06-28 at 20:06 +0200, Bartosz Golaszewski wrote:
> On Sun, Jun 28, 2020 at 7:37 PM Joe Perches <joe@perches.com> wrote:
> > On Sun, 2020-06-28 at 17:25 +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > 
> > > Memory allocated with kstrdup_const() must not be passed to regular
> > > krealloc() as it is not aware of the possibility of the chunk residing
> > > in .rodata. Since there are no potential users of krealloc_const()
> > > at the moment, let's just update the doc to make it explicit.
> > 
> > Another option would be to return NULL if it's
> > used from krealloc with a pointer into rodata
> > ---
> >  mm/slab_common.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 37d48a56431d..f8b49656171b 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1683,6 +1683,9 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
> >   * @new_size: how many bytes of memory are required.
> >   * @flags: the type of memory to allocate.
> >   *
> > + * If the object pointed to is in rodata (likely from kstrdup_const)
> > + * %NULL is returned.
> > + *
> >   * The contents of the object pointed to are preserved up to the
> >   * lesser of the new and old sizes.  If @p is %NULL, krealloc()
> >   * behaves exactly like kmalloc().  If @new_size is 0 and @p is not a
> > @@ -1694,6 +1697,9 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
> >  {
> >         void *ret;
> > 
> > +       if (unlikely(is_kernel_rodata((unsigned long)p)))
> > +               return NULL;
> > +
> >         if (unlikely(!new_size)) {
> >                 kfree(p);
> >                 return ZERO_SIZE_PTR;
> > 
> > 
> > 
> 
> In that case we should probably add a WARN_ON() - otherwise the user
> will be baffled by krealloc() failing.

Maybe:
---
 mm/slab_common.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index a143a8c8f874..06c2714ab8c9 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1073,6 +1073,9 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
  * @new_size: how many bytes of memory are required.
  * @flags: the type of memory to allocate.
  *
+ * If the object pointed to is in rodata (likely from kstrdup_const)
+ * %NULL is returned.
+ *
  * The contents of the object pointed to are preserved up to the
  * lesser of the new and old sizes.  If @p is %NULL, krealloc()
  * behaves exactly like kmalloc().  If @new_size is 0 and @p is not a
@@ -1084,6 +1087,14 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
 {
 	void *ret;
 
+	if (unlikely(is_kernel_rodata((unsigned long)p))) {
+		if (!(flags & __GFP_NOWARN)) {
+			printk(KERN_DEFAULT "invalid use of krealloc with const rodata\n");
+			dump_stack();
+		}
+		return NULL;
+	}
+
 	if (unlikely(!new_size)) {
 		kfree(p);
 		return ZERO_SIZE_PTR;


