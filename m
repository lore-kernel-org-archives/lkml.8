Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B449C2BBDE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CFB24686
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844081;
	bh=k+hGJZYSyfR7ivL/m9ThcSWN/LBHQZfZdVkxeHyYmkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=10FVPKCigIM83MN6gaTSQ0+Ut09qolASzKvtTFYC7tyYq1wLzsbdZdXfqd3oAGoFx
	 sUrbPg9bY6XDnThiU2kZfUnS7DnBQenpjtdBGo11R0JZedB7UI7PUfyn8IxhK91A4A
	 8iGCNzcD+V0+pRjdWReFL5ihbxXG+HtmRubduuTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgCJMlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgCJMlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:41:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1EBE24686;
        Tue, 10 Mar 2020 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844078;
        bh=k+hGJZYSyfR7ivL/m9ThcSWN/LBHQZfZdVkxeHyYmkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eF76EsYAahwSJ0CT2+pKRWnG7u5Vt62rJ/bnwBvEqadHP6RHs6dAoorr1vbrNODe1
         CvbwkUW091lSm4uGJD6r77jDcH70AGkoJ1Wrj29AFE+rDXFQ/+ehn9q4j4hdK2Zl5v
         3ZXMzagMnYj75NY3UjiEmkmrhyKop3ZFeuZ5KCCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+784ccb935f9900cc7c9e@syzkaller.appspotmail.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.4 23/72] HID: hiddev: Fix race in in hiddev_disconnect()
Date:   Tue, 10 Mar 2020 13:38:36 +0100
Message-Id: <20200310123607.622870224@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123601.053680753@linuxfoundation.org>
References: <20200310123601.053680753@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dan.carpenter@oracle.com <dan.carpenter@oracle.com>

commit 5c02c447eaeda29d3da121a2e17b97ccaf579b51 upstream.

Syzbot reports that "hiddev" is used after it's free in hiddev_disconnect().
The hiddev_disconnect() function sets "hiddev->exist = 0;" so
hiddev_release() can free it as soon as we drop the "existancelock"
lock.  This patch moves the mutex_unlock(&hiddev->existancelock) until
after we have finished using it.

Reported-by: syzbot+784ccb935f9900cc7c9e@syzkaller.appspotmail.com
Fixes: 7f77897ef2b6 ("HID: hiddev: fix potential use-after-free")
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/usbhid/hiddev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -962,9 +962,9 @@ void hiddev_disconnect(struct hid_device
 	hiddev->exist = 0;
 
 	if (hiddev->open) {
-		mutex_unlock(&hiddev->existancelock);
 		usbhid_close(hiddev->hid);
 		wake_up_interruptible(&hiddev->wait);
+		mutex_unlock(&hiddev->existancelock);
 	} else {
 		mutex_unlock(&hiddev->existancelock);
 		kfree(hiddev);


