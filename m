Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4933EC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5672073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198219;
	bh=tN+nrpu0O13el+O6r0cMCE25B6OgGlRsyq0VNQmnf4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=euENE1BXT6NLTBBkIwJ+62nyDOkoc6s4oWmoy8LrGRafylNQyucZYVS1L5LIIDGtF
	 EVGDTcfxmVvOLaiI3Hg3RRCJ3GLSWBY6WsKhMMTMDwqJAaO1MzVBBZsJvAwutESa+y
	 VW44bnIZOPf7AstDNXrOpuV3nvx10E18DxrURA3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395099AbgAPSKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393246AbgAPRiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:38:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A178D246C3;
        Thu, 16 Jan 2020 17:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196279;
        bh=tN+nrpu0O13el+O6r0cMCE25B6OgGlRsyq0VNQmnf4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=emOCy29CRhBtyCUTFNaGLFKoPOVYAFqIkHXQhVbUbCaiH1sIM+cXZ7ZfFITjXu9cG
         p3bxdBoOZheDPLIoOGSK1qlzGeYyI9y4A/8gFZdQFkNHuzvzQyq6Ecrqo2mclHjTRE
         1xIR5TqLZfuBwIyaXbQ1RUjPG1ZEAUla86mfBVgo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 099/251] media: cx23885: check allocation return
Date:   Thu, 16 Jan 2020 12:34:08 -0500
Message-Id: <20200116173641.22137-59-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
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
index 818f3c2fc98d..1d86e57f4d9f 100644
--- a/drivers/media/pci/cx23885/cx23885-dvb.c
+++ b/drivers/media/pci/cx23885/cx23885-dvb.c
@@ -1471,8 +1471,9 @@ static int dvb_register(struct cx23885_tsport *port)
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

