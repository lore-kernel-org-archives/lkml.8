Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25AAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B714A20809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582409;
	bh=1PzUjo7vtRgpMi9M/u+rqrEhgYH75PTlYUkDKGDkuwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JkhGPCs4T82KeUqq5rQEvWgBlU7jhgRyeIkbTf30QyQqaNm/LVwJbztsWkfK/s6RK
	 /o2TC5vqLcfMRQ4vpv5Xx5GFusX/pnDlvXD4tV7r7f4aL3e7xTDS1B9aChlFDULHPF
	 xtyNMlV5/IPKEvYtPT8NjhTW0IMpYSuFWwwR9f2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392327AbgFSPOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392088AbgFSPO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:14:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F01D12158C;
        Fri, 19 Jun 2020 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579665;
        bh=1PzUjo7vtRgpMi9M/u+rqrEhgYH75PTlYUkDKGDkuwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sEw4+GOKhH1W7T4e7VyGZ1pIvG46Cc6kwYZ7iqpgeEYmwGpGYUUaj5vVk4JJCpf/b
         gb6uOUXJ5++/6A1a+xPfrRroKyg3TCnFJZ5AtjpiOfzplibF5jVaYechteZKxtgIP8
         mdC0DphI577Q+5o/lMcplVCLXxXhK5aXOd7kse0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 190/261] PCI: Add Loongson vendor ID
Date:   Fri, 19 Jun 2020 16:33:21 +0200
Message-Id: <20200619141659.009207412@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 9acb9fe18d863aacc99948963f8d5d447dc311be ]

Add the Loongson vendor ID to pci_ids.h to be used by the controller
driver in the future.

The Loongson vendor ID can be found at the following link:
https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/pci.ids

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 6693cf561cd1..1dfc4e1dcb94 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -148,6 +148,8 @@
 
 /* Vendors and devices.  Sort key: vendor first, device next. */
 
+#define PCI_VENDOR_ID_LOONGSON		0x0014
+
 #define PCI_VENDOR_ID_TTTECH		0x0357
 #define PCI_DEVICE_ID_TTTECH_MC322	0x000a
 
-- 
2.25.1



