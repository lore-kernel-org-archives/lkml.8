Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C748C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3222083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448701;
	bh=+vEkPhmzh426RGcTQdJbbQ/XsrAnTOgO/RTwQ9TiMLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=02Zaz8rfXEVhniM2D8o4KzA0PIw7aDhn7rfSm8TgUa/o+D5r0w/j4rB+N3E7A8kEy
	 wIjhlPyQE6NE3B/HRLadTjCqT/j7PVzsMU97o7P5AMdcP5GBfLc9zlmigjFZ1w+C8q
	 72QHakzAXfKA+NzgXhJR+V/9UxA5eaEDkjmMG0NM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgFRCvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbgFRBI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:08:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59CCF2193E;
        Thu, 18 Jun 2020 01:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442536;
        bh=+vEkPhmzh426RGcTQdJbbQ/XsrAnTOgO/RTwQ9TiMLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XB5VoAs5UDwYPA025H4ZEJmUKVi6o6hno/8pTsZsFauLC8L9yzgVyOkV/eAOXS0Pr
         LBRmqFctnQ1ri5t4ASMhy9iLtytKwiEhF+4sX/YJwttgjpHKB1QyGO4W2vHALftICo
         IdyMW9Hru6g8WXfJ9eZNoGv1VJiFyS0zjseJWphU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 038/388] remoteproc: qcom_q6v5_mss: map/unmap mpss segments before/after use
Date:   Wed, 17 Jun 2020 21:02:15 -0400
Message-Id: <20200618010805.600873-38-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

[ Upstream commit be050a3429f46ecf13eb2b80f299479f8bb823fb ]

The application processor accessing the mpss region when the Q6 modem is
running will lead to an XPU violation. Fix this by un-mapping the mpss
segments post copy during mpss authentication and coredumps.

Tested-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Link: https://lore.kernel.org/r/20200415071619.6052-1-sibis@codeaurora.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 31 +++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 5475d4f808a8..22416e86a174 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1156,7 +1156,13 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 			goto release_firmware;
 		}
 
-		ptr = qproc->mpss_region + offset;
+		ptr = ioremap_wc(qproc->mpss_phys + offset, phdr->p_memsz);
+		if (!ptr) {
+			dev_err(qproc->dev,
+				"unable to map memory region: %pa+%zx-%x\n",
+				&qproc->mpss_phys, offset, phdr->p_memsz);
+			goto release_firmware;
+		}
 
 		if (phdr->p_filesz && phdr->p_offset < fw->size) {
 			/* Firmware is large enough to be non-split */
@@ -1165,6 +1171,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 					"failed to load segment %d from truncated file %s\n",
 					i, fw_name);
 				ret = -EINVAL;
+				iounmap(ptr);
 				goto release_firmware;
 			}
 
@@ -1175,6 +1182,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 			ret = request_firmware(&seg_fw, fw_name, qproc->dev);
 			if (ret) {
 				dev_err(qproc->dev, "failed to load %s\n", fw_name);
+				iounmap(ptr);
 				goto release_firmware;
 			}
 
@@ -1187,6 +1195,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 			memset(ptr + phdr->p_filesz, 0,
 			       phdr->p_memsz - phdr->p_filesz);
 		}
+		iounmap(ptr);
 		size += phdr->p_memsz;
 
 		code_length = readl(qproc->rmb_base + RMB_PMI_CODE_LENGTH_REG);
@@ -1236,7 +1245,8 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
 	int ret = 0;
 	struct q6v5 *qproc = rproc->priv;
 	unsigned long mask = BIT((unsigned long)segment->priv);
-	void *ptr = rproc_da_to_va(rproc, segment->da, segment->size);
+	int offset = segment->da - qproc->mpss_reloc;
+	void *ptr = NULL;
 
 	/* Unlock mba before copying segments */
 	if (!qproc->dump_mba_loaded) {
@@ -1250,10 +1260,15 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
 		}
 	}
 
-	if (!ptr || ret)
-		memset(dest, 0xff, segment->size);
-	else
+	if (!ret)
+		ptr = ioremap_wc(qproc->mpss_phys + offset, segment->size);
+
+	if (ptr) {
 		memcpy(dest, ptr, segment->size);
+		iounmap(ptr);
+	} else {
+		memset(dest, 0xff, segment->size);
+	}
 
 	qproc->dump_segment_mask |= mask;
 
@@ -1595,12 +1610,6 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
 
 	qproc->mpss_phys = qproc->mpss_reloc = r.start;
 	qproc->mpss_size = resource_size(&r);
-	qproc->mpss_region = devm_ioremap_wc(qproc->dev, qproc->mpss_phys, qproc->mpss_size);
-	if (!qproc->mpss_region) {
-		dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n",
-			&r.start, qproc->mpss_size);
-		return -EBUSY;
-	}
 
 	return 0;
 }
-- 
2.25.1

