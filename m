Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F89C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250582080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="cJY4cQ86";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lX7OCsN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgBXJJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:09:39 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:50617 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727275AbgBXJJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:27 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 19ACF616;
        Mon, 24 Feb 2020 04:09:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Paw5PYMOhjhZy
        +fzKf6WIcWIW2DlVtCPhwp3fbzQ4Bk=; b=cJY4cQ86Zd4RIzH7Jk2uoasZUIj/4
        em2wwa1BQtaeaIhUtfAGeokvj0lYbNeKPpjxALSMwXkTC1lMEhoZ3VEh5DiMQuwb
        5j/PJ+RaLPICoz7ZPtmFGae2qZqtoNRX1G2GaVpZACCH8fbWJ4urRy789+C1DOnJ
        qvEs3A2pRag85+yuFaT/DDhiM5GeLnl4b7zB80TzWoxcUBZ62XeodSgwVva31OLE
        e/dY6L5ysKMpnwrpITYxdTs9AFFXXbMx+b5pPRimuOJRVW+Kr7ZM0vtEpmgJQEor
        bp08f2otkaGYSqnUfWiEDAVNy3H0Wc1hikbJrcOsC1wK0urunGhF7Uk1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Paw5PYMOhjhZy+fzKf6WIcWIW2DlVtCPhwp3fbzQ4Bk=; b=lX7OCsN2
        khDMZjqJIky/SO09jtlluBzQmLSVyo17jYhHNYBkDiOpxa0L6w0D4oeytqbj4nkp
        ZZssrYMRjQkKtWolzBy3YSuSKTnHU2sTVvLot+4yQrfmfvCEPw5igtp/wIrh0eui
        8dtboIx3Mnpjb1/+nZ5FQHFv7JRSOP1RERhz7Y/3zypQaubYG1Co6iJ/hrsSbSWz
        5ZyhmXIVcIo0uKMNDGKq1mPj0fUr9xQxTYwG18cciTCeyHGOcaFwT2TTLyN/562U
        hiyOrx18uJeUTeYhj0N52VBVj3Tq3M5S3Xv0+v8VjQin3wBLWZxRCjMXSLOFoJMe
        uTjrMDSmczZ3ew==
X-ME-Sender: <xms:xZJTXjzTlNBDOXWu7FwEXbWOVhPzD3dUTHBef84dDaHoEtERmPP2rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepvddunecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:xZJTXqgQLG1wf-NGiw1uiIOrr8NB5_1vhoD1Qyvz9Kx_0_A9GxiqWQ>
    <xmx:xZJTXgL8-DfjgCI5NtdjVCy1jPlV8I0Nz_HDx8l4IDcLGv5UetO2eg>
    <xmx:xZJTXlDwFhKgJJOZ75ltU_VMiBGzvWZqTA_0fuYIDLHUbK9pWdpyiA>
    <xmx:xZJTXoifcz0S1IK_GZkhLDq4wzYitIk2swV2pwUZGKNtzOIOj2z0QN16-HY>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 59B3D3060BD1;
        Mon, 24 Feb 2020 04:09:25 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 25/89] reset: simple: Add reset callback
Date:   Mon, 24 Feb 2020 10:06:27 +0100
Message-Id: <e7e2c84206f2cc8c0cb36cd734226f73f3331198.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset-simple code lacks a reset callback that is still pretty easy to
implement. The only real thing to consider is the delay needed for a device
to be reset, so let's expose that as part of the reset-simple driver data.

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/reset/reset-simple.c       | 21 +++++++++++++++++++++
 include/linux/reset/reset-simple.h |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index c854aa351640..7a8c56512ae9 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -11,6 +11,7 @@
  * Maxime Ripard <maxime.ripard@free-electrons.com>
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -63,6 +64,25 @@ static int reset_simple_deassert(struct reset_controller_dev *rcdev,
 	return reset_simple_update(rcdev, id, false);
 }
 
+static int reset_simple_reset(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct reset_simple_data *data = to_reset_simple_data(rcdev);
+	int ret;
+
+	ret = reset_simple_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	mdelay(data->reset_ms);
+
+	ret = reset_simple_deassert(rcdev, id);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int reset_simple_status(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
@@ -80,6 +100,7 @@ static int reset_simple_status(struct reset_controller_dev *rcdev,
 const struct reset_control_ops reset_simple_ops = {
 	.assert		= reset_simple_assert,
 	.deassert	= reset_simple_deassert,
+	.reset		= reset_simple_reset,
 	.status		= reset_simple_status,
 };
 EXPORT_SYMBOL_GPL(reset_simple_ops);
diff --git a/include/linux/reset/reset-simple.h b/include/linux/reset/reset-simple.h
index 08ccb25a55e6..a5887f6cbe50 100644
--- a/include/linux/reset/reset-simple.h
+++ b/include/linux/reset/reset-simple.h
@@ -27,6 +27,9 @@
  * @status_active_low: if true, bits read back as cleared while the reset is
  *                     asserted. Otherwise, bits read back as set while the
  *                     reset is asserted.
+ * @reset_ms: Minimum delay in milliseconds needed that needs to be
+ *            waited for between an assert and a deassert to reset the
+ *            device.
  */
 struct reset_simple_data {
 	spinlock_t			lock;
@@ -34,6 +37,7 @@ struct reset_simple_data {
 	struct reset_controller_dev	rcdev;
 	bool				active_low;
 	bool				status_active_low;
+	unsigned int			reset_ms;
 };
 
 extern const struct reset_control_ops reset_simple_ops;
-- 
git-series 0.9.1
