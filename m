Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101C1C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8026206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587045899;
	bh=T/a03JFRVwZf26cJQ8+4XA7GcZj1JeU8Ggit0HX5RJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kwmEWPtrVCLcO3oWuLZsHEX5GzaYrnA9d14YEM3OuDTQmfbFxhX9F1y6XEIBry3O8
	 uWCy1FLo9Tbzh1E0xj/WSzaAAk5HYv2uF0D21xtGTa01s6cgjsRRnA0hwjFbnL7qxY
	 mr07LuA2/5j1qJDjkw0pepgUsJ2M7rB0l20t/+As=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393152AbgDPOE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392251AbgDPNnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:43:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3193720732;
        Thu, 16 Apr 2020 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044589;
        bh=T/a03JFRVwZf26cJQ8+4XA7GcZj1JeU8Ggit0HX5RJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wO1BH6wYedoqualAEAXrZ+h1tSCADakWiFozQgtOMIWriprLbdPml2UMdnIusW5dM
         TnjkLT4vseD08djc2Q9qe5Ih7RJoouwFYvxqiHGYSOK1KflG1erspaOoG1jsJLcmbI
         GqMlUn9lt5dv7aebUijl6/84IcxOjtcR/b/dC3eY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Wang <vulab@iscas.ac.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 021/232] qlcnic: Fix bad kzalloc null test
Date:   Thu, 16 Apr 2020 15:21:55 +0200
Message-Id: <20200416131318.980828264@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



