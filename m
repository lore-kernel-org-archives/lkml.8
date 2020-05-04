Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802FAC4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F4A20705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615115;
	bh=2lgtyrcy13/KIsuN0+aBm+tMjlWylUgV/Zkq7C1wZYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jV+rZz5mXoJ0rTQM164ZlvRbLgtyqtX/cVImbJ2J0+Y4DrTIcxqYLc0lnetBLKHTD
	 taJUMGy6hdFcsRIhGVYYFYmvUfkphEIzPj/itXaOQ+tWPh/u4f2gvKZOTQqzgtw5zJ
	 qfy9rdgg7zEwXYpiJ/26i3JLuHRW4AmMe/pGm22g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgEDR6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbgEDR6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:58:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D67E206B8;
        Mon,  4 May 2020 17:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615114;
        bh=2lgtyrcy13/KIsuN0+aBm+tMjlWylUgV/Zkq7C1wZYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IjMitgWEJAvloFTMW3whC3UzKLuACtsl656lTo9zytds+TAyGLjbzvzOv05RG3His
         OuPDiJqv4khRlmPmeRn0O//CfmGeOudAm3K9PrI70Ai/pZPsBKMTJ43VoVYi/6SYvw
         IDl73Xj3p+4rcAMt4HsBbUzmOreLDnAkJAqlM0M0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>, stable@kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 01/18] ext4: fix special inode number checks in __ext4_iget()
Date:   Mon,  4 May 2020 19:56:59 +0200
Message-Id: <20200504165441.879121107@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165441.533160703@linuxfoundation.org>
References: <20200504165441.533160703@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

commit 191ce17876c9367819c4b0a25b503c0f6d9054d8 upstream.

The check for special (reserved) inode number checks in __ext4_iget()
was broken by commit 8a363970d1dc: ("ext4: avoid declaring fs
inconsistent due to invalid file handles").  This was caused by a
botched reversal of the sense of the flag now known as
EXT4_IGET_SPECIAL (when it was previously named EXT4_IGET_NORMAL).
Fix the logic appropriately.

Fixes: 8a363970d1dc ("ext4: avoid declaring fs inconsistent...")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable@kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4233,7 +4233,7 @@ struct inode *__ext4_iget(struct super_b
 	uid_t i_uid;
 	gid_t i_gid;
 
-	if (((flags & EXT4_IGET_NORMAL) &&
+	if ((!(flags & EXT4_IGET_SPECIAL) &&
 	     (ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO)) ||
 	    (ino < EXT4_ROOT_INO) ||
 	    (ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))) {


