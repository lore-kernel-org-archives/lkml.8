Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F41C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85A520702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598028731;
	bh=VaX1+Ny6L+YXxWnugwcXEPKB6ewm/BTnTiDqgAWIiVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1B/qeaWzbsIf+gHRsCry/C8LRv3HVpVvPXS41gafvmkdkn/txlWhI2i64TlVpz0u4
	 8FK+KlyO4VqfjysJveBcl5a9v/sll63HylyE92jshPqfBwjE6U1ZwjKFmRMlH96Q2x
	 LZ+v9pkVnMB3v/B7osDjr1erlEV7AImsEEWXTGpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgHUQv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbgHUQUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:20:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF53D22B49;
        Fri, 21 Aug 2020 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026745;
        bh=VaX1+Ny6L+YXxWnugwcXEPKB6ewm/BTnTiDqgAWIiVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmtFTa3w6WBdGA9bLYwogKDAiJDa6rm13XFfKQyNdgYBPKlm4L0ttT5/EfAAIIGz9
         SYfyL/wGO18MIk6QtN4AKqymuirVqfQj84tgLjN5CBNhTXD3QrCBH/zz2U3zHCKoO4
         Xbx164WJ5DoQqnCpPeW6FrEQyz+lfSnP0kuggYrk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju@tsinghua.edu.cn>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 06/30] media: pci: ttpci: av7110: fix possible buffer overflow caused by bad DMA value in debiirq()
Date:   Fri, 21 Aug 2020 12:18:33 -0400
Message-Id: <20200821161857.348955-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161857.348955-1-sashal@kernel.org>
References: <20200821161857.348955-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

