Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D53C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A484320724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916209;
	bh=jGRWsaqRLoqev79/Xwgz7bNFRX+HkBGl7u0ryE7d7hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vyr7CwsAIt7v3ph5q/KuBMRBrjsFloheEmIMUxhzXvlxlxiyokT1Jujue7cqJtowB
	 2bLZXVoB3n33GyLf98tuM5MQytbs84X5HejLta6pMGsyKKElwOr2VKsCf8OJZLssF8
	 mv8lJbPPjepsUtTWxh9EJGoBB3u2MibqbiHPvldU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgHTJgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbgHTJgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:36:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87A7220724;
        Thu, 20 Aug 2020 09:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916199;
        bh=jGRWsaqRLoqev79/Xwgz7bNFRX+HkBGl7u0ryE7d7hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XanOR9F5wVE3CceZ5M6m3WIVGcASKsjKeLML5aslTzI0oN9VAu04jXSbIS0cZAY3w
         pQAtw3EnWkFAG0o7xBfw7cQppOUXdNfQw3xDbZj0AH2xQgy5v3ayPiqu/8FFt9sddj
         h9olyEHJZGgpvhdaQTAp0utZgT/SX47nWD0bWY68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.7 027/204] btrfs: dont WARN if we abort a transaction with EROFS
Date:   Thu, 20 Aug 2020 11:18:44 +0200
Message-Id: <20200820091607.624205450@linuxfoundation.org>
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

From: Josef Bacik <josef@toxicpanda.com>

commit f95ebdbed46a4d8b9fdb7bff109fdbb6fc9a6dc8 upstream.

If we got some sort of corruption via a read and call
btrfs_handle_fs_error() we'll set BTRFS_FS_STATE_ERROR on the fs and
complain.  If a subsequent trans handle trips over this it'll get EROFS
and then abort.  However at that point we're not aborting for the
original reason, we're aborting because we've been flipped read only.
We do not need to WARN_ON() here.

CC: stable@vger.kernel.org # 5.4+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ctree.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3198,7 +3198,7 @@ do {								\
 	/* Report first abort since mount */			\
 	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
 			&((trans)->fs_info->fs_state))) {	\
-		if ((errno) != -EIO) {				\
+		if ((errno) != -EIO && (errno) != -EROFS) {		\
 			WARN(1, KERN_DEBUG				\
 			"BTRFS: Transaction aborted (error %d)\n",	\
 			(errno));					\


