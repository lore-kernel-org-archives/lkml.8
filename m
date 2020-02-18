Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2431C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE6924670
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056076;
	bh=oHjNPYRc6V5pjSMnY/9ywhh4+Sjp1tPVDNCkJphgWzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AoUNqkpeEA5weJy2JoUAwPyH0FNkbK82D40ruXIjL6kl6xXls5PsIL65qD7+xcxye
	 o9jHSv/SLJy411sQRyFjDJtNsfuR9TMmD9XcjcEF9Pj1GAZ82bbF/8pVgAGsuYnnCM
	 WeNlGva62428imdGONyDMclO3Su9UckKvLDspSrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgBRUBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:01:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbgBRUBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:01:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E24D024670;
        Tue, 18 Feb 2020 20:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056068;
        bh=oHjNPYRc6V5pjSMnY/9ywhh4+Sjp1tPVDNCkJphgWzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXQl0/1VmfcqrOhcQ1AmvzNmsYMI9blyGYymGsXqxI1HTYde37HM5Ki7DwqTwwBJ8
         8Te359uEDR3/ryPvnYF20Exdosu+BUmBvXSzCNBPcpJqrFym9AnhhaomIdKxs4dNSp
         Ijl4f07aLZwh+POjosO9UyxeYcTaJHapaG9GYgpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.5 22/80] btrfs: ref-verify: fix memory leaks
Date:   Tue, 18 Feb 2020 20:54:43 +0100
Message-Id: <20200218190434.459046517@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
References: <20200218190432.043414522@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

commit f311ade3a7adf31658ed882aaab9f9879fdccef7 upstream.

In btrfs_ref_tree_mod(), 'ref' and 'ra' are allocated through kzalloc() and
kmalloc(), respectively. In the following code, if an error occurs, the
execution will be redirected to 'out' or 'out_unlock' and the function will
be exited. However, on some of the paths, 'ref' and 'ra' are not
deallocated, leading to memory leaks. For example, if 'action' is
BTRFS_ADD_DELAYED_EXTENT, add_block_entry() will be invoked. If the return
value indicates an error, the execution will be redirected to 'out'. But,
'ref' is not deallocated on this path, causing a memory leak.

To fix the above issues, deallocate both 'ref' and 'ra' before exiting from
the function when an error is encountered.

CC: stable@vger.kernel.org # 4.15+
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ref-verify.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -744,6 +744,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_i
 		 */
 		be = add_block_entry(fs_info, bytenr, num_bytes, ref_root);
 		if (IS_ERR(be)) {
+			kfree(ref);
 			kfree(ra);
 			ret = PTR_ERR(be);
 			goto out;
@@ -757,6 +758,8 @@ int btrfs_ref_tree_mod(struct btrfs_fs_i
 			"re-allocated a block that still has references to it!");
 			dump_block_entry(fs_info, be);
 			dump_ref_action(fs_info, ra);
+			kfree(ref);
+			kfree(ra);
 			goto out_unlock;
 		}
 
@@ -819,6 +822,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_i
 "dropping a ref for a existing root that doesn't have a ref on the block");
 				dump_block_entry(fs_info, be);
 				dump_ref_action(fs_info, ra);
+				kfree(ref);
 				kfree(ra);
 				goto out_unlock;
 			}
@@ -834,6 +838,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_i
 "attempting to add another ref for an existing ref on a tree block");
 			dump_block_entry(fs_info, be);
 			dump_ref_action(fs_info, ra);
+			kfree(ref);
 			kfree(ra);
 			goto out_unlock;
 		}


