Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D5DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D382072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597688047;
	bh=bN7E5iG/RTgo3CgEpGacs6B2YD4jqwur/wMV2RNafec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zY+AT1TPga7JnVXPZV3k4+638FpA67u8bLDKpf81dJlKQ0/Zn3pQEY6566pGnjBvk
	 yv2nYmvkfW7Phh5oR3CMPQ9ieOr6l9wiwvZu2ud6ukEWxyyCL2rQlpic42VvyoeZ5H
	 YjBfhXY/IcBEvm9S2a2wodF0Zk0ZcGnC52mXEx60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390322AbgHQSOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731059AbgHQQGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:06:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2FD0208E4;
        Mon, 17 Aug 2020 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680399;
        bh=bN7E5iG/RTgo3CgEpGacs6B2YD4jqwur/wMV2RNafec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2FJgANTeM47s28Nv45J+NekouDV7MZjUz85ulouL63SKD9IH8oKILm/7soQlXmVR
         nSt6Vlw6mBYG2kaU9QOU/DI5nxEoanWruQd72AI7aoln/jnPj9uexvRUUScVV3vtnJ
         /wfLcJQ35omdse0tHcjAlxKCCwwoX4xQ9sJFoovQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 172/270] Smack: prevent underflow in smk_set_cipso()
Date:   Mon, 17 Aug 2020 17:16:13 +0200
Message-Id: <20200817143804.396523979@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
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
index 2bae1fc493d16..9c4308077574c 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -884,7 +884,7 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	}
 
 	ret = sscanf(rule, "%d", &maplevel);
-	if (ret != 1 || maplevel > SMACK_CIPSO_MAXLEVEL)
+	if (ret != 1 || maplevel < 0 || maplevel > SMACK_CIPSO_MAXLEVEL)
 		goto out;
 
 	rule += SMK_DIGITLEN;
-- 
2.25.1



