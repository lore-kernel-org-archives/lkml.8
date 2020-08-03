Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251B8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053932083B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457724;
	bh=1lSb22xJIhaeGJv+HCgH8xtusIhyGxWIAiMO+X1TXrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h37rPB5DByXVB5WDyP81BKFNU2UpQR0GlN7MQQvr8E2dj07tyhP9D/28jcCQz9ego
	 NoxfEaKRe+RE2n2iDbucBWSPnZ6y7T5meLDN5aU4tc+4VZKGD9S0Vi1F3397I27jU7
	 5FuzFwwBjWEoKvDwFMIp8rf0N3dsfWucEBbLttXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgHCM2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728754AbgHCM2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:28:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E00B8204EC;
        Mon,  3 Aug 2020 12:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457719;
        bh=1lSb22xJIhaeGJv+HCgH8xtusIhyGxWIAiMO+X1TXrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkVfI6cccwxhot0dzdYVx5gVbDTRFhw/DZEWHgMvjTCQW0bo4rbXgQ64smb2X2U/t
         FkrR8bukW//YMe8lr9gLrpTxJpXhPTVdTshF+InqcoRF/yP+0Bd6ITMtfH+CP89QK5
         EQbJYIFrmQVLMwKVxPDxll2WX77LxUpgzYPqsahI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 49/90] net/mlx5: Verify Hardware supports requested ptp function on a given pin
Date:   Mon,  3 Aug 2020 14:19:11 +0200
Message-Id: <20200803121859.997229384@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eran Ben Elisha <eranbe@mellanox.com>

[ Upstream commit 071995c877a8646209d55ff8edddd2b054e7424c ]

Fix a bug where driver did not verify Hardware pin capabilities for
PTP functions.

Fixes: ee7f12205abc ("net/mlx5e: Implement 1PPS support")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Reviewed-by: Ariel Levkovich <lariel@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 43f97601b5000..75fc283cacc36 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -388,10 +388,31 @@ static int mlx5_ptp_enable(struct ptp_clock_info *ptp,
 	return 0;
 }
 
+enum {
+	MLX5_MTPPS_REG_CAP_PIN_X_MODE_SUPPORT_PPS_IN = BIT(0),
+	MLX5_MTPPS_REG_CAP_PIN_X_MODE_SUPPORT_PPS_OUT = BIT(1),
+};
+
 static int mlx5_ptp_verify(struct ptp_clock_info *ptp, unsigned int pin,
 			   enum ptp_pin_function func, unsigned int chan)
 {
-	return (func == PTP_PF_PHYSYNC) ? -EOPNOTSUPP : 0;
+	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock,
+						ptp_info);
+
+	switch (func) {
+	case PTP_PF_NONE:
+		return 0;
+	case PTP_PF_EXTTS:
+		return !(clock->pps_info.pin_caps[pin] &
+			 MLX5_MTPPS_REG_CAP_PIN_X_MODE_SUPPORT_PPS_IN);
+	case PTP_PF_PEROUT:
+		return !(clock->pps_info.pin_caps[pin] &
+			 MLX5_MTPPS_REG_CAP_PIN_X_MODE_SUPPORT_PPS_OUT);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return -EOPNOTSUPP;
 }
 
 static const struct ptp_clock_info mlx5_ptp_clock_info = {
-- 
2.25.1



