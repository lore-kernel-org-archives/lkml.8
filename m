Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC500C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 06:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1665207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 06:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgH2GlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 02:41:05 -0400
Received: from smtprelay0081.hostedemail.com ([216.40.44.81]:51024 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgH2GlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 02:41:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C5A11100E7B44;
        Sat, 29 Aug 2020 06:41:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: debt34_33114042707c
X-Filterd-Recvd-Size: 3722
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 29 Aug 2020 06:41:01 +0000 (UTC)
Message-ID: <2acf2dc0945bc7f1ec2617b616808ab3c514067b.camel@perches.com>
Subject: Re: [PATCH] sysfs: Add sysfs_emit to replace sprintf to PAGE_SIZE
 buffers.
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Aug 2020 23:41:00 -0700
In-Reply-To: <20200829062254.GA79296@kroah.com>
References: <a96cdf07cd136d06c3cc1e10eb884caa7498ba72.1598654887.git.joe@perches.com>
         <20200829062254.GA79296@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-29 at 08:22 +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 28, 2020 at 03:52:13PM -0700, Joe Perches wrote:
> > sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> > used for outputting sysfs content requests and it's possible to
> > overrun the buffer length.
> > 
> > Add a generic sysfs_emit mechanism that knows that the size of the
> > temporary buffer and ensures that no overrun is done.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  fs/sysfs/file.c       | 30 ++++++++++++++++++++++++++++++
> >  include/linux/sysfs.h |  8 ++++++++
> >  2 files changed, 38 insertions(+)
> > 
> > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > index eb6897ab78e7..06a13bbd7080 100644
> > --- a/fs/sysfs/file.c
> > +++ b/fs/sysfs/file.c
> > @@ -707,3 +707,33 @@ int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(sysfs_change_owner);
> > +
> > +/**
> > + *	sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer.
> > + *	@buf:	start of PAGE_SIZE buffer.
> > + *	@pos:	current position in buffer
> > + *              (pos - buf) must always be < PAGE_SIZE
> 
> sysfs files are always supposed to be "one value per file", so why would
> you ever need a 'pos' variable to show the location in the buffer?

I've done treewide conversions using cocci.
It's used all over the place.
Especially in loops with arrays.

Sometimes the output is single line.
Sometimes multiple lines.

Look at the sample conversion of mem_sleep_show I posted earlier.

#ifdef CONFIG_SUSPEND
 static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
                              char *buf)
 {
-       char *s = buf;
+       char *pos = buf;
        suspend_state_t i;
 
        for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++)
                if (mem_sleep_states[i]) {
                        const char *label = mem_sleep_states[i];
 
                        if (mem_sleep_current == i)
-                               s += sprintf(s, "[%s] ", label);
+                               pos += sysfs_emit(buf, pos, "[%s] ", label);
                        else
-                               s += sprintf(s, "%s ", label);
+                               pos += sysfs_emit(buf, pos, "%s ", label);
                }
 
        /* Convert the last space to a newline if needed. */
-       if (s != buf)
-               *(s-1) = '\n';
+       if (pos != buf)
+               *(pos - 1) = '\n';
 
-       return (s - buf);
+       return pos - buf;
 }
 



