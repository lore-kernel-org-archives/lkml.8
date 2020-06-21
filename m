Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F63C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 05:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36412479B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 05:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="MmB9gFrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgFUFq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 01:46:27 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17185 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbgFUFq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 01:46:27 -0400
X-Greylist: delayed 910 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jun 2020 01:46:26 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1592717468; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=PG+gT53m50blBYBKu3rXvb37BnPHGejAeXguu4NXFnNPFA29XvBNQg0+50YhPyTFf4yN9Pwo4XW+uPOY3aIDP5VHAHxNY81L2ReQkWi+EeNWrqGI+41/YT15bohADHuqftapMtHafLeVYP42DlpaNe8HXeL+PtxRIwEQ15sSK9A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1592717468; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=ncGOVGTvVXr8HQdPUjbtNc/ZzWf+9iRtPISZt83WDGs=; 
        b=fgNoZzFZERJ2+LwtzhV+fUP1IQApZfJGFiPfTzI4IV2oUzfR5tzTHzgrD6aOecKFGiSiCw7hGozR+7mYfFejm1THGsKc0ehcHYXc9bbnmPxfP3isXCYg6RNZ5Bh+iG/7G/Qr9IhqA6+1F4B0Royv5eK67cZyAorifNCVg7CRfo8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1592717468;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=ncGOVGTvVXr8HQdPUjbtNc/ZzWf+9iRtPISZt83WDGs=;
        b=MmB9gFrMT+YbnSW1Qt/ADDSaHZABafbFcKGO0aMC1cDWGGV5lRezItHATGoZ2K5g
        OuwnU+ujAWa/sxxZhoX/UAdUs40yHH2VarLNWm7JjQarQDL3Vs2ze0FjfWwds8St9MI
        c3GAjwEXZVo7o1GKhFfl/Ubywhe9xc4qs0HToelg=
Received: from localhost.localdomain (113.87.91.105 [113.87.91.105]) by mx.zoho.com.cn
        with SMTPS id 1592717466309467.4152727314364; Sun, 21 Jun 2020 13:31:06 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Subject: [PATCH] quota: minor optimization for __dquot_initialize()
Date:   Sun, 21 Jun 2020 13:31:00 +0800
Message-Id: <20200621053100.11713-1-cgxu519@mykernel.net>
X-Mailer: git-send-email 2.17.2
X-ZohoCNMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Count the number of quotas which are needed to initialize,
instead of just setting to 1 so that we may avoid unnecessary
process in special case.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/quota/dquot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 7b4bac91146b..f93bd60c3998 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1459,7 +1459,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 		if (!sb_has_quota_active(sb, cnt))
 			continue;
 
-		init_needed = 1;
+		init_needed++;
 
 		switch (cnt) {
 		case USRQUOTA:
@@ -1483,6 +1483,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 				goto out_put;
 			}
 			dquot = NULL;
+			init_needed--;
 		}
 		got[cnt] = dquot;
 	}
-- 
2.17.2

