Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915CCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5B02467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686476;
	bh=X2+KNYrnWc7xc7JQJmIwQfuTJNrbwS5UPIVPMmDqCPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RU60wVyTXLSBsBLlhlw0Mpfuf28RhfKjXeb1rUteLdRQ6y/lBEF7aTJyw4DdBZqJd
	 FzDyjWR6dm2qSfaqfV7Ia4Om4HB5B263wVfKFCMZvq1qjqumst1DkUY2M9VjU0OSdU
	 g8rZ0kjmsehu8bFI60GyobM83F1GQFt3bqpq2oqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgAVJrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:47:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:33090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729629AbgAVJlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:41:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 914F924686;
        Wed, 22 Jan 2020 09:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686102;
        bh=X2+KNYrnWc7xc7JQJmIwQfuTJNrbwS5UPIVPMmDqCPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6hkPNyK1kAbdCaXzpWQjbR8U70aBCsy24uTwNRQQTqvQsL8rf6sZ3U0G9qTWCDV2
         cfzMRzHX+O6lygq4EwitFOJ5GjggCXyc3gHjovv/k9TxS27+OrMKsB9onvRBJL1Bmj
         HfcloUCk71/3EjDl6Xo+YaMS1f3Ga8h6dbBVaJN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 044/103] btrfs: do not delete mismatched root refs
Date:   Wed, 22 Jan 2020 10:29:00 +0100
Message-Id: <20200122092810.489624554@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit 423a716cd7be16fb08690760691befe3be97d3fc upstream.

btrfs_del_root_ref() will simply WARN_ON() if the ref doesn't match in
any way, and then continue to delete the reference.  This shouldn't
happen, we have these values because there's more to the reference than
the original root and the sub root.  If any of these checks fail, return
-ENOENT.

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/root-tree.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -370,11 +370,13 @@ again:
 		leaf = path->nodes[0];
 		ref = btrfs_item_ptr(leaf, path->slots[0],
 				     struct btrfs_root_ref);
-
-		WARN_ON(btrfs_root_ref_dirid(leaf, ref) != dirid);
-		WARN_ON(btrfs_root_ref_name_len(leaf, ref) != name_len);
 		ptr = (unsigned long)(ref + 1);
-		WARN_ON(memcmp_extent_buffer(leaf, name, ptr, name_len));
+		if ((btrfs_root_ref_dirid(leaf, ref) != dirid) ||
+		    (btrfs_root_ref_name_len(leaf, ref) != name_len) ||
+		    memcmp_extent_buffer(leaf, name, ptr, name_len)) {
+			err = -ENOENT;
+			goto out;
+		}
 		*sequence = btrfs_root_ref_sequence(leaf, ref);
 
 		ret = btrfs_del_item(trans, tree_root, path);


