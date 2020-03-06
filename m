Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E12C10F26
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E4A206E2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YRsSIbpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgCGAAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:00:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44617 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCGAAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:00:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id n24so1786847pgk.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 16:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fa535hrpTpxZVWC2jXEsXv4d9XUZa691SL9SgolYs4Y=;
        b=YRsSIbpMAkMDVgwzUvqYgt5Pw2FWe38K7hVWxuT56wcYfjeSCrGFticDa/8sZo8SrP
         muEqQOjyKmXZDNM5RUGBdpKKU4Dx8lFk9b59ItnlKq08BTRHOfFL/OKdsXhnD/O7Phtr
         nZUnQAxr/+hYCGdRZl8k2U7iNsQroUXrOX19w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fa535hrpTpxZVWC2jXEsXv4d9XUZa691SL9SgolYs4Y=;
        b=HGVTcoI4uwBmbsBRJaHm//HUdpxWhA0LmHTXz9iaTT78GLlNNCBZNOvYJo95rN7FuE
         hcezzNArL3t7NSxY6zxgCEAgihCObs6MUC1nADvqFeKKaz1WOhIH/B6eGuEnkMUoNTTH
         WgAM0TMokaYLomdnlEPhOHX2tqKc4x3vr6PupGtAAekZV5NbwiRLQTkRdx4NfIq3MRWf
         QmKBtfDwMyjt2E8frwI0+jZHnzg4D01BxfrhpMvV7LB6pKqIvyFiS52j7k1CbwsPcY1Z
         88iq2HOZzR2fRRK5XXt5JRc5ZP+SuNG3qr0YtwBTIBt6AQWLy8u9ISa2/8Nq7P2zroOG
         AdvA==
X-Gm-Message-State: ANhLgQ0m+prDhideeyx7hjxRSu6KBdaMv8xK7fAfRwoVe5mEazo4vvUU
        l48IUIGQ6TU+ADdKqfAspaHvuA==
X-Google-Smtp-Source: ADFU+vuLg3Bqwh0pMdmhbZ2lf/7W/K+nOSsEUZ6rUJLzRWGPCGc0yXBD0jE1vPdLfE2P1yx40LUpLA==
X-Received: by 2002:a63:c643:: with SMTP id x3mr5167987pgg.299.1583539221779;
        Fri, 06 Mar 2020 16:00:21 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 9sm32302246pge.65.2020.03.06.16.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 16:00:21 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, mka@chromium.org,
        evgreen@chromium.org, swboyd@chromium.org,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH 1/9] drivers: qcom: rpmh-rsc: Clean code reading/writing regs/cmds
Date:   Fri,  6 Mar 2020 15:59:43 -0800
Message-Id: <20200306155707.RFT.1.I1b754137e8089e46cf33fc2ea270734ec3847ec4@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200306235951.214678-1-dianders@chromium.org>
References: <20200306235951.214678-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two changes, both of which should be no-ops:

1. Make read_tcs_reg() / read_tcs_cmd() symmetric to write_tcs_reg() /
   write_tcs_cmd().

2. Change the order of operations in the above functions to make it
   more obvious to me what the math is doing.  Specifically first you
   want to find the right TCS, then the right register, and then
   multiply by the command ID if necessary.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/soc/qcom/rpmh-rsc.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index e278fc11fe5c..5c88b8cd5bf8 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -61,28 +61,33 @@
 #define CMD_STATUS_ISSUED		BIT(8)
 #define CMD_STATUS_COMPL		BIT(16)
 
-static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
+static u32 read_tcs_cmd(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
 {
-	return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id +
+	return readl_relaxed(drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg +
 			     RSC_DRV_CMD_OFFSET * cmd_id);
 }
 
+static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id)
+{
+	return readl_relaxed(drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg);
+}
+
 static void write_tcs_cmd(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id,
 			  u32 data)
 {
-	writel_relaxed(data, drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id +
+	writel_relaxed(data, drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg +
 		       RSC_DRV_CMD_OFFSET * cmd_id);
 }
 
 static void write_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, u32 data)
 {
-	writel_relaxed(data, drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id);
+	writel_relaxed(data, drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg);
 }
 
 static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
 			       u32 data)
 {
-	writel(data, drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id);
+	writel(data, drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg);
 	for (;;) {
 		if (data == readl(drv->tcs_base + reg +
 				  RSC_DRV_TCS_OFFSET * tcs_id))
@@ -94,7 +99,7 @@ static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
 static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
 {
 	return !test_bit(tcs_id, drv->tcs_in_use) &&
-	       read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id, 0);
+	       read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id);
 }
 
 static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
@@ -212,7 +217,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 	const struct tcs_request *req;
 	struct tcs_cmd *cmd;
 
-	irq_status = read_tcs_reg(drv, RSC_DRV_IRQ_STATUS, 0, 0);
+	irq_status = read_tcs_reg(drv, RSC_DRV_IRQ_STATUS, 0);
 
 	for_each_set_bit(i, &irq_status, BITS_PER_LONG) {
 		req = get_req_from_tcs(drv, i);
@@ -226,7 +231,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 			u32 sts;
 
 			cmd = &req->cmds[j];
-			sts = read_tcs_reg(drv, RSC_DRV_CMD_STATUS, i, j);
+			sts = read_tcs_cmd(drv, RSC_DRV_CMD_STATUS, i, j);
 			if (!(sts & CMD_STATUS_ISSUED) ||
 			   ((req->wait_for_compl || cmd->wait) &&
 			   !(sts & CMD_STATUS_COMPL))) {
@@ -265,7 +270,7 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 	cmd_msgid |= msg->wait_for_compl ? CMD_MSGID_RESP_REQ : 0;
 	cmd_msgid |= CMD_MSGID_WRITE;
 
-	cmd_complete = read_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, tcs_id, 0);
+	cmd_complete = read_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, tcs_id);
 
 	for (i = 0, j = cmd_id; i < msg->num_cmds; i++, j++) {
 		cmd = &msg->cmds[i];
@@ -281,7 +286,7 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 	}
 
 	write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, tcs_id, cmd_complete);
-	cmd_enable |= read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id, 0);
+	cmd_enable |= read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id);
 	write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id, cmd_enable);
 }
 
@@ -294,7 +299,7 @@ static void __tcs_trigger(struct rsc_drv *drv, int tcs_id)
 	 * While clearing ensure that the AMC mode trigger is cleared
 	 * and then the mode enable is cleared.
 	 */
-	enable = read_tcs_reg(drv, RSC_DRV_CONTROL, tcs_id, 0);
+	enable = read_tcs_reg(drv, RSC_DRV_CONTROL, tcs_id);
 	enable &= ~TCS_AMC_MODE_TRIGGER;
 	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
 	enable &= ~TCS_AMC_MODE_ENABLE;
@@ -319,10 +324,10 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
 		if (tcs_is_free(drv, tcs_id))
 			continue;
 
-		curr_enabled = read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id, 0);
+		curr_enabled = read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id);
 
 		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
-			addr = read_tcs_reg(drv, RSC_DRV_CMD_ADDR, tcs_id, j);
+			addr = read_tcs_cmd(drv, RSC_DRV_CMD_ADDR, tcs_id, j);
 			for (k = 0; k < msg->num_cmds; k++) {
 				if (addr == msg->cmds[k].addr)
 					return -EBUSY;
-- 
2.25.1.481.gfbce0eb801-goog

