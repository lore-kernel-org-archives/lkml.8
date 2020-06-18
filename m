Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30DAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995322193E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592442901;
	bh=3FCVTIUBK2FrT/pFejJuUW8MW0xWwlLn2woVgszM86s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hMdLVYOsBZpgPx9EWi5WybsFhj0AKk2XWNH9zyrxrbLuSIqRp7/RJBkcUI0OvVC+Z
	 YvVoE39R/UHoH+1PBGmu1M33P2M3TWjf8+oTkJygjqHSzcVe8nnrXI/QLFOUErmoD2
	 MjIK5K5YNStjUci9qF529ibkjxiPq66iyTosIzR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgFRBO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbgFRBNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:13:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A80121974;
        Thu, 18 Jun 2020 01:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442810;
        bh=3FCVTIUBK2FrT/pFejJuUW8MW0xWwlLn2woVgszM86s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GItDV1A18buH7DxTDQVPKPpFe26FGjQlqE5zh6cl0jeDMGzv2WQjZviOclyJzuDwS
         ZwIva4l75sxWWNo/+h9+IN+vMPn76871NDY9moTNu6RVFm2tMZNow3l/GrZflhrcaH
         TP7Feb1gOIXjxbafTXIA04xSdm/DVf+UcaQWiadM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen Zhou <chenzhou10@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.7 249/388] powerpc/powernv: add NULL check after kzalloc
Date:   Wed, 17 Jun 2020 21:05:46 -0400
Message-Id: <20200618010805.600873-249-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Zhou <chenzhou10@huawei.com>

[ Upstream commit ceffa63acce7165c442395b7d64a11ab8b5c5dca ]

Fixes coccicheck warning:

./arch/powerpc/platforms/powernv/opal.c:813:1-5:
	alloc with no test, possible model on line 814

Add NULL check after kzalloc.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200509020838.121660-1-chenzhou10@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/opal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2b3dfd0b6cdd..d95954ad4c0a 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -811,6 +811,10 @@ static int opal_add_one_export(struct kobject *parent, const char *export_name,
 		goto out;
 
 	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+	if (!attr) {
+		rc = -ENOMEM;
+		goto out;
+	}
 	name = kstrdup(export_name, GFP_KERNEL);
 	if (!name) {
 		rc = -ENOMEM;
-- 
2.25.1

