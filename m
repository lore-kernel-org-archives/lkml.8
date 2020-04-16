Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9204C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C878520786
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587045616;
	bh=xGr13XJGLUS/LaE43iRBCiEAnAPKV75jLFypsS8T3w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nl0Q8IAT3YFi1U9dcNZ5juLFgpwY/YCiEUwvWF3r28tOz1Y+g6UhzN//cCYuAq5cX
	 p/q9DJZ7PX39PHxwF7AvOvtq3anAyZ1PO2LLVmWimaUs41WyJeTXS1nGplxHUUwfRi
	 CBRuKrCkpAli+N4vjCTC8cQxi+50MP1XBNhF1rzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbgDPOAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898078AbgDPNkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:40:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1646F2222C;
        Thu, 16 Apr 2020 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044414;
        bh=xGr13XJGLUS/LaE43iRBCiEAnAPKV75jLFypsS8T3w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ci5HX4DR/5Pp5mI94YZ4N2J+QY3vYu5BvXFJKS0eHcDP4HrZSNt6fO+pXpkeZhNX
         VCRXZfY7f7MXF045DuHdiQmQFpQaTisLOG74VUf6IuLYKdwf5NOMsma8kWOGd/q57S
         YEYCsfAgWHpJLk9IvDw1Dzmf5qyAHdf1eAjW6vkM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 5.5 167/257] remoteproc: qcom_q6v5_mss: Dont reassign mpss region on shutdown
Date:   Thu, 16 Apr 2020 15:23:38 +0200
Message-Id: <20200416131347.362917342@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit 900fc60df22748dbc28e4970838e8f7b8f1013ce upstream.

Trying to reclaim mpss memory while the mba is not running causes the
system to crash on devices with security fuses blown, so leave it
assigned to the remote on shutdown and recover it on a subsequent boot.

Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem ownership switch")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20200304194729.27979-2-sibis@codeaurora.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/remoteproc/qcom_q6v5_mss.c |   35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -887,11 +887,6 @@ static void q6v5_mba_reclaim(struct q6v5
 		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
 	}
 
-	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm,
-				      false, qproc->mpss_phys,
-				      qproc->mpss_size);
-	WARN_ON(ret);
-
 	q6v5_reset_assert(qproc);
 
 	q6v5_clk_disable(qproc->dev, qproc->reset_clks,
@@ -981,6 +976,14 @@ static int q6v5_mpss_load(struct q6v5 *q
 			max_addr = ALIGN(phdr->p_paddr + phdr->p_memsz, SZ_4K);
 	}
 
+	/**
+	 * In case of a modem subsystem restart on secure devices, the modem
+	 * memory can be reclaimed only after MBA is loaded. For modem cold
+	 * boot this will be a nop
+	 */
+	q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, false,
+				qproc->mpss_phys, qproc->mpss_size);
+
 	mpss_reloc = relocate ? min_addr : qproc->mpss_phys;
 	qproc->mpss_reloc = mpss_reloc;
 	/* Load firmware segments */
@@ -1070,8 +1073,16 @@ static void qcom_q6v5_dump_segment(struc
 	void *ptr = rproc_da_to_va(rproc, segment->da, segment->size);
 
 	/* Unlock mba before copying segments */
-	if (!qproc->dump_mba_loaded)
+	if (!qproc->dump_mba_loaded) {
 		ret = q6v5_mba_load(qproc);
+		if (!ret) {
+			/* Reset ownership back to Linux to copy segments */
+			ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm,
+						      false,
+						      qproc->mpss_phys,
+						      qproc->mpss_size);
+		}
+	}
 
 	if (!ptr || ret)
 		memset(dest, 0xff, segment->size);
@@ -1082,8 +1093,14 @@ static void qcom_q6v5_dump_segment(struc
 
 	/* Reclaim mba after copying segments */
 	if (qproc->dump_segment_mask == qproc->dump_complete_mask) {
-		if (qproc->dump_mba_loaded)
+		if (qproc->dump_mba_loaded) {
+			/* Try to reset ownership back to Q6 */
+			q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm,
+						true,
+						qproc->mpss_phys,
+						qproc->mpss_size);
 			q6v5_mba_reclaim(qproc);
+		}
 	}
 }
 
@@ -1123,10 +1140,6 @@ static int q6v5_start(struct rproc *rpro
 	return 0;
 
 reclaim_mpss:
-	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm,
-						false, qproc->mpss_phys,
-						qproc->mpss_size);
-	WARN_ON(xfermemop_ret);
 	q6v5_mba_reclaim(qproc);
 
 	return ret;


