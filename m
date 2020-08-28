Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CDCC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 04:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C1C6208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 04:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgH1EMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 00:12:12 -0400
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:56988 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgH1EML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 00:12:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id EE44B182CED34;
        Fri, 28 Aug 2020 04:12:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brake40_18021b527072
X-Filterd-Recvd-Size: 10858
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2020 04:12:07 +0000 (UTC)
Message-ID: <d99c613aa70617f440c51d9413372b858a4ae826.camel@perches.com>
Subject: Re: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Denis Efremov <efremov@linux.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>,
        Alex Dewar <alex.dewar90@gmail.com>
Date:   Thu, 27 Aug 2020 21:12:06 -0700
In-Reply-To: <5ebe5c2737b59d04f1b8a46008cd3159c638f9d0.camel@perches.com>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
         <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
         <20200827071537.GA168593@kroah.com>
         <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
         <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
         <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
         <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
         <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
         <5853c58e-7d26-2cf9-6cbf-698ecd93cbf9@linux.com>
         <202008271517.ECC1F1F8F@keescook>
         <5ebe5c2737b59d04f1b8a46008cd3159c638f9d0.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-27 at 15:45 -0700, Joe Perches wrote:
> On Thu, 2020-08-27 at 15:20 -0700, Kees Cook wrote:
> > On Fri, Aug 28, 2020 at 12:01:34AM +0300, Denis Efremov wrote:
> > > Just FYI, I've send an addition to the device_attr_show.cocci script[1] to turn
> > > simple cases of snprintf (e.g. "%i") to sprintf. Looks like many developers would
> > > like it more than changing snprintf to scnprintf. As for me, I don't like the idea
> > > of automated altering of the original logic from bounded snprint to unbouded one
> > > with sprintf.
> > 
> > Agreed. This just makes me cringe. If the API design declares that when
> > a show() callback starts, buf has been allocated with PAGE_SIZE bytes,
> > then that's how the logic should proceed, and it should be using
> > scnprintf...
> > 
> > show(...) {
> > 	size_t remaining = PAGE_SIZE;
> > 
> > 	...
> > 	remaining -= scnprintf(buf, remaining, "fmt", var args ...);
> > 	remaining -= scnprintf(buf, remaining, "fmt", var args ...);
> > 	remaining -= scnprintf(buf, remaining, "fmt", var args ...);
> > 
> > 	return PAGE_SIZE - remaining;
> > }
> 
> It seems likely that coccinelle could do those transform
> with any of sprintf/snprintf/scnprint too.
> 
> Though my bikeshed would use a single function and have
> that function know the maximum output size

Perhaps something like the below with a sample conversion
that uses single and multiple sysfs_emit uses.

I believe coccinelle can _mostly_ automated this.

---
 fs/sysfs/file.c       | 30 ++++++++++++++++++++++++++++++
 include/linux/sysfs.h |  8 ++++++++
 kernel/power/main.c   | 49 ++++++++++++++++++++++++++-----------------------
 3 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index eb6897ab78e7..c0ff3ba8e373 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -707,3 +707,33 @@ int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sysfs_change_owner);
+
+/**
+ *	sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer.
+ *	@buf:	start of PAGE_SIZE buffer.
+ *	@pos:	current position in buffer
+ *              (pos - buf) must always be < PAGE_SIZE
+ *	@fmt:	format
+ *	@...:	arguments to format
+ *
+ *
+ * Returns number of characters written at pos.
+ */
+int sysfs_emit(char *buf, char *pos, const char *fmt, ...)
+{
+	int len;
+	va_list args;
+
+	WARN(pos < buf, "pos < buf\n");
+	WARN(pos - buf >= PAGE_SIZE, "pos >= PAGE_SIZE (%tu > %lu)\n",
+	     pos - buf, PAGE_SIZE);
+	if (pos < buf || pos - buf >= PAGE_SIZE)
+		return 0;
+
+	va_start(args, fmt);
+	len = vscnprintf(pos, PAGE_SIZE - (pos - buf), fmt, args);
+	va_end(args);
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(sysfs_emit);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 34e84122f635..5a21d3d30016 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -329,6 +329,8 @@ int sysfs_groups_change_owner(struct kobject *kobj,
 int sysfs_group_change_owner(struct kobject *kobj,
 			     const struct attribute_group *groups, kuid_t kuid,
 			     kgid_t kgid);
+__printf(3, 4)
+int sysfs_emit(char *buf, char *pos, const char *fmt, ...);
 
 #else /* CONFIG_SYSFS */
 
@@ -576,6 +578,12 @@ static inline int sysfs_group_change_owner(struct kobject *kobj,
 	return 0;
 }
 
+__printf(3, 4)
+static inline int sysfs_emit(char *buf, char *pos, const char *fmt, ...)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SYSFS */
 
 static inline int __must_check sysfs_create_file(struct kobject *kobj,
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 40f86ec4ab30..f3fb9f255234 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -100,7 +100,7 @@ int pm_async_enabled = 1;
 static ssize_t pm_async_show(struct kobject *kobj, struct kobj_attribute *attr,
 			     char *buf)
 {
-	return sprintf(buf, "%d\n", pm_async_enabled);
+	return sysfs_emit(buf, buf, "%d\n", pm_async_enabled);
 }
 
 static ssize_t pm_async_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -124,7 +124,7 @@ power_attr(pm_async);
 static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
 			      char *buf)
 {
-	char *s = buf;
+	char *pos = buf;
 	suspend_state_t i;
 
 	for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++)
@@ -132,16 +132,16 @@ static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
 			const char *label = mem_sleep_states[i];
 
 			if (mem_sleep_current == i)
-				s += sprintf(s, "[%s] ", label);
+				pos += sysfs_emit(buf, pos, "[%s] ", label);
 			else
-				s += sprintf(s, "%s ", label);
+				pos += sysfs_emit(buf, pos, "%s ", label);
 		}
 
 	/* Convert the last space to a newline if needed. */
-	if (s != buf)
-		*(s-1) = '\n';
+	if (pos != buf)
+		*(pos - 1) = '\n';
 
-	return (s - buf);
+	return pos - buf;
 }
 
 static suspend_state_t decode_suspend_state(const char *buf, size_t n)
@@ -202,7 +202,7 @@ bool sync_on_suspend_enabled = !IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC);
 static ssize_t sync_on_suspend_show(struct kobject *kobj,
 				   struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", sync_on_suspend_enabled);
+	return sysfs_emit(buf, buf, "%d\n", sync_on_suspend_enabled);
 }
 
 static ssize_t sync_on_suspend_store(struct kobject *kobj,
@@ -336,7 +336,7 @@ static ssize_t last_failed_dev_show(struct kobject *kobj,
 	index %= REC_FAILED_NUM;
 	last_failed_dev = suspend_stats.failed_devs[index];
 
-	return sprintf(buf, "%s\n", last_failed_dev);
+	return sysfs_emit(buf, buf, "%s\n", last_failed_dev);
 }
 static struct kobj_attribute last_failed_dev = __ATTR_RO(last_failed_dev);
 
@@ -350,7 +350,7 @@ static ssize_t last_failed_errno_show(struct kobject *kobj,
 	index %= REC_FAILED_NUM;
 	last_failed_errno = suspend_stats.errno[index];
 
-	return sprintf(buf, "%d\n", last_failed_errno);
+	return sysfs_emit(buf, buf, "%d\n", last_failed_errno);
 }
 static struct kobj_attribute last_failed_errno = __ATTR_RO(last_failed_errno);
 
@@ -366,7 +366,7 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
 	step = suspend_stats.failed_steps[index];
 	last_failed_step = suspend_step_name(step);
 
-	return sprintf(buf, "%s\n", last_failed_step);
+	return sysfs_emit(buf, buf, "%s\n", last_failed_step);
 }
 static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
 
@@ -474,7 +474,7 @@ bool pm_print_times_enabled;
 static ssize_t pm_print_times_show(struct kobject *kobj,
 				   struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", pm_print_times_enabled);
+	return sysfs_emit(buf, buf, "%d\n", pm_print_times_enabled);
 }
 
 static ssize_t pm_print_times_store(struct kobject *kobj,
@@ -504,7 +504,9 @@ static ssize_t pm_wakeup_irq_show(struct kobject *kobj,
 					struct kobj_attribute *attr,
 					char *buf)
 {
-	return pm_wakeup_irq ? sprintf(buf, "%u\n", pm_wakeup_irq) : -ENODATA;
+	if (!pm_wakeup_irq)
+		return -ENODATA;
+	return sysfs_emit(buf, buf, "%u\n", pm_wakeup_irq);
 }
 
 power_attr_ro(pm_wakeup_irq);
@@ -514,7 +516,7 @@ bool pm_debug_messages_on __read_mostly;
 static ssize_t pm_debug_messages_show(struct kobject *kobj,
 				      struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", pm_debug_messages_on);
+	return sysfs_emit(buf, buf, "%d\n", pm_debug_messages_on);
 }
 
 static ssize_t pm_debug_messages_store(struct kobject *kobj,
@@ -704,8 +706,9 @@ static ssize_t wakeup_count_show(struct kobject *kobj,
 {
 	unsigned int val;
 
-	return pm_get_wakeup_count(&val, true) ?
-		sprintf(buf, "%u\n", val) : -EINTR;
+	if (!pm_get_wakeup_count(&val, true))
+		return -EINTR;
+	return sysfs_emit(buf, buf, "%u\n", val);
 }
 
 static ssize_t wakeup_count_store(struct kobject *kobj,
@@ -747,17 +750,17 @@ static ssize_t autosleep_show(struct kobject *kobj,
 	suspend_state_t state = pm_autosleep_state();
 
 	if (state == PM_SUSPEND_ON)
-		return sprintf(buf, "off\n");
+		return sysfs_emit(buf, buf, "off\n");
 
 #ifdef CONFIG_SUSPEND
 	if (state < PM_SUSPEND_MAX)
-		return sprintf(buf, "%s\n", pm_states[state] ?
-					pm_states[state] : "error");
+		return sysfs_emit(buf, buf, "%s\n",
+				  pm_states[state] ?: "error");
 #endif
 #ifdef CONFIG_HIBERNATION
-	return sprintf(buf, "disk\n");
+	return sysfs_emit(buf, buf, "disk\n");
 #else
-	return sprintf(buf, "error");
+	return sysfs_emit(buf, buf, "error\n");
 #endif
 }
 
@@ -826,7 +829,7 @@ int pm_trace_enabled;
 static ssize_t pm_trace_show(struct kobject *kobj, struct kobj_attribute *attr,
 			     char *buf)
 {
-	return sprintf(buf, "%d\n", pm_trace_enabled);
+	return sysfs_emit(buf, buf, "%d\n", pm_trace_enabled);
 }
 
 static ssize_t
@@ -863,7 +866,7 @@ power_attr_ro(pm_trace_dev_match);
 static ssize_t pm_freeze_timeout_show(struct kobject *kobj,
 				      struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%u\n", freeze_timeout_msecs);
+	return sysfs_emit(buf, buf, "%u\n", freeze_timeout_msecs);
 }
 
 static ssize_t pm_freeze_timeout_store(struct kobject *kobj,


