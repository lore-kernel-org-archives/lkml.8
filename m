Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F40C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 17:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD4820738
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 17:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgIFRY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 13:24:29 -0400
Received: from smtprelay0084.hostedemail.com ([216.40.44.84]:46130 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725816AbgIFRY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 13:24:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 5816F18224D93;
        Sun,  6 Sep 2020 17:24:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wall63_3303465270c5
X-Filterd-Recvd-Size: 4608
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sun,  6 Sep 2020 17:24:23 +0000 (UTC)
Message-ID: <743a648dc817cddd2e7046283c868f1c08742f29.camel@perches.com>
Subject: Re: [PATCH V2] sysfs: Add sysfs_emit and sysfs_emit_at to format
 sysfs output
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 06 Sep 2020 10:24:20 -0700
In-Reply-To: <a9054fb521e65f2809671fa9c18e2453061e9d91.1598744610.git.joe@perches.com>
References: <a9054fb521e65f2809671fa9c18e2453061e9d91.1598744610.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-29 at 16:48 -0700, Joe Perches wrote:
> Output defects can exist in sysfs content using sprintf and snprintf.
> 
> sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> used for outputting sysfs content and it's possible to overrun the
> PAGE_SIZE buffer length.
> 
> Add a generic sysfs_emit function that knows that the size of the
> temporary buffer and ensures that no overrun is done.
> 
> Add a generic sysfs_emit_at function that can be used in multiple
> call situations that also ensures that no overrun is done.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> V2: Simplify sysfs_emit and add sysfs_emit_at
>     Include Documentation change

Greg?  Rafael? Thoughts on this?

One additional possibility is to validate the buf address to be
page aligned by adding a test of buf and offset_in_page(buf)

ie: WARN(!buf || offset_in_page(buf), etc...

Output defects can exist in sysfs content using sprintf and snprintf.

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Add a generic sysfs_emit function that knows that the size of the
temporary buffer and ensures that no overrun is done.

Add a generic sysfs_emit_at function that can be used in multiple
call situations that also ensures that no overrun is done.

Validate the output buffer argument to be page aligned.
Validate the offset len argument to be within the PAGE_SIZE buf.

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/sysfs/file.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index eb6897ab78e7..96d0da65e088 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/seq_file.h>
+#include <linux/mm.h>
 
 #include "sysfs.h"
 
@@ -707,3 +708,57 @@ int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sysfs_change_owner);
+
+/**
+ *	sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer.
+ *	@buf:	start of PAGE_SIZE buffer.
+ *	@fmt:	format
+ *	@...:	optional arguments to @format
+ *
+ *
+ * Returns number of characters written to @buf.
+ */
+int sysfs_emit(char *buf, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+
+	if (WARN(!buf || offset_in_page(buf),
+		 "invalid sysfs_emit: buf:%p\n", buf))
+		return 0;
+
+	va_start(args, fmt);
+	len = vscnprintf(buf, PAGE_SIZE, fmt, args);
+	va_end(args);
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(sysfs_emit);
+
+/**
+ *	sysfs_emit_at - scnprintf equivalent, aware of PAGE_SIZE buffer.
+ *	@buf:	start of PAGE_SIZE buffer.
+ *	@at:	offset in @buf to start write in bytes
+ *		@at must be >= 0 && < PAGE_SIZE
+ *	@fmt:	format
+ *	@...:	optional arguments to @fmt
+ *
+ *
+ * Returns number of characters written starting at &@buf[@at].
+ */
+int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+
+	if (WARN(!buf || offset_in_page(buf) || at < 0 || at >= PAGE_SIZE,
+		 "invalid sysfs_emit_at: buf:%p at:%d\n", buf, at))
+		return 0;
+
+	va_start(args, fmt);
+	len = vscnprintf(buf + at, PAGE_SIZE - at, fmt, args);
+	va_end(args);
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(sysfs_emit_at);


