Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9399C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80856206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598980152;
	bh=VaX1+Ny6L+YXxWnugwcXEPKB6ewm/BTnTiDqgAWIiVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SlEpSqFoETSQUWpnzbekvQswrF8rzxV7jxAkUQX/A+sIOaVX8Nwnr2iBQJ7XHfCj4
	 /4Oom/0gGNkxal7lcnW/B5u+0FkxJdjlxZGHqsFmC9oJB4YfK+rLNQ0JW1WrqKUpSQ
	 27LjR4sNpnCz1niPjdqxlJvnLadHpkujvig0wRCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgIARJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728670AbgIAPRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:17:48 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1068820767;
        Tue,  1 Sep 2020 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973467;
        bh=VaX1+Ny6L+YXxWnugwcXEPKB6ewm/BTnTiDqgAWIiVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UmBETSq3N0Rp9hw/xnVM61HhZSUje3V4oafbVsg0d53MopgSul3oyJ4DohESrGqAC
         l1/Oac/F5Z3A+ba0MIb9k+xq+aAkRV696wq/zh+AFt44mdGLostZ3fmCo/iIj+RIP6
         cdvCkahGFmTJMcisvquCZqMCEAFBtPvqu5CqO4jc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju@tsinghua.edu.cn>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 11/91] media: pci: ttpci: av7110: fix possible buffer overflow caused by bad DMA value in debiirq()
Date:   Tue,  1 Sep 2020 17:09:45 +0200
Message-Id: <20200901150928.666814366@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150928.096174795@linuxfoundation.org>
References: <20200901150928.096174795@linuxfoundation.org>
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
index f46947d8adf8f..fcc053d95ae49 100644
--- a/drivers/media/pci/ttpci/av7110.c
+++ b/drivers/media/pci/ttpci/av7110.c
@@ -423,14 +423,15 @@ static void debiirq(unsigned long cookie)
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



