Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925EDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D7020734
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592585611;
	bh=m7itLL+suMvKrE4Ih6Lu806CDHzZ1b+4jWpo97SiUQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kvVoWPIo2qqz+AKFla3A7us/K6n6Sne+i1XUyoBLAc1nrPRxledFg2ugKsU94lA5N
	 vpQZ0NJmH2BRBS/838HOyAX/43NPaBlto2ebk8VYEbMjJWEPPO2rAy9EePEZ+mbXsr
	 FTNWYEGADwIn1A2OT7+wLKwsNqeuTqZVWkh54gmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbgFSQx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387697AbgFSOhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:37:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E344E20CC7;
        Fri, 19 Jun 2020 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577440;
        bh=m7itLL+suMvKrE4Ih6Lu806CDHzZ1b+4jWpo97SiUQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOvhpDt31vl6RUeC66FrKbdk04BAfR1vseeSBAnulzAdSa+QkEFBNKR/qMDCtwqZI
         hF8BR/4Iv05gHsWe0M2+xzO5RUQQjKtAcqebc9AaZzylUy+mSsIvN6L2dBZveiRMo3
         yB82StbhvYWzmzIGnj90Re+tUIXPqKi35GTE9K5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 051/101] btrfs: do not ignore error from btrfs_next_leaf() when inserting checksums
Date:   Fri, 19 Jun 2020 16:32:40 +0200
Message-Id: <20200619141616.735284582@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141614.001544111@linuxfoundation.org>
References: <20200619141614.001544111@linuxfoundation.org>
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
index 58ece6558430..fb5c97ea670f 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -742,10 +742,12 @@ again:
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



