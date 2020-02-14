Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88823C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634E22067D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701755;
	bh=8uG1pKmllG6vODb9BHuyO83kQ55D5RpViPviNkzTLOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y3QPh0XhczYV6iWLlVzYO3yxcBrXBvTFjqmgRc5bWnTnDC1UbSgDJNcjm9u9FFNyg
	 YGww2Hm3a9Dss8LUf5sWIsYgYXjobQ/IA2mt+GmmS2POxbUl35dbimFlqf6liyuvAq
	 dvgalX/6cFhIJDLU8cLZyEd+vgU3lWnNWGjEXAVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390199AbgBNRfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:35:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390067AbgBNQFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:05:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 053082467D;
        Fri, 14 Feb 2020 16:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696346;
        bh=8uG1pKmllG6vODb9BHuyO83kQ55D5RpViPviNkzTLOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v6kotx0uYbjCkpuHvjOmxE5NBX6x7bCnAeZYPqUgpWE2V/cHPj/wZf5hORjBM9lGW
         z2lvuOFS3kLGye/OWSU1oDY0HSE1j8ioppyOiFmtDJkvxt5WYBCmY5bcHsbs+01YAw
         DX+Dvnal7Yvq2iWJIIwanrrYUYiIN2dX/3HP4yL8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Hurley <john.hurley@netronome.com>,
        Sasha Levin <sashal@kernel.org>, oss-drivers@netronome.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 181/459] Revert "nfp: abm: fix memory leak in nfp_abm_u32_knode_replace"
Date:   Fri, 14 Feb 2020 10:57:11 -0500
Message-Id: <20200214160149.11681-181-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 1d1997db870f4058676439ef7014390ba9e24eb2 ]

This reverts commit 78beef629fd9 ("nfp: abm: fix memory leak in
nfp_abm_u32_knode_replace").

The quoted commit does not fix anything and resulted in a bogus
CVE-2019-19076.

If match is NULL then it is known there is no matching entry in
list, hence, calling nfp_abm_u32_knode_delete() is pointless.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: John Hurley <john.hurley@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/abm/cls.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/abm/cls.c b/drivers/net/ethernet/netronome/nfp/abm/cls.c
index 9f8a1f69c0c4c..23ebddfb95325 100644
--- a/drivers/net/ethernet/netronome/nfp/abm/cls.c
+++ b/drivers/net/ethernet/netronome/nfp/abm/cls.c
@@ -176,10 +176,8 @@ nfp_abm_u32_knode_replace(struct nfp_abm_link *alink,
 	u8 mask, val;
 	int err;
 
-	if (!nfp_abm_u32_check_knode(alink->abm, knode, proto, extack)) {
-		err = -EOPNOTSUPP;
+	if (!nfp_abm_u32_check_knode(alink->abm, knode, proto, extack))
 		goto err_delete;
-	}
 
 	tos_off = proto == htons(ETH_P_IP) ? 16 : 20;
 
@@ -200,18 +198,14 @@ nfp_abm_u32_knode_replace(struct nfp_abm_link *alink,
 		if ((iter->val & cmask) == (val & cmask) &&
 		    iter->band != knode->res->classid) {
 			NL_SET_ERR_MSG_MOD(extack, "conflict with already offloaded filter");
-			err = -EOPNOTSUPP;
 			goto err_delete;
 		}
 	}
 
 	if (!match) {
 		match = kzalloc(sizeof(*match), GFP_KERNEL);
-		if (!match) {
-			err = -ENOMEM;
-			goto err_delete;
-		}
-
+		if (!match)
+			return -ENOMEM;
 		list_add(&match->list, &alink->dscp_map);
 	}
 	match->handle = knode->handle;
@@ -227,7 +221,7 @@ nfp_abm_u32_knode_replace(struct nfp_abm_link *alink,
 
 err_delete:
 	nfp_abm_u32_knode_delete(alink, knode);
-	return err;
+	return -EOPNOTSUPP;
 }
 
 static int nfp_abm_setup_tc_block_cb(enum tc_setup_type type,
-- 
2.20.1

