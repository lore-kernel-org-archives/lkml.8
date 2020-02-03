Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3E8C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90DB20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747816;
	bh=cT221eGtXfBf/EoROk90JvQi1WD/sZCnFCuiMlMDBDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V+PKcgxQAgjF4+m2s3mOUbc2zEYcuD2Q1PiglI3RqScGaaHqmUHA06SsDAVuvvUbp
	 7rHpXlaroDHC9jYGodBR/Xlx/spCUNQElRSPZPteYq51n0DjePDLy7GzjvPgRLqQbB
	 EbwAf+jzIWeKF7D2TLyqAvKmt0icAIihPGq8oDb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbgBCQgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731232AbgBCQgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:36:51 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED2702087E;
        Mon,  3 Feb 2020 16:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747811;
        bh=cT221eGtXfBf/EoROk90JvQi1WD/sZCnFCuiMlMDBDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=coZ+VrR+pSVfjnFRi6SAbPtHWqqb8/4OqKKYepNmBk/++5Mr4T7Vvsb/BODyp7XBW
         RcWpdNZlSDX8lMiq6kc6+G3rdMTj/cuGawbfoufnEr/3JpP3ofICkCWMtyRw+kdNDb
         BHG8Ff9qb9jH3TEE1BAj5MIu/6rIMhgzg5/sW7gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hayes Wang <hayeswang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 80/90] r8152: disable DelayPhyPwrChg
Date:   Mon,  3 Feb 2020 16:20:23 +0000
Message-Id: <20200203161926.942360252@linuxfoundation.org>
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

[ Upstream commit aa475d935272481c9ffb1ae54eeca5c1819fbe1a ]

When enabling this, the device would wait an internal signal which
wouldn't be triggered. Then, the device couldn't enter P3 mode, so
the power consumption is increased.

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 5f59affa94d0c..6912624eed4ad 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -29,7 +29,7 @@
 #define NETNEXT_VERSION		"10"
 
 /* Information for net */
-#define NET_VERSION		"10"
+#define NET_VERSION		"11"
 
 #define DRIVER_VERSION		"v1." NETNEXT_VERSION "." NET_VERSION
 #define DRIVER_AUTHOR "Realtek linux nic maintainers <nic_swsd@realtek.com>"
@@ -104,6 +104,7 @@
 #define PLA_BP_EN		0xfc38
 
 #define USB_USB2PHY		0xb41e
+#define USB_SSPHYLINK1		0xb426
 #define USB_SSPHYLINK2		0xb428
 #define USB_U2P3_CTRL		0xb460
 #define USB_CSR_DUMMY1		0xb464
@@ -363,6 +364,9 @@
 #define USB2PHY_SUSPEND		0x0001
 #define USB2PHY_L1		0x0002
 
+/* USB_SSPHYLINK1 */
+#define DELAY_PHY_PWR_CHG	BIT(1)
+
 /* USB_SSPHYLINK2 */
 #define pwd_dn_scale_mask	0x3ffe
 #define pwd_dn_scale(x)		((x) << 1)
@@ -4030,6 +4034,10 @@ static void rtl8153_up(struct r8152 *tp)
 	ocp_data &= ~LANWAKE_PIN;
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG, ocp_data);
 
+	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_SSPHYLINK1);
+	ocp_data &= ~DELAY_PHY_PWR_CHG;
+	ocp_write_word(tp, MCU_TYPE_USB, USB_SSPHYLINK1, ocp_data);
+
 	r8153_aldps_en(tp, true);
 
 	switch (tp->version) {
-- 
2.20.1



