Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4F8C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2191A21655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgCKFHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:07:39 -0400
Received: from smtprelay0201.hostedemail.com ([216.40.44.201]:51848 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728314AbgCKFHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:07:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 0AD4410194079;
        Wed, 11 Mar 2020 05:07:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: flag51_245cc6c4f8053
X-Filterd-Recvd-Size: 2301
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:07:29 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 022/491] X86 MCE INFRASTRUCTURE: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:36 -0700
Message-Id: <1dbc36979b08577a2d589b7fe572f83aadf7b5ef.1583896349.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/x86/kernel/cpu/mce/inject.c | 2 +-
 arch/x86/kernel/cpu/mce/intel.c  | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 3413b41..b5e3bab 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -199,7 +199,7 @@ static int raise_local(void)
 			 * calling irq_enter, but the necessary
 			 * machinery isn't exported currently.
 			 */
-			/*FALL THROUGH*/
+			fallthrough;
 		case MCJ_CTX_PROCESS:
 			raise_exception(m, NULL);
 			break;
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index d8f9230..5be647 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -192,9 +192,7 @@ unsigned long cmci_intel_adjust_timer(unsigned long interval)
 		__this_cpu_write(cmci_storm_state, CMCI_STORM_SUBSIDED);
 		if (!atomic_sub_return(1, &cmci_storm_on_cpus))
 			pr_notice("CMCI storm subsided: switching to interrupt mode\n");
-
-		/* FALLTHROUGH */
-
+		fallthrough;
 	case CMCI_STORM_SUBSIDED:
 		/*
 		 * We wait for all CPUs to go back to SUBSIDED state. When that
-- 
2.24.0

