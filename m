Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BFFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B71B207E8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgGAXDO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 19:03:14 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48233 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgGAXDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 19:03:13 -0400
Received: from sogo2.sd4.0x35.net (sogo2.sd4.0x35.net [10.200.201.52])
        (Authenticated sender: kerneldev@karsmulder.nl)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPA id D833C20005;
        Wed,  1 Jul 2020 23:03:10 +0000 (UTC)
From:   "Kars Mulder" <kerneldev@karsmulder.nl>
In-Reply-To: <0ceda3b41fe446e792fce5ff2634c48f@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Thu, 02 Jul 2020 01:03:10 +0200
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Pavel Machek" <pavel@ucw.cz>,
        =?utf-8?q?linux-kernel=40vger=2Ekernel=2Eorg?= 
        <linux-kernel@vger.kernel.org>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>
To:     "David Laight" <David.Laight@ACULAB.COM>
MIME-Version: 1.0
Message-ID: <1f2d-5efd1600-b3-caae120@315006>
Subject: =?utf-8?q?RE=3A?= Writing to a const =?utf-8?q?pointer=3A?= is this 
 supposed to =?utf-8?q?happen=3F?=
User-Agent: SOGoMail 4.3.2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, June 27, 2020 12:24 CEST, David Laight wrote: 
> The code quoted (using strset()) is almost certainly wrong.
> The caller is unlikely to expect the input be modified.
> Since it doesn't fault the string must be in read-write memory.

I tried writing a patch that avoids the writing-to-const-pointer issue
by using the less intrusive sscanf function instead of strsep. It might
avoid a potential bug when somebody wrongly assumes that a
kernel_param_ops.set function will not write to its const char* argument.

Would a patch like this be acceptable, or would I first have to
demonstrate that the current implementation is actually causing real
problems?

This is not yet a formal patch submission; I have some more rigorous
testing to do first. (Relatedly, I'm a bit confused by the requirement
to "always *test* your changes on at least 4 or 5 people" mentioned in
MAINTAINERS. Where should I find those people? Can those people come
from the LKML mailing list, or should I find testers on some third party
forum before submitting my patch to the LKML?)

---
 drivers/usb/core/quirks.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index e0b77674869c..fe2059d71705 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -27,11 +27,11 @@ static char quirks_param[128];
 
 static int quirks_param_set(const char *val, const struct kernel_param *kp)
 {
-	char *p, *field;
-	u16 vid, pid;
+	const char *p;
+	unsigned short vid, pid;
 	u32 flags;
-	size_t i;
-	int err;
+	size_t i, len;
+	int err, res;
 
 	err = param_set_copystring(val, kp);
 	if (err)
@@ -63,29 +63,16 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
 		return -ENOMEM;
 	}
 
-	for (i = 0, p = (char *)val; p && *p;) {
+	for (i = 0, p = val; p && *p;) {
 		/* Each entry consists of VID:PID:flags */
-		field = strsep(&p, ":");
-		if (!field)
-			break;
-
-		if (kstrtou16(field, 16, &vid))
-			break;
-
-		field = strsep(&p, ":");
-		if (!field)
-			break;
-
-		if (kstrtou16(field, 16, &pid))
-			break;
-
-		field = strsep(&p, ",");
-		if (!field || !*field)
+		res = sscanf(p, "%hx:%hx%zn", &vid, &pid, &len);
+		if (res != 2 || *(p+len) != ':')
 			break;
+		p += len+1;
 
 		/* Collect the flags */
-		for (flags = 0; *field; field++) {
-			switch (*field) {
+		for (flags = 0; *p; p++) {
+			switch (*p) {
 			case 'a':
 				flags |= USB_QUIRK_STRING_FETCH_255;
 				break;
@@ -132,11 +119,15 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
 				flags |= USB_QUIRK_HUB_SLOW_RESET;
 				break;
 			/* Ignore unrecognized flag characters */
+			case ',':
+				p++;
+				goto collect_flags_end;
 			}
 		}
+collect_flags_end:
 
 		quirk_list[i++] = (struct quirk_entry)
-			{ .vid = vid, .pid = pid, .flags = flags };
+			{ .vid = (u16)vid, .pid = (u16)pid, .flags = flags };
 	}
 
 	if (i < quirk_count)
--
2.27.0

