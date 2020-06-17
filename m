Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1216EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA5F5206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgFQPHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgFQPHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:07:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6887C06174E;
        Wed, 17 Jun 2020 08:06:59 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlZeP-0003FY-Px; Wed, 17 Jun 2020 17:06:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3E5C71C0089;
        Wed, 17 Jun 2020 17:06:53 +0200 (CEST)
Date:   Wed, 17 Jun 2020 15:06:52 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/msr: Filter MSR writes
Cc:     kernel test robot <lkp@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200612105026.GA22660@zn.tnic>
References: <20200612105026.GA22660@zn.tnic>
MIME-Version: 1.0
Message-ID: <159240641292.16989.16267248536029944582.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     5603119e48d0fee163a827c2342b372f1a0e913c
Gitweb:        https://git.kernel.org/tip/5603119e48d0fee163a827c2342b372f1a0e913c
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 10 Jun 2020 21:37:49 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 17 Jun 2020 15:46:52 +02:00

x86/msr: Filter MSR writes

Add functionality to disable writing to MSRs from userspace. Writes can
still be allowed by supplying the allow_writes=on module parameter. The
kernel will be tainted so that it shows in oopses.

Having unfettered access to all MSRs on a system is and has always been
a disaster waiting to happen. Think performance counter MSRs, MSRs with
sticky or locked bits, MSRs making major system changes like loading
microcode, MTRRs, PAT configuration, TSC counter, security mitigations
MSRs, you name it.

This also destroys all the kernel's caching of MSR values for
performance, as the recent case with MSR_AMD64_LS_CFG showed.

Another example is writing MSRs by mistake by simply typing the wrong
MSR address. System freezes have been experienced that way.

In general, poking at MSRs under the kernel's feet is a bad bad idea.

So log writing to MSRs by default. Longer term, such writes will be
disabled by default.

If userspace still wants to do that, then proper interfaces should be
defined which are under the kernel's control and accesses to those MSRs
can be synchronized and sanitized properly.

[ Fix sparse warnings. ]
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200612105026.GA22660@zn.tnic
---
 arch/x86/kernel/msr.c | 69 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 1547be3..576c43e 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -42,6 +42,14 @@
 static struct class *msr_class;
 static enum cpuhp_state cpuhp_msr_state;
 
+enum allow_write_msrs {
+	MSR_WRITES_ON,
+	MSR_WRITES_OFF,
+	MSR_WRITES_DEFAULT,
+};
+
+static enum allow_write_msrs allow_writes = MSR_WRITES_DEFAULT;
+
 static ssize_t msr_read(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos)
 {
@@ -70,6 +78,24 @@ static ssize_t msr_read(struct file *file, char __user *buf,
 	return bytes ? bytes : err;
 }
 
+static int filter_write(u32 reg)
+{
+	switch (allow_writes) {
+	case MSR_WRITES_ON:  return 0;		break;
+	case MSR_WRITES_OFF: return -EPERM;	break;
+	default: break;
+	}
+
+	if (reg == MSR_IA32_ENERGY_PERF_BIAS)
+		return 0;
+
+	pr_err_ratelimited("Write to unrecognized MSR 0x%x by %s\n"
+			   "Please report to x86@kernel.org\n",
+			   reg, current->comm);
+
+	return 0;
+}
+
 static ssize_t msr_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
@@ -84,6 +110,10 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	if (err)
 		return err;
 
+	err = filter_write(reg);
+	if (err)
+		return err;
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -92,9 +122,13 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 			err = -EFAULT;
 			break;
 		}
+
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+
 		err = wrmsr_safe_on_cpu(cpu, reg, data[0], data[1]);
 		if (err)
 			break;
+
 		tmp += 2;
 		bytes += 8;
 	}
@@ -242,6 +276,41 @@ static void __exit msr_exit(void)
 }
 module_exit(msr_exit)
 
+static int set_allow_writes(const char *val, const struct kernel_param *cp)
+{
+	/* val is NUL-terminated, see kernfs_fop_write() */
+	char *s = strstrip((char *)val);
+
+	if (!strcmp(s, "on"))
+		allow_writes = MSR_WRITES_ON;
+	else if (!strcmp(s, "off"))
+		allow_writes = MSR_WRITES_OFF;
+	else
+		allow_writes = MSR_WRITES_DEFAULT;
+
+	return 0;
+}
+
+static int get_allow_writes(char *buf, const struct kernel_param *kp)
+{
+	const char *res;
+
+	switch (allow_writes) {
+	case MSR_WRITES_ON:  res = "on"; break;
+	case MSR_WRITES_OFF: res = "off"; break;
+	default: res = "default"; break;
+	}
+
+	return sprintf(buf, "%s\n", res);
+}
+
+static const struct kernel_param_ops allow_writes_ops = {
+	.set = set_allow_writes,
+	.get = get_allow_writes
+};
+
+module_param_cb(allow_writes, &allow_writes_ops, NULL, 0600);
+
 MODULE_AUTHOR("H. Peter Anvin <hpa@zytor.com>");
 MODULE_DESCRIPTION("x86 generic MSR driver");
 MODULE_LICENSE("GPL");
