Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3BFC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0564208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846453;
	bh=+lIJtQNb3GDX3UdUpxWon3y+MZGFtP4kv/JLgQFn/50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QDLJLGgUBB+z3rdVaYqOO1v0Dge3Hg/5nxwC5qA5xogDMGzgCws9CxqEww4YtgZn7
	 jX4RGxU3llC8E5qcBc7OTqoYRUaMWPQy0Y2dmWsK2jQOzTsO9kt1BT6Psyq9hZ0p2V
	 Ek/W5iGt9dYEHR1T5KSbCOJ8ZScTBC7ApnKCL9/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbgCJNGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730486AbgCJNGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:06:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA2CE20873;
        Tue, 10 Mar 2020 13:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845603;
        bh=+lIJtQNb3GDX3UdUpxWon3y+MZGFtP4kv/JLgQFn/50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CmgQUakaTw4EpnhZnVvGaB53L+Oy7S0qH2GEUG3m5YAd9UzBfqmn5KkiaFySEATuB
         RNdQPLGERpBCv24UqEkVBmbwRhzGYbArtxS/AfvWvFz+Go5ieM680DeszBb4MBBAbn
         Px8+hFRi72tEiamckCSmh9U6BE1cP9FldjUY6O/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suraj Jitindar Singh <surajjs@amazon.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, stable@kernel.org,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 034/126] ext4: potential crash on allocation error in ext4_alloc_flex_bg_array()
Date:   Tue, 10 Mar 2020 13:40:55 +0100
Message-Id: <20200310124206.579194582@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 37b0b6b8b99c0e1c1f11abbe7cf49b6d03795b3f upstream.

If sbi->s_flex_groups_allocated is zero and the first allocation fails
then this code will crash.  The problem is that "i--" will set "i" to
-1 but when we compare "i >= sbi->s_flex_groups_allocated" then the -1
is type promoted to unsigned and becomes UINT_MAX.  Since UINT_MAX
is more than zero, the condition is true so we call kvfree(new_groups[-1]).
The loop will carry on freeing invalid memory until it crashes.

Fixes: 7c990728b99e ("ext4: fix potential race between s_flex_groups online resizing and access")
Reviewed-by: Suraj Jitindar Singh <surajjs@amazon.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20200228092142.7irbc44yaz3by7nb@kili.mountain
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2238,7 +2238,7 @@ int ext4_alloc_flex_bg_array(struct supe
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct flex_groups **old_groups, **new_groups;
-	int size, i;
+	int size, i, j;
 
 	if (!sbi->s_log_groups_per_flex)
 		return 0;
@@ -2259,8 +2259,8 @@ int ext4_alloc_flex_bg_array(struct supe
 					 sizeof(struct flex_groups)),
 					 GFP_KERNEL);
 		if (!new_groups[i]) {
-			for (i--; i >= sbi->s_flex_groups_allocated; i--)
-				kvfree(new_groups[i]);
+			for (j = sbi->s_flex_groups_allocated; j < i; j++)
+				kvfree(new_groups[j]);
 			kvfree(new_groups);
 			ext4_msg(sb, KERN_ERR,
 				 "not enough memory for %d flex groups", size);


