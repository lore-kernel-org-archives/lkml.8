Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC04C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECD421532
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582937;
	bh=gJnEIUMosMfO28LKrdnPOmXGxL4XDkNaNUGnHu7aZ6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1HeloQ5QF3NkqyOw4E8YAUIS8HNDhqk3uPs/INfY5eOUPxsQrzJAZdT9GA02Hq0br
	 u2Ls3F2WDRSj8djuHiUlGjuSpLomW4qvBlfxC1GjVYA5qKSDQsSRCmqvy6JuL8d2NV
	 hXeGV2TQa6bdkmeUTSow5W2c6reointfnahLxFkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393069AbgFSQIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391571AbgFSPHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:07:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D34D021835;
        Fri, 19 Jun 2020 15:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579242;
        bh=gJnEIUMosMfO28LKrdnPOmXGxL4XDkNaNUGnHu7aZ6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQsQ8dQuUZZkwU54svzPCwel2ETYUUqZ3PF9i6NlDFS4K8t1sRiBRQthZKDUHWQbk
         ti04VOh49GKf0UC+iTrwpe1fmWp77yCCzdycrUghKZaK+jsVAWCh2Cs0TH5PMbdchB
         Bo8egSirXppbNkUojle9Kxaz1aXkey7uX9em0K14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Frank Ch. Eigler" <fche@redhat.com>,
        Jeremy Cline <jcline@redhat.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 031/261] lockdown: Allow unprivileged users to see lockdown status
Date:   Fri, 19 Jun 2020 16:30:42 +0200
Message-Id: <20200619141651.403840598@linuxfoundation.org>
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
index b2f87015d6e9..3f38583bed06 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -177,7 +177,7 @@ static int __init lockdown_secfs_init(void)
 {
 	struct dentry *dentry;
 
-	dentry = securityfs_create_file("lockdown", 0600, NULL, NULL,
+	dentry = securityfs_create_file("lockdown", 0644, NULL, NULL,
 					&lockdown_ops);
 	return PTR_ERR_OR_ZERO(dentry);
 }
-- 
2.25.1



