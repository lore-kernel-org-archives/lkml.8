Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E880EC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A0120728
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258455;
	bh=q3yD8SMbWAwNrT1iBJkEQAuuzq44A4f7dNbQy1ansmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NhFp397eK9+NcAZJ8s4nYfyVMq2pdHMCdK/E8L40S4rx1JDIzq+dmNsHgCpSP+Aj/
	 jgK9z71Idrmv50kxKrLwDoamZYfecEUYUo2HgIzJ/0QMTVUH3jLUrpT4vX+Kjqb2Gx
	 jDScHFRyGJYw2AMHely5ik9yvLFpaiRtsdSW310A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbgCCSAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:00:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:44760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387411AbgCCSAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:00:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED31A20656;
        Tue,  3 Mar 2020 18:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258450;
        bh=q3yD8SMbWAwNrT1iBJkEQAuuzq44A4f7dNbQy1ansmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1b6RZ6fZb2GqhqdQ1FHMDvXCKMz1o5oHA9gw5a8wIRBmBgoIVi2cMh6sh2bvfy6n
         bYujjrJI1heYGS64KD5IbJmbNUzBxq1WaUObzLawQmREqwpn2Qvhvddxkm+B1UbpIw
         7BD0lsnuVf3VQcd7gyKp6zX0IVwmTCxxzm3SauNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+784ccb935f9900cc7c9e@syzkaller.appspotmail.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.19 53/87] HID: hiddev: Fix race in in hiddev_disconnect()
Date:   Tue,  3 Mar 2020 18:43:44 +0100
Message-Id: <20200303174355.132315650@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174349.075101355@linuxfoundation.org>
References: <20200303174349.075101355@linuxfoundation.org>
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
@@ -954,9 +954,9 @@ void hiddev_disconnect(struct hid_device
 	hiddev->exist = 0;
 
 	if (hiddev->open) {
-		mutex_unlock(&hiddev->existancelock);
 		hid_hw_close(hiddev->hid);
 		wake_up_interruptible(&hiddev->wait);
+		mutex_unlock(&hiddev->existancelock);
 	} else {
 		mutex_unlock(&hiddev->existancelock);
 		kfree(hiddev);


