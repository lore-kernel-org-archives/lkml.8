Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B81C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0090B20888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dqdCbynR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgGWMTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:19:08 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7232 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWMTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:19:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f197ffc0000>; Thu, 23 Jul 2020 05:18:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 Jul 2020 05:19:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 Jul 2020 05:19:06 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Jul
 2020 12:19:06 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 23 Jul 2020 12:19:06 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f1980370002>; Thu, 23 Jul 2020 05:19:05 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <digetx@gmail.com>, <linux-i2c@vger.kernel.org>,
        <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ldewangan@nvidia.com>,
        <smohammed@nvidia.com>, <rgumasta@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 1/7] i2c: tegra: remove dead code
Date:   Thu, 23 Jul 2020 17:48:47 +0530
Message-ID: <1595506733-10307-1-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595506684; bh=fa+P5jAGVjPVirFmB1xYmlo1dz271n97QHWg6liSJZc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=dqdCbynRWBTP0EBgNI6Jsw3LPfIDlnGpA5wTxo6YBYDADj05qQq6N62gGYPQRvode
         kSOeqaydNeULiJkUJELwwU1WPYuGGJCRnf8YnDMukhubNRerzk+xxiMuauyBHWqd8a
         +oJGTQOJnvRt6hBMFBEj4TJHpncqJihryRdX372SWX1D4R72sDTqm7nn3Srbh0rcok
         ecu+okg5mzW5BVQHyTGLzL1LRnz+3DMP4EiKp5KQDbj7RfB7jst0Afcsc9zetFkx63
         Dq3A+ZPomsk3pLgRYff5tSxyGaBr3QtJVwD497rROpCjj2/BuG1t06fr2dRVLwNNVs
         pCQLncIXiqPGw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shardar Shariff Md <smohammed@nvidia.com>

When I2C_HEADER_CONT_ON_NAK bit in IO header is set then =E2=80=9CNo ACK
from slave=E2=80=9D error is not reported (NACK is considered as ACK
and transfer is continued). So if I2C_ERR_NO_ACK is set, it would
imply I2C_M_IGNORE_NAK is not set and hence this code will never
execute. When I2C_HEADER_CONT_ON_NAK bit in IO header is set then
=E2=80=9CNo ACK from slave=E2=80=9D error is not reported.
Condition (msg->flags & I2C_M_IGNORE_NAK) will never be hit

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/i2c/busses/i2c-tegra.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.=
c
index 1577296..c6c870c 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1336,11 +1336,8 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *=
i2c_dev,
 		return -EAGAIN;
 	}
=20
-	if (i2c_dev->msg_err =3D=3D I2C_ERR_NO_ACK) {
-		if (msg->flags & I2C_M_IGNORE_NAK)
-			return 0;
+	if (i2c_dev->msg_err =3D=3D I2C_ERR_NO_ACK)
 		return -EREMOTEIO;
-	}
=20
 	return -EIO;
 }
--=20
2.7.4

