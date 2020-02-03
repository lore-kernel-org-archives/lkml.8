Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E21C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4A72080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580746977;
	bh=UMNkywr2kghPfVriFgzkLLTwv2Xm+B2fKeuP25mKzTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CLidN4TlZ31wSjp+1oBm9TzkT/jg9+8HwlDCg/Q734X3tTsa0qE5FjQ0kCGCg41kI
	 AAJV+KWp0MkPK6ViGEFiv/76mMFnGXf0IB7Nq2snLTQNNERzlZ2bwAGgKj3QzH6iRv
	 cy5IfvqmYiBtTzym5bSzT8DQbRJk9BrYZmQs17e4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgBCQW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:22:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgBCQUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:20:43 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D9EC2086A;
        Mon,  3 Feb 2020 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580746842;
        bh=UMNkywr2kghPfVriFgzkLLTwv2Xm+B2fKeuP25mKzTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nT0/8gMh2SVk26jl/RIk4TLsoKNKEjFr35BZ6iMiQUWDmePDzXBIyLUhNWkudEup/
         Um23q0it9TBDcNuPEPRo6vdD0v4PGKXoBAhxcJQYYajM608A6zGK3+K4qWXFJhhnsv
         rKEnYeFr/Yi5nTtG+DM7acfaZtRGrL1U2xMjfIec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        syzbot+32310fc2aea76898d074@syzkaller.appspotmail.com,
        syzbot+99706d6390be1ac542a2@syzkaller.appspotmail.com,
        syzbot+64437af5c781a7f0e08e@syzkaller.appspotmail.com
Subject: [PATCH 4.4 29/53] media: gspca: zero usb_buf
Date:   Mon,  3 Feb 2020 16:19:21 +0000
Message-Id: <20200203161908.365893015@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
References: <20200203161902.714326084@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit de89d0864f66c2a1b75becfdd6bf3793c07ce870 upstream.

Allocate gspca_dev->usb_buf with kzalloc instead of kmalloc to
ensure it is property zeroed. This fixes various syzbot errors
about uninitialized data.

Syzbot links:

https://syzkaller.appspot.com/bug?extid=32310fc2aea76898d074
https://syzkaller.appspot.com/bug?extid=99706d6390be1ac542a2
https://syzkaller.appspot.com/bug?extid=64437af5c781a7f0e08e

Reported-and-tested-by: syzbot+32310fc2aea76898d074@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+99706d6390be1ac542a2@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+64437af5c781a7f0e08e@syzkaller.appspotmail.com

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/gspca/gspca.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/gspca/gspca.c
+++ b/drivers/media/usb/gspca/gspca.c
@@ -2028,7 +2028,7 @@ int gspca_dev_probe2(struct usb_interfac
 		pr_err("couldn't kzalloc gspca struct\n");
 		return -ENOMEM;
 	}
-	gspca_dev->usb_buf = kmalloc(USB_BUF_SZ, GFP_KERNEL);
+	gspca_dev->usb_buf = kzalloc(USB_BUF_SZ, GFP_KERNEL);
 	if (!gspca_dev->usb_buf) {
 		pr_err("out of memory\n");
 		ret = -ENOMEM;


