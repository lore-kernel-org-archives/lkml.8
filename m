Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76231C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C53206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592585065;
	bh=qn7AOa62G/27kavDCg6/ccOrtB4coHWNJVvquYcj4Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IL7f+kosEabChnKn0yeN26VMa/m9lS2l1bLJw50xd21LdlyorO+VCqGbfI6qGgoRn
	 ejCU4R3Y2iezAm/1XBhiZ7lD00L83+hbBWwr91XtarMEP4Buu6qv/XEK0WbbFQYaI7
	 NlWZHrJmACPV5mLMq+fJqVRLANHZhwQpzWKGTmKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393986AbgFSQoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388455AbgFSOnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:43:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C617C20CC7;
        Fri, 19 Jun 2020 14:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577795;
        bh=qn7AOa62G/27kavDCg6/ccOrtB4coHWNJVvquYcj4Mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F6oRga5qwmEw9JkAnP9058FSxJTfTjR0idssvVolWEc3dtKz3rzJbO02zqu121ciF
         Bj8/SXCDt2F39z8DvsmrMJkFnBwICuxqyeGIGo0KVKw7PjimSqfurnjYFXX7Kl5eWV
         cjwySp1P5krLQHjeWROETF6vfKekSus2i60hP/qg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 063/128] btrfs: do not ignore error from btrfs_next_leaf() when inserting checksums
Date:   Fri, 19 Jun 2020 16:32:37 +0200
Message-Id: <20200619141623.547732225@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 7e4a3f7ed5d54926ec671bbb13e171cfe179cc50 ]

We are currently treating any non-zero return value from btrfs_next_leaf()
the same way, by going to the code that inserts a new checksum item in the
tree. However if btrfs_next_leaf() returns an error (a value < 0), we
should just stop and return the error, and not behave as if nothing has
happened, since in that case we do not have a way to know if there is a
next leaf or we are currently at the last leaf already.

So fix that by returning the error from btrfs_next_leaf().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/file-item.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index d0d571c47d33..4f919628137c 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -779,10 +779,12 @@ again:
 		nritems = btrfs_header_nritems(path->nodes[0]);
 		if (!nritems || (path->slots[0] >= nritems - 1)) {
 			ret = btrfs_next_leaf(root, path);
-			if (ret == 1)
+			if (ret < 0) {
+				goto out;
+			} else if (ret > 0) {
 				found_next = 1;
-			if (ret != 0)
 				goto insert;
+			}
 			slot = path->slots[0];
 		}
 		btrfs_item_key_to_cpu(path->nodes[0], &found_key, slot);
-- 
2.25.1



