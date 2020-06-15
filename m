Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BBFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F211A2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="GME8/4zM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgFOGit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:38:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48646 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbgFOGit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:38:49 -0400
Received: from zn.tnic (p200300ec2f063c003187a4190bac43a1.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:3c00:3187:a419:bac:43a1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EC21A1EC0322;
        Mon, 15 Jun 2020 08:38:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592203128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rW+N6IIBRLGHKd6BrTbGzh9GW2GBhMaTgnuWpn9t/C8=;
        b=GME8/4zMjhb/BEy3Z7DWNVkUpbzmpHmPxEB4rDmGWS+qYgkzGNHNrdqmmvGKdCc2GeDUvy
        tOBK0rr+0B9fjo4KZnTfeEi0UQE5+gxXmd27KCCJJrym7UxH24nAEDourkg8PPRp7dgYbB
        EZZA7gSBCdZERuwfFGQlva50xBmBPr8=
Date:   Mon, 15 Jun 2020 08:38:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     x86-ml <x86@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20200615063837.GA14668@zn.tnic>
References: <20200612105026.GA22660@zn.tnic>
 <20200613154844.GB584@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200613154844.GB584@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an improved v2 with sparse warnings fixed:

---
Disable writing to MSRs from userspace by default. Writes can still be
allowed by supplying the allow_writes=1 module parameter and the kernel
will be tainted so that it shows in oopses.

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

So disable poking directly at the MSRs by default. If userspace still
wants to do that, then proper interfaces should be defined which
are under the kernel's control and accesses to those MSRs can be
synchronized and sanitized properly.

Changelog:
- taint before WRMSR, all
- make param 0600, Sean.
- do not deny but log writes by default, Linus.

[ Fix sparse warnings ]
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/msr.c | 69 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 1547be359d7f..576c43e39247 100644
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
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
