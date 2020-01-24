Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A17CC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6344D2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864701;
	bh=+o2ItOrpXjMGegFkdt3WLY/3y07xBRwUnmRwb4ZqWGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o8MNvCec3f8YWQVF0PdFvjEYFJQ2WaoKz+7Kye31xqv5DLn+cgQPERDXU5qpZhWNV
	 ZuR1NfmNueWKQ7L4vWR4kaM1wlVp4Qt7urC7DnUjN1Zj4dVYXxWhBKycovp/IK0Cqu
	 8D9WXH3moUOedsUDVgATQbWtm/epMOCSO8zW41WA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390633AbgAXLSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:18:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390623AbgAXLSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:18:18 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5405D2075D;
        Fri, 24 Jan 2020 11:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864697;
        bh=+o2ItOrpXjMGegFkdt3WLY/3y07xBRwUnmRwb4ZqWGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yFXBlbqwOc9S1gLnmHlbLqt8bs0jiMmEf5/sgaweh6N4egGhQkEmOfYvELytU17OD
         IqjY58bB5UepMk4tQy0mrHrKJEFYua5G65ANn7f0bXGJ/87VDwklZnyHu0Ji2dAR4W
         JPlh9WOXfTfr1Wa8otec+6i/qe9R4CC27uvcyQcs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 327/639] NFS: Dont interrupt file writeout due to fatal errors
Date:   Fri, 24 Jan 2020 10:28:17 +0100
Message-Id: <20200124093128.083330329@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

[ Upstream commit 14bebe3c90b326d2a0df78aed5e9de090c71d878 ]

When flushing out dirty pages, the fact that we may hit fatal errors
is not a reason to stop writeback. Those errors are reported through
fsync(), not through the flush mechanism.

Fixes: a6598813a4c5b ("NFS: Don't write back further requests if there...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 117ffd90419e2..e27637fa0f790 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -646,7 +646,7 @@ out:
 	return ret;
 out_launder:
 	nfs_write_error_remove_page(req);
-	return ret;
+	return 0;
 }
 
 static int nfs_do_writepage(struct page *page, struct writeback_control *wbc,
-- 
2.20.1



