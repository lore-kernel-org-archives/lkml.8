Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8B9C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD6A2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S6Q0CQKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgBDG0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 01:26:54 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34448 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgBDG0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:26:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id j7so6852503plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 22:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/MsxSmnO7M1aByaqdtSVpeD8wIEt+sQjjgWd9Bkhj/g=;
        b=S6Q0CQKR3fVspRKvuT2ptfzz6GbxzKVj0PKG68oupJtciOGMUNudcyHDhv7cj30l1j
         bF93mn58x6pBBjRx0NQkrW9bQk2ldum33amfgyU0R1qyiqAbKSbrXBWa24idtumn83bT
         37ZxLM5/m+LGiNh4kJE1LWtKmeopmiuVz6oBbmIw+KfJB8s/KxuKub/0+oQ9tYEe+eBL
         vYRNTff02LCAZn09D+YsuhEZnGC6zSiBR8GIWlwEk4kBRHMBqcgDn6dRMulbuoyx575Q
         CAyHaRaQSBbDmkELf+AZPswoP2lk5Xm0DQJmXFLy6IBG6Sfp9ZYcPQ/r0QMINaDnoEzt
         X/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/MsxSmnO7M1aByaqdtSVpeD8wIEt+sQjjgWd9Bkhj/g=;
        b=Gf3Rjx3OmHs5B/q58FguzU2EhvD10oLN0o4cI6K+PQxr9u1uMKy4DSkEO8a6/Qg35B
         0I2WJ6A2apjRLAglpmmACP8cnXv58v/5SDS/L5VK9yFOanOqz7jtFrX/1W+bBOEkYCRT
         JzVebfms2ePGK7pDUAmXuy+2MpyfOvSpxjWsbfD4mtQU1dTsISOyZI99lC2tNcnDC9Ds
         bFkYB4mOUy7lCn2Esq0ll/lkVNVxDLJHSu40heQMH0XTTfI5zomZrmCWg+UnkAxHxkQB
         q3+sInWjmjtcEgcYF+jMbSuSEjDhKxSdavLIVnYVQvvpPmEf0nYvaDha3vvE0qzaQe8I
         J0ng==
X-Gm-Message-State: APjAAAXusBlcqRYaS91AsJqNzEEKNPnEKbGJaf/DZrYzMKTGIvNgg02F
        Y1V7Kiz18c5Pr8VRjr+RF3dEww==
X-Google-Smtp-Source: APXvYqxKkro5twpTQ9itRoSve2PlhishCNJxxMdJWRAsjZZmKPt5Q4nhB9pYJ2/ctSPWS2471D1lmA==
X-Received: by 2002:a17:90a:8001:: with SMTP id b1mr4211344pjn.39.1580797607810;
        Mon, 03 Feb 2020 22:26:47 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l69sm6901897pgd.1.2020.02.03.22.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 22:26:47 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v3 2/2] remoteproc: qcom_q6v5_mss: Validate each segment during loading
Date:   Mon,  3 Feb 2020 22:26:41 -0800
Message-Id: <20200204062641.393949-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200204062641.393949-1-bjorn.andersson@linaro.org>
References: <20200204062641.393949-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code used to sync with the MBA after each segment loaded and this is
still what's done downstream. So reduce the delta towards downstream by
switching to a model where the content is iteratively validated.

Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Tested-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Tested-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Picked up Luca's t-b

 drivers/remoteproc/qcom_q6v5_mss.c | 76 ++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 25 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 25c03a26bf88..5eb154f221a4 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -360,23 +360,29 @@ static void q6v5_pds_disable(struct q6v5 *qproc, struct device **pds,
 }
 
 static int q6v5_xfer_mem_ownership(struct q6v5 *qproc, int *current_perm,
-				   bool remote_owner, phys_addr_t addr,
+				   bool local, bool remote, phys_addr_t addr,
 				   size_t size)
 {
-	struct qcom_scm_vmperm next;
+	struct qcom_scm_vmperm next[2];
+	int perms = 0;
 
 	if (!qproc->need_mem_protection)
 		return 0;
-	if (remote_owner && *current_perm == BIT(QCOM_SCM_VMID_MSS_MSA))
-		return 0;
-	if (!remote_owner && *current_perm == BIT(QCOM_SCM_VMID_HLOS))
-		return 0;
 
-	next.vmid = remote_owner ? QCOM_SCM_VMID_MSS_MSA : QCOM_SCM_VMID_HLOS;
-	next.perm = remote_owner ? QCOM_SCM_PERM_RW : QCOM_SCM_PERM_RWX;
+	if (local) {
+		next[perms].vmid = QCOM_SCM_VMID_HLOS;
+		next[perms].perm = QCOM_SCM_PERM_RWX;
+		perms++;
+	}
+
+	if (remote) {
+		next[perms].vmid = QCOM_SCM_VMID_MSS_MSA;
+		next[perms].perm = QCOM_SCM_PERM_RW;
+		perms++;
+	}
 
 	return qcom_scm_assign_mem(addr, ALIGN(size, SZ_4K),
-				   current_perm, &next, 1);
+				   current_perm, next, perms);
 }
 
 static int q6v5_load(struct rproc *rproc, const struct firmware *fw)
@@ -693,7 +699,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw)
 
 	/* Hypervisor mapping to access metadata by modem */
 	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
-	ret = q6v5_xfer_mem_ownership(qproc, &mdata_perm, true, phys, size);
+	ret = q6v5_xfer_mem_ownership(qproc, &mdata_perm, false, true, phys, size);
 	if (ret) {
 		dev_err(qproc->dev,
 			"assigning Q6 access to metadata failed: %d\n", ret);
@@ -711,7 +717,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw)
 		dev_err(qproc->dev, "MPSS header authentication failed: %d\n", ret);
 
 	/* Metadata authentication done, remove modem access */
-	xferop_ret = q6v5_xfer_mem_ownership(qproc, &mdata_perm, false, phys, size);
+	xferop_ret = q6v5_xfer_mem_ownership(qproc, &mdata_perm, true, false, phys, size);
 	if (xferop_ret)
 		dev_warn(qproc->dev,
 			 "mdt buffer not reclaimed system may become unstable\n");
@@ -798,7 +804,7 @@ static int q6v5_mba_load(struct q6v5 *qproc)
 	}
 
 	/* Assign MBA image access in DDR to q6 */
-	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, true,
+	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, false, true,
 				      qproc->mba_phys, qproc->mba_size);
 	if (ret) {
 		dev_err(qproc->dev,
@@ -832,8 +838,8 @@ static int q6v5_mba_load(struct q6v5 *qproc)
 	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_nc);
 
 reclaim_mba:
-	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, false,
-						qproc->mba_phys,
+	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, true,
+						false, qproc->mba_phys,
 						qproc->mba_size);
 	if (xfermemop_ret) {
 		dev_err(qproc->dev,
@@ -900,7 +906,7 @@ static void q6v5_mba_reclaim(struct q6v5 *qproc)
 	/* In case of failure or coredump scenario where reclaiming MBA memory
 	 * could not happen reclaim it here.
 	 */
-	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, false,
+	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, true, false,
 				      qproc->mba_phys,
 				      qproc->mba_size);
 	WARN_ON(ret);
@@ -927,6 +933,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	phys_addr_t boot_addr;
 	phys_addr_t min_addr = PHYS_ADDR_MAX;
 	phys_addr_t max_addr = 0;
+	u32 code_length;
 	bool relocate = false;
 	char *fw_name;
 	size_t fw_name_len;
@@ -977,9 +984,19 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	}
 
 	/* Try to reset ownership back to Linux */
-	q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, false,
+	q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, true, false,
 				qproc->mpss_phys, qproc->mpss_size);
 
+	/* Share ownership between Linux and MSS, during segment loading */
+	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, true, true,
+				      qproc->mpss_phys, qproc->mpss_size);
+	if (ret) {
+		dev_err(qproc->dev,
+			"assigning Q6 access to mpss memory failed: %d\n", ret);
+		ret = -EAGAIN;
+		goto release_firmware;
+	}
+
 	mpss_reloc = relocate ? min_addr : qproc->mpss_phys;
 	qproc->mpss_reloc = mpss_reloc;
 	/* Load firmware segments */
@@ -1028,10 +1045,24 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 			       phdr->p_memsz - phdr->p_filesz);
 		}
 		size += phdr->p_memsz;
+
+		code_length = readl(qproc->rmb_base + RMB_PMI_CODE_LENGTH_REG);
+		if (!code_length) {
+			boot_addr = relocate ? qproc->mpss_phys : min_addr;
+			writel(boot_addr, qproc->rmb_base + RMB_PMI_CODE_START_REG);
+			writel(RMB_CMD_LOAD_READY, qproc->rmb_base + RMB_MBA_COMMAND_REG);
+		}
+		writel(size, qproc->rmb_base + RMB_PMI_CODE_LENGTH_REG);
+
+		ret = readl(qproc->rmb_base + RMB_MBA_STATUS_REG);
+		if (ret < 0) {
+			dev_err(qproc->dev, "MPSS authentication failed: %d\n", ret);
+			goto release_firmware;
+		}
 	}
 
 	/* Transfer ownership of modem ddr region to q6 */
-	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, true,
+	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, false, true,
 				      qproc->mpss_phys, qproc->mpss_size);
 	if (ret) {
 		dev_err(qproc->dev,
@@ -1040,11 +1071,6 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 		goto release_firmware;
 	}
 
-	boot_addr = relocate ? qproc->mpss_phys : min_addr;
-	writel(boot_addr, qproc->rmb_base + RMB_PMI_CODE_START_REG);
-	writel(RMB_CMD_LOAD_READY, qproc->rmb_base + RMB_MBA_COMMAND_REG);
-	writel(size, qproc->rmb_base + RMB_PMI_CODE_LENGTH_REG);
-
 	ret = q6v5_rmb_mba_wait(qproc, RMB_MBA_AUTH_COMPLETE, 10000);
 	if (ret == -ETIMEDOUT)
 		dev_err(qproc->dev, "MPSS authentication timed out\n");
@@ -1074,7 +1100,7 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
 		if (!ret) {
 			/* Try to reset ownership back to Linux */
 			ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm,
-						      false,
+						      true, false,
 						      qproc->mpss_phys,
 						      qproc->mpss_size);
 		}
@@ -1116,8 +1142,8 @@ static int q6v5_start(struct rproc *rproc)
 		goto reclaim_mpss;
 	}
 
-	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, false,
-						qproc->mba_phys,
+	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, true,
+						false, qproc->mba_phys,
 						qproc->mba_size);
 	if (xfermemop_ret)
 		dev_err(qproc->dev,
-- 
2.23.0

