Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB90C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3908206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975419;
	bh=7HKd/IscGoK7CQQqMS7/I9PwnB6S63WqRDGkpK4y1JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eWwjFRngS49rtMwNq+L77lXbrmfgAttg0WmUZmsrFSg0D6UMFs5oIFa03Z1H5grlJ
	 g3eS4TZY1yCURLQgjQkTVuBmoUeE+X18iOBsGOZuCXV+8hGC3bZLP8Qpfl40oWlImZ
	 XQ96Cr2HuZELcKcfhbcMT0hK7CgfU/dacetYl7Z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbgIAPuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbgIAPrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:47:02 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AB2A208CA;
        Tue,  1 Sep 2020 15:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975221;
        bh=7HKd/IscGoK7CQQqMS7/I9PwnB6S63WqRDGkpK4y1JU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dmpvusf0d5mLeoEAoC+/N3u2lyCQZ+Jn9absnqeGphrJkc8BXsk4E/7ms5svQJiys
         cqD1UXZrhdujaAP4AfUlfI220uH73IdOtHlrNn87vS7Jn7MVqIk3cJDBUFuuSCxCwQ
         c0oWHiyV6D2GNijx99jhtxqDlmy8lplfZHulVmag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+34ee1b45d88571c2fa8b@syzkaller.appspotmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 5.8 249/255] HID: hiddev: Fix slab-out-of-bounds write in hiddev_ioctl_usage()
Date:   Tue,  1 Sep 2020 17:11:45 +0200
Message-Id: <20200901151012.700165738@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peilin Ye <yepeilin.cs@gmail.com>

commit 25a097f5204675550afb879ee18238ca917cba7a upstream.

`uref->usage_index` is not always being properly checked, causing
hiddev_ioctl_usage() to go out of bounds under some cases. Fix it.

Reported-by: syzbot+34ee1b45d88571c2fa8b@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=f2aebe90b8c56806b050a20b36f51ed6acabe802
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/usbhid/hiddev.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -519,12 +519,16 @@ static noinline int hiddev_ioctl_usage(s
 
 		switch (cmd) {
 		case HIDIOCGUSAGE:
+			if (uref->usage_index >= field->report_count)
+				goto inval;
 			uref->value = field->value[uref->usage_index];
 			if (copy_to_user(user_arg, uref, sizeof(*uref)))
 				goto fault;
 			goto goodreturn;
 
 		case HIDIOCSUSAGE:
+			if (uref->usage_index >= field->report_count)
+				goto inval;
 			field->value[uref->usage_index] = uref->value;
 			goto goodreturn;
 


