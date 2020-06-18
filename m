Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5FFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E556221ED
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444502;
	bh=K8ggbYfVXawYt0cRCMqwiU4eryBGWBPjIqLxyPT0/sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JgvQsY7EuPz299XI8mvupzgxM0D19XIhX97ScqSc3YgMuRkDFTDlTarfRgSAWHMM+
	 Pl59ZiDLT7t6rxODZFekoOESU/9MqzGW/eKyg7X/A57Av646c6sQkBUVSbdtSzOe8I
	 H0HrIO98+GgK/jcJIngWQit96GZPcvyHe4dWKbfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgFRBlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731676AbgFRB3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:29:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB3922242;
        Thu, 18 Jun 2020 01:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443779;
        bh=K8ggbYfVXawYt0cRCMqwiU4eryBGWBPjIqLxyPT0/sY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DfRYkuNO4REiGtuApAykZGdquCaa4t4YNf/0xg1QryNL6NfcFrKNp4ALB0QjVRaNY
         8PtQkkVqyoUebVKzsMoXh6ergX8vchBgh5aI2mMzKOepMYxlR2yZITKb53QsT+0S2u
         BS9GNcPDoNgaxHjRLMysgk/oxpHmm3jN8D2RCGNg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>, Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 62/80] usb: gadget: fix potential double-free in m66592_probe.
Date:   Wed, 17 Jun 2020 21:28:01 -0400
Message-Id: <20200618012819.609778-62-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012819.609778-1-sashal@kernel.org>
References: <20200618012819.609778-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit 44734a594196bf1d474212f38fe3a0d37a73278b ]

m66592_free_request() is called under label "err_add_udc"
and "clean_up", and m66592->ep0_req is not set to NULL after
first free, leading to a double-free. Fix this issue by
setting m66592->ep0_req to NULL after the first free.

Fixes: 0f91349b89f3 ("usb: gadget: convert all users to the new udc infrastructure")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/m66592-udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/m66592-udc.c b/drivers/usb/gadget/udc/m66592-udc.c
index 6e977dc22570..1be409644a48 100644
--- a/drivers/usb/gadget/udc/m66592-udc.c
+++ b/drivers/usb/gadget/udc/m66592-udc.c
@@ -1672,7 +1672,7 @@ static int m66592_probe(struct platform_device *pdev)
 
 err_add_udc:
 	m66592_free_request(&m66592->ep[0].ep, m66592->ep0_req);
-
+	m66592->ep0_req = NULL;
 clean_up3:
 	if (m66592->pdata->on_chip) {
 		clk_disable(m66592->clk);
-- 
2.25.1

