Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26413C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0012420786
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459651;
	bh=8U2lto+MbErabC19mkBLZ3pfvdEMeuF2mKDQB2xk8s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IAAQ4/D+LliRAl22svKwuY6NQDk5Cq2amMcDZ9NDyq95AvbhJwkEjao2Yx/4LWWL8
	 jdv8yCwtNqgVCEeCPr5idHwwv1p6UNvOrZtXcJSfWf+4+5eMpHczpv8WzZnorCm6mk
	 4jPeTLqTzqg0da4lzwTvd10V0u3kjQRQMKyq5FYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbgF2Tks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733156AbgF2Tk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 674F72485F;
        Mon, 29 Jun 2020 15:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444361;
        bh=8U2lto+MbErabC19mkBLZ3pfvdEMeuF2mKDQB2xk8s0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbnBuFLYEfIAn5wwi2uqJlnkxBScdVwJ/RVgpEdjalm9FBrLzOP72s7gyg6+qDWs6
         4Iq5HbWTLTaUA8wK52hCGCgIemsu0FUI++IABu1WW1LZa55kq+34ySQVZBTme0Bm7P
         GmCUUGUY+9l58BFNPeXTje1jRt0fK0TQeQWAsY2A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Longfang Liu <liulongfang@huawei.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4 037/178] USB: ehci: reopen solution for Synopsys HC bug
Date:   Mon, 29 Jun 2020 11:23:02 -0400
Message-Id: <20200629152523.2494198-38-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longfang Liu <liulongfang@huawei.com>

commit 1ddcb71a3edf0e1682b6e056158e4c4b00325f66 upstream.

A Synopsys USB2.0 core used in Huawei Kunpeng920 SoC has a bug which
might cause the host controller not issuing ping.

Bug description:
After indicating an Interrupt on Async Advance, the software uses the
doorbell mechanism to delete the Next Link queue head of the last
executed queue head. At this time, the host controller still references
the removed queue head(the queue head is NULL). NULL reference causes
the host controller to lose the USB device.

Solution:
After deleting the Next Link queue head, when has_synopsys_hc_bug set
to 1，the software can write one of the valid queue head addresses to
the ASYNCLISTADDR register to allow the host controller to get
the valid queue head. in order to solve that problem, this patch set
the flag for Huawei Kunpeng920

There are detailed instructions and solutions in this patch:
commit 2f7ac6c19997 ("USB: ehci: add workaround for Synopsys HC bug")

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/1591588019-44284-1-git-send-email-liulongfang@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/ehci-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index b0882c13a1d16..66713c2537653 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -216,6 +216,13 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
 		ehci_info(ehci, "applying MosChip frame-index workaround\n");
 		ehci->frame_index_bug = 1;
 		break;
+	case PCI_VENDOR_ID_HUAWEI:
+		/* Synopsys HC bug */
+		if (pdev->device == 0xa239) {
+			ehci_info(ehci, "applying Synopsys HC workaround\n");
+			ehci->has_synopsys_hc_bug = 1;
+		}
+		break;
 	}
 
 	/* optional debug port, normally in the first BAR */
-- 
2.25.1

