Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDDEC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F502073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262232;
	bh=qUgvMVeuGCwJse6LZQTi1a4mzS0/QlP8Jmm/3rSEGEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BMKq8FX7paI5hxmLNiV7PdlsJ8WfPcWZtdxW8gI9Ti2/xjlXEF4DpFfjHGSnuTTId
	 G20mjqrNcGivBRpjrGwCvbPIbzORkg2DTIySZsen9NVkpa4F14SDCv3gRndwboTQdA
	 lCdoNJDrtW1ADELYSHDrI/Blyr7F+EQOVSJ+D27o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbgGTQEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732861AbgGTQEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:04:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30D2F20773;
        Mon, 20 Jul 2020 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261076;
        bh=qUgvMVeuGCwJse6LZQTi1a4mzS0/QlP8Jmm/3rSEGEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0njkhF+stRpGifFNT+8XBH1nIuSDdCK+wzOXImL1H6gWr4KlemktsBH3ZxgPBUpdX
         CcIn2S+R4lGm1x/7Le0TUikJ1BzVRbq3EjPR0YsP9GqWuwPTTj1DSPsdVtbhphP5fx
         aqW+6SeyngT6u9kiw3MGXHjSAQjF9tKaEtwPlUj0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        youngjun <her0gyugyu@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.4 170/215] ovl: inode reference leak in ovl_is_inuse true case.
Date:   Mon, 20 Jul 2020 17:37:32 +0200
Message-Id: <20200720152828.259729336@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: youngjun <her0gyugyu@gmail.com>

commit 24f14009b8f1754ec2ae4c168940c01259b0f88a upstream.

When "ovl_is_inuse" true case, trap inode reference not put.  plus adding
the comment explaining sequence of ovl_is_inuse after ovl_setup_trap.

Fixes: 0be0bfd2de9d ("ovl: fix regression caused by overlapping layers detection")
Cc: <stable@vger.kernel.org> # v4.19+
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: youngjun <her0gyugyu@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/super.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1356,14 +1356,23 @@ static int ovl_get_lower_layers(struct s
 		if (err < 0)
 			goto out;
 
+		/*
+		 * Check if lower root conflicts with this overlay layers before
+		 * checking if it is in-use as upperdir/workdir of "another"
+		 * mount, because we do not bother to check in ovl_is_inuse() if
+		 * the upperdir/workdir is in fact in-use by our
+		 * upperdir/workdir.
+		 */
 		err = ovl_setup_trap(sb, stack[i].dentry, &trap, "lowerdir");
 		if (err)
 			goto out;
 
 		if (ovl_is_inuse(stack[i].dentry)) {
 			err = ovl_report_in_use(ofs, "lowerdir");
-			if (err)
+			if (err) {
+				iput(trap);
 				goto out;
+			}
 		}
 
 		mnt = clone_private_mount(&stack[i]);


