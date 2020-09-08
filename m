Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBB7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2EC02074B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599587994;
	bh=RQUte2aRs3iXxquBXmpc6nmmKLRAgSCjyhjiTxlN/eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KrH1lSXX1aKLNjs6Khs6cDubkjlUSSgMgWNvevluZ1rZu/dmi0TVdSvhp4XYmB/pL
	 UxedP9HpbOAhUQXqrm2gLIAr9TK+/kyTNK5LhUuXLSaQYAQs2HS2p8aTTlfutPmRQ6
	 +6ucVRggWKfraMqri+tcFaOad1sg3pr9R/Ewc6qE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbgIHR7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:59:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731568AbgIHQMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:12:47 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F21802487E;
        Tue,  8 Sep 2020 15:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580327;
        bh=RQUte2aRs3iXxquBXmpc6nmmKLRAgSCjyhjiTxlN/eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdI1Q84p4BeUe1agdXrPTbI4VfgqypdJQU0odb8HRSGX50WxTgnpAQBZggc5LZixr
         eA+oJFH6fRf9dbX/D+gJIjZGpxynMONsB6nk3CBleJ2OxQVIM/ij13rvwV0Yh1pMS3
         QFzSblSPzeUSBNiB/KYdlS2X5bHNf3jNZahtiWkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 32/65] fix regression in "epoll: Keep a reference on files added to the check list"
Date:   Tue,  8 Sep 2020 17:26:17 +0200
Message-Id: <20200908152218.693996372@linuxfoundation.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 77f4689de17c0887775bb77896f4cc11a39bf848 ]

epoll_loop_check_proc() can run into a file already committed to destruction;
we can't grab a reference on those and don't need to add them to the set for
reverse path check anyway.

Tested-by: Marc Zyngier <maz@kernel.org>
Fixes: a9ed4a6560b8 ("epoll: Keep a reference on files added to the check list")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 00f0902e27e88..af9dfa494b1fa 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1901,9 +1901,9 @@ static int ep_loop_check_proc(void *priv, void *cookie, int call_nests)
 			 * during ep_insert().
 			 */
 			if (list_empty(&epi->ffd.file->f_tfile_llink)) {
-				get_file(epi->ffd.file);
-				list_add(&epi->ffd.file->f_tfile_llink,
-					 &tfile_check_list);
+				if (get_file_rcu(epi->ffd.file))
+					list_add(&epi->ffd.file->f_tfile_llink,
+						 &tfile_check_list);
 			}
 		}
 	}
-- 
2.25.1



