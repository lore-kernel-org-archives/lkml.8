Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98355C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B09D2465B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580229336;
	bh=hwCU/YE3wtBg29QuHeIDAw8kl6vJOsmZ+lIxVkx0j+g=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Gbmik9SVTbG9ibstsBsX3MRfFvmfoDvh0gF/VpXl5DgW+rp/7atslSpnY0Q3xeD3c
	 bT8MQt/R8rQ7Mo2RsDLHvsn7Lxtnci1Lb3MlpK2RPwq4sN0LSnG5pRsoEJ1a8ep/4O
	 Z6PifceKqlnsj83KSaN92kNbzpG/Yb+KMIb4zUnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgA1Qff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:35:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39722 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgA1Qff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:35:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so16764161wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 08:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QdZd1fqKDA6uO2e3P5Ih6oOtyLcTyX2n5VKSCXawdk8=;
        b=Tz+LmmoT/IXlPktI+4+H5uQ3EOHAuyktEzd7GEIzmd9WuRba3JKCptW6LHmGhp20tl
         KSIQL55aa/cM0nMis6a+TnvfTSw+1oRCgkaklmcIubQkz8Pi1tg8e55xO1XLqAgGhIj4
         Xr4Q9h0hasfoIplPcnb4HtbSDbj2M6IR3PBOrJhC5eT7hQapj1wMsA+PrJjzNKS2JhQH
         Sz+mUzetnHERgpJudBYWZCIyT6k3zwpii9xYA8yxLE8+EzwvrVit1TEPYcqkuYvWyshh
         gHL8DGWMXOHfb5DSvmdFgvaK44k8C6PTsRPNkaZcpBLaLhX5nhU6pQbtXH5cZOrukynZ
         2EOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=QdZd1fqKDA6uO2e3P5Ih6oOtyLcTyX2n5VKSCXawdk8=;
        b=f4jY9bbpYXrbx+KQj4dwpNvwtYP11GDCFLPZufe0XXkcXVg9N4xCvA483LMV4CgSRk
         nEEkUoW0GbhHVa23TdGKnOW9SyHUC1ZZ+c2pjgY0qpTQEgiubrvdDbm8DDz5ktcK9ipk
         5WJ9+uUTkVfSrYnkr3tEb5TOAHUouPb/YE/FXghWRfecfda5+NMMIrA45F07EJpBugs8
         DeRMgs1aAiXYkpeFc8VXHBwpBuD/lmL83Uyw7uu2TeHwx89zj+MuYtYdRa7RWdC5a6+p
         qbRweOwhZgRr7qq7gqm0LIxO6LsFf2lLNYYOkOo242yK0T06GwDGYfyBgsX/0VQk7taX
         S9IQ==
X-Gm-Message-State: APjAAAUekyhvpy5giWVAoNcTTCzCOIfo1B3dqJo0QEK3t+AsYcZpDNZc
        X/RJWNcmggB2izYX7VbhaMQ=
X-Google-Smtp-Source: APXvYqxc1Z9g3kH3ab62qePsgEpDOIrOFT8btRqNUXYQTWeEoARaI3cssOOcHVMpfxWO+XA2n0448A==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr2566368wrs.81.1580229333000;
        Tue, 28 Jan 2020 08:35:33 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s16sm27048263wrn.78.2020.01.28.08.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 08:35:32 -0800 (PST)
Date:   Tue, 28 Jan 2020 17:35:30 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/apic fix
Message-ID: <20200128163530.GA122391@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-apic-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus

   # HEAD: d0b7788804482b2689946cd8d910ac3e03126c8d x86/apic/uv: Avoid unused variable warning

A single commit that simplifies the code and gets rid of a compiler 
warning.

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      x86/apic/uv: Avoid unused variable warning


 arch/x86/kernel/apic/x2apic_uv_x.c | 43 ++++++--------------------------------
 1 file changed, 6 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d5b51a740524..ad53b2abc859 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1493,65 +1493,34 @@ static void check_efi_reboot(void)
 }
 
 /* Setup user proc fs files */
-static int proc_hubbed_show(struct seq_file *file, void *data)
+static int __maybe_unused proc_hubbed_show(struct seq_file *file, void *data)
 {
 	seq_printf(file, "0x%x\n", uv_hubbed_system);
 	return 0;
 }
 
-static int proc_hubless_show(struct seq_file *file, void *data)
+static int __maybe_unused proc_hubless_show(struct seq_file *file, void *data)
 {
 	seq_printf(file, "0x%x\n", uv_hubless_system);
 	return 0;
 }
 
-static int proc_oemid_show(struct seq_file *file, void *data)
+static int __maybe_unused proc_oemid_show(struct seq_file *file, void *data)
 {
 	seq_printf(file, "%s/%s\n", oem_id, oem_table_id);
 	return 0;
 }
 
-static int proc_hubbed_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_hubbed_show, (void *)NULL);
-}
-
-static int proc_hubless_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_hubless_show, (void *)NULL);
-}
-
-static int proc_oemid_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_oemid_show, (void *)NULL);
-}
-
-/* (struct is "non-const" as open function is set at runtime) */
-static struct file_operations proc_version_fops = {
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations proc_oemid_fops = {
-	.open		= proc_oemid_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static __init void uv_setup_proc_files(int hubless)
 {
 	struct proc_dir_entry *pde;
-	char *name = hubless ? "hubless" : "hubbed";
 
 	pde = proc_mkdir(UV_PROC_NODE, NULL);
-	proc_create("oemid", 0, pde, &proc_oemid_fops);
-	proc_create(name, 0, pde, &proc_version_fops);
+	proc_create_single("oemid", 0, pde, proc_oemid_show);
 	if (hubless)
-		proc_version_fops.open = proc_hubless_open;
+		proc_create_single("hubless", 0, pde, proc_hubless_show);
 	else
-		proc_version_fops.open = proc_hubbed_open;
+		proc_create_single("hubbed", 0, pde, proc_hubbed_show);
 }
 
 /* Initialize UV hubless systems */
