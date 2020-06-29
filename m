Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF65DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D58B20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593468398;
	bh=RYfkEx+K0eqsbULCE1FHocr7/0rtrtEm/3kjazqQxlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uLys1Y01PmYXJW5QWF4ObhfU6AwX8iGioi6+b1qJbDMon6dAllubGA7JZJ/WqnAKK
	 WOKkaojOdpnHFhUUlcYfU96bKXLA/S6VJM6E2bllfvkctvVC6WmMPeti2VqpiA4gpM
	 tIkVGHcCDJGmW8LXRensNYorwDOX2wqNed87OX2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404846AbgF2WGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgF2SfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98B6E24685;
        Mon, 29 Jun 2020 15:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593443983;
        bh=RYfkEx+K0eqsbULCE1FHocr7/0rtrtEm/3kjazqQxlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ig1KAs8m84ZWVWEw2fwDLT6PsWXXRW8Jqh6IyA4Ld7+8peKFiMYXbAhNU8iU0oryZ
         5Z1JgcCcQFhzJafQfNb3z+vHn1R6ubOs8iRbCcNynNRRByxVDLacK3XSZrHs9Bfh7m
         RPdv4kyJrAJQLZnDfoXyI1uShUav7h+53/YvmqNs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 087/265] xhci: Fix enumeration issue when setting max packet size for FS devices.
Date:   Mon, 29 Jun 2020 11:15:20 -0400
Message-Id: <20200629151818.2493727-88-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Cooper <alcooperx@gmail.com>

commit a73d9d9cfc3cfceabd91fb0b0c13e4062b6dbcd7 upstream.

Unable to complete the enumeration of a USB TV Tuner device.

Per XHCI spec (4.6.5), the EP state field of the input context shall
be cleared for a set address command. In the special case of an FS
device that has "MaxPacketSize0 = 8", the Linux XHCI driver does
not do this before evaluating the context. With an XHCI controller
that checks the EP state field for parameter context error this
causes a problem in cases such as the device getting reset again
after enumeration.

When that field is cleared, the problem does not occur.

This was found and fixed by Sasi Kumar.

Cc: stable@vger.kernel.org
Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20200624135949.22611-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 10d76205a79ca..dcc987e1d57b0 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1430,6 +1430,7 @@ static int xhci_check_maxpacket(struct xhci_hcd *xhci, unsigned int slot_id,
 				xhci->devs[slot_id]->out_ctx, ep_index);
 
 		ep_ctx = xhci_get_ep_ctx(xhci, command->in_ctx, ep_index);
+		ep_ctx->ep_info &= cpu_to_le32(~EP_STATE_MASK);/* must clear */
 		ep_ctx->ep_info2 &= cpu_to_le32(~MAX_PACKET_MASK);
 		ep_ctx->ep_info2 |= cpu_to_le32(MAX_PACKET(max_packet_size));
 
-- 
2.25.1

