Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEA8C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0A020838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748266;
	bh=tI9Mp8W8EjqrfA9AfeHBMMTk2MT5fyEAYSPNYbwmJT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KfTobh6sXYym205vwqfH9dVmnSQ6fKJ6zMpyQzJrxl0yfNThIJVEnaBlydSuP1bf6
	 AmfbrWtKwKHB+16Aonw/8gpuKKguP+XJQn6DPYPMhtYRXefk/E96w1neQwBozQEV41
	 b1yqh/eCX94DerIFzj/IjG/jBvLmLOfNfXt7xL+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgBCQbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:31:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730233AbgBCQbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:31:35 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37B2F21741;
        Mon,  3 Feb 2020 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747494;
        bh=tI9Mp8W8EjqrfA9AfeHBMMTk2MT5fyEAYSPNYbwmJT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aTnDSwJNxT05kLZsnNrAM5bY7T2NZ8hY1prX4zzrTp3rZovXk1kIhVY2I75offFf6
         UKfukpb6ko3pAMWl47ecPlZT4gyRlOUxLHp+cykg5v/nay71+7w63u90EcY0l5OuXB
         Ihp1McHTbc+y/uzZqGgNM2+2ioS8dke6tyxXF0Dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        syzbot+32310fc2aea76898d074@syzkaller.appspotmail.com,
        syzbot+99706d6390be1ac542a2@syzkaller.appspotmail.com,
        syzbot+64437af5c781a7f0e08e@syzkaller.appspotmail.com
Subject: [PATCH 4.19 18/70] media: gspca: zero usb_buf
Date:   Mon,  3 Feb 2020 16:19:30 +0000
Message-Id: <20200203161915.265422265@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
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
@@ -1473,7 +1473,7 @@ int gspca_dev_probe2(struct usb_interfac
 		pr_err("couldn't kzalloc gspca struct\n");
 		return -ENOMEM;
 	}
-	gspca_dev->usb_buf = kmalloc(USB_BUF_SZ, GFP_KERNEL);
+	gspca_dev->usb_buf = kzalloc(USB_BUF_SZ, GFP_KERNEL);
 	if (!gspca_dev->usb_buf) {
 		pr_err("out of memory\n");
 		ret = -ENOMEM;


