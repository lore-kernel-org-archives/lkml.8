Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0879DC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCDE20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588254903;
	bh=biXchweKB4DFENIbviTTEdyqXlCdXdqu7PHwjKG0fm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vvMi1J4Z4a6LZpSKa6x+JbFEpdZA3XpJlS36nVjWKpxWVxOyd+pRiLGaXCKV2pZjD
	 +No0rSA8qxComqz63Rif+W7aMIYj4JGBtLjsPLVTiHKyjvbX/wNHKBkRA56AI8oxQh
	 w76sV8VhZ7s3yytZBDoIdVw8ZILWE/mtIO1ksYOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgD3NzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbgD3NyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:54:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 625D82495F;
        Thu, 30 Apr 2020 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254854;
        bh=biXchweKB4DFENIbviTTEdyqXlCdXdqu7PHwjKG0fm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2BmW5dQS6BBfvMnhg4G5ftA4lhygcgNVg5cTY3fkvSjrBQJm8FN8felJTJYkxyRxW
         FURPP0/6cmvlP2Ec2d7jBfZwuWbjwMtxzX0G6uHEXOLSfVtppn3j/nTv2Bfj0ckTsj
         HuU5Ep/OVswhFcRTHbvrPqVPMR5+OWFCwpJfyV/A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 10/27] ARM: dts: bcm283x: Disable dsi0 node
Date:   Thu, 30 Apr 2020 09:53:45 -0400
Message-Id: <20200430135402.20994-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135402.20994-1-sashal@kernel.org>
References: <20200430135402.20994-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

[ Upstream commit 90444b958461a5f8fc299ece0fe17eab15cba1e1 ]

Since its inception the module was meant to be disabled by default, but
the original commit failed to add the relevant property.

Fixes: 4aba4cf82054 ("ARM: dts: bcm2835: Add the DSI module nodes and clocks")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm283x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index fdb018e1278fb..9d1e1061d8af1 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -454,6 +454,7 @@
 					     "dsi0_ddr2",
 					     "dsi0_ddr";
 
+			status = "disabled";
 		};
 
 		thermal: thermal@7e212000 {
-- 
2.20.1

