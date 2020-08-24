Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AE6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5D0207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258092;
	bh=ObB8scPObpqBxHgYAz3uByh5AW7ZXQnLWcvr0snphRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nCvZ2NWEhKEa9RrZf7ai0xB9I6QkbzzaTZH4W6PlmcaJLzalEkZVp+oAPkUTNfUUc
	 8dSowqL3IdwLIC7P+utFRIqNJjB31Kc3KHXuw14rH4eweGyQ1QYKBWCEsfS7nUh5vf
	 rAgxwgZ6XX9i37VBnmmkse8e6GaAzvI7ePm8vdck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgHXIev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbgHXIek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:34:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52746206F0;
        Mon, 24 Aug 2020 08:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258079;
        bh=ObB8scPObpqBxHgYAz3uByh5AW7ZXQnLWcvr0snphRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNE38rRTwZ0FjEExwg6md2VVQRerjcuy0uvp9WZFqk3V3uh8YZ9EMs1wMo1tKteTr
         DQhoyOMRPgGhat9GKjbNjN0sKmh+9SXlY2tILVsEPUUykNT+EfWXUnoDaQ35ctiR/R
         76FU7O1Ssp6QCldKujwctaUjhsxKJsEN6ITu2gS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eiichi Tsukata <devel@etsukata.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 068/148] xfs: Fix UBSAN null-ptr-deref in xfs_sysfs_init
Date:   Mon, 24 Aug 2020 10:29:26 +0200
Message-Id: <20200824082417.335060916@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eiichi Tsukata <devel@etsukata.com>

[ Upstream commit 96cf2a2c75567ff56195fe3126d497a2e7e4379f ]

If xfs_sysfs_init is called with parent_kobj == NULL, UBSAN
shows the following warning:

  UBSAN: null-ptr-deref in ./fs/xfs/xfs_sysfs.h:37:23
  member access within null pointer of type 'struct xfs_kobj'
  Call Trace:
   dump_stack+0x10e/0x195
   ubsan_type_mismatch_common+0x241/0x280
   __ubsan_handle_type_mismatch_v1+0x32/0x40
   init_xfs_fs+0x12b/0x28f
   do_one_initcall+0xdd/0x1d0
   do_initcall_level+0x151/0x1b6
   do_initcalls+0x50/0x8f
   do_basic_setup+0x29/0x2b
   kernel_init_freeable+0x19f/0x20b
   kernel_init+0x11/0x1e0
   ret_from_fork+0x22/0x30

Fix it by checking parent_kobj before the code accesses its member.

Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
[darrick: minor whitespace edits]
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_sysfs.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_sysfs.h b/fs/xfs/xfs_sysfs.h
index e9f810fc67317..43585850f1546 100644
--- a/fs/xfs/xfs_sysfs.h
+++ b/fs/xfs/xfs_sysfs.h
@@ -32,9 +32,11 @@ xfs_sysfs_init(
 	struct xfs_kobj		*parent_kobj,
 	const char		*name)
 {
+	struct kobject		*parent;
+
+	parent = parent_kobj ? &parent_kobj->kobject : NULL;
 	init_completion(&kobj->complete);
-	return kobject_init_and_add(&kobj->kobject, ktype,
-				    &parent_kobj->kobject, "%s", name);
+	return kobject_init_and_add(&kobj->kobject, ktype, parent, "%s", name);
 }
 
 static inline void
-- 
2.25.1



