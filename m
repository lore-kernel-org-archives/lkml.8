Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5492C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 00:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90FAE20738
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 00:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tl2HgLRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgGTANK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 20:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgGTANK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 20:13:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0401C0619D2;
        Sun, 19 Jul 2020 17:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=OoBxCM7kR8Bn+e6mXK1TKeVJzvNOOfwwqkj9KXYxgso=; b=Tl2HgLRl9N+TtT85weWwfaoaY4
        TWZ/f8kwZEnVbmrq+TGqh60mymp7HOPxg7+3tarbIN/EeD/D6AGp9zgR4V6mzpHbxxWKTmTrA9Xvr
        VAr3zURKbGBEBvbeWJ9PshVVs83ydZ5dXH46iVlXrpAEPN2nRVvUgHikReaRWNqn4c2DAVV1cqMbl
        mSfb6XZBQt24hxncavkRbu4RM8mucypL3eAkQ7bLH9OLtXO/1mVnRP0DOkfsTRAupuuiQh3QOB0fr
        +hRznH8LShMrW/G4xMNss1v091t8maUN6Ze8H17D+dwBorwDOR3nDMInofefEdMLvg5l17WQlsZBt
        7rvYUIbw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxJQY-0003w8-EM; Mon, 20 Jul 2020 00:13:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Subject: [PATCH] ceph: super.h: delete a duplicated word
Date:   Sun, 19 Jul 2020 17:12:59 -0700
Message-Id: <20200720001259.21668-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/super.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/fs/ceph/super.h
+++ linux-next-20200717/fs/ceph/super.h
@@ -353,7 +353,7 @@ struct ceph_inode_info {
 	unsigned i_dirty_caps, i_flushing_caps;     /* mask of dirtied fields */
 
 	/*
-	 * Link to the the auth cap's session's s_cap_dirty list. s_cap_dirty
+	 * Link to the auth cap's session's s_cap_dirty list. s_cap_dirty
 	 * is protected by the mdsc->cap_dirty_lock, but each individual item
 	 * is also protected by the inode's i_ceph_lock. Walking s_cap_dirty
 	 * requires the mdsc->cap_dirty_lock. List presence for an item can
