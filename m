Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E2DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1CA8206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462250;
	bh=jxeRtGUTFudl/LcXwdaL28++ML6w0W2mxLCRMjSy+eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MG1fXE0CrtN2sAF1x6aM2y2ew0GfjDq3eA1nbS+Eye9v53o6eTz/dGWMRXox0iWyT
	 4eA8QW2p/vAFbqUigGawWEHXQi8F4YZTL2DXjsDFqrBbbKnr0AOb8pU7+LUQuDEkQl
	 fVsNjxassQzuypvoGAZ/gFn4gqWXVrALP0SZlh6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388937AbgF2UYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732292AbgF2TZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 599472544E;
        Mon, 29 Jun 2020 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445402;
        bh=jxeRtGUTFudl/LcXwdaL28++ML6w0W2mxLCRMjSy+eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/BQd/9G2tQgUzEVSFyX4bK8uJt+jcF2ho5iiBEVm5a395e2i/rxQxPm78TVC79aY
         nRqtOo7uUmw8k5UtQmjNzRypsa/Bg8nC8AVOHvy9K/HKRAQu83p/QAt1NRH5iVXXSe
         C8mWDFGaXg2AuoGvWvZ2M9fHRxgFphXI1DdoPsIg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joakim Tjernlund <joakim.tjernlund@infinera.com>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.9 154/191] cdc-acm: Add DISABLE_ECHO quirk for Microchip/SMSC chip
Date:   Mon, 29 Jun 2020 11:39:30 -0400
Message-Id: <20200629154007.2495120-155-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
References: <20200629154007.2495120-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joakim Tjernlund <joakim.tjernlund@infinera.com>

commit 03894573f2913181ee5aae0089f333b2131f2d4b upstream.

USB_DEVICE(0x0424, 0x274e) can send data before cdc_acm is ready,
causing garbage chars on the TTY causing stray input to the shell
and/or login prompt.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: stable@vger.kernel.org
Acked-by: Oliver Neukum <oneukum@suse.com>
Link: https://lore.kernel.org/r/20200605105418.22263-1-joakim.tjernlund@infinera.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/cdc-acm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 5b0bffba4aac0..2dc563b61b88a 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1627,6 +1627,8 @@ static int acm_reset_resume(struct usb_interface *intf)
 
 static const struct usb_device_id acm_ids[] = {
 	/* quirky and broken devices */
+	{ USB_DEVICE(0x0424, 0x274e), /* Microchip Technology, Inc. (formerly SMSC) */
+	  .driver_info = DISABLE_ECHO, }, /* DISABLE ECHO in termios flag */
 	{ USB_DEVICE(0x076d, 0x0006), /* Denso Cradle CU-321 */
 	.driver_info = NO_UNION_NORMAL, },/* has no union descriptor */
 	{ USB_DEVICE(0x17ef, 0x7000), /* Lenovo USB modem */
-- 
2.25.1

