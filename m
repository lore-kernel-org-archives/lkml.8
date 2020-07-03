Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5070C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9FFA20760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgGCNXn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:23:43 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:43613 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgGCNXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:23:42 -0400
Received: from sogo6.sd4.0x35.net (sogo6.sd4.0x35.net [10.200.201.56])
        (Authenticated sender: kerneldev@karsmulder.nl)
        by relay11.mail.gandi.net (Postfix) with ESMTPA id B245C100005;
        Fri,  3 Jul 2020 13:23:38 +0000 (UTC)
From:   "Kars Mulder" <kerneldev@karsmulder.nl>
In-Reply-To: <0c2bda4dd9e64a019d69339cf9054586@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Fri, 03 Jul 2020 15:23:38 +0200
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Pavel Machek" <pavel@ucw.cz>,
        =?utf-8?q?linux-kernel=40vger=2Ekernel=2Eorg?= 
        <linux-kernel@vger.kernel.org>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>
To:     "David Laight" <David.Laight@ACULAB.COM>
MIME-Version: 1.0
Message-ID: <33f8-5eff3180-187-71fa2980@45220895>
Subject: =?utf-8?q?RE=3A?= Writing to a const =?utf-8?q?pointer=3A?= is this 
 supposed to =?utf-8?q?happen=3F?=
User-Agent: SOGoMail 4.3.2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There ought to be one that returns a pointer to the first character
> that isn't converted - but I'm no expert on the full range of these
> functions.

I've searched for a function that parses an int from a string and 
stores a pointer to the end; I can find some function simple_strtoul
that matches this criterion, but it's documented as

    "This function has caveats. Please use kstrtoul instead."

... and kstrtoul does not store a pointer to the end. The documentation
of kstrtoul describes simple_strtoul as obsolete as well. Also, there's
no simple_strtou16 function.

It seems that the standard C function strtoul has the behaviour you
describe as well, but this function is not defined in the kernel except
for certain specific architectures.

> The problem with strdup() is you get the extra (unlikely) failure path.
> 128 bytes of stack won't be a problem if the function is (essentially)
> a leaf.
> Deep stack use is actually likely to be in the bowels of printf())
> inside an obscure error path.

The function already makes a call to kcalloc, so the unlikely out-of-
memory error path already exists; a second memory allocation just
makes it slightly less unlikely. The two new out-of-memory conditions
do happen at different points of the function though, making them
have different side effects. I could fix this by moving my code.

As for this function being a leaf: keep in mind that this function has
the potential of calling printk in an obscure error condition (the user-
provided parameter being longer that 128 characters); quirks_param_set
calls param_set_copystring, which on its turn calls pr_err, which is a
macro for printk.

Meanwhile, here's a patch for copying the parameter to the stack:

---
 drivers/usb/core/quirks.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index e0b77674869c..86b1a6739b4e 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -12,6 +12,8 @@
 #include <linux/usb/hcd.h>
 #include "usb.h"
 
+#define QUIRKS_PARAM_SIZE 128
+
 struct quirk_entry {
 	u16 vid;
 	u16 pid;
@@ -23,19 +25,21 @@ static DEFINE_MUTEX(quirk_mutex);
 static struct quirk_entry *quirk_list;
 static unsigned int quirk_count;
 
-static char quirks_param[128];
+static char quirks_param[QUIRKS_PARAM_SIZE];
 
-static int quirks_param_set(const char *val, const struct kernel_param *kp)
+static int quirks_param_set(const char *value, const struct kernel_param *kp)
 {
+	char val[QUIRKS_PARAM_SIZE];
 	char *p, *field;
 	u16 vid, pid;
 	u32 flags;
 	size_t i;
 	int err;
 
-	err = param_set_copystring(val, kp);
+	err = param_set_copystring(value, kp);
 	if (err)
 		return err;
+	strscpy(val, value, sizeof(val));
 
 	mutex_lock(&quirk_mutex);
 
--
2.27.0

