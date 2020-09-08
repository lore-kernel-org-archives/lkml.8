Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868FBC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE7820732
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599585266;
	bh=t9oVmlAucUPz8wGFixUVdC8fAehFz3C3ZSo8YUF4qKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vQprzd/Df8olEmwZqI1Jq3/MVIKUBNsLKF++65UY4YljDYHfJ2YgKZsCoMDoUgaxc
	 lRXKhmb/zKLmyElAChDnx9ltkPTbNP+kZMI+iLF3vA8/T1moRQL3AT6lbAUOSCLjA8
	 Ph4tUxQxwAi4qsHB1IU2oZmC5FjQ+0zZLckq0f9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgIHROY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731764AbgIHQTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:19:09 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9C7C24839;
        Tue,  8 Sep 2020 15:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579892;
        bh=t9oVmlAucUPz8wGFixUVdC8fAehFz3C3ZSo8YUF4qKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QUi9voyZ+uduZSCbHDGhatykNuRsucdyh7XherfXxWlKuJyZPDcQIq9/nBSL/9g2q
         3UpR5Tn/qcCMeuxj3EGtaWzSckZHPxZxk7yH7aYsqi265ylxgeouZxSnoybpoyKYDm
         4C2d34TDMl5AWga44leKJfTP9zNNzyVnDtHb4i4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Smith <msmith626@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 046/129] bnxt_en: fix HWRM error when querying VF temperature
Date:   Tue,  8 Sep 2020 17:24:47 +0200
Message-Id: <20200908152232.002539599@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Edwin Peer <edwin.peer@broadcom.com>

[ Upstream commit 12cce90b934bf2b0ed9c339b4d5503e69954351a ]

Firmware returns RESOURCE_ACCESS_DENIED for HWRM_TEMP_MONITORY_QUERY for
VFs. This produces unpleasing error messages in the log when temp1_input
is queried via the hwmon sysfs interface from a VF.

The error is harmless and expected, so silence it and return unknown as
the value. Since the device temperature is not particularly sensitive
information, provide flexibility to change this policy in future by
silencing the error rather than avoiding the HWRM call entirely for VFs.

Fixes: cde49a42a9bb ("bnxt_en: Add hwmon sysfs support to read temperature")
Cc: Marc Smith <msmith626@gmail.com>
Reported-by: Marc Smith <msmith626@gmail.com>
Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 16462d21fea38..089d7b9cc409d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8938,16 +8938,19 @@ static ssize_t bnxt_show_temp(struct device *dev,
 	struct hwrm_temp_monitor_query_input req = {0};
 	struct hwrm_temp_monitor_query_output *resp;
 	struct bnxt *bp = dev_get_drvdata(dev);
-	u32 temp = 0;
+	u32 len = 0;
 
 	resp = bp->hwrm_cmd_resp_addr;
 	bnxt_hwrm_cmd_hdr_init(bp, &req, HWRM_TEMP_MONITOR_QUERY, -1, -1);
 	mutex_lock(&bp->hwrm_cmd_lock);
-	if (!_hwrm_send_message(bp, &req, sizeof(req), HWRM_CMD_TIMEOUT))
-		temp = resp->temp * 1000; /* display millidegree */
+	if (!_hwrm_send_message_silent(bp, &req, sizeof(req), HWRM_CMD_TIMEOUT))
+		len = sprintf(buf, "%u\n", resp->temp * 1000); /* display millidegree */
 	mutex_unlock(&bp->hwrm_cmd_lock);
 
-	return sprintf(buf, "%u\n", temp);
+	if (len)
+		return len;
+
+	return sprintf(buf, "unknown\n");
 }
 static SENSOR_DEVICE_ATTR(temp1_input, 0444, bnxt_show_temp, NULL, 0);
 
-- 
2.25.1



