Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C52C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6141820855
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597922364;
	bh=kVRhEtl+UAk4V947xnY62S2SgqgbROmEWjYLUe4PZH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0+kxfuMurRFkHmVT8hplImeUmUl3BHRL8EFPWIHHXB+JRJ4UOehIKDyY3WbFuS1I6
	 mwydyMvjdEjNOqesoBQEM0brqEd1FuhcXdLVEbuSelZPdVgsbK2+mlX+Du+7J1K+eV
	 3wlab4+H0KQy3/iEXjdsVTko8+nkKkA/MQ9L2Zlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgHTLTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbgHTKH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:07:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F21232067C;
        Thu, 20 Aug 2020 10:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918076;
        bh=kVRhEtl+UAk4V947xnY62S2SgqgbROmEWjYLUe4PZH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnR+NM4N3uMXyx5U3aSKxRb4uMc1nDbW5uuKoYoEN4xTuP5tlmYBNyeoEj3CDEDqI
         E+p0O8oc4fURLlD9/+ldWw6/K1XotXq8A7XJmI+j1NDNqFRh5buqvm+TjerhpSLIM3
         CXUiXassmDJk/bmx1RLzhq+QbamsB7gBJj3+ni3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>,
        Darren Hart <darren@dvhart.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.14 044/228] HID: input: Fix devices that return multiple bytes in battery report
Date:   Thu, 20 Aug 2020 11:20:19 +0200
Message-Id: <20200820091609.804574301@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grant Likely <grant.likely@secretlab.ca>

commit 4f57cace81438cc873a96f9f13f08298815c9b51 upstream.

Some devices, particularly the 3DConnexion Spacemouse wireless 3D
controllers, return more than just the battery capacity in the battery
report. The Spacemouse devices return an additional byte with a device
specific field. However, hidinput_query_battery_capacity() only
requests a 2 byte transfer.

When a spacemouse is connected via USB (direct wire, no wireless dongle)
and it returns a 3 byte report instead of the assumed 2 byte battery
report the larger transfer confuses and frightens the USB subsystem
which chooses to ignore the transfer. Then after 2 seconds assume the
device has stopped responding and reset it. This can be reproduced
easily by using a wired connection with a wireless spacemouse. The
Spacemouse will enter a loop of resetting every 2 seconds which can be
observed in dmesg.

This patch solves the problem by increasing the transfer request to 4
bytes instead of 2. The fix isn't particularly elegant, but it is simple
and safe to backport to stable kernels. A further patch will follow to
more elegantly handle battery reports that contain additional data.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Darren Hart <darren@dvhart.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: stable@vger.kernel.org
Tested-by: Darren Hart <dvhart@infradead.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-input.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -362,13 +362,13 @@ static int hidinput_query_battery_capaci
 	u8 *buf;
 	int ret;
 
-	buf = kmalloc(2, GFP_KERNEL);
+	buf = kmalloc(4, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 2,
+	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 4,
 				 dev->battery_report_type, HID_REQ_GET_REPORT);
-	if (ret != 2) {
+	if (ret < 2) {
 		kfree(buf);
 		return -ENODATA;
 	}


