Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D180C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098CE2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582860;
	bh=6pPFugxbQhag+Gcg3s4zYYrpngAtaHNVwPKm2oVb/40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vFz9yNR/I6GvBy54kNlrWf03xV6wOdKP/BqYSIS2z54ATT+St8fdC/cFXRjyH3Grc
	 UY0lgP+Jwnadvnq/MFz3ZuvjuEtx9Jmg+tKE7SAeb+L/Ucu7hLA1zauq2pjB6h0jDR
	 9/jmt6sZ/o5WVA8Mzz6dtBYgnyI+VWn+LhIgnaWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391771AbgFSPIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391741AbgFSPIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:08:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9463820776;
        Fri, 19 Jun 2020 15:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579312;
        bh=6pPFugxbQhag+Gcg3s4zYYrpngAtaHNVwPKm2oVb/40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DSUfyt27TJCgRzGmZbszrbUIa8cbm6w2KrOu0FX4wgqEa60MoPJMxtPz+X1JO2lJt
         0/mRcxzpFWeBL46IKTTgfX7NPKL9SPPxZSBnkanJ8wXJXpevTHLrFB/AAKaUVQw8MZ
         XSYZDCwtSwv3TEKBmMhOGpawrLqKep5W7bcBHifg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 086/261] selinux: fix error return code in policydb_read()
Date:   Fri, 19 Jun 2020 16:31:37 +0200
Message-Id: <20200619141654.009625482@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 4c09f8b6913a779ca0c70ea8058bf21537eebb3b ]

Fix to return negative error code -ENOMEM from the kvcalloc() error
handling case instead of 0, as done elsewhere in this function.

Fixes: acdf52d97f82 ("selinux: convert to kvmalloc")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/ss/policydb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 1260f5fb766e..dd7aabd94a92 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2496,6 +2496,7 @@ int policydb_read(struct policydb *p, void *fp)
 	if (rc)
 		goto bad;
 
+	rc = -ENOMEM;
 	p->type_attr_map_array = kvcalloc(p->p_types.nprim,
 					  sizeof(*p->type_attr_map_array),
 					  GFP_KERNEL);
-- 
2.25.1



