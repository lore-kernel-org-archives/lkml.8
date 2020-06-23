Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70213C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415252070E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944971;
	bh=2pOq+a6mzU9kK7Y31dgwxOh6PtmWViOMD6qN44fKLJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HAMX3pRf2B/yNPmpehUzshtz4kRcdtYq2zt9UjMHleik7bwHo9bdevar9Q2U4GOf+
	 iUdqKjAPKtwRpfAaPS5ThcBsYCkWiw7/z3XIAySlN9l1CKUiArYjLahDLwpjPMX4d4
	 jTDeA8lsieNLaWrkjhHGZw5f9wsGF1oThnSGplps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403905AbgFWUmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392448AbgFWUmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:42:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89AD52070E;
        Tue, 23 Jun 2020 20:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944967;
        bh=2pOq+a6mzU9kK7Y31dgwxOh6PtmWViOMD6qN44fKLJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atN35/0Qlaa1MbSAgt8O1AkLrfSRJlXk8RP9PD++q4gVcY7l6+Pmsr1524EtFBN7P
         h5HXAwq4TtsU/FdzxspvQVBhT12qsRa/s3QkLwIuTA7ucqsJEyIS9PChDR4nb2RWeH
         jkGzcd6o4wyonFM/lWB+YAVWCcLm/3ovbFdTnA7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Qais Yousef <qais.yousef@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Oliver Neukum <oneukum@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 164/206] usb/ehci-platform: Set PM runtime as active on resume
Date:   Tue, 23 Jun 2020 21:58:12 +0200
Message-Id: <20200623195325.065129185@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 drivers/usb/host/ehci-platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 8a45362155c5a..cbc45941a699d 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -457,6 +457,10 @@ static int ehci_platform_resume(struct device *dev)
 
 	ehci_resume(hcd, priv->reset_on_resume);
 
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	if (priv->quirk_poll)
 		quirk_poll_init(priv);
 
-- 
2.25.1



