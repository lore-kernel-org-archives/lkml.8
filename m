Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DD9C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 07:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96EF20825
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 07:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgH2HNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 03:13:35 -0400
Received: from smtprelay0066.hostedemail.com ([216.40.44.66]:50738 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726115AbgH2HNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 03:13:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7755018029138;
        Sat, 29 Aug 2020 07:13:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: beds82_040d8132707c
X-Filterd-Recvd-Size: 3330
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat, 29 Aug 2020 07:13:29 +0000 (UTC)
Message-ID: <fe4de2e9f0a492e66b870cddbadb820e3459cc7a.camel@perches.com>
Subject: Re: [PATCH] sysfs: Add sysfs_emit to replace sprintf to PAGE_SIZE
 buffers.
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 29 Aug 2020 00:13:28 -0700
In-Reply-To: <c77e83a0-7587-3e07-81cb-6b185d1ce6aa@linux.com>
References: <a96cdf07cd136d06c3cc1e10eb884caa7498ba72.1598654887.git.joe@perches.com>
         <c77e83a0-7587-3e07-81cb-6b185d1ce6aa@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-29 at 09:59 +0300, Denis Efremov wrote:
> Hi,
> 
> On 8/29/20 1:52 AM, Joe Perches wrote:
> > sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> > used for outputting sysfs content requests and it's possible to
> > overrun the buffer length.
> > 
> > Add a generic sysfs_emit mechanism that knows that the size of the
> > temporary buffer and ensures that no overrun is done.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > --- rK
> 
> It could be a good idea to update the docs to, i.e.:
> https://www.kernel.org/doc/html/latest/filesystems/sysfs.html

Yes, thanks.

I have the below already, but Greg makes a sensible point
about the generic use of sysfs_emit for single values
which is ~95% of the actual uses, so likely there will be
two functions.  Given the multiple thousand instances,
using 2 functions would be smaller overall object code
as well.

Perhaps:

sysfs_emit (for single value output)
sysfs_emit_at (or sysfs_emit_pos ? or some better name?)

	int sysfs_emit(char *buf, const char *fmt, ...)
	int sysfs_emit_at(char *buf, int pos, const char *fmt, ...)

or maybe use

	int sysfs_emit_pos(char *buf, char *pos, const char *fmt, ...)

The multiple use emit_at with int as the 2nd parameter would
make the direct return easier than the char * which needs a
subtraction.

six of this/half dozen of that...

cheers...

---

Anyway, this will need updating, likely with better examples.

diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index ab0f7795792b..13c7a86fa6c8 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -242,12 +242,9 @@ Other notes:
   is 4096.
 
 - show() methods should return the number of bytes printed into the
-  buffer. This is the return value of scnprintf().
+  buffer. This is the return value of sysfs_emit().
 
-- show() must not use snprintf() when formatting the value to be
-  returned to user space. If you can guarantee that an overflow
-  will never happen you can use sprintf() otherwise you must use
-  scnprintf().
+- show() methods should only use sysfs_emit to format output.

