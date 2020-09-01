Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E48C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2828020767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978426;
	bh=12JOAH0VTUXZinnu0n+/Whfv4+taCzf0ytk9XsIi58c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IHkZSvIN981G6tu3aLgibmeGdPf/hfCfRHe9eBLRmFUuVGaBcFdxbFY265SOyXG7S
	 8TP9SysrE0MTsqyIY0/d5m1uK0oTtmuNlmAP63lYLZaHXbSb1maa25ihZGuAkUUp1v
	 b2AxXKgM8/woHkwqkWGFsxakb5emCF9zlnkURvr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbgIAQkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729694AbgIAP2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:28:22 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 380242137B;
        Tue,  1 Sep 2020 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974101;
        bh=12JOAH0VTUXZinnu0n+/Whfv4+taCzf0ytk9XsIi58c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCsX0zKtKni3nrWy/i4M3nOsy6V1LVCdUut92qSPbhB/86PB/3R49Oav3/W1MAiwI
         x0NPXII2XLOut4TTR83cZ1JMSskHCHSbbuNE31yqNAjt35OemPDm7Alzv7K2GJiP+/
         +zqLc8EL+oC2LfTn2eVQe5u1Nv+ZHajWt+i/gebA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 045/214] cec-api: prevent leaking memory through hole in structure
Date:   Tue,  1 Sep 2020 17:08:45 +0200
Message-Id: <20200901150955.134426718@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 12d6764844724..ed75636a6fb34 100644
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



