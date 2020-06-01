Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0F4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373E8206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgFAJb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:31:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:45276 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFAJb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:31:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 059DAAEFE;
        Mon,  1 Jun 2020 09:31:25 +0000 (UTC)
Date:   Mon, 1 Jun 2020 11:31:13 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode for 5.8
Message-ID: <20200601093113.GA30795@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

just a single fix this time. Please pull,

thx.

---
The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_5.8

for you to fetch changes up to 9adbf3c609af92a57a73000a3cb8f4c2d307dfa3:

  x86/microcode: Fix return value for microcode late loading (2020-04-22 19:55:50 +0200)

----------------------------------------------------------------
A single fix for late microcode loading to handle the correct return
value from stop_machine(), from Mihai Carabas.

----------------------------------------------------------------
Mihai Carabas (1):
      x86/microcode: Fix return value for microcode late loading

 arch/x86/kernel/cpu/microcode/core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7019d4b2df0c..baec68b7e010 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -545,8 +545,7 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
 /*
  * Returns:
  * < 0 - on error
- *   0 - no update done
- *   1 - microcode was updated
+ *   0 - success (no update done or microcode was updated)
  */
 static int __reload_late(void *info)
 {
@@ -573,11 +572,11 @@ static int __reload_late(void *info)
 	else
 		goto wait_for_siblings;
 
-	if (err > UCODE_NFOUND) {
-		pr_warn("Error reloading microcode on CPU %d\n", cpu);
+	if (err >= UCODE_NFOUND) {
+		if (err == UCODE_ERROR)
+			pr_warn("Error reloading microcode on CPU %d\n", cpu);
+
 		ret = -1;
-	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
-		ret = 1;
 	}
 
 wait_for_siblings:
@@ -608,7 +607,7 @@ static int microcode_reload_late(void)
 	atomic_set(&late_cpus_out, 0);
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
-	if (ret > 0)
+	if (ret == 0)
 		microcode_check();
 
 	pr_info("Reload completed, microcode revision: 0x%x\n", boot_cpu_data.microcode);
@@ -649,7 +648,7 @@ static ssize_t reload_store(struct device *dev,
 put:
 	put_online_cpus();
 
-	if (ret >= 0)
+	if (ret == 0)
 		ret = size;
 
 	return ret;

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
