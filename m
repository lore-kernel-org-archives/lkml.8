Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A948C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E752076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046290;
	bh=vHr6g5MwzQjKMd6VRdS/hjjFnOfpLL/Nb7slM5ESHiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l7qO0Lcoeb44wXQOOP8YgxiYppX0/Ko3i7Y/U8oMiZSIEj++n0L+JL+VPVJ0vd9ai
	 SYdohZjJZg2/p0dny2OZekiyW+efGb+4Lr58YtJ0auSzMat7J+IfBSz9kkMC7osQbF
	 cdyh0ohVwtqy24eN/TeoMjCNhYXn3wj6CxhfyK+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbgDPOL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898656AbgDPNrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:47:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6697121734;
        Thu, 16 Apr 2020 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044835;
        bh=vHr6g5MwzQjKMd6VRdS/hjjFnOfpLL/Nb7slM5ESHiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOfowzlTB+yf2rJ4dmrVwwwotZcl5AtLtoIjUSxl0kdhfsZ58IWeBy3hlV4aIDwnj
         5H/Hwyq3sOY8i2WGo+/qHcaWrlI1+CQbZM5YFuWv0pderE5SnI4yeTVwNdw7uGCpfj
         8qf1vd0fcsmS7DSCfRQI9gPsOesamvD8dUZu6hyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.4 120/232] x86/tsc_msr: Use named struct initializers
Date:   Thu, 16 Apr 2020 15:23:34 +0200
Message-Id: <20200416131330.114238768@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 812c2d7506fde7cdf83cb2532810a65782b51741 upstream.

Use named struct initializers for the freq_desc struct-s initialization
and change the "u8 msr_plat" to a "bool use_msr_plat" to make its meaning
more clear instead of relying on a comment to explain it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20200223140610.59612-1-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/tsc_msr.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -22,10 +22,10 @@
  * read in MSR_PLATFORM_ID[12:8], otherwise in MSR_PERF_STAT[44:40].
  * Unfortunately some Intel Atom SoCs aren't quite compliant to this,
  * so we need manually differentiate SoC families. This is what the
- * field msr_plat does.
+ * field use_msr_plat does.
  */
 struct freq_desc {
-	u8 msr_plat;	/* 1: use MSR_PLATFORM_INFO, 0: MSR_IA32_PERF_STATUS */
+	bool use_msr_plat;
 	u32 freqs[MAX_NUM_FREQS];
 };
 
@@ -35,31 +35,39 @@ struct freq_desc {
  * by MSR based on SDM.
  */
 static const struct freq_desc freq_desc_pnw = {
-	0, { 0, 0, 0, 0, 0, 99840, 0, 83200 }
+	.use_msr_plat = false,
+	.freqs = { 0, 0, 0, 0, 0, 99840, 0, 83200 },
 };
 
 static const struct freq_desc freq_desc_clv = {
-	0, { 0, 133200, 0, 0, 0, 99840, 0, 83200 }
+	.use_msr_plat = false,
+	.freqs = { 0, 133200, 0, 0, 0, 99840, 0, 83200 },
 };
 
 static const struct freq_desc freq_desc_byt = {
-	1, { 83300, 100000, 133300, 116700, 80000, 0, 0, 0 }
+	.use_msr_plat = true,
+	.freqs = { 83300, 100000, 133300, 116700, 80000, 0, 0, 0 },
 };
 
 static const struct freq_desc freq_desc_cht = {
-	1, { 83300, 100000, 133300, 116700, 80000, 93300, 90000, 88900, 87500 }
+	.use_msr_plat = true,
+	.freqs = { 83300, 100000, 133300, 116700, 80000, 93300, 90000,
+		   88900, 87500 },
 };
 
 static const struct freq_desc freq_desc_tng = {
-	1, { 0, 100000, 133300, 0, 0, 0, 0, 0 }
+	.use_msr_plat = true,
+	.freqs = { 0, 100000, 133300, 0, 0, 0, 0, 0 },
 };
 
 static const struct freq_desc freq_desc_ann = {
-	1, { 83300, 100000, 133300, 100000, 0, 0, 0, 0 }
+	.use_msr_plat = true,
+	.freqs = { 83300, 100000, 133300, 100000, 0, 0, 0, 0 },
 };
 
 static const struct freq_desc freq_desc_lgm = {
-	1, { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 }
+	.use_msr_plat = true,
+	.freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 },
 };
 
 static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
@@ -91,7 +99,7 @@ unsigned long cpu_khz_from_msr(void)
 		return 0;
 
 	freq_desc = (struct freq_desc *)id->driver_data;
-	if (freq_desc->msr_plat) {
+	if (freq_desc->use_msr_plat) {
 		rdmsr(MSR_PLATFORM_INFO, lo, hi);
 		ratio = (lo >> 8) & 0xff;
 	} else {


