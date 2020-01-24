Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08E5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3D82071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864500;
	bh=7zmx5lstEh3h7RXG3u58tR1w29WMv3ONXGIMt7CYEFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TQ1Qs09ZrKcC2dUdmRgoNEM95teuHklcj1mpQqrD8qGP8dysYQK1aZnzZIXIGIVji
	 hZ3njWAmDP4iJlaxvAOeb+J5CbUH5ap6GGWM7qozoaJFa8OiaddbCGDhmAmf0zrT8R
	 iJQwkRTZQNN6H7r6DUfhoYVkN273wjNOzxDGn/7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbgAXLPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:15:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389143AbgAXLOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:14:54 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31CC324658;
        Fri, 24 Jan 2020 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864493;
        bh=7zmx5lstEh3h7RXG3u58tR1w29WMv3ONXGIMt7CYEFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ay/YFw0KetXIah6GS++8Q9B0DhPSel5Ln+mcfDSIG+1VGVFu4xmHocMhm+MbGAq1W
         f8vwajDUPAQFa1KIsSm3Wqm8INzt2JtRBqAIYvM8llj3j/k6c+tqQwOjfWh7zzPtim
         3VJcpk1fjRO6+IxqSQZDsLvhHvG1H7GQqS9kxEUc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 267/639] media: cx23885: check allocation return
Date:   Fri, 24 Jan 2020 10:27:17 +0100
Message-Id: <20200124093120.157000436@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 7d52173073d6e..bafcb39822747 100644
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



