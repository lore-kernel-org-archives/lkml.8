Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CA3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C71E20E65
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322486;
	bh=LUaGMoUbjdbFQRmoKpjS+1KFdgYIxUgQbBO85tMnjrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=riip9QnTFUP+0ypk3+wc3RQFHKEaTeJOfd1WW69O0KtygwLtpJKvdjf8bNEM3lsjE
	 BlnpzY/BXwAC5nSHZTekECjmsH2sW2bmsVCLJo/C1W/ZDQp12dO4f7M0847J5w7DtV
	 gsgeIlQRE8eW/9fX+RpexfczDNBKvi+mk6u3UHB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbgFPPsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732063AbgFPPr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:47:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E43720E65;
        Tue, 16 Jun 2020 15:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322479;
        bh=LUaGMoUbjdbFQRmoKpjS+1KFdgYIxUgQbBO85tMnjrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zpe6IxKSxN8kbkGIDPN5j6E52zWds/P9tqjoh2/XsykyQgNgoog5CdmO08INd9rBY
         HVi+H2jSvchYyBMhT5BLpWSLuSd2GSsSzVcJdeCKVBJ52PxXDu14iwxU5AWIhzd/nm
         uwha/V3SKiGtsJGcVwvkXfcxGSbuJfYGLUYhkFHA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6f1624f937d9d6911e2d@syzkaller.appspotmail.com,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.7 147/163] fat: dont allow to mount if the FAT length == 0
Date:   Tue, 16 Jun 2020 17:35:21 +0200
Message-Id: <20200616153113.843610229@linuxfoundation.org>
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

From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

commit b1b65750b8db67834482f758fc385bfa7560d228 upstream.

If FAT length == 0, the image doesn't have any data. And it can be the
cause of overlapping the root dir and FAT entries.

Also Windows treats it as invalid format.

Reported-by: syzbot+6f1624f937d9d6911e2d@syzkaller.appspotmail.com
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Link: http://lkml.kernel.org/r/87r1wz8mrd.fsf@mail.parknet.co.jp
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fat/inode.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1520,6 +1520,12 @@ static int fat_read_bpb(struct super_blo
 		goto out;
 	}
 
+	if (bpb->fat_fat_length == 0 && bpb->fat32_length == 0) {
+		if (!silent)
+			fat_msg(sb, KERN_ERR, "bogus number of FAT sectors");
+		goto out;
+	}
+
 	error = 0;
 
 out:


