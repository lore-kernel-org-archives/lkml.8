Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42822C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A1E2065D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135050;
	bh=/2HtsTSjJmXvMsJ91Q9Z7SL8AT2KMpSO5NaRPPKn97g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M47mVHA78NLMtedKVJ1wu7yWnlBQ8gzPiD2JBXGQoku9/qaMF3IMtuTmadZLg646W
	 tb+uGy/wCCQ3lDYp9GrFYsc4dpLaplg3je9jomvC6fL+syZWQ9SdJnZuwPYtwQty8L
	 RSGlUVwX8a+SvNPS2MNOp5ZiClEcDrkBPSjZvQws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgGGPR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbgGGPQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:16:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39C7320773;
        Tue,  7 Jul 2020 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135014;
        bh=/2HtsTSjJmXvMsJ91Q9Z7SL8AT2KMpSO5NaRPPKn97g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcbswT/kQ0D7kMbgT/QciVMI26DNhu7e1z10D9c7tWGpMvGrVPvye6srGWH+JWZO7
         ouM23QXxLxzgNlxz0O/e9IPlpPFOAsUqnnKgCzQ/hNukxSESrPuJZmBpwm1FUxUVvt
         mHL8SSxPwyP6S6/ndBUiGFNbe1yLTp+shRKUflMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Aurich <paul@darkrain42.org>,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 4.14 21/27] SMB3: Honor seal flag for multiuser mounts
Date:   Tue,  7 Jul 2020 17:15:48 +0200
Message-Id: <20200707145749.962041387@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145748.944863698@linuxfoundation.org>
References: <20200707145748.944863698@linuxfoundation.org>
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
@@ -4327,6 +4327,7 @@ cifs_construct_tcon(struct cifs_sb_info
 	vol_info->no_linux_ext = !master_tcon->unix_ext;
 	vol_info->sectype = master_tcon->ses->sectype;
 	vol_info->sign = master_tcon->ses->sign;
+	vol_info->seal = master_tcon->seal;
 
 	rc = cifs_set_vol_auth(vol_info, master_tcon->ses);
 	if (rc) {


