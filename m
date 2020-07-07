Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC347C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC3A2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135634;
	bh=u4HwCGcn8HVCMtu5Ujk7nqwfMT0GJpyjK2Cnff1ZIuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qrlA8dUPg2+6Nf60t5TdVJm1rZCaYYfgNs3sZGmUrvGbRpbiboQ6qCX2cNIe+tfX+
	 O2eJxY1ziCD5GKVN4Ltuy8BtXuTcre+okFqI4ywoCPlZHCEsB9k0YSG0811BUbfiyb
	 c77JsCyv//GDmobvIzVaL0CAfAJhU9vFXfq0IgBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgGGP1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730338AbgGGP1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:27:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8568020663;
        Tue,  7 Jul 2020 15:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135625;
        bh=u4HwCGcn8HVCMtu5Ujk7nqwfMT0GJpyjK2Cnff1ZIuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zw8LiUQxe495sMw90BiPRqOFxqXfv8fSpk7EkwUD7qPvQF449q2VPvieDUd/5EGL6
         OkB145yqEYcNwIPNXuObm6bELgkbz+tGQ74fDkZH1d1zFxyRza4Ce6P7wroNUbcTuq
         ZXFmivxy+bpanR5EJFnuiNTYWkHmIwrAbEKUjBKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Aurich <paul@darkrain42.org>,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 5.7 092/112] SMB3: Honor handletimeout flag for multiuser mounts
Date:   Tue,  7 Jul 2020 17:17:37 +0200
Message-Id: <20200707145805.355148460@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145800.925304888@linuxfoundation.org>
References: <20200707145800.925304888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Aurich <paul@darkrain42.org>

commit 6b356f6cf941d5054d7fab072cae4a5f8658e3db upstream.

Fixes: ca567eb2b3f0 ("SMB3: Allow persistent handle timeout to be configurable on mount")
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
@@ -5309,6 +5309,7 @@ cifs_construct_tcon(struct cifs_sb_info
 	vol_info->no_lease = master_tcon->no_lease;
 	vol_info->resilient = master_tcon->use_resilient;
 	vol_info->persistent = master_tcon->use_persistent;
+	vol_info->handle_timeout = master_tcon->handle_timeout;
 	vol_info->no_linux_ext = !master_tcon->unix_ext;
 	vol_info->linux_ext = master_tcon->posix_extensions;
 	vol_info->sectype = master_tcon->ses->sectype;


