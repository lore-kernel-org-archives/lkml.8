Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3954FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F43B2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388641AbgE0Npf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:45:35 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:45323 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbgE0Npd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:45:33 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N5CMP-1iv9Gv0jwb-0118Vd; Wed, 27 May 2020 15:45:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dilip Kota <eswara.kota@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] phy: intel: fix enum type mismatch warning
Date:   Wed, 27 May 2020 15:45:06 +0200
Message-Id: <20200527134518.908624-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nyIOF008cbZxsbmhfvGhCRdrwCcN1q1JDweBfwxy95/py9s3Bz7
 BFHwcfK/dnZiPczlXT624LDAPtJsDwXBDDVwKsXxmRjYf1EWQfTsfA1lMSe65U0u8rKWGRz
 3INsuZt+Gl5Bw9EtoeuItFkPoX0bh/5MKbcJprGU199PLC52YdwdIY6BxhvjcCJSsvqOqAI
 hm1FdsF24f+/DT3woz7iQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JauS/qGrgKE=:E8zZXa1xetlRt0BTAijuz5
 X0mQ+xT50m+/+kDnEKmuArkBTJXF096ns60R0bqWmW9YD9hv5hvPx5q83HjOoWzs+KxKNymy3
 8drzDdkH35yPqJK9roborwsd/c8NqvXUZIrT+KrRDdW8N7t1mmHMKsyVQgOnuSZPUa0yu1R8s
 5As1TX/0KyWq3G7V6GidUbogztS46M/n5olB7epjstaleNgtSsLFwbLIPNgqSdLeS1QBYupGS
 pnPiB1WeN4JZoPoC2yMIs2raU+7Yh1b2kVOfV2qUjAxTyRhsc4kZojwdHPkYCg+f+Ip1ClB72
 DpVLBg7PiD5rCc3McRVwnUUHes9lmnSQkzCptMSPztT/HFD2nkRZgCBJjVekLeYb9jL0nqBBX
 VnNzrImSCMTinqB62tyeRCwdCoZqkyqUKHJOFpNKY6lA9BVSTrP0y1RkDOdm/tIr3KW63jY86
 OJ8c+zVEoc6xc2lNBXSqkExO2OkJnDu/1eA8xCwpBSGME24XqDEQX7mkkxAco8KrHqtH54rs7
 6H1T295VZ/3UKHhCPxpKrazeX1UACoHFWarFD8rvcWaBudccUk1itslfLRk+ikPp69O4Pk3bx
 TPJGyeKDLYmKZkmxDLLomdfql/hXGIXDccGOtyQTypxgsskTutUa/a+IeBAtbNlqa3HAtmlXN
 k+1xtv3VC/6qp3IGjrqVK6YQ4UHw9wHtVeNa2HpRNK/WVnyi+8usIN94R1r8Lk3N5T5IwT9bl
 +UwwWo98adgXNiY1f81FyiMNQiKDt+gHPASU69bNXDCcfOLxHDx/n+wpPNIC/rn1shIN5v0Ba
 Jfwr8DWgUGXYWltQ3BUf8x6G8jUdnpE+ywwMU72tPj3VTl+9xM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang points out that a local variable is initialized with
an enum value of the wrong type:

drivers/phy/intel/phy-intel-combo.c:202:34: error: implicit conversion from enumeration type 'enum intel_phy_mode' to different enumeration type 'enum intel_combo_mode' [-Werror,-Wenum-conversion]
        enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
                              ~~~~~~~   ^~~~~~~~~~~~~

From reading the code, it seems that this was not only the
wrong type, but not even supposed to be a code path that can
happen in practice.

Change the code to have no default phy mode but instead return an
error for invalid input.

Fixes: ac0a95a3ea78 ("phy: intel: Add driver support for ComboPhy")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/intel/phy-intel-combo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-combo.c
index c2a35be4cdfb..04f7b0d08742 100644
--- a/drivers/phy/intel/phy-intel-combo.c
+++ b/drivers/phy/intel/phy-intel-combo.c
@@ -199,7 +199,7 @@ static int intel_cbphy_pcie_dis_pad_refclk(struct intel_cbphy_iphy *iphy)
 
 static int intel_cbphy_set_mode(struct intel_combo_phy *cbphy)
 {
-	enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
+	enum intel_combo_mode cb_mode;
 	enum aggregated_mode aggr = cbphy->aggr_mode;
 	struct device *dev = cbphy->dev;
 	enum intel_phy_mode mode;
@@ -224,6 +224,8 @@ static int intel_cbphy_set_mode(struct intel_combo_phy *cbphy)
 
 		cb_mode = SATA0_SATA1_MODE;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	ret = regmap_write(cbphy->hsiocfg, REG_COMBO_MODE(cbphy->bid), cb_mode);
-- 
2.26.2

