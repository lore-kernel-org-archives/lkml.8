Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14962C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A5922D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597929779;
	bh=7cAz3Ec2k+7Y8nlZLkYt3m3jyL4YEhx1BCEiANHBXnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Y1401/eK3ZEIEctMpLS2TtrOQje0zPMO/1O2JP+fiDa6nX9TvR09fdOEXBZGm4Bi
	 Ia9naqHYMqOCcSx0d+ixRLYu4zSt5buEoTZiPVJ76J8RBcU61A4z5E1r0MU5pD5x3X
	 2QQl+V37o6xlrUtCCA85JB9Pwlg0Yo4QhJxYwG04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgHTNRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbgHTJez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:34:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBC7B20724;
        Thu, 20 Aug 2020 09:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916095;
        bh=7cAz3Ec2k+7Y8nlZLkYt3m3jyL4YEhx1BCEiANHBXnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVYNB8h6WrwwGG52s+B8KvIB/FgJ9Egxag0xMvTrz32Tnme5EZnbxgYfDjkwYR60R
         W3dApJnv/kfFdiCGX39329y/OAE/o4pWtEYTlpvzCW4Ra9JQCqzs5KGcNcSTL64yWc
         uDlOfoSniVhuIhMPs6ma/x7FPUlrVJKgLtRKO4Gw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.7 010/204] btrfs: allow use of global block reserve for balance item deletion
Date:   Thu, 20 Aug 2020 11:18:27 +0200
Message-Id: <20200820091606.724524770@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Sterba <dsterba@suse.com>

commit 3502a8c0dc1bd4b4970b59b06e348f22a1c05581 upstream.

On a filesystem with exhausted metadata, but still enough to start
balance, it's possible to hit this error:

[324402.053842] BTRFS info (device loop0): 1 enospc errors during balance
[324402.060769] BTRFS info (device loop0): balance: ended with status: -28
[324402.172295] BTRFS: error (device loop0) in reset_balance_state:3321: errno=-28 No space left

It fails inside reset_balance_state and turns the filesystem to
read-only, which is unnecessary and should be fixed too, but the problem
is caused by lack for space when the balance item is deleted. This is a
one-time operation and from the same rank as unlink that is allowed to
use the global block reserve. So do the same for the balance item.

Status of the filesystem (100GiB) just after the balance fails:

$ btrfs fi df mnt
Data, single: total=80.01GiB, used=38.58GiB
System, single: total=4.00MiB, used=16.00KiB
Metadata, single: total=19.99GiB, used=19.48GiB
GlobalReserve, single: total=512.00MiB, used=50.11MiB

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3235,7 +3235,7 @@ static int del_balance_item(struct btrfs
 	if (!path)
 		return -ENOMEM;
 
-	trans = btrfs_start_transaction(root, 0);
+	trans = btrfs_start_transaction_fallback_global_rsv(root, 0);
 	if (IS_ERR(trans)) {
 		btrfs_free_path(path);
 		return PTR_ERR(trans);


