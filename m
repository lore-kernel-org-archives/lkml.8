Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10254C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47532088E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446212;
	bh=iwpDz4ivvU2NwI8cLZznxd63NSH1XaeXY624pIZQNsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G9R59NvLtmd4FWO5A7LyoRoWun7SKMBxvzhaeXm8Pw61miUJ7St9TwJ+bFAPSXCWt
	 IIpoTNKeaeY4muv6NO1L6XQbSug7sG9Kc4AGsc9a6jpqTdzqlgG4Yy/2dwzbbBZNH3
	 y7gfB2LjKOLZ6dl75b3CrsUuuWsXSFR4DmG1ekYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgFRCKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730611AbgFRBVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:21:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA2A820B1F;
        Thu, 18 Jun 2020 01:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443312;
        bh=iwpDz4ivvU2NwI8cLZznxd63NSH1XaeXY624pIZQNsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QeZYt41W7ND4/zvSnGW1u4vNB6S6Pcd2mbAHa4Gs18qJf8k6TzQd+FnV7oQB5iAkB
         dm5GRjkC4IS5/bi69WyVemdaV3aIFip/AeaMZd9wqDc7eJ0C2QkTl6KO3EW5paafpc
         eDPg4DNL6HpsWU3GprXo6sg2plkM+zIJBSCYXdJQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 249/266] afs: Fix memory leak in afs_put_sysnames()
Date:   Wed, 17 Jun 2020 21:16:14 -0400
Message-Id: <20200618011631.604574-249-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhihao Cheng <chengzhihao1@huawei.com>

[ Upstream commit 2ca068be09bf8e285036603823696140026dcbe7 ]

Fix afs_put_sysnames() to actually free the specified afs_sysnames
object after its reference count has been decreased to zero and
its contents have been released.

Fixes: 6f8880d8e681557 ("afs: Implement @sys substitution handling")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index fba2ec3a3a9c..106b27011f6d 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -562,6 +562,7 @@ void afs_put_sysnames(struct afs_sysnames *sysnames)
 			if (sysnames->subs[i] != afs_init_sysname &&
 			    sysnames->subs[i] != sysnames->blank)
 				kfree(sysnames->subs[i]);
+		kfree(sysnames);
 	}
 }
 
-- 
2.25.1

