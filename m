Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF89C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE272158C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582276;
	bh=xww3ha3RV/sRMp/8nxc5RDnUU7jjFcQdrVOpE9QJWXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E3cADFVn+wHCQXww6RL3WwLcUNf8BpLuI78zRrLsq4RLLMj/PddC57WNbmlzxxmT/
	 UZcQ75ZnYqxem7Vnz96hqV9n3gaJYRIJCJNhNh8Tp4xtQQrQzPbPSQd2Is1GBIyp1E
	 VZHIzt9QrR8hsqoyEpqv6YdiiqzEhN/qSKSh1y4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389766AbgFSPT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392583AbgFSPSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:18:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0901206DB;
        Fri, 19 Jun 2020 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579895;
        bh=xww3ha3RV/sRMp/8nxc5RDnUU7jjFcQdrVOpE9QJWXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5BhCUsx2ZXS3jpbirQy7lukob21IPkRz1wUUo15ut9ddgcZNveiI6yumJ2cnstu7
         eiOm1EpfgD0+h+OHjB1sxbtbSsi4N+PKKoGcSwwGmMa314+fiI5BA9CJQcsEWqGYWs
         VjYTVcllYDDq/42QEoqe+q0YsuNKgs8xdQbZR9lo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Frank Ch. Eigler" <fche@redhat.com>,
        Jeremy Cline <jcline@redhat.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 043/376] lockdown: Allow unprivileged users to see lockdown status
Date:   Fri, 19 Jun 2020 16:29:21 +0200
Message-Id: <20200619141712.397384086@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Cline <jcline@redhat.com>

[ Upstream commit 60cf7c5ed5f7087c4de87a7676b8c82d96fd166c ]

A number of userspace tools, such as systemtap, need a way to see the
current lockdown state so they can gracefully deal with the kernel being
locked down. The state is already exposed in
/sys/kernel/security/lockdown, but is only readable by root. Adjust the
permissions so unprivileged users can read the state.

Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
Cc: Frank Ch. Eigler <fche@redhat.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
Signed-off-by: James Morris <jmorris@namei.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/lockdown/lockdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 5a952617a0eb..87cbdc64d272 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -150,7 +150,7 @@ static int __init lockdown_secfs_init(void)
 {
 	struct dentry *dentry;
 
-	dentry = securityfs_create_file("lockdown", 0600, NULL, NULL,
+	dentry = securityfs_create_file("lockdown", 0644, NULL, NULL,
 					&lockdown_ops);
 	return PTR_ERR_OR_ZERO(dentry);
 }
-- 
2.25.1



