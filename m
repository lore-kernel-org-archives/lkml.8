Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6649C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF96A2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323662;
	bh=bzr/AX9iv/cLZSte631JwVq5+ZiXXYC5kSpMu6k8j4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zNOFvNMlJ115qoHs5pzTmfRUj8qLUPnebd+OIyIGpS2jpxYaLXaMVzBlE1hgcbnFT
	 dXzGPuB8s4zBL0StaxxnrplvOHJ1OqYHq/Pdqfl87h7RZ4b6sEOz7RkI4tivj1mCiJ
	 eYA8d/yAihl05hraZ3xgZmeAYkgeVnJkUYO+UWvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbgFPPqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731694AbgFPPqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:46:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B28EF21475;
        Tue, 16 Jun 2020 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322407;
        bh=bzr/AX9iv/cLZSte631JwVq5+ZiXXYC5kSpMu6k8j4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1RMvEshryjm/MgaLQTu7N0HbZ/rjFaa4jIx8EqIvRyEb2CJuJW2avjIV3aCKNxm77
         ypkMI9p29mVJnenBQ5jb2c0+n54kfnoUS/z/T3YsnHtHbiIG1vLtIBvvDojTBYt42B
         tPtFoZjjr0oRAS/d79RzkDCdonvnSHRqyJo4DiLo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH 5.7 118/163] exfat: fix incorrect update of stream entry in __exfat_truncate()
Date:   Tue, 16 Jun 2020 17:34:52 +0200
Message-Id: <20200616153112.458363768@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namjae Jeon <namjae.jeon@samsung.com>

commit 29bbb14bfc80dd760b07d2be0a27e610562982e3 upstream.

At truncate, there is a problem of incorrect updating in the file entry
pointer instead of stream entry. This will cause the problem of
overwriting the time field of the file entry to new_size. Fix it to
update stream entry.

Fixes: 98d917047e8b ("exfat: add file operations")
Cc: stable@vger.kernel.org # v5.7
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/exfat/file.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -170,11 +170,11 @@ int __exfat_truncate(struct inode *inode
 
 		/* File size should be zero if there is no cluster allocated */
 		if (ei->start_clu == EXFAT_EOF_CLUSTER) {
-			ep->dentry.stream.valid_size = 0;
-			ep->dentry.stream.size = 0;
+			ep2->dentry.stream.valid_size = 0;
+			ep2->dentry.stream.size = 0;
 		} else {
-			ep->dentry.stream.valid_size = cpu_to_le64(new_size);
-			ep->dentry.stream.size = ep->dentry.stream.valid_size;
+			ep2->dentry.stream.valid_size = cpu_to_le64(new_size);
+			ep2->dentry.stream.size = ep->dentry.stream.valid_size;
 		}
 
 		if (new_size == 0) {


