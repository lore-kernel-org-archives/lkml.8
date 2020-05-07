Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54108C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE1820708
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588812577;
	bh=6dM9PvAApVzyT0m8Cbbv9yowJQZ8Y9LI5uoElqgxx2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VJ4dAqNb2oSIIjpkPMLeeFA4eAlcocF7stlpD+8XdLZ6h/SZxnjQIlE3yJR3d3CT/
	 9Tybx9BNtVSZJz2I1x878axYPP+/XeWBgHlfoCsWsxl0+pC17JzZXlib5fAemWGR7p
	 jMBgbugKFdeVoaKjQtVDx3kYGaPKQIQ8v5+omF/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEGAtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 20:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgEGAtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 20:49:35 -0400
Received: from localhost.localdomain (unknown [180.171.74.255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 809F020736;
        Thu,  7 May 2020 00:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588812575;
        bh=6dM9PvAApVzyT0m8Cbbv9yowJQZ8Y9LI5uoElqgxx2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aC4XblCAXelcpdT4g5npOeH0svbcWQnL9zwy+1a5AogvuNDzvRENS1pL0Y4X1sOnN
         esDustmO4MR+8PzyZKkVoGTvvoDD+9P7FD139/HMXdYX019p4evUijHQGNQca2CDGT
         V1jy1ciCsuvvrV0yMnvkxTGg2gO/oTK6GAI0evM4=
From:   Peter Chen <peter.chen@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 1/1] usb: chipidea: msm: Ensure proper controller reset using role switch API
Date:   Thu,  7 May 2020 08:49:18 +0800
Message-Id: <20200507004918.25975-2-peter.chen@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507004918.25975-1-peter.chen@kernel.org>
References: <20200507004918.25975-1-peter.chen@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Currently we check to make sure there is no error state on the extcon
handle for VBUS when writing to the HS_PHY_GENCONFIG_2 register. When using
the USB role-switch API we still need to write to this register absent an
extcon handle.

This patch makes the appropriate update to ensure the write happens if
role-switching is true.

Fixes: 05559f10ed79 ("usb: chipidea: add role switch class support")

Cc: Peter Chen <Peter.Chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index af648ba6544d..46105457e1ca 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -114,7 +114,7 @@ static int ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
 			hw_write_id_reg(ci, HS_PHY_GENCONFIG_2,
 					HS_PHY_ULPI_TX_PKT_EN_CLR_FIX, 0);
 
-		if (!IS_ERR(ci->platdata->vbus_extcon.edev)) {
+		if (!IS_ERR(ci->platdata->vbus_extcon.edev) || ci->role_switch) {
 			hw_write_id_reg(ci, HS_PHY_GENCONFIG_2,
 					HS_PHY_SESS_VLD_CTRL_EN,
 					HS_PHY_SESS_VLD_CTRL_EN);
-- 
2.17.1

