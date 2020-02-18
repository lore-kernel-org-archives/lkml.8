Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5005DC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2731C24654
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582055780;
	bh=1EFulnPCHgMnVTH9lfMBF8UDwfE32KxlB9KmML0iR7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fhJ5j4oJnioEYwWZc6OlhrXV/suwt3Kh/opc5rUxNNa1a9zqfDCKKk5EVTV/FEFJx
	 ol4GVXbRuM4Dxz0ZJnQGd/SDbrKkt5g+oaR/sUlUM9iU5y/JCvFNht0JIa4ppg6Mz1
	 Tzenun1trM3bBYDAQr3Fg0JzM0tPd1LPGQbH8LLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgBRT4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:56:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgBRT4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:56:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69A5724654;
        Tue, 18 Feb 2020 19:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582055775;
        bh=1EFulnPCHgMnVTH9lfMBF8UDwfE32KxlB9KmML0iR7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlm9hlNxX0kvEg/KRt0MH3/XJuHxMIv4qYVXGYzBCJlGXpP9Ep+LwBDFyMtXC67rT
         p1+v3IyCtQmkDXH3YIBxwIj68fgufAive2Q2b182x2h88hvBrcNb+puwBuUFks2GxU
         R0o4Xm4dRVLK3PMyqeCSCOY+p8Zza4/v6EQSXcLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 17/38] btrfs: ref-verify: fix memory leaks
Date:   Tue, 18 Feb 2020 20:55:03 +0100
Message-Id: <20200218190420.636463914@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190418.536430858@linuxfoundation.org>
References: <20200218190418.536430858@linuxfoundation.org>
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
@@ -747,6 +747,7 @@ int btrfs_ref_tree_mod(struct btrfs_root
 		 */
 		be = add_block_entry(root->fs_info, bytenr, num_bytes, ref_root);
 		if (IS_ERR(be)) {
+			kfree(ref);
 			kfree(ra);
 			ret = PTR_ERR(be);
 			goto out;
@@ -760,6 +761,8 @@ int btrfs_ref_tree_mod(struct btrfs_root
 			"re-allocated a block that still has references to it!");
 			dump_block_entry(fs_info, be);
 			dump_ref_action(fs_info, ra);
+			kfree(ref);
+			kfree(ra);
 			goto out_unlock;
 		}
 
@@ -822,6 +825,7 @@ int btrfs_ref_tree_mod(struct btrfs_root
 "dropping a ref for a existing root that doesn't have a ref on the block");
 				dump_block_entry(fs_info, be);
 				dump_ref_action(fs_info, ra);
+				kfree(ref);
 				kfree(ra);
 				goto out_unlock;
 			}
@@ -837,6 +841,7 @@ int btrfs_ref_tree_mod(struct btrfs_root
 "attempting to add another ref for an existing ref on a tree block");
 			dump_block_entry(fs_info, be);
 			dump_ref_action(fs_info, ra);
+			kfree(ref);
 			kfree(ra);
 			goto out_unlock;
 		}


