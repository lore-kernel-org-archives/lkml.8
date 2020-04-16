Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D09FC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67CDB2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047142;
	bh=+09gj9DFydIP7mf6pVPiMl7RvRE9gZ7eUk45AMpunfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=syvy+D72D6zuirw7oaEnITT5lm/7SsCPyjGiHnQOSUCnhWOOh9H5U91+tb4+MejE8
	 sf7SXY9GWe0fHm+/yoEJ7hih3Z/IZVaNP7aMqqKfXRvD9MccvKXr/sq0mfe43whAd7
	 A7IqGKGkLlrAa0QUcd7Lk884QDCRRSSNSlqmWunI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410006AbgDPOZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636331AbgDPN6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:58:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90B952078B;
        Thu, 16 Apr 2020 13:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045486;
        bh=+09gj9DFydIP7mf6pVPiMl7RvRE9gZ7eUk45AMpunfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNdLLgjcx8bJjdK6Nnf9tCbzRM7as1TkycUgzAqhoEUCSw66QuvWQFEF0cdc8opU5
         gaW4VR/iL0+qVSrdHKa22W6iodkdhYrzsMBgib8z4+3WLDsRsexx3dXmKUWU9tuN+o
         qEtU+XijFdGMWwvSFn5hfBqMvU5OXVCpUF4b8LWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.6 155/254] btrfs: unset reloc control if we fail to recover
Date:   Thu, 16 Apr 2020 15:24:04 +0200
Message-Id: <20200416131345.994367461@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit fb2d83eefef4e1c717205bac71cb1941edf8ae11 upstream.

If we fail to load an fs root, or fail to start a transaction we can
bail without unsetting the reloc control, which leads to problems later
when we free the reloc control but still have it attached to the file
system.

In the normal path we'll end up calling unset_reloc_control() twice, but
all it does is set fs_info->reloc_control = NULL, and we can only have
one balance at a time so it's not racey.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/relocation.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4593,9 +4593,8 @@ int btrfs_recover_relocation(struct btrf
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		unset_reloc_control(rc);
 		err = PTR_ERR(trans);
-		goto out_free;
+		goto out_unset;
 	}
 
 	rc->merge_reloc_tree = 1;
@@ -4615,7 +4614,7 @@ int btrfs_recover_relocation(struct btrf
 		if (IS_ERR(fs_root)) {
 			err = PTR_ERR(fs_root);
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
-			goto out_free;
+			goto out_unset;
 		}
 
 		err = __add_reloc_root(reloc_root);
@@ -4625,7 +4624,7 @@ int btrfs_recover_relocation(struct btrf
 
 	err = btrfs_commit_transaction(trans);
 	if (err)
-		goto out_free;
+		goto out_unset;
 
 	merge_reloc_roots(rc);
 
@@ -4641,7 +4640,8 @@ out_clean:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
 		err = ret;
-out_free:
+out_unset:
+	unset_reloc_control(rc);
 	kfree(rc);
 out:
 	if (!list_empty(&reloc_roots))


