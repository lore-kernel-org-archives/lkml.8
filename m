Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403E8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213DA206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580955;
	bh=Cj3n0XTwhCg+EkvrE/zsdb1K+4DKdGGpbmvgDDCCccU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eG8JUx7J7ABXdrOEgcvZowoLGvPFBGfDef+BbfbHSvGXWJVgvtBlFoDmx4gAacakI
	 YF+11L2SRIuH+Ti+rmmaeVT+yJliIKSAiVCSgzh4db+/T9m3aJFkSL2ANdpuR/ppu7
	 8bSQUBGLls/9zyQ8cHldPoBTnJXhc7O3MwEwcGCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393821AbgFSPbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393783AbgFSPbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:31:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 963E720734;
        Fri, 19 Jun 2020 15:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580669;
        bh=Cj3n0XTwhCg+EkvrE/zsdb1K+4DKdGGpbmvgDDCCccU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Kno/ZUqUMj8cq5M5PAowHEBT1IJX0KqlUL2TvaAt6/TJG72i0Gf8j4/AHOvjcpA9
         +ruZraO7lmS90Oobw1b5yvdvFzUJcoSzoLMYaIWeC2+tAob5yqmuGUZ7+4FaEDMYS0
         sOgxlftVHpfreJp1XBm4uFAJglDeAy/sptIYxBoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Erhard F." <erhard_f@mailbox.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.7 337/376] drivers/macintosh: Fix memleak in windfarm_pm112 driver
Date:   Fri, 19 Jun 2020 16:34:15 +0200
Message-Id: <20200619141726.285539729@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit 93900337b9ac2f4eca427eff6d187be2dc3b5551 upstream.

create_cpu_loop() calls smu_sat_get_sdb_partition() which does
kmalloc() and returns the allocated buffer. In fact it's called twice,
and neither buffer is freed.

This results in a memory leak as reported by Erhard:
  unreferenced object 0xc00000047081f840 (size 32):
    comm "kwindfarm", pid 203, jiffies 4294880630 (age 5552.877s)
    hex dump (first 32 bytes):
      c8 06 02 7f ff 02 ff 01 fb bf 00 41 00 20 00 00  ...........A. ..
      00 07 89 37 00 a0 00 00 00 00 00 00 00 00 00 00  ...7............
    backtrace:
      [<0000000083f0a65c>] .smu_sat_get_sdb_partition+0xc4/0x2d0 [windfarm_smu_sat]
      [<000000003010fcb7>] .pm112_wf_notify+0x104c/0x13bc [windfarm_pm112]
      [<00000000b958b2dd>] .notifier_call_chain+0xa8/0x180
      [<0000000070490868>] .blocking_notifier_call_chain+0x64/0x90
      [<00000000131d8149>] .wf_thread_func+0x114/0x1a0
      [<000000000d54838d>] .kthread+0x13c/0x190
      [<00000000669b72bc>] .ret_from_kernel_thread+0x58/0x64
  unreferenced object 0xc0000004737089f0 (size 16):
    comm "kwindfarm", pid 203, jiffies 4294880879 (age 5552.050s)
    hex dump (first 16 bytes):
      c4 04 01 7f 22 11 e0 e6 ff 55 7b 12 ec 11 00 00  ...."....U{.....
    backtrace:
      [<0000000083f0a65c>] .smu_sat_get_sdb_partition+0xc4/0x2d0 [windfarm_smu_sat]
      [<00000000b94ef7e1>] .pm112_wf_notify+0x1294/0x13bc [windfarm_pm112]
      [<00000000b958b2dd>] .notifier_call_chain+0xa8/0x180
      [<0000000070490868>] .blocking_notifier_call_chain+0x64/0x90
      [<00000000131d8149>] .wf_thread_func+0x114/0x1a0
      [<000000000d54838d>] .kthread+0x13c/0x190
      [<00000000669b72bc>] .ret_from_kernel_thread+0x58/0x64

Fix it by rearranging the logic so we deal with each buffer
separately, which then makes it easy to free the buffer once we're
done with it.

Fixes: ac171c46667c ("[PATCH] powerpc: Thermal control for dual core G5s")
Cc: stable@vger.kernel.org # v2.6.16+
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Tested-by: Erhard F. <erhard_f@mailbox.org>
Link: https://lore.kernel.org/r/20200423060038.3308530-1-mpe@ellerman.id.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/macintosh/windfarm_pm112.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/drivers/macintosh/windfarm_pm112.c
+++ b/drivers/macintosh/windfarm_pm112.c
@@ -132,14 +132,6 @@ static int create_cpu_loop(int cpu)
 	s32 tmax;
 	int fmin;
 
-	/* Get PID params from the appropriate SAT */
-	hdr = smu_sat_get_sdb_partition(chip, 0xC8 + core, NULL);
-	if (hdr == NULL) {
-		printk(KERN_WARNING"windfarm: can't get CPU PID fan config\n");
-		return -EINVAL;
-	}
-	piddata = (struct smu_sdbp_cpupiddata *)&hdr[1];
-
 	/* Get FVT params to get Tmax; if not found, assume default */
 	hdr = smu_sat_get_sdb_partition(chip, 0xC4 + core, NULL);
 	if (hdr) {
@@ -152,6 +144,16 @@ static int create_cpu_loop(int cpu)
 	if (tmax < cpu_all_tmax)
 		cpu_all_tmax = tmax;
 
+	kfree(hdr);
+
+	/* Get PID params from the appropriate SAT */
+	hdr = smu_sat_get_sdb_partition(chip, 0xC8 + core, NULL);
+	if (hdr == NULL) {
+		printk(KERN_WARNING"windfarm: can't get CPU PID fan config\n");
+		return -EINVAL;
+	}
+	piddata = (struct smu_sdbp_cpupiddata *)&hdr[1];
+
 	/*
 	 * Darwin has a minimum fan speed of 1000 rpm for the 4-way and
 	 * 515 for the 2-way.  That appears to be overkill, so for now,
@@ -174,6 +176,9 @@ static int create_cpu_loop(int cpu)
 		pid.min = fmin;
 
 	wf_cpu_pid_init(&cpu_pid[cpu], &pid);
+
+	kfree(hdr);
+
 	return 0;
 }
 


