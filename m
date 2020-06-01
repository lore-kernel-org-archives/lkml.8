Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53333C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB7E20679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037946;
	bh=SsLiBfPUfwRMO5zOAfXQpcBzfExWYne2KkXaGffZrCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xffG0NHAxWucH+m03ol0Jqs73RHttA0ey281/C6nZwh2VTDj6bgaXNJEonBoY/fBi
	 R0VxH1nsDvsXRtNHYynoc5S8uol2hffGhurpPWLyQS7Xn1d9rkP+oscOCYm2W7HjLz
	 L25pZ9ggLIaTBkNtt4n8pD/nZNPGO02rPm233e34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgFAR55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgFAR5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:57:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C0372073B;
        Mon,  1 Jun 2020 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034270;
        bh=SsLiBfPUfwRMO5zOAfXQpcBzfExWYne2KkXaGffZrCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BB8FW0PtFQssryoHpVvvPjyHjRqphFwxg4qmQxDzCNpZxUq+ka5ChWlYX5wTMOx7p
         FSoq5osHlxVb4vE3pAcChdYX9yIK5oMNX4rDn+nA24rIVMVMmOV++RPEsQzzsxE7Dv
         AxT08sEiIdh9Diey4dB9MMBNYXldx36hd/vt3MAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coverity <scan-admin@coverity.com>,
        Steve French <stfrench@microsoft.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 19/61] cifs: Fix null pointer check in cifs_read
Date:   Mon,  1 Jun 2020 19:53:26 +0200
Message-Id: <20200601174015.342675377@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174010.316778377@linuxfoundation.org>
References: <20200601174010.316778377@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 9bd21d4b1a767c3abebec203342f3820dcb84662 ]

Coverity scan noted a redundant null check

Coverity-id: 728517
Reported-by: Coverity <scan-admin@coverity.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Shyam Prasad N <nspmangalore@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 09d83275c20b..b2919166855f 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3293,7 +3293,7 @@ cifs_read(struct file *file, char *read_data, size_t read_size, loff_t *offset)
 			 * than it negotiated since it will refuse the read
 			 * then.
 			 */
-			if ((tcon->ses) && !(tcon->ses->capabilities &
+			if (!(tcon->ses->capabilities &
 				tcon->ses->server->vals->cap_large_files)) {
 				current_read_size = min_t(uint,
 					current_read_size, CIFSMaxBufSize);
-- 
2.25.1



