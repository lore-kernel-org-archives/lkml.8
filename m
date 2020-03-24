Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6B4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CE120775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056426;
	bh=5JBSIkC3TP1w0v29aCSo7yu3A3g7hc6op7y0mDD8IjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ktoi23Ac2KTUzKykj8bXEIcMaDssELgEvNBy2ttIhgi50VdIHM50Mn+hHnLZJCVJ8
	 oJZtD8DVI2dMJWV+9mHe0FIbbo6/9PGS2aFWNnAi2R5/nZyZME8fCQOG6Xm0B+AaVY
	 qkqsnAsut2B45J/TzKGjPQeYVfdgEyQK4jJ1/mmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgCXN1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729335AbgCXN1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:27:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3F42208CA;
        Tue, 24 Mar 2020 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056422;
        bh=5JBSIkC3TP1w0v29aCSo7yu3A3g7hc6op7y0mDD8IjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wCmdniqxD/PgK0/wtHiEuaAwvpb1AD87khY34saKuP4VIx9F/fueZAJ/khL6vEez7
         0hfhXJ3Y7mDVAGhaEWlgcvhihDJAMZhQwnEDKnmz3uZG9NI//zmOQuIUsugMN4rOV3
         1fI1vj40AMC8uLU2ne8gHrD3kSPLVZptqFpe6yhY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.5 111/119] btrfs: fix removal of raid[56|1c34} incompat flags after removing block group
Date:   Tue, 24 Mar 2020 14:11:36 +0100
Message-Id: <20200324130818.828760040@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit d8e6fd5c7991033037842b32c9774370a038e902 upstream.

We are incorrectly dropping the raid56 and raid1c34 incompat flags when
there are still raid56 and raid1c34 block groups, not when we do not any
of those anymore. The logic just got unintentionally broken after adding
the support for the raid1c34 modes.

Fix this by clear the flags only if we do not have block groups with the
respective profiles.

Fixes: 9c907446dce3 ("btrfs: drop incompat bit for raid1c34 after last block group is gone")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/block-group.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -849,9 +849,9 @@ static void clear_incompat_bg_bits(struc
 				found_raid1c34 = true;
 			up_read(&sinfo->groups_sem);
 		}
-		if (found_raid56)
+		if (!found_raid56)
 			btrfs_clear_fs_incompat(fs_info, RAID56);
-		if (found_raid1c34)
+		if (!found_raid1c34)
 			btrfs_clear_fs_incompat(fs_info, RAID1C34);
 	}
 }


