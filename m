Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BB6C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2722222D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587050117;
	bh=abW9mqF4/+eweCUNjDjEwQ43Ov3PO8W9fEwl/H+1PM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gniIH5AhQrV2LlCEZ/CLNmno2i4CCmVniFYamTJBPdZXpZq6nuduVmHRBu92bMOwI
	 VjeZrMsHL+h3bA9h+saiv4xYDV2pe/BBZD/dVx0z4AyDakw5HWx/yDWyZ9sbiSnhdD
	 2RsU7x5U+0fWfVaxKme3TrJBxLNkIXALNH1JDuFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbgDPPPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441653AbgDPNuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:50:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ADCB221F7;
        Thu, 16 Apr 2020 13:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044980;
        bh=abW9mqF4/+eweCUNjDjEwQ43Ov3PO8W9fEwl/H+1PM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRgtykpXfzbv9+eun7cGMUFGVCYXec59sNT5vdeTTQs6r3b/02B+Zpg8gRMe6Pr5K
         d4VDGrKvSy+HH8rESIQTcZLDulP530cYfcGVv4BJeKzlRZBA6WH2ZkU6qOFzLlo9S0
         2bjI+OiIsPoXq3YyZ87djHOJ/0y81y04xm6hWSZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 139/232] btrfs: reloc: clean dirty subvols if we fail to start a transaction
Date:   Thu, 16 Apr 2020 15:23:53 +0200
Message-Id: <20200416131332.370952511@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit 6217b0fadd4473a16fabc6aecd7527a9f71af534 upstream.

If we do merge_reloc_roots() we could insert a few roots onto the dirty
subvol roots list, where we hold a ref on them.  If we fail to start the
transaction we need to run clean_dirty_subvols() in order to cleanup the
refs.

CC: stable@vger.kernel.org # 5.4+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/relocation.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4224,10 +4224,10 @@ restart:
 		goto out_free;
 	}
 	btrfs_commit_transaction(trans);
+out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
 		err = ret;
-out_free:
 	btrfs_free_block_rsv(fs_info, rc->block_rsv);
 	btrfs_free_path(path);
 	return err;
@@ -4625,10 +4625,10 @@ int btrfs_recover_relocation(struct btrf
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
-		goto out_free;
+		goto out_clean;
 	}
 	err = btrfs_commit_transaction(trans);
-
+out_clean:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
 		err = ret;


