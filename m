Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA33C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E32207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597235365;
	bh=f3IsrBPjFZW9O/OhedYFTCoSyKNKxk+e2qJfKxrclSM=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=wL2exLvuXC6rxDxvCBgL8wMh+pHX0mgD9sIzjavdiB2X7cQl3k5XS4Uo0Od6brbKo
	 nlu87/UQDrJJGYrxTV+fH71OIve9WDVenrA28jz2Kt9QxEuxMaxtN3FRZqR2vLzRyj
	 hsx9u1VvuerDDG+tlF3jijgpdwJA0D2T2A4P4+hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHLM3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgHLM3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:29:22 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAEF3207DA;
        Wed, 12 Aug 2020 12:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597235362;
        bh=f3IsrBPjFZW9O/OhedYFTCoSyKNKxk+e2qJfKxrclSM=;
        h=From:To:Cc:Subject:Date:From;
        b=rNUF20X3nWg8kV4+NxvAKd+oCVMq6ffq/OhRQKtqqJiNfGaiM8Hdmx8fg6CwQjsBL
         WVDFozhoWymmDysCBdVSGi0SEsvYwp60v2Gi0p/JHZ1yBKDCqUUJqulFH7B+Qp6dIz
         7ue0qX2z4MgEu40CsS0I3IokL/gXWxg2T6kP2j7Q=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5psd-005f7j-MJ; Wed, 12 Aug 2020 14:29:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] spmi: get rid of a warning when built with W=1
Date:   Wed, 12 Aug 2020 14:29:18 +0200
Message-Id: <b7c07d7476697145bbd685d11a57b40d222f2c50.1597235356.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPMI core complaing with this warning when built with W=1:

	drivers/spmi/spmi.c: In function ‘spmi_controller_remove’:
	drivers/spmi/spmi.c:548:6: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]
	  548 |  int dummy;
	      |      ^~~~~

As the dummy var isn't needed, remove it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/spmi/spmi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index c16b60f645a4..fd3ff6079b15 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -545,13 +545,10 @@ static int spmi_ctrl_remove_device(struct device *dev, void *data)
  */
 void spmi_controller_remove(struct spmi_controller *ctrl)
 {
-	int dummy;
-
 	if (!ctrl)
 		return;
 
-	dummy = device_for_each_child(&ctrl->dev, NULL,
-				      spmi_ctrl_remove_device);
+	device_for_each_child(&ctrl->dev, NULL, spmi_ctrl_remove_device);
 	device_del(&ctrl->dev);
 }
 EXPORT_SYMBOL_GPL(spmi_controller_remove);
-- 
2.26.2

