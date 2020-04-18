Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A071AC38A30
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D6C2054F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587217982;
	bh=EESLg4YTW+c/e2tqVpoqnoRT3IqLFAmKCrOvge2esno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x6w1lrXkGvgrc3khSiAAfrH/j8T/vwZvuknYNdbVMnZYnABTHr4F4RqYxFVPnp6EL
	 nixm6Ya7xIyo89C2AIsA25g2xEEHhlJBbyWpvZE/P7adcfzMaUYE/CGHEaz0KJu38s
	 3FJtR03q+LH96R7zbrS0W47s18Q7NV209rRmpvpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgDRNxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 09:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgDRNsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 09:48:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E231022202;
        Sat, 18 Apr 2020 13:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587217712;
        bh=EESLg4YTW+c/e2tqVpoqnoRT3IqLFAmKCrOvge2esno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1wQcdqCND1NMv47sTnT79MzUiKDDuiEf/CUUnFylg1XhRAcR4eU8KeYQ0246BPoCa
         emMBwz1s0EH+BzqHgQpYcxYbBGFMAgvVc81+FQvdU8fekqAzWOl4byK8WOlaXFFqAq
         wy1F/zLbTCemFjyuR7cT0rT1Qq1I0aUG/3gh9piI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 14/73] ceph: don't skip updating wanted caps when cap is stale
Date:   Sat, 18 Apr 2020 09:47:16 -0400
Message-Id: <20200418134815.6519-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418134815.6519-1-sashal@kernel.org>
References: <20200418134815.6519-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yan, Zheng" <zyan@redhat.com>

[ Upstream commit 0aa971b6fd3f92afef6afe24ef78d9bb14471519 ]

1. try_get_cap_refs() fails to get caps and finds that mds_wanted
   does not include what it wants. It returns -ESTALE.
2. ceph_get_caps() calls ceph_renew_caps(). ceph_renew_caps() finds
   that inode has cap, so it calls ceph_check_caps().
3. ceph_check_caps() finds that issued caps (without checking if it's
   stale) already includes caps wanted by open file, so it skips
   updating wanted caps.

Above events can cause an infinite loop inside ceph_get_caps().

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 28ae0c1347004..d050acc1fd5d9 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1973,8 +1973,12 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
 		}
 
 		/* want more caps from mds? */
-		if (want & ~(cap->mds_wanted | cap->issued))
-			goto ack;
+		if (want & ~cap->mds_wanted) {
+			if (want & ~(cap->mds_wanted | cap->issued))
+				goto ack;
+			if (!__cap_is_valid(cap))
+				goto ack;
+		}
 
 		/* things we might delay */
 		if ((cap->issued & ~retain) == 0)
-- 
2.20.1

