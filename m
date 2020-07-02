Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03515C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE4552075D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgGBVsF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:48:05 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:50587 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBVsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:48:05 -0400
Received: from sogo3.sd4.0x35.net (sogo3.sd4.0x35.net [10.200.201.53])
        (Authenticated sender: kerneldev@karsmulder.nl)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPA id B3BC61C0002;
        Thu,  2 Jul 2020 21:48:02 +0000 (UTC)
From:   "Kars Mulder" <kerneldev@karsmulder.nl>
In-Reply-To: <32182d4126fd49dabac4091b7a6c89e7@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Thu, 02 Jul 2020 23:48:02 +0200
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Pavel Machek" <pavel@ucw.cz>,
        =?utf-8?q?linux-kernel=40vger=2Ekernel=2Eorg?= 
        <linux-kernel@vger.kernel.org>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>
To:     "David Laight" <David.Laight@ACULAB.COM>
MIME-Version: 1.0
Message-ID: <297d-5efe5600-1cf-7eab9a80@67481175>
Subject: =?utf-8?q?RE=3A?= Writing to a const =?utf-8?q?pointer=3A?= is this 
 supposed to =?utf-8?q?happen=3F?=
User-Agent: SOGoMail 4.3.2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 02, 2020 09:55 CEST, David Laight wrote: 
> Hmm... sscanf() is also horrid.
> Surprisingly difficult to use correctly.
> 
> It is usually best to use strchr() (and maybe str[c]scn())
> to parse strings.
> For numbers use whatever the kernels current 'favourite' implementation
> of strtoul() is called.

I thought that using sscanf would clean up the code a bit compared to
several haphazard calls, but I can see your point about sscanf being
difficult to use correctly.

The kernel functions kstrtou16 seem to expect a null-terminated string
as argument. Since there are no null-bytes after the numbers we want to
parse, it becomes necessary to copy at least part of the strings to a
buffer.

If we're copying strings to buffers anyway, I think the simplest
solution would be to just kstrdup the entire parameter and not touch
the rest of the string parsing code. This has the disadvantage of
having an extra memory allocation to keep track of.

Since the parameter is currently restricted to 128 characters at
most, it may alternatively be possible to copy the parameter to
a 128-byte buffer on the stack. This has the advantage of having
to keep track of one less memory allocation, but the disadvantage
of using 128 bytes more stack space; I'm not sure whether that's
acceptable.

Here's a sample patch involving kstrdup:

---
 drivers/usb/core/quirks.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index e0b77674869c..3b64b0be2563 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -25,17 +25,23 @@ static unsigned int quirk_count;
 
 static char quirks_param[128];
 
-static int quirks_param_set(const char *val, const struct kernel_param *kp)
+static int quirks_param_set(const char *value, const struct kernel_param *kp)
 {
-	char *p, *field;
+	char *val, *p, *field;
 	u16 vid, pid;
 	u32 flags;
 	size_t i;
 	int err;
 
+	val = kstrdup(value, GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+
 	err = param_set_copystring(val, kp);
-	if (err)
+	if (err) {
+		kfree(val);
 		return err;
+	}
 
 	mutex_lock(&quirk_mutex);
 
@@ -60,6 +66,7 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
 	if (!quirk_list) {
 		quirk_count = 0;
 		mutex_unlock(&quirk_mutex);
+		kfree(val);
 		return -ENOMEM;
 	}
 
@@ -144,6 +151,7 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
 
 unlock:
 	mutex_unlock(&quirk_mutex);
+	kfree(val);
 
 	return 0;
 }
--
2.27.0

