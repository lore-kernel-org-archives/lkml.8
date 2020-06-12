Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E042DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6488206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="n2lti7DG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgFLKui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFLKui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:50:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B54C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:50:37 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0af400c173145ce686c7e8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:f400:c173:145c:e686:c7e8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7CF6D1EC02E0;
        Fri, 12 Jun 2020 12:50:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591959034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=i67OvWK19gpLvFCtSsadQeL9dLaZioiCanotMz9MAN4=;
        b=n2lti7DGntdg6i8Xr02yv60JBjBlu4dSe7Jl39iorfmHHkkPCpskSkS7GPXhxuya1pkyag
        Zph75nKViDADXboKl4MFuuI2wd94mFYp1gQiFR63xLZgx3g1mHi65f42wY9+Vj0kLxXvxo
        NX4B+nrVEItKlgBDsIh+QaSLeKqe9Y8=
Date:   Fri, 12 Jun 2020 12:50:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     x86-ml <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] x86/msr: Filter MSR writes
Message-ID: <20200612105026.GA22660@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

so this has been popping up from time to time in the last couple of
years so let's have a go at it. The reason for it is explained in the
commit message below but basically the goal is to have MSR writes
disabled by default on distros and on the general Linux setup and only
those who know what they're doing, can reenable them if they really need
to.

The other, more important goal is to stop the perpetuation of poking at
naked MSRs from userspace instead of defining proper functionality and
interfaces which synchronize with the kernel's access to those MSRs.

Hell, even while testing this, I did

# wrmsr --all 0x10 12; rdmsr --all 0x10

0x10 being the TSC MSR and the module wouldn't unload after that. And
this is just the latest example of what can go wrong.

Now, a concern with questionable validity has been raised that this
might break "some tools on github" which poke directly at MSRs. And we
don't break userspace.

Well, for starters, the functionality is still there - it is just behind
a module parameter. Then, it'll hopefully convince people providing the
functionality controlled by those MSRs, to design proper interfaces for
that.

For example, the whitelisted MSR_IA32_ENERGY_PERF_BIAS is used by
cpupower in tools/. The hope is that this gets converted to a proper
interface too.

In any case, let me add Linus as I might be missing some angle here.

Thx.

--

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

Signed-off-by: Borislav Petkov <bp@suse.de>

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 1547be359d7f..931e7b00ffb7 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -41,6 +41,7 @@
 
 static struct class *msr_class;
 static enum cpuhp_state cpuhp_msr_state;
+static bool allow_writes;
 
 static ssize_t msr_read(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos)
@@ -70,6 +71,18 @@ static ssize_t msr_read(struct file *file, char __user *buf,
 	return bytes ? bytes : err;
 }
 
+static int filter_write(u32 reg)
+{
+	switch (reg) {
+	case MSR_IA32_ENERGY_PERF_BIAS:
+		return 0;
+
+	default:
+		pr_err("%s: Filter out MSR write to 0x%x\n", __func__, reg);
+		return -EPERM;
+	}
+}
+
 static ssize_t msr_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
@@ -84,6 +97,12 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	if (err)
 		return err;
 
+	if (!allow_writes) {
+		err = filter_write(reg);
+		if (err)
+			return err;
+	}
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -95,11 +114,18 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 		err = wrmsr_safe_on_cpu(cpu, reg, data[0], data[1]);
 		if (err)
 			break;
+
 		tmp += 2;
 		bytes += 8;
 	}
 
-	return bytes ? bytes : err;
+	if (bytes) {
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+
+		return bytes;
+	}
+
+	return err;
 }
 
 static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
@@ -242,6 +268,8 @@ static void __exit msr_exit(void)
 }
 module_exit(msr_exit)
 
+module_param(allow_writes, bool, 0400);
+
 MODULE_AUTHOR("H. Peter Anvin <hpa@zytor.com>");
 MODULE_DESCRIPTION("x86 generic MSR driver");
 MODULE_LICENSE("GPL");
