Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7864BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B0FA20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461876;
	bh=6/VqPEUwgQ3wclxXqTm+MNn7vRvWDbl5Nym/x87nqOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EqU1LBfZFxAVFlfperTkTEW6+3kYitDIpXvAwQcw8Ox3nB0gaOjZNEM8r6d7SS1av
	 /dnkEiCPRL9v7HGUjNFSqVeYVXi5TXj1pqc9evqW/fL7BemngUP9hIqgnh87XmpzEt
	 ckptu3U8njSU6bJmAGMKaUeNTcDpPPuR8O29a58g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733253AbgF2URz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732640AbgF2TZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0777253CB;
        Mon, 29 Jun 2020 15:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445306;
        bh=6/VqPEUwgQ3wclxXqTm+MNn7vRvWDbl5Nym/x87nqOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qDsmxy2JqClsFoNXd5VTkD6CqfkJHHEoWUrNqr0JUTriGEExpG6HliapJy81prQjm
         hi+PR4/I5Xc0shIF+yKMDP17hsTSpz0b3KAyE6jaT1l6vjRWF/W9lsVxeGnZnM2aeM
         FSy/WAh6bcU5XMroZNu7f2A7bB5A0zCRWjWHjitM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Oliver Neukum <oneukum@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 076/191] usb/ehci-platform: Set PM runtime as active on resume
Date:   Mon, 29 Jun 2020 11:38:12 -0400
Message-Id: <20200629154007.2495120-77-sashal@kernel.org>
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

From: Qais Yousef <qais.yousef@arm.com>

[ Upstream commit 16bdc04cc98ab0c74392ceef2475ecc5e73fcf49 ]

Follow suit of ohci-platform.c and perform pm_runtime_set_active() on
resume.

ohci-platform.c had a warning reported due to the missing
pm_runtime_set_active() [1].

[1] https://lore.kernel.org/lkml/20200323143857.db5zphxhq4hz3hmd@e107158-lin.cambridge.arm.com/

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Tony Prisk <linux@prisktech.co.nz>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Mathias Nyman <mathias.nyman@intel.com>
CC: Oliver Neukum <oneukum@suse.de>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-usb@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/20200518154931.6144-3-qais.yousef@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ehci-platform.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index a268d9e8d6cfb..1b141e9299f99 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -378,6 +378,11 @@ static int ehci_platform_resume(struct device *dev)
 	}
 
 	ehci_resume(hcd, priv->reset_on_resume);
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	return 0;
 }
 #endif /* CONFIG_PM_SLEEP */
-- 
2.25.1

