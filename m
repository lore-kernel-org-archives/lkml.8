Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CDAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A741920702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598029162;
	bh=CuavRm0CKBzQlhflULSq+Uof+b5mUZFbdVDsHUwhgfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zLuG1E3kX8OtaL2ygZdlCY/oYY4vn6Le6FjYa5sqT/Vm49tbE4Rk0oHSAzepO0KTi
	 nmccVMqRNbPYPK58s3zPaeVGsZB8hx8PV4R4+BTct3p4UxdQeBV/D7iIOmVymjSObU
	 VUWmPUTRHCVEd+XgjEwAOwOsPpp7bvo4JXIsVhfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgHUQ7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:59:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728286AbgHUQTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:19:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FAC421741;
        Fri, 21 Aug 2020 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026722;
        bh=CuavRm0CKBzQlhflULSq+Uof+b5mUZFbdVDsHUwhgfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOY/r5pqQ7VRx/Km6e/pqZKqCes4HvMT1tOJBnkAhf6pysE/CTcBIlB2bk/4aJYJm
         PsZmsp7dYqc98fRoO17PArGUftFLiUAgP0KFN1tXFkTcHnp2q8OEmRA+Rd1YjQJ7l3
         KVmhjSuaJ5mqT1CGN/mMcu436bT8aLQr0jnl7ldk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 27/38] cec-api: prevent leaking memory through hole in structure
Date:   Fri, 21 Aug 2020 12:17:56 -0400
Message-Id: <20200821161807.348600-27-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161807.348600-1-sashal@kernel.org>
References: <20200821161807.348600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 6c42227c3467549ddc65efe99c869021d2f4a570 ]

Fix this smatch warning:

drivers/media/cec/core/cec-api.c:156 cec_adap_g_log_addrs() warn: check that 'log_addrs' doesn't leak information (struct has a hole after
'features')

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/cec/cec-api.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/cec/cec-api.c b/drivers/media/cec/cec-api.c
index 4961573850d54..b2b3f779592fd 100644
--- a/drivers/media/cec/cec-api.c
+++ b/drivers/media/cec/cec-api.c
@@ -147,7 +147,13 @@ static long cec_adap_g_log_addrs(struct cec_adapter *adap,
 	struct cec_log_addrs log_addrs;
 
 	mutex_lock(&adap->lock);
-	log_addrs = adap->log_addrs;
+	/*
+	 * We use memcpy here instead of assignment since there is a
+	 * hole at the end of struct cec_log_addrs that an assignment
+	 * might ignore. So when we do copy_to_user() we could leak
+	 * one byte of memory.
+	 */
+	memcpy(&log_addrs, &adap->log_addrs, sizeof(log_addrs));
 	if (!adap->is_configured)
 		memset(log_addrs.log_addr, CEC_LOG_ADDR_INVALID,
 		       sizeof(log_addrs.log_addr));
-- 
2.25.1

