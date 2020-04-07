Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C023C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1836020768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586217840;
	bh=T/a03JFRVwZf26cJQ8+4XA7GcZj1JeU8Ggit0HX5RJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NdDxa3OnN0PRl95Cf76IXAMbYXydhpOrvDxgeJcdlNsBM2BSoHj1VWX+cY28nBS9+
	 pg+AfD7Bwlh3cnMUD2IabgOkzd52m7LYKY0jstnpgQEQ+BSAXkkxylMm2TF1/HwbqG
	 5/HTFcvkxOG7isjsTqqTNvZZJX/emk+EA/7Ey550=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgDGAD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbgDGADC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:03:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E0062078C;
        Tue,  7 Apr 2020 00:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586217782;
        bh=T/a03JFRVwZf26cJQ8+4XA7GcZj1JeU8Ggit0HX5RJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pbdLyaNrvbrBJbg7Qr6B7J6C6SBppZZVAs/Ihcy+lzFU3vPCz66ISvox6AJuvRUd/
         OhgflHm9bE7SA6L37bABLT3eHlZuDdiKuaOXzJGTNzF8h2v6QUYKGa9u+mudA+uhWN
         sRWlqzpLpGGIa1Us+FQc/HSFnvHoJ+K9dRCaGeLA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xu Wang <vulab@iscas.ac.cn>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 8/9] qlcnic: Fix bad kzalloc null test
Date:   Mon,  6 Apr 2020 20:02:51 -0400
Message-Id: <20200407000252.17241-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407000252.17241-1-sashal@kernel.org>
References: <20200407000252.17241-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Wang <vulab@iscas.ac.cn>

[ Upstream commit bcaeb886ade124331a6f3a5cef34a3f1484c0a03 ]

In qlcnic_83xx_get_reset_instruction_template, the variable
of null test is bad, so correct it.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
index 07f9067affc65..cda5b0a9e9489 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
@@ -1720,7 +1720,7 @@ static int qlcnic_83xx_get_reset_instruction_template(struct qlcnic_adapter *p_d
 
 	ahw->reset.seq_error = 0;
 	ahw->reset.buff = kzalloc(QLC_83XX_RESTART_TEMPLATE_SIZE, GFP_KERNEL);
-	if (p_dev->ahw->reset.buff == NULL)
+	if (ahw->reset.buff == NULL)
 		return -ENOMEM;
 
 	p_buff = p_dev->ahw->reset.buff;
-- 
2.20.1

