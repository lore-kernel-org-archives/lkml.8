Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F6AC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D952173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340144;
	bh=9ZEfTlPJ7HVJU0ny0FcJ9LkkLSG0DsPnQSqKHUzEQVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=klLi2JXNPXK12vSs77gHfJxw2yDzIDxiLjz2FQ9bKg3Bx30X8gGQAx1nv7simi+PI
	 KIiyMBh/OCDD6627vIZ5f130/7uwy6J+S/0uw/vcg/Vc9MacssawkevIZpU8xJ4KSa
	 54D3Rf+qBQF/3SvA51vz194+zG0IRoWheQA2/lW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgEANfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730712AbgEANfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:35:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20E5E216FD;
        Fri,  1 May 2020 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340131;
        bh=9ZEfTlPJ7HVJU0ny0FcJ9LkkLSG0DsPnQSqKHUzEQVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SAsEAFaX7X4OkzIxNZu7wEPkYeFOAgSx6ulCJe42hWfZ3E3EaJRgRSLhpeWcFw8BU
         tCIOuQT3RGccr6bP4N/5Pc17wnWiRhpidLXoLg8BmCr9S9r39Ykf8WtBYLkEQvx3LS
         AhxLrZvPs+optbOGnZiUpkQXxCM5pminUi7On3oQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
        Theodore Tso <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 106/117] ext4: use matching invalidatepage in ext4_writepage
Date:   Fri,  1 May 2020 15:22:22 +0200
Message-Id: <20200501131557.944505287@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yangerkun <yangerkun@huawei.com>

[ Upstream commit c2a559bc0e7ed5a715ad6b947025b33cb7c05ea7 ]

Run generic/388 with journal data mode sometimes may trigger the warning
in ext4_invalidatepage. Actually, we should use the matching invalidatepage
in ext4_writepage.

Signed-off-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20200226041002.13914-1-yangerkun@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b0d5ca2c2b2a..0cbb241488ec3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2123,7 +2123,7 @@ static int ext4_writepage(struct page *page,
 	bool keep_towrite = false;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
-		ext4_invalidatepage(page, 0, PAGE_SIZE);
+		inode->i_mapping->a_ops->invalidatepage(page, 0, PAGE_SIZE);
 		unlock_page(page);
 		return -EIO;
 	}
-- 
2.20.1



