Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA556C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A64206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599587517;
	bh=EtnrMDPSnzBefgsxcNQ2r0meJuOKoRRndp64tejU9Qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uQH9hhm5dbK8oowbW9HzYhNDiflMDmga8BvA2/5BJiETeX7SoTS2KycVCFh+rVbgR
	 3bmMIEFStyBxJl5mJUcpIiqYIvEPXVBmXsYztt9LSE5Q2upOfgImYTyb0h51F0KiiR
	 BbI+CzcsmcfBXI7eB6btgZin/djwgkmRe4hyol34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbgIHRv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731591AbgIHQNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:13:44 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B96248AB;
        Tue,  8 Sep 2020 15:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580350;
        bh=EtnrMDPSnzBefgsxcNQ2r0meJuOKoRRndp64tejU9Qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxS7m2MDDFBGT0FQPl09tAty3/DQjQtm5zlDqAxV7w/4o1gQADlFppR8UUR3kOQc7
         U7ZVa2BpjcXtewzfjNRIe/d9G7R5FhOhBUT+thRWkIWgfo6BZnyHdJkItEr00o0shh
         EwnQfdF0GxHUNURg83UAvFtilVE0l9Qsoheg84cY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 40/65] btrfs: Remove extraneous extent_buffer_get from tree_mod_log_rewind
Date:   Tue,  8 Sep 2020 17:26:25 +0200
Message-Id: <20200908152219.101351925@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152217.022816723@linuxfoundation.org>
References: <20200908152217.022816723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

[ Upstream commit 24cee18a1c1d7c731ea5987e0c99daea22ae7f4a ]

When a rewound buffer is created it already has a ref count of 1 and the
dummy flag set. Then another ref is taken bumping the count to 2.
Finally when this buffer is released from btrfs_release_path the extra
reference is decremented by the special handling code in
free_extent_buffer.

However, this special code is in fact redundant sinca ref count of 1 is
still correct since the buffer is only accessed via btrfs_path struct.
This paves the way forward of removing the special handling in
free_extent_buffer.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 492a781c27cd4..ae8ac4837eb19 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1367,7 +1367,6 @@ tree_mod_log_rewind(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
 	btrfs_tree_read_unlock_blocking(eb);
 	free_extent_buffer(eb);
 
-	extent_buffer_get(eb_rewin);
 	btrfs_tree_read_lock(eb_rewin);
 	__tree_mod_log_rewind(fs_info, eb_rewin, time_seq, tm);
 	WARN_ON(btrfs_header_nritems(eb_rewin) >
-- 
2.25.1



