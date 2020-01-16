Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CFAC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928FE20730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194222;
	bh=J+v8LTbKNIpIwSqcGpwLTtXjKBtX7PN/R0fJXvGGMw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SpAnFf702HZydIm+yC1Wwz0BLGki9n4bxB1uc7GFXU0V9tkWJcKY4lSIwNBW+SK4x
	 ZVsIn194+FQjlnFjKGBBDYPl714Xa8y5VaP8gc+MGIYwAu1rVBUTHnQujwTJo5hO4T
	 UYo9QHER3mQw507IQc9dspRMPWLfBTEqdgJrzfN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbgAPRDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:03:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388497AbgAPRCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:02:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5CB32468C;
        Thu, 16 Jan 2020 17:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194172;
        bh=J+v8LTbKNIpIwSqcGpwLTtXjKBtX7PN/R0fJXvGGMw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMCqx8G3/8ah2HZ1yR0dmbUe4WuThqlWuute9VCbCGvri0pdqwhZdAmQtuUROwRtR
         +FS+wEmRDIZtFrg9OLoD31u3DowCsZjObxL0jl7fZfxY75viUqzNNy0cHIMNgTVU9L
         /jz6lN5qkF+LE7+Ltxj2F3QssCdNPhIyw24jWqyg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 251/671] media: cx23885: check allocation return
Date:   Thu, 16 Jan 2020 11:52:40 -0500
Message-Id: <20200116165940.10720-134-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit a3d7f22ef34ec4206b50ee121384d5c8bebd5591 ]

Checking of kmalloc() seems to have been committed - as
cx23885_dvb_register() is checking for != 0 return, returning
-ENOMEM should be fine here.  While at it address the coccicheck
suggestion to move to kmemdup rather than using kmalloc+memcpy.

Fixes: 46b21bbaa8a8 ("[media] Add support for DViCO FusionHDTV DVB-T Dual Express2")

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx23885/cx23885-dvb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/cx23885/cx23885-dvb.c b/drivers/media/pci/cx23885/cx23885-dvb.c
index 7d52173073d6..bafcb3982274 100644
--- a/drivers/media/pci/cx23885/cx23885-dvb.c
+++ b/drivers/media/pci/cx23885/cx23885-dvb.c
@@ -1474,8 +1474,9 @@ static int dvb_register(struct cx23885_tsport *port)
 		if (fe0->dvb.frontend != NULL) {
 			struct i2c_adapter *tun_i2c;
 
-			fe0->dvb.frontend->sec_priv = kmalloc(sizeof(dib7000p_ops), GFP_KERNEL);
-			memcpy(fe0->dvb.frontend->sec_priv, &dib7000p_ops, sizeof(dib7000p_ops));
+			fe0->dvb.frontend->sec_priv = kmemdup(&dib7000p_ops, sizeof(dib7000p_ops), GFP_KERNEL);
+			if (!fe0->dvb.frontend->sec_priv)
+				return -ENOMEM;
 			tun_i2c = dib7000p_ops.get_i2c_master(fe0->dvb.frontend, DIBX000_I2C_INTERFACE_TUNER, 1);
 			if (!dvb_attach(dib0070_attach, fe0->dvb.frontend, tun_i2c, &dib7070p_dib0070_config))
 				return -ENODEV;
-- 
2.20.1

