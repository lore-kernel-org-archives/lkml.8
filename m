Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DA5C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C49C20730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="pbDmPRo0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1mMXAFlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgDGF6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 01:58:50 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:33511 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726769AbgDGF6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 01:58:49 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 655B1580306;
        Tue,  7 Apr 2020 01:58:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 07 Apr 2020 01:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=yrW9UFf8Ckuho
        4dOnBWe9v/QNnRt/BB4F2Z5BywTppk=; b=pbDmPRo0ym6/FacDzog7IuQQ+aMoC
        b9ykP8p8D7R5Yf3AgiJzAggmJMbm1vUcU8cR+gDEQniDhMB4KTlFlHRg0eJI+W4P
        lnux0kZXDWGsm3vgBa4YKmlnxFF3W0QjRROgMxW94xr+oUArijRvkP8u3SenolWX
        d2zTmBqZmz/S3pVJ12SZ3/G6xm4eSoS8I99zPLpLnuh9XylFPqf6Yo18UrNu/0Ux
        Cz+5Bg9qRDrwNnUqD7B+2mwRebhBHERGhe44Za4HRAiejcSB38lQf1cZB6Y4azep
        VozWQTaWVeNAJRhpAmzqzH5W4nxyoSobD2PFNzA2XWaicf04pPsJNi9CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=yrW9UFf8Ckuho4dOnBWe9v/QNnRt/BB4F2Z5BywTppk=; b=1mMXAFlV
        bF4nm/PRzu3OQ0jztQHgkiMxkneQpWjFJ+GamZoZNarbyVChgJP7ibgKNkDQ51HZ
        XoLc1qhimvneS3KMfVjiXIEh1q/QPOBqTorHWxDpMWrtnznk9fW6+hYK1gaH1x3m
        9f+Z59qGXB+TGScQyJVWb0N5udZW0uIZazSkpumAoPLxrmlitKBPaW8WqLGML5LT
        zJaVx358v8WTxdej5Wg4fZYReMq6+ipwTimpImtESOpK8HgBOKx6taz4f93u8kvi
        xqXoEBebAlTeLVKCY/bIy6nt0EScILwX5SLm9kdpcVAeF7/cGg2FSjFrWfWWcfLw
        bYKk9QlHTt1a7w==
X-ME-Sender: <xms:lhaMXiF0xTmTzPAltDY-_LopFKVzyq51zTXZsmVUB51jk5bqMBGEFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeggdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecukfhppeejfedrleefrdekgedrvddtkeenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:lhaMXmh1p8jzifoTQ1JfckevUgSZ81BtokFfbvLPZ7Hqe2GGiwwv9w>
    <xmx:lhaMXi-D1cf7EMmOMBK272Lo2ZvNGOBoSZC7N8WIRCa3uwKb7F4L5g>
    <xmx:lhaMXhIyqjhAuB740QRplnIbtVaZbNjbDXkPCmOK6DtfdHF80ZMdXA>
    <xmx:mBaMXoauhRxUANuAkuwlOwMd3GGeocLDdPi2e_SCAXNB-0KfvZhCFA>
Received: from alistair-xps-14z.alistair23.me (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 00CFA328005E;
        Tue,  7 Apr 2020 01:58:44 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, mripard@kernel.org, wens@csie.org
Cc:     anarsoul@gmail.com, devicetree@vger.kernel.org,
        alistair23@gmail.com, linux-arm-kernel@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2 2/3] Bluetooth: hci_h5: Add support for binding RTL8723BS with device tree
Date:   Mon,  6 Apr 2020 22:58:36 -0700
Message-Id: <20200407055837.3508017-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200407055837.3508017-1-alistair@alistair23.me>
References: <20200407055837.3508017-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

RTL8723BS is often used in ARM boards, so add ability to bind it
using device tree.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/bluetooth/hci_h5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 106c110efe56..b0e25a7ca850 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -1019,6 +1019,8 @@ static const struct of_device_id rtl_bluetooth_of_match[] = {
 	{ .compatible = "realtek,rtl8822cs-bt",
 	  .data = (const void *)&rtl_vnd },
 #endif
+	{ .compatible = "realtek,rtl8822bs-bt",
+	  .data = (const void *)&rtl_vnd },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, rtl_bluetooth_of_match);
-- 
2.25.1

