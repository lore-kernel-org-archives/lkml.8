Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CD3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4745921D82
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445037;
	bh=IKPyz6tJZvLQGO9raFAy7/YNlQnRZ+ZjNkL39vKhCpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MdNdKIHe0o7VswjXQjtfAEaCuKUVSQk+W6Kdx9SONxNJfdY3X8Gf9OoUjLmDq4nx/
	 Wb3NzP6UdHzhO3QXUYs0O97vmuyMwyNLGyAPgdIbH7KdSYOTM6VVqvFyzsQU30zM+S
	 Uw78bSyhinYc1VVyKjhWO8wt892TF5RU0Y4Eqsg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbgFRBue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731857AbgFRB1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:27:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03D2F20776;
        Thu, 18 Jun 2020 01:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443643;
        bh=IKPyz6tJZvLQGO9raFAy7/YNlQnRZ+ZjNkL39vKhCpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKcpRE3W8j0sYYuJY7wvjLqUtO29Rza+V2F1rZQ7nWb+o4rYTnOP3Dw/x2LLW0aDO
         MuEMGPE7X7thL8DEO/2+RjgzBygEUVJR7/Ni0kl2a2F/A7EHi3Vtjut0XVRiP+r0PK
         6lQqc43oKRXREWMGKpmaT1LFJOFsD3I9zmFFsKLw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        Peter Chen <peter.chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 065/108] USB: host: ehci-mxc: Add error handling in ehci_mxc_drv_probe()
Date:   Wed, 17 Jun 2020 21:25:17 -0400
Message-Id: <20200618012600.608744-65-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012600.608744-1-sashal@kernel.org>
References: <20200618012600.608744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tang Bin <tangbin@cmss.chinamobile.com>

[ Upstream commit d49292025f79693d3348f8e2029a8b4703be0f0a ]

The function ehci_mxc_drv_probe() does not perform sufficient error
checking after executing platform_get_irq(), thus fix it.

Fixes: 7e8d5cd93fac ("USB: Add EHCI support for MX27 and MX31 based boards")
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
Link: https://lore.kernel.org/r/20200513132647.5456-1-tangbin@cmss.chinamobile.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ehci-mxc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index c7a9b31eeaef..637079a35003 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -63,6 +63,8 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	hcd = usb_create_hcd(&ehci_mxc_hc_driver, dev, dev_name(dev));
 	if (!hcd)
-- 
2.25.1

