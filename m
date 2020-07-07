Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D519C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397A92078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594134874;
	bh=qLMUC6+uDC61IlVZVqhCF7zyC2j3eb/UOvWXtDlHzqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fhfZSPGwn5MiMZlYRUzTnELAsRx/A5/fJ9AWa75R8XLJQ8DasIRjFAGMxW8JQQJd7
	 5Yb5JJJ4BGQh3pHhdC8vzs4ih9cUKAhfU2EXnk40dxe2qUnQYSYwGOV6wETCS66nlB
	 bl2DEfl3BtpGeCAObFWPoIMVH+0S3wzaJdIftvoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgGGPOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbgGGPO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:14:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E73E1207C4;
        Tue,  7 Jul 2020 15:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594134868;
        bh=qLMUC6+uDC61IlVZVqhCF7zyC2j3eb/UOvWXtDlHzqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OkYxCS7NmPixzOo3Xn+dmDyiuykwTzNMkQSbOxg4yztFn3o4QgAlBBLYZy6P6TYm7
         fGGhyJRRecnn2vVMlxU3IZo9LevaxcQ/bDk7oNMVxfuE/qdvs1BAvLHUKrIfnPfcXI
         Ch0lONt38zixZesWGdTZKlkGVszaLQqB9tmmnkSs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Aurich <paul@darkrain42.org>,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 4.9 19/24] SMB3: Honor seal flag for multiuser mounts
Date:   Tue,  7 Jul 2020 17:13:51 +0200
Message-Id: <20200707145749.901516030@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145748.952502272@linuxfoundation.org>
References: <20200707145748.952502272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Aurich <paul@darkrain42.org>

commit cc15461c73d7d044d56c47e869a215e49bd429c8 upstream.

Ensure multiuser SMB3 mounts use encryption for all users' tcons if the
mount options are configured to require encryption. Without this, only
the primary tcon and IPC tcons are guaranteed to be encrypted. Per-user
tcons would only be encrypted if the server was configured to require
encryption.

Signed-off-by: Paul Aurich <paul@darkrain42.org>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/connect.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -4216,6 +4216,7 @@ cifs_construct_tcon(struct cifs_sb_info
 	vol_info->no_linux_ext = !master_tcon->unix_ext;
 	vol_info->sectype = master_tcon->ses->sectype;
 	vol_info->sign = master_tcon->ses->sign;
+	vol_info->seal = master_tcon->seal;
 
 	rc = cifs_set_vol_auth(vol_info, master_tcon->ses);
 	if (rc) {


