Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3B8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F32E2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597924184;
	bh=Xfmu0m+llcc95gIlz5bcfc4Sifh2ACawWvvoGyo5E0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FCp0AMh2Yp8kQ0Hjo/Fd/g0BoBpzkIrvCoyPoomN5hym3cLinBwhxCTUmsJjW9H0T
	 OUkWyd5pN+YxCXQemHjL+k419G6tk8FqOS21LEulVMhCiDpoz602rCV0nxwKuf6eAr
	 hX5pXlWRN5sg5ynPkTrgvELy6YEFR2vRHPo6Gh3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbgHTLtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729804AbgHTKDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:03:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C511122D03;
        Thu, 20 Aug 2020 10:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917811;
        bh=Xfmu0m+llcc95gIlz5bcfc4Sifh2ACawWvvoGyo5E0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0H0f5ROxYJO/TWKcS5sJQxM2l7ltY6+TcZqJCVaADTgaczQEleaMKk14e5GiS7RNH
         zqQ3y9G5lRsGFQ08w4KBVurRo0atXq9WEMyB10cCsXaZ1zzJ0byHTtwaeB9qjgSs7B
         bDAdcWl1bEQs0uHXP5dcm6h/g1fmJXSLVRNN2JQc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 136/212] Smack: prevent underflow in smk_set_cipso()
Date:   Thu, 20 Aug 2020 11:21:49 +0200
Message-Id: <20200820091609.222472988@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
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
index 2eba7c1e66630..4aecdc8f74b2a 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -907,7 +907,7 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	}
 
 	ret = sscanf(rule, "%d", &maplevel);
-	if (ret != 1 || maplevel > SMACK_CIPSO_MAXLEVEL)
+	if (ret != 1 || maplevel < 0 || maplevel > SMACK_CIPSO_MAXLEVEL)
 		goto out;
 
 	rule += SMK_DIGITLEN;
-- 
2.25.1



