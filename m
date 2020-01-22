Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9C4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8AA2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685576;
	bh=T6Bz7GzP/Tc70fMoKXyvu0ibzBZJF2aJQbCdC6q0keg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xXEgCTy8umdo6dQUoXYIbRZQTHq1eHOyTmALZXm9k02eTTokjKPUAOUxNzZv1cX6K
	 FQO89YvwxgoKM3e28ta2uo9TAMzjCytw10i/Qg5elkwokT4LQ8tSde4kAIwgXbSxq5
	 NVaQlPbe1bIfEhgbWhEOiD06kbLCy9l3mC71nT30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgAVJcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:32:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbgAVJcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:32:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD3D424673;
        Wed, 22 Jan 2020 09:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685572;
        bh=T6Bz7GzP/Tc70fMoKXyvu0ibzBZJF2aJQbCdC6q0keg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgQPQZNGZMO+tO0fi9kbkZB7LATtYv50ZU4vUvjf770t9ds7Ptp2xMeBl+WuxXR61
         849MPooQP8u2cVT3K6kLLYe0gcxDzS7I/dIvMWYGW8tF6j/6c1nBWtiP1nvmKGj8LD
         z0DZx65kRVOLTbLdNCGc0o/D7wGurT0X7B4Wnk2M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Subject: [PATCH 4.4 67/76] xen/blkfront: Adjust indentation in xlvbd_alloc_gendisk
Date:   Wed, 22 Jan 2020 10:29:23 +0100
Message-Id: <20200122092801.587987713@linuxfoundation.org>
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

commit 589b72894f53124a39d1bb3c0cecaf9dcabac417 upstream.

Clang warns:

../drivers/block/xen-blkfront.c:1117:4: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
                nr_parts = PARTS_PER_DISK;
                ^
../drivers/block/xen-blkfront.c:1115:3: note: previous statement is here
                if (err)
                ^

This is because there is a space at the beginning of this line; remove
it so that the indentation is consistent according to the Linux kernel
coding style and clang no longer warns.

While we are here, the previous line has some trailing whitespace; clean
that up as well.

Fixes: c80a420995e7 ("xen-blkfront: handle Xen major numbers other than XENVBD")
Link: https://github.com/ClangBuiltLinux/linux/issues/791
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/xen-blkfront.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -952,8 +952,8 @@ static int xlvbd_alloc_gendisk(blkif_sec
 	if (!VDEV_IS_EXTENDED(info->vdevice)) {
 		err = xen_translate_vdev(info->vdevice, &minor, &offset);
 		if (err)
-			return err;		
- 		nr_parts = PARTS_PER_DISK;
+			return err;
+		nr_parts = PARTS_PER_DISK;
 	} else {
 		minor = BLKIF_MINOR_EXT(info->vdevice);
 		nr_parts = PARTS_PER_EXT_DISK;


