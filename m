Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A879EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED8A20768
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593465007;
	bh=bGzG+iPRM2VG9c8HA/q5X0aU7W1UiDFnnv1Hfm+zFNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=js+smvzjH+ZHeBW+xguj232olaQ0Z/SRFQfUTwNw2ujBaHI7JblnM5fYW29vrCCIL
	 V81HQkNw1qSweEGOyJxnp+1PKdTKDtOepU9STyc9PTTxasAKAt7fbnGXauiwWQZnsf
	 369Ze4EjvZ/DNcbt+vrNUkBOq9OhCqGMWw5E1Fa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388143AbgF2VKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730229AbgF2TAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:00:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 247C2254F6;
        Mon, 29 Jun 2020 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446053;
        bh=bGzG+iPRM2VG9c8HA/q5X0aU7W1UiDFnnv1Hfm+zFNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+2koGM3uM14xxRjvUt5f5+efGUgvHMJpjlfkBxKrBaJBWOCRp1N9wtY+rvZ/XMhd
         tY51UPJ52+UP6oPrCj7Qyx4VXM5mYlPLLPrhXO1nwaBej02Dfxt2u/tWubl/643RHc
         5Xy7iX0dEPBA//BOCCIP97Gu47kqoo4ZIhTiU1NY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Oliver Neukum <oneukum@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 055/135] usb/xhci-plat: Set PM runtime as active on resume
Date:   Mon, 29 Jun 2020 11:51:49 -0400
Message-Id: <20200629155309.2495516-56-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qais Yousef <qais.yousef@arm.com>

[ Upstream commit 79112cc3c29f4a8c73a21428fbcbcb0afb005e3e ]

Follow suit of ohci-platform.c and perform pm_runtime_set_active() on
resume.

ohci-platform.c had a warning reported due to the missing
pm_runtime_set_active() [1].

[1] https://lore.kernel.org/lkml/20200323143857.db5zphxhq4hz3hmd@e107158-lin.cambridge.arm.com/

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Tony Prisk <linux@prisktech.co.nz>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Mathias Nyman <mathias.nyman@intel.com>
CC: Oliver Neukum <oneukum@suse.de>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-usb@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/20200518154931.6144-2-qais.yousef@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-plat.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c4c40e9d42471..510fb7853f92a 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -249,8 +249,17 @@ static int xhci_plat_resume(struct device *dev)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	int ret;
+
+	ret = xhci_resume(xhci, 0);
+	if (ret)
+		return ret;
 
-	return xhci_resume(xhci, 0);
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
 }
 
 static const struct dev_pm_ops xhci_plat_pm_ops = {
-- 
2.25.1

