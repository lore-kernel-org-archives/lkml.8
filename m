Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126BDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75EA20702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461032;
	bh=PCMb1FSQDXT+Fl2v4voDD/LCRJKIFXWVpLWwX+ZrLm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fYRUkJl86t0dHedj/UXc+JYF0k8d+YcSQ2z2LdBBWIs3QFwKWYpe7HCX4ea4Qt1Gb
	 YygdfHj1N7WvMoJkPKHyWhotfFDy42xbcNEfVIduJkLSengqZu3SLuDZD/1L1soYS+
	 iGN5q/zOiINvnB4OWUkyZmVZH4RyUUeqIY1S/rNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbgF2UDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732993AbgF2Tac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6B89252F8;
        Mon, 29 Jun 2020 15:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445125;
        bh=PCMb1FSQDXT+Fl2v4voDD/LCRJKIFXWVpLWwX+ZrLm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vM+4u+gIcBxbm9h4pB9hDhm7mJSnLspaSRHRmZP++tLypsIEimKyqs2hFqsG/s/p1
         chzF+EyzEbYYTnoZc7BxYVXg4D/zkc5lIzlDDsu3GpAxZnBHZW0bwgVDScKYFiRdIz
         5fwdd+5PeAE0x19AIXO/bIZTqs0n71r3s/ByjbDY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joakim Tjernlund <joakim.tjernlund@infinera.com>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.14 32/78] cdc-acm: Add DISABLE_ECHO quirk for Microchip/SMSC chip
Date:   Mon, 29 Jun 2020 11:37:20 -0400
Message-Id: <20200629153806.2494953-33-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153806.2494953-1-sashal@kernel.org>
References: <20200629153806.2494953-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.186-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.186-rc1
X-KernelTest-Deadline: 2020-07-01T15:38+00:00
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
index 4067f079b08da..0de467c8593db 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1734,6 +1734,8 @@ static int acm_pre_reset(struct usb_interface *intf)
 
 static const struct usb_device_id acm_ids[] = {
 	/* quirky and broken devices */
+	{ USB_DEVICE(0x0424, 0x274e), /* Microchip Technology, Inc. (formerly SMSC) */
+	  .driver_info = DISABLE_ECHO, }, /* DISABLE ECHO in termios flag */
 	{ USB_DEVICE(0x076d, 0x0006), /* Denso Cradle CU-321 */
 	.driver_info = NO_UNION_NORMAL, },/* has no union descriptor */
 	{ USB_DEVICE(0x17ef, 0x7000), /* Lenovo USB modem */
-- 
2.25.1

