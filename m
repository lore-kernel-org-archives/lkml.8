Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E93C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AAFA22B51
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753293;
	bh=nDJc5vRd3K9zdIMpBjogFrF89tU+Gwn04dciJ4YtJfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=slvlG+SNbvpjtgtJ/MEQXgxkmllrIhZohAaSRSnX2a5tqxM4mRdo8cRhzO0Ljp0dN
	 ro0pclLG5RLaFbJ4WYMR31qZ5LRA8G5tLe54wQf2FVZMyKyVjtff/kykQqmOJdsXCt
	 KbbYiRKF6VLc4j28tneSuBlRe/H0KTp5lpLY69cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbgGNS7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730733AbgGNS7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:59:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FB82207F5;
        Tue, 14 Jul 2020 18:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753172;
        bh=nDJc5vRd3K9zdIMpBjogFrF89tU+Gwn04dciJ4YtJfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nVlKsBvI+lZ+avlYL26LOxV/+k/uB96wQmNx8XBotWSpXL+sfBNiW5NbUYE+95/e3
         jPGbu8z83ieHEk5PdGuWPri4cO3BVDBuHO7ZcSA7/PnQohOkZRp4k++NmR4jVaDeCu
         sKlymWdGoEerKX79/0iTGPKRYeKnZUm4244rb10s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 5.7 147/166] smb3: fix access denied on change notify request to some servers
Date:   Tue, 14 Jul 2020 20:45:12 +0200
Message-Id: <20200714184122.865978096@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

commit 4ef9b4f1a76ea2370fbfe20e80fef141ab92b65e upstream.

read permission, not just read attributes permission, is required
on the directory.

See MS-SMB2 (protocol specification) section 3.3.5.19.

Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org> # v5.6+
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2ops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2119,7 +2119,7 @@ smb3_notify(const unsigned int xid, stru
 
 	tcon = cifs_sb_master_tcon(cifs_sb);
 	oparms.tcon = tcon;
-	oparms.desired_access = FILE_READ_ATTRIBUTES;
+	oparms.desired_access = FILE_READ_ATTRIBUTES | FILE_READ_DATA;
 	oparms.disposition = FILE_OPEN;
 	oparms.create_options = cifs_create_options(cifs_sb, 0);
 	oparms.fid = &fid;


