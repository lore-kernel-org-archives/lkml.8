Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48211C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A03D2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944753;
	bh=SHAhC7DmFtppXWs7b0Kn01bV/vNSQiVgCjFt4xW8ddQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dJDMBKp66RSHJmXUyahW7PutaUShqXcYDeDff9L/xTLbex+K6KuIgr34/iaWjcSB1
	 bhb1YM5nIKpAv1qHtzxFm9rWmgu/YXbgr93QG5313AMhR/dkzetUh9auIhr4OPcpmW
	 tTRyefpmmwlFZwJd8y/P6Pwdj6a/1VQfXYF+vp0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392024AbgFWUjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403844AbgFWUjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:39:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E8502080C;
        Tue, 23 Jun 2020 20:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944745;
        bh=SHAhC7DmFtppXWs7b0Kn01bV/vNSQiVgCjFt4xW8ddQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gMxF6jZ+HE6SJEdPTvDc1rLKv9t8jryDyzhlscmcXWoNH+/2V4EdJFUHCF7Uy7vo9
         GDLALBoQPCV/mgkoKUCGfzMRH+UQle63BU5i3faH3S/voDgPJkJCVc1I19VRzZP/3J
         9lAVvlRGbPzc0w/GTW4oStXlumUqAPTKLe/lEtxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 109/206] usb: gadget: fix potential double-free in m66592_probe.
Date:   Tue, 23 Jun 2020 21:57:17 +0200
Message-Id: <20200623195322.306819485@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index a8288df6aadf0..ea59b56e54023 100644
--- a/drivers/usb/gadget/udc/m66592-udc.c
+++ b/drivers/usb/gadget/udc/m66592-udc.c
@@ -1667,7 +1667,7 @@ static int m66592_probe(struct platform_device *pdev)
 
 err_add_udc:
 	m66592_free_request(&m66592->ep[0].ep, m66592->ep0_req);
-
+	m66592->ep0_req = NULL;
 clean_up3:
 	if (m66592->pdata->on_chip) {
 		clk_disable(m66592->clk);
-- 
2.25.1



