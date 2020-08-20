Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35A3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD54208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597917481;
	bh=d48/wqnRyveoPbGeJevVTB9ec4J9pTMHqjBH7dZK2gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j9Auu52O/QfDsRSe4sYlKaWWv2aS/6IJKespX+MXOfnoiTvKmgURbRFVqyMw7WDKW
	 hEQvmKh2I1zj562e7AT7tj6ywSF7Tt8gWA9VG8hRSIzUeMcwm8jKPFP4z5kLOmIhne
	 Slz3RY5b8P9FjQMYu01AApYMSaBppR6pQnbfNNyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgHTJ57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730290AbgHTJ5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:57:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E1F8207FB;
        Thu, 20 Aug 2020 09:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917449;
        bh=d48/wqnRyveoPbGeJevVTB9ec4J9pTMHqjBH7dZK2gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkWF7PN//VntkQ2jK7VBKadw6FObivtvDClaM8S3535uPozIvJ0QsJdDsLFITtSZn
         +1KRyZ/4maPQMVBbmJxPI4HH37sD+xvEbw7MSfhNV1Jh7+8OE793lC5Ob2RTXfhHbD
         r3T9yuFEwVdq57192utLgZ1TL4jCkY6OVUKZzAJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 006/212] media: rc: prevent memory leak in cx23888_ir_probe
Date:   Thu, 20 Aug 2020 11:19:39 +0200
Message-Id: <20200820091602.571979921@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
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
index c1aa888af7054..83864a99d3a66 100644
--- a/drivers/media/pci/cx23885/cx23888-ir.c
+++ b/drivers/media/pci/cx23885/cx23888-ir.c
@@ -1179,8 +1179,11 @@ int cx23888_ir_probe(struct cx23885_dev *dev)
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



