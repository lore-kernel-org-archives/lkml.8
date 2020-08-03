Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6875CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393AF20678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458732;
	bh=5vqUXZqNHicOPd5VauNDyLWLLk0gMnVuZuYvgGZBg/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FCuzzKY4arO5t9CpD/T50tDSldinicIc0HNRuvg2lpuO7Dx3t+S6TWdDNBX6ZyzTa
	 bvoi0bzwpP85NtyK8Mkbh23e0hAl+ul3ARFrjVkechEunF5RyN7CKjrHM62te0budk
	 sYYKxAtcmQo9kXydNPUYC4NJMt80uU/GVRpXSGsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgHCM12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbgHCM1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:27:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CB91204EC;
        Mon,  3 Aug 2020 12:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457638;
        bh=5vqUXZqNHicOPd5VauNDyLWLLk0gMnVuZuYvgGZBg/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ie8Z9WVQ38c6oB9G8MxSkoK+NmyNI5pQ30aSGc0hL1ZvI3N6OtQbSXsDhVtHwwQGD
         0rkxM5rsGJJRF3sLBVjT520pheqAhhn9Bdip5E4op+CGkvjAZvcRE639ae42ZSuDBS
         pvCQK4A0MFXriePNOg5FM8UDsV1lev/Oq4Tsc5fc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 02/90] media: rc: prevent memory leak in cx23888_ir_probe
Date:   Mon,  3 Aug 2020 14:18:24 +0200
Message-Id: <20200803121857.663999765@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit a7b2df76b42bdd026e3106cf2ba97db41345a177 ]

In cx23888_ir_probe if kfifo_alloc fails the allocated memory for state
should be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx23885/cx23888-ir.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx23885/cx23888-ir.c b/drivers/media/pci/cx23885/cx23888-ir.c
index e880afe37f151..d59ca3601785e 100644
--- a/drivers/media/pci/cx23885/cx23888-ir.c
+++ b/drivers/media/pci/cx23885/cx23888-ir.c
@@ -1167,8 +1167,11 @@ int cx23888_ir_probe(struct cx23885_dev *dev)
 		return -ENOMEM;
 
 	spin_lock_init(&state->rx_kfifo_lock);
-	if (kfifo_alloc(&state->rx_kfifo, CX23888_IR_RX_KFIFO_SIZE, GFP_KERNEL))
+	if (kfifo_alloc(&state->rx_kfifo, CX23888_IR_RX_KFIFO_SIZE,
+			GFP_KERNEL)) {
+		kfree(state);
 		return -ENOMEM;
+	}
 
 	state->dev = dev;
 	sd = &state->sd;
-- 
2.25.1



