Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80785C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB4120704
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579687040;
	bh=lNwvgoE/PBtC0RiZuyLt2rKFKfMXnJYmrTD/qeV7Iio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HPl0ohGu+6liUtgh/KEpo2aPXOF53Fx4zKfWaTYxf2TvDnY6GhHKXVxA7rndFIMju
	 VYwCAoqJDpy3ryNVs6SSznrg8AushYa2Ml4GSyxe7LK+iubiqJ+gGXnt4kso3MGOQp
	 0j+6CqG4b4qiJiFeX7T6z2+TO02oq8PHM/4XMoC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgAVJbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:31:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbgAVJa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:30:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 374A924672;
        Wed, 22 Jan 2020 09:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685458;
        bh=lNwvgoE/PBtC0RiZuyLt2rKFKfMXnJYmrTD/qeV7Iio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ccZIF3/DGh4t0oro1nr5L4SWGVW+IehbIf0mC4TTk5FptqQFuRPOS/KOAOTz17Bez
         QQtggVsiaaTR6QhTUq16JIL2/PLWHVnE7pxBEo90tEUuDeQ5z5NdXYxgmWNB4PGJdZ
         jHgCRJZUlXjEE9igcaQmwf7xG0xZdhL5t24JdPtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.4 22/76] cifs: Adjust indentation in smb2_open_file
Date:   Wed, 22 Jan 2020 10:28:38 +0100
Message-Id: <20200122092754.000190250@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092751.587775548@linuxfoundation.org>
References: <20200122092751.587775548@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 7935799e041ae10d380d04ea23868240f082bd11 upstream.

Clang warns:

../fs/cifs/smb2file.c:70:3: warning: misleading indentation; statement
is not part of the previous 'if' [-Wmisleading-indentation]
         if (oparms->tcon->use_resilient) {
         ^
../fs/cifs/smb2file.c:66:2: note: previous statement is here
        if (rc)
        ^
1 warning generated.

This warning occurs because there is a space after the tab on this line.
Remove it so that the indentation is consistent with the Linux kernel
coding style and clang no longer warns.

Fixes: 592fafe644bf ("Add resilienthandles mount parm")
Link: https://github.com/ClangBuiltLinux/linux/issues/826
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/smb2file.c
+++ b/fs/cifs/smb2file.c
@@ -69,7 +69,7 @@ smb2_open_file(const unsigned int xid, s
 		goto out;
 
 
-	 if (oparms->tcon->use_resilient) {
+	if (oparms->tcon->use_resilient) {
 		nr_ioctl_req.Timeout = 0; /* use server default (120 seconds) */
 		nr_ioctl_req.Reserved = 0;
 		rc = SMB2_ioctl(xid, oparms->tcon, fid->persistent_fid,


