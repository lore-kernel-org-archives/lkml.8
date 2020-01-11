Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3EDC33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE24B20842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736902;
	bh=qKWuJhiIFt1cwzfYqWXteVeVO7+gTjjLjT3zqAHymas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i3WSyKfNCDBZg86cINd3p3AEWyMpMn++4/NuXJrgqTxaergUGbRQBo3zL1g2C2/sA
	 AUfpszjfrPOX0rzBsm1rN+izL0MWkCf4sCiQJ9powuL7GEfUYN3CUEiN9mZ+j6rqec
	 kVYFcMlOBwSXDF9bq0JO+wFx/EyPDaPD6SR5DX9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgAKKBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728828AbgAKKBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:01:40 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CAB02077C;
        Sat, 11 Jan 2020 10:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736899;
        bh=qKWuJhiIFt1cwzfYqWXteVeVO7+gTjjLjT3zqAHymas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ACuKPkxGLHXWiekMwRIP1qqo5c71ZK+QD5AFMRzszCT6XHbaTUaY4QsWe+lqB4z17
         JLTjJSY0e3x3aVeo3aV/jLqXkj//WcCJcKJMncVJ3+VW1hNdjFIiOE2gKDJvIFve4l
         zLixzbDn+0aEaEXsveaCThovgzI5IzIY0/WNU7o8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 44/91] fix compat handling of FICLONERANGE, FIDEDUPERANGE and FS_IOC_FIEMAP
Date:   Sat, 11 Jan 2020 10:49:37 +0100
Message-Id: <20200111094901.841255643@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

commit 6b2daec19094a90435abe67d16fb43b1a5527254 upstream.

Unlike FICLONE, all of those take a pointer argument; they do need
compat_ptr() applied to arg.

Fixes: d79bdd52d8be ("vfs: wire up compat ioctl for CLONE/CLONE_RANGE")
Fixes: 54dbc1517237 ("vfs: hoist the btrfs deduplication ioctl to the vfs")
Fixes: ceac204e1da9 ("fs: make fiemap work from compat_ioctl")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/compat_ioctl.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1585,9 +1585,10 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned i
 #endif
 
 	case FICLONE:
+		goto do_ioctl;
 	case FICLONERANGE:
 	case FIDEDUPERANGE:
-		goto do_ioctl;
+		goto found_handler;
 
 	case FIBMAP:
 	case FIGETBSZ:


