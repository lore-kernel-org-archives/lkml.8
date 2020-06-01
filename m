Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93361C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6757320678
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591036725;
	bh=qqYvGaidwfg4zvFMt8jOwZD5KqkfullPtDDFDko273A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DfHIh0dNlpvbxYV0Nxju/msjhqNMW0268jJ0MyWPtQQ0Dbv+QcujKQwoTh/UBGViu
	 +sF2Zq43yaaVHL7tVn/0WlPk5Wai9c7y1BviybF5PJCHU9hF+LqowSJvMnTgq7o4As
	 3ezaVWMT3lgKTi+ZfTIviQ5UURbfY8IvlCL7oRJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbgFASio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731586AbgFASih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:38:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4F582074B;
        Mon,  1 Jun 2020 18:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591036419;
        bh=qqYvGaidwfg4zvFMt8jOwZD5KqkfullPtDDFDko273A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qVJKIijzyzGRpGzCLLAUITptTuR+bjLvtTz+VO6ijadSfOqU/fdTLC1LchMO19OyV
         B/4U29h3XSdjBwIflvuLxS6wU6RbadyFVJWAapKz9879yF2Ez9biVqZwfIm1JRJAcM
         6y8aCwInHu++XA4IO/y1SznegAB7M2Rct41DyIPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        =?UTF-8?q?Andrej=20Filip=C4=8Di=C4=8D?= <andrej.filipcic@ijs.si>
Subject: [PATCH 5.4 095/142] ceph: flush release queue when handling caps for unknown inode
Date:   Mon,  1 Jun 2020 19:54:13 +0200
Message-Id: <20200601174047.815799572@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit fb33c114d3ed5bdac230716f5b0a93b56b92a90d ]

It's possible for the VFS to completely forget about an inode, but for
it to still be sitting on the cap release queue. If the MDS sends the
client a cap message for such an inode, it just ignores it today, which
can lead to a stall of up to 5s until the cap release queue is flushed.

If we get a cap message for an inode that can't be located, then go
ahead and flush the cap release queue.

Cc: stable@vger.kernel.org
URL: https://tracker.ceph.com/issues/45532
Fixes: 1e9c2eb6811e ("ceph: delete stale dentry when last reference is dropped")
Reported-and-Tested-by: Andrej Filipčič <andrej.filipcic@ijs.si>
Suggested-by: Yan, Zheng <zyan@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 2d602c2b0ff6..b2695919435e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3938,7 +3938,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 			__ceph_queue_cap_release(session, cap);
 			spin_unlock(&session->s_cap_lock);
 		}
-		goto done;
+		goto flush_cap_releases;
 	}
 
 	/* these will work even if we don't have a cap yet */
-- 
2.25.1



