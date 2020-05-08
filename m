Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA882C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9116621974
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgEHWCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 18:02:52 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34557 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbgEHWCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 18:02:52 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Ma1oK-1jaQAZ0hW8-00W11D; Sat, 09 May 2020 00:02:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Will Deacon <will@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Robin Murphy <robin.murphy@arm.com>,
        Hai Nguyen Pham <hai.pham.ud@renesas.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/renesas: fix unused-function warning
Date:   Sat,  9 May 2020 00:02:16 +0200
Message-Id: <20200508220224.688985-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nguKpoyDbwtn9OPppaa1Wkm4f1dh24v77iIkSuLPsDpqTEETLOi
 8fGI9X9HbB6Af8+GtEuUXekkCnA0zjffrQYJhHl/OPgS7W0gkuT+/ZASHGVNNBmD3SfMcH1
 AAGLAMgVzsl7553S0p0+gRRp9X/+7V2PRZdlyEWbVSJ2rM1gHU0VKGWC/NrJKqt0rHiFIR0
 9FR0/q2tCmYqKwfxA3KEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WGPHeoCJUXo=:PqfGjNxO7ONTBOkQt/zAOC
 QlMKZK0qcyOf3cdLRylgomWSUGUDNkcqfUM36WbBmvEoCzkvl4tr+BDAKe3jP7p18JxptopLs
 UFBYh+LgN7pY9RduTraN7x5nTpgkQf9C7A1MgDARF1JLR5f5N3SgY0v+EQqfHws6zHKvJMelL
 DwMo4oSCL+3M16cmQbmdraaCkOrVkJQ5gF34CO2ZzhRL7MHYHR1Iy1XIanAzGqyMbMKKuoDVR
 PlEKq1suHKxI/ATEie3dGznx1dEKJXxaPyvxEMf0Db5oldNDTMEX/WA6BYJ8dgUaw+b9j+aA7
 rEzTVjUnU6TDC9nmS+fWwabEaSuHLjMKWXeb5+emVhbQUyXXqv9d9L+r03km42Z7gsjfmPk6L
 kfESyxiLlnzSg8v9otXEYCsilsULpMPkbDGzmd5qkOdKt791iMo4VfYkuh7wqVsnjWEC+f3u+
 ow2BEzyCLe7JJvjuYy5ZbcP536WJ5f+sdjqgC7N9V0tk7nLCUcz9nbRuvx+Pt/AIJYOVwARoE
 Q249S44z3FYo0mCcrc2KtbBUqyNfidv0Vs0+maeykj9XySk/50QkEMeBbnyxkMgZr6efRHcLM
 mw/jeVZ9Lb3SJTfUszsp3y5+gzynRf1eQ2K2G5/d0qpVqiBudB/es/RMEY70VkyogwNIiohyJ
 P+icQj54FV47lv1EYva3zM/poh54vDXE31mCyN9HZRCujg9TnNtQrNGJoNV6OBQpX9LL4tARj
 sMMZ+qrS+jXKNKjD+eKroIiBhuCr74S0ycznjIn0tx/hAHkIKysvkzgqBZQorv2Gqgslt+Pis
 s2dgqRHg8mK402ZMbvmx3vt0xB3AStgNO3joc6teXckSiZ8M0o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc warns because the only reference to ipmmu_find_group
is inside of an #ifdef:

drivers/iommu/ipmmu-vmsa.c:878:28: error: 'ipmmu_find_group' defined but not used [-Werror=unused-function]

Change the #ifdef to an equivalent IS_ENABLED().

Fixes: 6580c8a78424 ("iommu/renesas: Convert to probe/release_device() call-backs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/ipmmu-vmsa.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index fb7e702dee23..4c2972f3153b 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -903,11 +903,8 @@ static const struct iommu_ops ipmmu_ops = {
 	.probe_device = ipmmu_probe_device,
 	.release_device = ipmmu_release_device,
 	.probe_finalize = ipmmu_probe_finalize,
-#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
-	.device_group = generic_device_group,
-#else
-	.device_group = ipmmu_find_group,
-#endif
+	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
+			? generic_device_group : ipmmu_find_group,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
 	.of_xlate = ipmmu_of_xlate,
 };
-- 
2.26.0

