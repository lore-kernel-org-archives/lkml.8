Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBCDC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D362072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgHYE4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:56:51 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:38442 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728089AbgHYE4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:56:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5B1DE182CED2A;
        Tue, 25 Aug 2020 04:56:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cover96_0806a5227059
X-Filterd-Recvd-Size: 3208
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:56:44 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, Robert Richter <rric@kernel.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, oprofile-list@lists.sf.net
Subject: [PATCH 02/29] alpha: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:55:59 -0700
Message-Id: <4facd57f80c70437f085ba3a1bcf13ae0b63c3bc.1598331148.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/alpha/kernel/pci_iommu.c      |  8 +++++---
 arch/alpha/oprofile/op_model_ev4.c | 22 ++++++++++++++--------
 arch/alpha/oprofile/op_model_ev5.c |  8 +++++---
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 81037907268d..b8af7ad6c607 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -161,10 +161,12 @@ iommu_arena_find_pages(struct device *dev, struct pci_iommu_arena *arena,
 			goto again;
 		}
 
-		if (ptes[p+i])
-			p = ALIGN(p + i + 1, mask + 1), i = 0;
-		else
+		if (ptes[p+i]) {
+			p = ALIGN(p + i + 1, mask + 1);
+			i = 0;
+		} else {
 			i = i + 1;
+		}
 	}
 
 	if (i < n) {
diff --git a/arch/alpha/oprofile/op_model_ev4.c b/arch/alpha/oprofile/op_model_ev4.c
index 086a0d5445c5..004f80a4291f 100644
--- a/arch/alpha/oprofile/op_model_ev4.c
+++ b/arch/alpha/oprofile/op_model_ev4.c
@@ -46,18 +46,24 @@ ev4_reg_setup(struct op_register_config *reg,
 	   map it onto one of the possible values, and write it back.  */
 
 	count = ctr[0].count;
-	if (count <= 4096)
-		count = 4096, hilo = 1;
-	else
-		count = 65536, hilo = 0;
+	if (count <= 4096) {
+		count = 4096;
+		hilo = 1;
+	} else {
+		count = 65536;
+		hilo = 0;
+	}
 	ctr[0].count = count;
 	ctl |= (ctr[0].enabled && hilo) << 3;
 
 	count = ctr[1].count;
-	if (count <= 256)
-		count = 256, hilo = 1;
-	else
-		count = 4096, hilo = 0;
+	if (count <= 256) {
+		count = 256;
+		hilo = 1;
+	} else {
+		count = 4096;
+		hilo = 0;
+	}
 	ctr[1].count = count;
 	ctl |= (ctr[1].enabled && hilo);
 
diff --git a/arch/alpha/oprofile/op_model_ev5.c b/arch/alpha/oprofile/op_model_ev5.c
index c300f5ef3482..6f52244e1181 100644
--- a/arch/alpha/oprofile/op_model_ev5.c
+++ b/arch/alpha/oprofile/op_model_ev5.c
@@ -92,9 +92,11 @@ common_reg_setup(struct op_register_config *reg,
 		if (!ctr[i].enabled)
 			continue;
 
-		if (count <= 256)
-			count = 256, hilo = 3, max = 256;
-		else {
+		if (count <= 256) {
+			max = 256;
+			hilo = 3;
+			count = 256;
+		} else {
 			max = (i == 2 ? 16384 : 65536);
 			hilo = 2;
 			if (count > max)
-- 
2.26.0

