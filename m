Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F04C3F351
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010F324697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812340;
	bh=jHR9r+mJqCqgX72W1j73v2wO3rq6zIuS09GGBsXXdh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LMDbsL5s8tLejZBHrgsQQ/f32/Sq/jUumshEtweb+iO1S5e7zFZExOsC+X76iN6og
	 IBzwbwsbEveFcHFqs/j7nyWEk7Y9xfx6ETMJRtlbpOTPYEMZbOVvmwiKFjnF/kjm8i
	 x/vIhPVa04cB11c61lhlfLVKF+jByzZjOPahGFaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbgB0OFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:05:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733005AbgB0OFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:05:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 824DA2469D;
        Thu, 27 Feb 2020 14:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812335;
        bh=jHR9r+mJqCqgX72W1j73v2wO3rq6zIuS09GGBsXXdh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LowZ+Xl3pzP0rxF1JVGAfuDQTITCihd5TJDLTvFxyUK7PFiy7fP2R/p9X1VGKBclc
         6S7khrY5AST0XSXSlyqNoF9nH/SJzWFFS3NuRiaS8LWfK+bws4ZBwZaKK/AkgeSzph
         Sx+W5BFLf+0XI6gNwMQfNXIPMEdYoWeEb1qSFdrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 76/97] btrfs: reset fs_root to NULL on error in open_ctree
Date:   Thu, 27 Feb 2020 14:37:24 +0100
Message-Id: <20200227132226.886831210@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
References: <20200227132214.553656188@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit 315bf8ef914f31d51d084af950703aa1e09a728c upstream.

While running my error injection script I hit a panic when we tried to
clean up the fs_root when freeing the fs_root.  This is because
fs_info->fs_root == PTR_ERR(-EIO), which isn't great.  Fix this by
setting fs_info->fs_root = NULL; if we fail to read the root.

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/disk-io.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3153,6 +3153,7 @@ retry_root_backup:
 	if (IS_ERR(fs_info->fs_root)) {
 		err = PTR_ERR(fs_info->fs_root);
 		btrfs_warn(fs_info, "failed to read fs tree: %d", err);
+		fs_info->fs_root = NULL;
 		goto fail_qgroup;
 	}
 


