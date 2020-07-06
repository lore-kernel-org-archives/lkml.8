Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6DAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEDF2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgGFM6E convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:58:04 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59237 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgGFM6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:58:04 -0400
Received: from sogo13.sd4.0x35.net (sogo13.sd4.0x35.net [10.200.201.63])
        (Authenticated sender: kerneldev@karsmulder.nl)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPA id 2DD061BF208;
        Mon,  6 Jul 2020 12:57:59 +0000 (UTC)
From:   "Kars Mulder" <kerneldev@karsmulder.nl>
In-Reply-To: <20200706103405.GA11622@kroah.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Mon, 06 Jul 2020 14:57:59 +0200
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        "David Laight" <David.Laight@aculab.com>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        "Pavel Machek" <pavel@denx.de>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        "Oliver Neukum" <oneukum@suse.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
MIME-Version: 1.0
Message-ID: <5e4e-5f032000-4f-47356f00@80491239>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPATCH=5D?==?utf-8?q?_usb=3A?=
 =?utf-8?q?_core=3A?= fix =?utf-8?q?quirks=5Fparam=5Fset=28=29?= writing to 
 a const pointer
User-Agent: SOGoMail 4.3.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 06, 2020 12:34 CEST, Greg Kroah-Hartman wrote: 
> That's a lot of stack space, is it really needed?  Can we just use a
> static variable instead, or dynamically allocate this?

It is very possible to statically or dynamically allocate this.

Statically reserving an additional 128 bytes regardless of whether
this feature is actually used feels a bit wasteful, so I'd prefer
stack or dynamic allocation.

An earlier draft of my patch did dynamically allocate this memory;
early discussion (https://lkml.org/lkml/2020/7/3/248) suggested that
dynamic allocation has the disadvantage of introducing a new obscure
error condition:

On Friday, July 03, 2020 10:13 CEST, David Laight wrote: 
> The problem with strdup() is you get the extra (unlikely) failure path.
> 128 bytes of stack won't be a problem if the function is (essentially)
> a leaf.

So I rewrote my patch to use stack-based allocation instead. I've attached
a patch using kstrdup at the end of this mail.

I think that the new obscure error condition caused by kstrdup() isn't
too bad since original code already had a call to kcalloc() anyway; the
possibility for the function to fail due to out-of-memory errors
already existed. In this version of the patch, there may however be a
possible issue that different code paths are taken depending on when
the out-of-memory error occurs, resulting in different side effects:

	val = kstrdup(value, GFP_KERNEL);
	if (!val)
		return -ENOMEM;

	err = param_set_copystring(val, kp);
	[...]
	
	if (quirk_list) {
		kfree(quirk_list);
		quirk_list = NULL;
	}

	quirk_list = kcalloc(quirk_count, sizeof(struct quirk_entry),
			     GFP_KERNEL);


If the OOM happens at the kstrdup() step (which I added), then the old
value of the parameter will be retained. If the OOM happens at the
kcalloc() step, then the kernel will remember the value of the new
parameter (and return that value if asked what the parameter's current
value is), but but neither the old nor the new parameter will be in
effect: the quirk_list will be a NULL pointer and the quirks module
will behave as if the usbcore.quirks parameter is empty.

I could move my code to make an OOM at kstrdup() have the same side
effects as an OOM at kcalloc(), but I'd personally think that the first
kind of behaviour "setting the parameter failed, nothing happened" is
more correct than the latter kind "setting the parameter failed, the
parameter is now in limbo".

---
 drivers/usb/core/quirks.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index e0b77674869c..c96c50faccf7 100644
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
 
@@ -60,10 +66,11 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
 	if (!quirk_list) {
 		quirk_count = 0;
 		mutex_unlock(&quirk_mutex);
+		kfree(val);
 		return -ENOMEM;
 	}
 
-	for (i = 0, p = (char *)val; p && *p;) {
+	for (i = 0, p = val; p && *p;) {
 		/* Each entry consists of VID:PID:flags */
 		field = strsep(&p, ":");
 		if (!field)
@@ -144,6 +151,7 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
 
 unlock:
 	mutex_unlock(&quirk_mutex);
+	kfree(val);
 
 	return 0;
 }
-- 
2.27.0

