Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C389C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2672075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096627;
	bh=qdAfJnBJ7sjyxic7UNz+QaCPtfFw871DnQVRrHY+yCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yxOnKthLPLCmdFYm9/v1CP5Zv1dIknw2H3yiGYo0x2efDAmecO8GmvHxGnnRMPOjL
	 DCxes1VIc6AcuL7oBFG9DbMaQvk4Ex0TOB15spVcUAUGBMXEnP/8O7YZnGk5x5zV7o
	 Jr2TWvE/KGoovrikO2HQYaZQ8uMP3Cj3dmckQ9/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgG3IK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729724AbgG3IKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:10:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86FFE2070B;
        Thu, 30 Jul 2020 08:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096605;
        bh=qdAfJnBJ7sjyxic7UNz+QaCPtfFw871DnQVRrHY+yCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ME9AWsu8zhVUpMMTW+6HcDnFZu4SXXCslaULJKXG9wQxpB97+DTp3xGDs/gisAcjs
         CBdZ1MGvKDWSe3BjU6X0v3WF+8nM94eGJA5qSroAehsKCPy3jkCNYC7V94WE5dr2vb
         8qQNzAMJtcF3A/sbtBk/C5ukVzHdMoe1NrAI5tNU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Federico Ricchiuto <fed.ricchiuto@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 21/61] HID: i2c-hid: add Mediacom FlexBook edge13 to descriptor override
Date:   Thu, 30 Jul 2020 10:04:39 +0200
Message-Id: <20200730074421.870696620@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.811058810@linuxfoundation.org>
References: <20200730074420.811058810@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Federico Ricchiuto <fed.ricchiuto@gmail.com>

[ Upstream commit 43e666acb79f3d355dd89bf20f4d25d3b15da13e ]

The Mediacom FlexBook edge13 uses the SIPODEV SP1064 touchpad, which does not
supply descriptors, so it has to be added to the override list.

Signed-off-by: Federico Ricchiuto <fed.ricchiuto@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
index 681ac9bc68b3d..f98c1e1b1dbdc 100644
--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -373,6 +373,14 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
 		},
 		.driver_data = (void *)&sipodev_desc
 	},
+	{
+		.ident = "Mediacom FlexBook edge 13",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MEDIACOM"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "FlexBook_edge13-M-FBE13"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	},
 	{
 		.ident = "Odys Winbook 13",
 		.matches = {
-- 
2.25.1



