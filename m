Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7CFC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B05920B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099405;
	bh=aT9hg1sNSwLGT6XuCK3dDWR6DyvsBM1bIaw3wIjbf28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tpSNq3y+QEOw0eA+NDW4hL2PLO91OHqHyw+4cAsPRucMDQUQEN1zq5TZNGwDhSg0A
	 mkXwNyqui0aUtQjcrzuRAs7gBzgIolemsOGKURFB3yaCM6DoJl/rUb8QaRsiloJ1P2
	 /I2l/GL2/bb+adbA5sLLncrx8FM+XpIxKwPhz9x8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgD1SnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731219AbgD1SnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:43:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB3120575;
        Tue, 28 Apr 2020 18:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099400;
        bh=aT9hg1sNSwLGT6XuCK3dDWR6DyvsBM1bIaw3wIjbf28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CcOT7e2+XBIurtNVMBGnJ858hkWBciuBrtZMzqq5iRNdJEZhbRf5i/cfgjR6akm7O
         3j6WRTYIZNXA2c65CsIX5f1R8zY6fqR1Coy6ESq8BQVxO+f7Q5YY2DLE+jbWb1FF+n
         zhqIHbVOCmS1nvhU1LfmHjH+cr73VXPFwt0eIgGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 5.4 133/168] cifs: fix uninitialised lease_key in open_shroot()
Date:   Tue, 28 Apr 2020 20:25:07 +0200
Message-Id: <20200428182248.820379456@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paulo Alcantara <pc@cjr.nz>

commit 0fe0781f29dd8ab618999e6bda33c782ebbdb109 upstream.

SMB2_open_init() expects a pre-initialised lease_key when opening a
file with a lease, so set pfid->lease_key prior to calling it in
open_shroot().

This issue was observed when performing some DFS failover tests and
the lease key was never randomly generated.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2ops.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -664,6 +664,11 @@ int open_shroot(unsigned int xid, struct
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
 
+	if (!server->ops->new_lease_key)
+		return -EIO;
+
+	server->ops->new_lease_key(pfid);
+
 	memset(rqst, 0, sizeof(rqst));
 	resp_buftype[0] = resp_buftype[1] = CIFS_NO_BUFFER;
 	memset(rsp_iov, 0, sizeof(rsp_iov));


