Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587EAC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D42B2087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748008;
	bh=GeOEc8lU5kM05tGC4M3rSUXZQqWtiIyHarYETVBYwQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fu5NGSYQbiss5gHc+LcuTORvgGrV012wEdBLZ4A+G7UwSWHB8zGALlpcF3nRmEXYA
	 YKLZJ0aEeuDFBh8mciIZ8NDxFyF2N2OqFAOhyCovHF4AsqloiN4KI6xK9N2t/FHgUx
	 MH8IuA0rvd/89xOQMXBa6fSwO3UBioOy7pJx0y4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbgBCQgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:36:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbgBCQgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:36:44 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17E82087E;
        Mon,  3 Feb 2020 16:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747804;
        bh=GeOEc8lU5kM05tGC4M3rSUXZQqWtiIyHarYETVBYwQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=didrrbQNyID2Cu0CoS1zp0NUIlpgMHw+P4a2tNV2/wrFqEVumg5GWgINM2cy7+AgM
         kJABYJwZ/Aib9ITOrsAwWPATgzJM6DP1isxLJ3oFz+68ObIuNcPO0IYwb8Hu5HKcen
         bfQOv6zu5hoSrCl3PYR++NWvwIuqdbvisWHA5Ru0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hayes Wang <hayeswang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 77/90] r8152: Disable PLA MCU clock speed down
Date:   Mon,  3 Feb 2020 16:20:20 +0000
Message-Id: <20200203161926.657764538@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hayes Wang <hayeswang@realtek.com>

[ Upstream commit 08997b5eec08a2c29367f19a74abdea54b299406 ]

PLA MCU clock speed down could only be enabled when tx/rx are disabled.
Otherwise, the packet loss may occur.

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index debab2c27f638..2d3374a373f83 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -310,6 +310,7 @@
 #define MAC_CLK_SPDWN_EN	BIT(15)
 
 /* PLA_MAC_PWR_CTRL3 */
+#define PLA_MCU_SPDWN_EN	BIT(14)
 #define PKT_AVAIL_SPDWN_EN	0x0100
 #define SUSPEND_SPDWN_EN	0x0004
 #define U1U2_SPDWN_EN		0x0002
@@ -4042,6 +4043,8 @@ static void rtl8153_down(struct r8152 *tp)
 
 static void rtl8153b_up(struct r8152 *tp)
 {
+	u32 ocp_data;
+
 	if (test_bit(RTL8152_UNPLUG, &tp->flags))
 		return;
 
@@ -4052,17 +4055,27 @@ static void rtl8153b_up(struct r8152 *tp)
 	r8153_first_init(tp);
 	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, RX_THR_B);
 
+	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
+	ocp_data &= ~PLA_MCU_SPDWN_EN;
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
+
 	r8153_aldps_en(tp, true);
 	r8153b_u1u2en(tp, true);
 }
 
 static void rtl8153b_down(struct r8152 *tp)
 {
+	u32 ocp_data;
+
 	if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		return;
 	}
 
+	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
+	ocp_data |= PLA_MCU_SPDWN_EN;
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
+
 	r8153b_u1u2en(tp, false);
 	r8153_u2p3en(tp, false);
 	r8153b_power_cut_en(tp, false);
@@ -4523,6 +4536,10 @@ static void r8153b_init(struct r8152 *tp)
 	ocp_data |= MAC_CLK_SPDWN_EN;
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2, ocp_data);
 
+	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
+	ocp_data &= ~PLA_MCU_SPDWN_EN;
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
+
 	set_bit(GREEN_ETHERNET, &tp->flags);
 
 	/* rx aggregation */
-- 
2.20.1



