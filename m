Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49369C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 210A720658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919375;
	bh=wb9p2DCOeh7YwKQ76vVOAMWtHSt5r4AroP1eifuCw+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hceqTgJQgrfZY1/d5GzSDHvbfx59IBFxzonIbdnNVMiz9zopR7Q5S2pur/00InIe4
	 JxrE7NmuVwYaob3r0zw8pra6wm29C/mbBpaZNomcF16zVkjezTgtDDHU5iSRm1AgQy
	 Qwu2GBxUPHFRkM7BqbWCKcN6wF3dVhDfWugFTk04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbgHTK3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731522AbgHTKVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:21:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4544B2075E;
        Thu, 20 Aug 2020 10:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918873;
        bh=wb9p2DCOeh7YwKQ76vVOAMWtHSt5r4AroP1eifuCw+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p1R4Wt/7Sxz3OTIE4NpS4jk+XZYNoQtDGhRZpvIzAYp0DD87Yr9k7sDQ9lhEgCHPZ
         JksINMJXTQyJAABSacBUHWuk+QdlxTZ2LcV2qn7Guc27MYH3zHOzXeGQ8kvWFV10GL
         /423GGQzmdV+cG4CGdTGhup+3uTohJIAgcShTnoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 097/149] Smack: prevent underflow in smk_set_cipso()
Date:   Thu, 20 Aug 2020 11:22:54 +0200
Message-Id: <20200820092130.415903010@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 42a2df3e829f3c5562090391b33714b2e2e5ad4a ]

We have an upper bound on "maplevel" but forgot to check for negative
values.

Fixes: e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smackfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 2e2ef3a525ecb..df082648eb0aa 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -918,7 +918,7 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	}
 
 	ret = sscanf(rule, "%d", &maplevel);
-	if (ret != 1 || maplevel > SMACK_CIPSO_MAXLEVEL)
+	if (ret != 1 || maplevel < 0 || maplevel > SMACK_CIPSO_MAXLEVEL)
 		goto out;
 
 	rule += SMK_DIGITLEN;
-- 
2.25.1



