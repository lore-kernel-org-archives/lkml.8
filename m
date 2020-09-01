Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EAAC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EC720707
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=whu.edu.cn header.i=@whu.edu.cn header.b="FeR4BlwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgIAC2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:28:31 -0400
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net ([209.97.182.222]:44259
        "HELO zg8tmja5ljk3lje4mi4ymjia.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1725993AbgIAC2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=whu.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=jbsXwd3S/y
        BwfSReOxpmspgYRrmvMUbUnWOZgpGcXBs=; b=FeR4BlwTER8d9uM8MG9xId4nOh
        VWtLdAQ4XORLU/q23SfZM3QI01FE/n0r+SGrJqCZIWGZcrg/lnRRYPlIeZPdj2Ee
        JqBKVVgHQ5kFyB3B6lpPOf2P89GZ2bSfQxUdjKUCVOto75eFOyNyRdWlhaYI2Iut
        VvB4m4S4YMObpzpqs=
Received: from zbook.lan (unknown [223.214.144.166])
        by email1 (Coremail) with SMTP id AQBjCgA3FwC9sU1fvJ9OAA--.26090S4;
        Tue, 01 Sep 2020 10:28:14 +0800 (CST)
From:   Tong Chen <tongchen@whu.edu.cn>
To:     tongchen@whu.edu.cn
Cc:     nic_swsd@realtek.com, hkallweit1@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: reduce the param length of the line
Date:   Tue,  1 Sep 2020 10:28:11 +0800
Message-Id: <20200901022811.8675-1-tongchen@whu.edu.cn>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQBjCgA3FwC9sU1fvJ9OAA--.26090S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKFy3CrWUKw1fKr17Xw18Zrb_yoWfKwbEkr
        1YqF4fZw4FkF90kr47Ca1ruFy0kanrZwn5ZFy2qr97X3WfXrW3Zw1UuFn3Xr9rWa18ZFy7
        WrWxZF17A34UWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4U
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VU1sYFtUUUUU==
X-CM-SenderInfo: ysqrljaqrviiqrtvq4lkxovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the param length of the line from 79 chars to 52 chars,
which complies with kernel preferences.
Signed-off-by: Tong Chen <tongchen@whu.edu.cn>
---
 drivers/net/ethernet/realtek/r8169_phy_config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index 913d030d73eb..f4b738cf8ad7 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1302,7 +1302,8 @@ static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
 	rtl8125b_config_eee_phy(phydev);
 }
 
-void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
+void r8169_hw_phy_config(struct rtl8169_private *tp,
+			 struct phy_device *phydev,
 			 enum mac_version ver)
 {
 	static const rtl_phy_cfg_fct phy_configs[] = {
-- 
2.28.0

