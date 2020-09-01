Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991B6C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ABB620E65
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974672;
	bh=SF7cbSp+8aJt7HKiEK1+h754VI5LCsyUECgtetCo9QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UeyjMR6BtRo3JtihvJP57hDqb/eGME7Hf6S6eyOP27jg7HK1iIXez1CcUQc1kerPU
	 JF0g7tApYTlhHvMxfAv44H5OnIdXT7nKZqid7NF2CTbnc1PRU/DPDOowkI40z43Zyj
	 yaNJSkz/5CVQ37mp2p5c3BOAuiREXanriuWCp0DY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbgIAPhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:37:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731252AbgIAPgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:36:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7669120866;
        Tue,  1 Sep 2020 15:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974577;
        bh=SF7cbSp+8aJt7HKiEK1+h754VI5LCsyUECgtetCo9QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFabxefKhmPEr00TWsXzIMDVQyobFrGj0P+u747II8QCu4qorV/ROqegFkPf3HnX6
         Inb9wqyLOhCDb39l6U8wgELYX3e2ApTas8u8wCqBR3tm/0zgGij3TR0sTf5WldYUM8
         egKjk2HZ1qZ+kJOdZMNNf9YPJh++z1vcLla+ck/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju@tsinghua.edu.cn>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 015/255] media: pci: ttpci: av7110: fix possible buffer overflow caused by bad DMA value in debiirq()
Date:   Tue,  1 Sep 2020 17:07:51 +0200
Message-Id: <20200901151001.522065077@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju@tsinghua.edu.cn>

[ Upstream commit 6499a0db9b0f1e903d52f8244eacc1d4be00eea2 ]

The value av7110->debi_virt is stored in DMA memory, and it is assigned
to data, and thus data[0] can be modified at any time by malicious
hardware. In this case, "if (data[0] < 2)" can be passed, but then
data[0] can be changed into a large number, which may cause buffer
overflow when the code "av7110->ci_slot[data[0]]" is used.

To fix this possible bug, data[0] is assigned to a local variable, which
replaces the use of data[0].

Signed-off-by: Jia-Ju Bai <baijiaju@tsinghua.edu.cn>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ttpci/av7110.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/ttpci/av7110.c b/drivers/media/pci/ttpci/av7110.c
index d0cdee1c6eb0b..bf36b1e22b635 100644
--- a/drivers/media/pci/ttpci/av7110.c
+++ b/drivers/media/pci/ttpci/av7110.c
@@ -406,14 +406,15 @@ static void debiirq(unsigned long cookie)
 	case DATA_CI_GET:
 	{
 		u8 *data = av7110->debi_virt;
+		u8 data_0 = data[0];
 
-		if ((data[0] < 2) && data[2] == 0xff) {
+		if (data_0 < 2 && data[2] == 0xff) {
 			int flags = 0;
 			if (data[5] > 0)
 				flags |= CA_CI_MODULE_PRESENT;
 			if (data[5] > 5)
 				flags |= CA_CI_MODULE_READY;
-			av7110->ci_slot[data[0]].flags = flags;
+			av7110->ci_slot[data_0].flags = flags;
 		} else
 			ci_get_data(&av7110->ci_rbuffer,
 				    av7110->debi_virt,
-- 
2.25.1



