Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA25C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BCE208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565063;
	bh=e6ZbtL6uKzijKplzpSabQhYVd1hsxqGHDUAVZXO08oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E03StT/W+TT/vaj+08YQF+3gm/AsRYKqL8eWnwLpuAa8DnSv54bCsgCHKfYcXDF59
	 wP4O9xeLjbMrb9WAhMhOO38mVackNr/IP4DV3FEVmBHHM84wX3fG/JbozAVc1AOeO2
	 mXp1FhBl68nzVH9U3GI1Q6UR9Cqi1ThStFzvRzt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgCRU5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgCRU44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:56:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 556E521473;
        Wed, 18 Mar 2020 20:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584565016;
        bh=e6ZbtL6uKzijKplzpSabQhYVd1hsxqGHDUAVZXO08oY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1wVvfpXXeMT5anA+o/BQHwm4b9/kMWTXbwyEbPXfWgWztx3O4xqQJNejMCUKOAEbU
         QAbbhd/Pkja2OLvHo3jnMX0JsEvA+XPOyPwoh2wfg94N3UfsWU6GmF3Zo7abmBD3wj
         OnLG5TdGMfN3/jyI6tRRxshIZ+adCshbz9aqMsl4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 06/12] netfilter: cthelper: add missing attribute validation for cthelper
Date:   Wed, 18 Mar 2020 16:56:42 -0400
Message-Id: <20200318205648.17937-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205648.17937-1-sashal@kernel.org>
References: <20200318205648.17937-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit c049b3450072b8e3998053490e025839fecfef31 ]

Add missing attribute validation for cthelper
to the netlink policy.

Fixes: 12f7a505331e ("netfilter: add user-space connection tracking helper infrastructure")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink_cthelper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nfnetlink_cthelper.c b/net/netfilter/nfnetlink_cthelper.c
index ac143ae4f7b65..8c17338693432 100644
--- a/net/netfilter/nfnetlink_cthelper.c
+++ b/net/netfilter/nfnetlink_cthelper.c
@@ -711,6 +711,8 @@ static const struct nla_policy nfnl_cthelper_policy[NFCTH_MAX+1] = {
 	[NFCTH_NAME] = { .type = NLA_NUL_STRING,
 			 .len = NF_CT_HELPER_NAME_LEN-1 },
 	[NFCTH_QUEUE_NUM] = { .type = NLA_U32, },
+	[NFCTH_PRIV_DATA_LEN] = { .type = NLA_U32, },
+	[NFCTH_STATUS] = { .type = NLA_U32, },
 };
 
 static const struct nfnl_callback nfnl_cthelper_cb[NFNL_MSG_CTHELPER_MAX] = {
-- 
2.20.1

