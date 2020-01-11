Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541D3C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2202077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736653;
	bh=XeHyWWEnQOTi2O9lBiQmY2LxGna8vP21Mi46u6Rip+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rmq/16SZXoaHzEa5/JWvHcXxjVJDWQD/hv+mvhjT9UEgfghrfn1tLv9MzJuEjGU4L
	 eF99EbsPp00tCoT7+yyLejHEbJ+jgtrAZFPTaEeLjOYhrUDz9zWRn4oBLIhjp6KfnQ
	 +CRw2/ndbr2yZ9xTOIRl/zVMemCtsSHpxkil21Js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgAKJ5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbgAKJ5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:57:31 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB9A2077C;
        Sat, 11 Jan 2020 09:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736650;
        bh=XeHyWWEnQOTi2O9lBiQmY2LxGna8vP21Mi46u6Rip+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGu6XO/wlpz4RuMi1UDdZuIjQDoMPMoVLcxrDpdySSorzj9lE8+cUwSN8fKPFqNvy
         WvfKbCG0aOCuvdAKKndwV6GzpP9sB2kdqoj/tnJqXvNP2r4xRoDFTJV0IFDwCtcEBf
         o5lM5ZTI3ClgcA5+xoo498IsDYplKiXbfg81oGUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 40/59] bnx2x: Do not handle requests from VFs after parity
Date:   Sat, 11 Jan 2020 10:49:49 +0100
Message-Id: <20200111094846.118726829@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094835.417654274@linuxfoundation.org>
References: <20200111094835.417654274@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Chopra <manishc@marvell.com>

[ Upstream commit 7113f796bbbced2470cd6d7379d50d7a7a78bf34 ]

Parity error from the hardware will cause PF to lose the state
of their VFs due to PF's internal reload and hardware reset following
the parity error. Restrict any configuration request from the VFs after
the parity as it could cause unexpected hardware behavior, only way
for VFs to recover would be to trigger FLR on VFs and reload them.

Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 12 ++++++++++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h |  1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c  | 12 ++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 82960603da33..026c72e62c18 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9942,10 +9942,18 @@ static void bnx2x_recovery_failed(struct bnx2x *bp)
  */
 static void bnx2x_parity_recover(struct bnx2x *bp)
 {
-	bool global = false;
 	u32 error_recovered, error_unrecovered;
-	bool is_parity;
+	bool is_parity, global = false;
+#ifdef CONFIG_BNX2X_SRIOV
+	int vf_idx;
+
+	for (vf_idx = 0; vf_idx < bp->requested_nr_virtfn; vf_idx++) {
+		struct bnx2x_virtf *vf = BP_VF(bp, vf_idx);
 
+		if (vf)
+			vf->state = VF_LOST;
+	}
+#endif
 	DP(NETIF_MSG_HW, "Handling parity\n");
 	while (1) {
 		switch (bp->recovery_state) {
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h
index 6f6f13dc2be3..ab8339594cd3 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h
@@ -139,6 +139,7 @@ struct bnx2x_virtf {
 #define VF_ACQUIRED	1	/* VF acquired, but not initialized */
 #define VF_ENABLED	2	/* VF Enabled */
 #define VF_RESET	3	/* VF FLR'd, pending cleanup */
+#define VF_LOST		4	/* Recovery while VFs are loaded */
 
 	bool flr_clnup_stage;	/* true during flr cleanup */
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
index a12a4236b143..e9fc3b09dba8 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
@@ -2095,6 +2095,18 @@ static void bnx2x_vf_mbx_request(struct bnx2x *bp, struct bnx2x_virtf *vf,
 {
 	int i;
 
+	if (vf->state == VF_LOST) {
+		/* Just ack the FW and return if VFs are lost
+		 * in case of parity error. VFs are supposed to be timedout
+		 * on waiting for PF response.
+		 */
+		DP(BNX2X_MSG_IOV,
+		   "VF 0x%x lost, not handling the request\n", vf->abs_vfid);
+
+		storm_memset_vf_mbx_ack(bp, vf->abs_vfid);
+		return;
+	}
+
 	/* check if tlv type is known */
 	if (bnx2x_tlv_supported(mbx->first_tlv.tl.type)) {
 		/* Lock the per vf op mutex and note the locker's identity.
-- 
2.20.1



