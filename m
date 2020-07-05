Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3CDC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 21:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7136020658
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 21:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgGEVxb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 17:53:31 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:12389 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgGEVxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 17:53:30 -0400
Received: from sogo3.sd4.0x35.net (sogo3.sd4.0x35.net [10.200.201.53])
        (Authenticated sender: kerneldev@karsmulder.nl)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPA id 8C598240004;
        Sun,  5 Jul 2020 21:53:27 +0000 (UTC)
From:   "Kars Mulder" <kerneldev@karsmulder.nl>
In-Reply-To: <20200704115538.GD16083@amd>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Sun, 05 Jul 2020 23:53:27 +0200
Cc:     "David Laight" <David.Laight@ACULAB.COM>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        "Pavel Machek" <pavel@denx.de>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        "Oliver Neukum" <oneukum@suse.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
MIME-Version: 1.0
Message-ID: <3212-5f024c00-215-220fe080@174542169>
Subject: =?utf-8?q?=5BPATCH=5D?==?utf-8?q?_usb=3A?==?utf-8?q?_core=3A?= fix 
 =?utf-8?q?quirks=5Fparam=5Fset=28=29?= writing to a const pointer
User-Agent: SOGoMail 4.3.2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function quirks_param_set() takes as argument a const char* pointer
to the new value of the usbcore.quirks parameter. It then casts this
pointer to a non-const char* pointer and passes it to the strsep()
function, which overwrites the value.

Fix this by copying the value to a local buffer on the stack and 
letting that buffer be written to by strsep().

Fixes: 027bd6cafd9a ("usb: core: Add "quirks" parameter for usbcore")
Signed-off-by: Kars Mulder <kerneldev@karsmulder.nl>

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

