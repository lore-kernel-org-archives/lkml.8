Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A491C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8278206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217392;
	bh=JSuBphsjuh0+PpEiMvHb+bCx5t9x0cjW3CLELLPZeHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Aic8J1RGeBkkFucme/mUCKfvDlpLy91BWQOyw0msxoRQ0r6S2ezHtxZI6goX3Ebm6
	 gS0s/bpLcwCj6RcpVh0JVTTJO34nDMxoNARSCZ5Lq6hv5ZAxsw4oKKGYcNAFlQstPk
	 k0/ZeUsuE1qMSGoDwzkfTJgBNO1pbNLgAXQjE5XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391340AbgAPX3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:29:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:35696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391336AbgAPX3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:29:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A022206D9;
        Thu, 16 Jan 2020 23:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217383;
        bh=JSuBphsjuh0+PpEiMvHb+bCx5t9x0cjW3CLELLPZeHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nqgpf7fzk95CcAfEMo9u9ksZQwy2R184yvc4zxCvg35rt1/yTb8vpFUcWvuHdUYoh
         3tg945Wsx/nL+DXbJKHQdzACh5cNruPFMcylGyXyyVI8Ftmy2ib90SBKbtLPVmF/hP
         2imWHPCS1a99/3xmV5SiiFdXsgkxiMyr5y6s5+rs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 34/84] btrfs: simplify inode locking for RWF_NOWAIT
Date:   Fri, 17 Jan 2020 00:18:08 +0100
Message-Id: <20200116231717.760212736@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231713.087649517@linuxfoundation.org>
References: <20200116231713.087649517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

commit 9cf35f673583ccc9f3e2507498b3079d56614ad3 upstream.

This is similar to 942491c9e6d6 ("xfs: fix AIM7 regression"). Apparently
our current rwsem code doesn't like doing the trylock, then lock for
real scheme. This causes extra contention on the lock and can be
measured eg. by AIM7 benchmark.  So change our read/write methods to
just do the trylock for the RWF_NOWAIT case.

Fixes: edf064e7c6fe ("btrfs: nowait aio support")
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ update changelog ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/file.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1903,9 +1903,10 @@ static ssize_t btrfs_file_write_iter(str
 	    (iocb->ki_flags & IOCB_NOWAIT))
 		return -EOPNOTSUPP;
 
-	if (!inode_trylock(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock(inode))
 			return -EAGAIN;
+	} else {
 		inode_lock(inode);
 	}
 


