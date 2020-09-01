Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88505C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568E7206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598980202;
	bh=OkHyNzl9xUn+d4iYpHmmhglnStq2FibL0dceBF1zm7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Loae2LsBjppSbqu3h+onIyv+OV7ODRFtGURSuuTB52jfiNQaX4tfzCcoM4JqKi4F4
	 iw24aMJqGk82RLPMjkZv1jteF+RBYY6is8Hv+HY7vWwStVD2Oz0mWwZSYBc/Z4Wy3M
	 X1/40OiSDkjHjex6Xg2LcwoorG7O7mzjxcK5EeZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgIARKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbgIAPRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:17:15 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 021AC2100A;
        Tue,  1 Sep 2020 15:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973435;
        bh=OkHyNzl9xUn+d4iYpHmmhglnStq2FibL0dceBF1zm7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6cwa7j5gSiohv6LIk118WrmEfzwaT+ClXg1/MtrnVUK6dkKsd7STHY+iaUB4oFYD
         RSBinfF93V2RzJQQLI2PXUz+LfFKVBZwJBmlCab2YGM/yY4H01VB3tCVYPo47PCF7D
         o4cjygUzBg6e+32fVnFtk4sV4jVsGbKLfTaSJyOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+34ee1b45d88571c2fa8b@syzkaller.appspotmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.9 77/78] HID: hiddev: Fix slab-out-of-bounds write in hiddev_ioctl_usage()
Date:   Tue,  1 Sep 2020 17:10:53 +0200
Message-Id: <20200901150928.604384200@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150924.680106554@linuxfoundation.org>
References: <20200901150924.680106554@linuxfoundation.org>
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
@@ -554,12 +554,16 @@ static noinline int hiddev_ioctl_usage(s
 
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
 


