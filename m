Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1592C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB7C2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738423;
	bh=S+w4KJDE5XByCpBm+fE8vRGeqF8zC6rTCNGq2iQEB5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VDEDsej+9toIvIFvr86yCGc1QcY98FabpC1/opSUAtfz7eHfbumcIhykw09DmuViV
	 WnvSaKZBeQzozOWvWnaruNEEDonl8ME0aeqHOuwbmK20ILPeoBMfA62wX0GMDxkpwJ
	 vNS5LFxTxpPnB5bchC/SiCxAbNrc1lrgQOB1a8CA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbgAKK1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:27:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbgAKK07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:26:59 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78DD020842;
        Sat, 11 Jan 2020 10:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738418;
        bh=S+w4KJDE5XByCpBm+fE8vRGeqF8zC6rTCNGq2iQEB5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cp8kZ7vD1TebMggLHxgE8TD7UoYsMm85CnzJJnUDfDukJMravnReqUjdkSuxVTrDE
         0Jpm7H2TA71Nk9TGLsZqs2Trqpe2PW4vOeb0HX2vtlVoZM8grhAFrQeaBAVaDiF59R
         NyH1Rv6Sjn0vqawcqn4Yyjgn6Kif+p3JRuAdHBwI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 073/165] btrfs: Fix error messages in qgroup_rescan_init
Date:   Sat, 11 Jan 2020 10:49:52 +0100
Message-Id: <20200111094927.278639956@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

[ Upstream commit 37d02592f11bb76e4ab1dcaa5b8a2a0715403207 ]

The branch of qgroup_rescan_init which is executed from the mount
path prints wrong errors messages. The textual print out in case
BTRFS_QGROUP_STATUS_FLAG_RESCAN/BTRFS_QGROUP_STATUS_FLAG_ON are not
set are transposed. Fix it by exchanging their place.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 27a903aaf43b..aeb5f2f3cdd7 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3232,12 +3232,12 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		if (!(fs_info->qgroup_flags &
 		      BTRFS_QGROUP_STATUS_FLAG_RESCAN)) {
 			btrfs_warn(fs_info,
-			"qgroup rescan init failed, qgroup is not enabled");
+			"qgroup rescan init failed, qgroup rescan is not queued");
 			ret = -EINVAL;
 		} else if (!(fs_info->qgroup_flags &
 			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
 			btrfs_warn(fs_info,
-			"qgroup rescan init failed, qgroup rescan is not queued");
+			"qgroup rescan init failed, qgroup is not enabled");
 			ret = -EINVAL;
 		}
 
-- 
2.20.1



