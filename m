Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0719C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9981920801
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586217775;
	bh=T/a03JFRVwZf26cJQ8+4XA7GcZj1JeU8Ggit0HX5RJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JRjG+orGv2Q3TZjkWGQFeYutMCvtetORGKH2rS9oSl3hOVOSd4yrJNVKPDJ267mSn
	 H34zAGiPriWsSfKKJnAIgV1Jgk+qtdB2L4ugVhQlFU2okisxJJHOzB6DW4XtSfnr6C
	 XmUUeN1PkFFZjEhx6UQTyHXpyb/VkeQHt9jsOvqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgDGACy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbgDGACt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:02:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C271E2082F;
        Tue,  7 Apr 2020 00:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586217769;
        bh=T/a03JFRVwZf26cJQ8+4XA7GcZj1JeU8Ggit0HX5RJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NO1CD4pDJL6ns7I4tk+g5FD8hoBk2/OR2h1OXZgIffG23Z5Y0oOA5+yPbhXSURZfw
         /dp/VKtGZ6e0V4BhNZdClyqMzc82pdKJfEAvFC3XYrZKgrS+SID+eVqtzk2BU/Ek3I
         XnuxTS0TF1O+CyEJTsnZZqTKQK8eF9Gv+Ea58J/I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xu Wang <vulab@iscas.ac.cn>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 12/13] qlcnic: Fix bad kzalloc null test
Date:   Mon,  6 Apr 2020 20:02:33 -0400
Message-Id: <20200407000234.17088-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407000234.17088-1-sashal@kernel.org>
References: <20200407000234.17088-1-sashal@kernel.org>
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

