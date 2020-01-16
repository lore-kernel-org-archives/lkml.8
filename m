Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0312BC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB36E2072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217222;
	bh=IL/aoOh9AuCGQjJL/BwlrmEDOqzkzTyXv6qi+8K5jeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NLTa1eC2aP+Q8AA9y4md9gp+OMD2JtHNNKsLVPMQEvZxNoWUn65FC5dXnFRnA+DkA
	 O/jGkvA8AZpJupmI7e7DltN0Ep49u9gpdGx81hqerVJus0e4ignUDOZUMPMuy04gX5
	 r+4GQq9NISsDZNuoBJIbk0vMt8DdzA83jzJEGRKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbgAPX1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:27:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388576AbgAPX0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:26:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE8E620684;
        Thu, 16 Jan 2020 23:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217195;
        bh=IL/aoOh9AuCGQjJL/BwlrmEDOqzkzTyXv6qi+8K5jeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=njlNV4PsNYKDnRvRivjguaXbqXF0ArjmozNq03pKkhBXwer8FG1zvIJ74tPKoz/Sp
         JfjQeZ7a9TzB/TytECemUtyAAM4m9Pqt/23HWUFuFVWYdkAyGmiWX27LK0Uk2z4mbh
         1TVSS9b0P/fTn1nDbh3UGsBuTTDBZsvgKxK5CMb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Richard Weinberger <richard@nod.at>,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH 5.4 162/203] Revert "ubifs: Fix memory leak bug in alloc_ubifs_info() error path"
Date:   Fri, 17 Jan 2020 00:17:59 +0100
Message-Id: <20200116231758.872830984@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Weinberger <richard@nod.at>

commit 91cbf01178c37086b32148c53e24b04cb77557cf upstream.

This reverts commit 9163e0184bd7d5f779934d34581843f699ad2ffd.

At the point when ubifs_fill_super() runs, we have already a reference
to the super block. So upon deactivate_locked_super() c will get
free()'ed via ->kill_sb().

Cc: Wenwen Wang <wenwen@cs.uga.edu>
Fixes: 9163e0184bd7 ("ubifs: Fix memory leak bug in alloc_ubifs_info() error path")
Reported-by: https://twitter.com/grsecurity/status/1180609139359277056
Signed-off-by: Richard Weinberger <richard@nod.at>
Tested-by: Romain Izard <romain.izard.pro@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/super.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2267,10 +2267,8 @@ static struct dentry *ubifs_mount(struct
 		}
 	} else {
 		err = ubifs_fill_super(sb, data, flags & SB_SILENT ? 1 : 0);
-		if (err) {
-			kfree(c);
+		if (err)
 			goto out_deact;
-		}
 		/* We do not support atime */
 		sb->s_flags |= SB_ACTIVE;
 		if (IS_ENABLED(CONFIG_UBIFS_ATIME_SUPPORT))


