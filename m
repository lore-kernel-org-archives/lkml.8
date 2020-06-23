Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A82DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ABA021548
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945413;
	bh=khsAJ4ZidOaLgn219+IpSknbqrHVVtVqkpp/uuHqMl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tZEj6ZkD5sCSMtr9K6Okiuw2i0fuBrlr0ZO+JNLfOZWrM8RGaLz06JEtNaBj1Q/IC
	 QWoB8mQ/x5j5BwJkzoVv0xZDQodT+NHH3CAfFnbDNF8o/p3jUN8tCJkOfHNgwK5Pa7
	 KEoPBL1APWSQR7cAM4AMGOuoKhojnvu6spCizhNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392590AbgFWUuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389870AbgFWUtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:49:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AA3E2098B;
        Tue, 23 Jun 2020 20:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945341;
        bh=khsAJ4ZidOaLgn219+IpSknbqrHVVtVqkpp/uuHqMl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uctO9gWbSHWBiwhg/3s1Z7fM0IkU8YntYNTl7BfLvjAT54IU/R/COIVpCB+b+QOIW
         9o0pJLfJ2Cg5d6VYAbZrO9uF/FlO2btADV+Z8amWI4dFd9HDGJw80aDN8izu34KdL8
         7uqnRvLmmG+VELFGnplfSp2cN8c7jtUyMmUGoTNk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Oliver Neukum <oneukum@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 104/136] usb/xhci-plat: Set PM runtime as active on resume
Date:   Tue, 23 Jun 2020 21:59:20 +0200
Message-Id: <20200623195308.905960323@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 drivers/usb/host/xhci-plat.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 2a73592908e1e..7219cbf7c54c2 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -381,7 +381,15 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	return xhci_resume(xhci, 0);
+	ret = xhci_resume(xhci, 0);
+	if (ret)
+		return ret;
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
 }
 
 static int __maybe_unused xhci_plat_runtime_suspend(struct device *dev)
-- 
2.25.1



