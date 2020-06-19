Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F65C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E22F2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583216;
	bh=bRT+hm0y+p31iqcsZ+X01T4GOni5nOI8iFTpWrOaJng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iNDKqs9kNAmHPuEPhS66NS+dpTEFsN+zzB6FNs6V/sosZLFjyIlnbzYmzb2+3d+tB
	 nPsMx/aJ3ctmv4wkBS0UK+CtSuKBCtw01o6K+NadKN21pHfgP40C1BxliZpQORqPq8
	 QltF2G/ifmG+5qr4TNXcijs55zFP0YK5Br/gskmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394384AbgFSQNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391086AbgFSPEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:04:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 266D421941;
        Fri, 19 Jun 2020 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579041;
        bh=bRT+hm0y+p31iqcsZ+X01T4GOni5nOI8iFTpWrOaJng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xhj9tmNz7dLihIJQVy+FSZ1N4FYD8EBizCkr9TcWh9cU1iJJwKqBqNrAD14aCSsp1
         lvu/SujQcSrqme++m6YEVV2/T5L6HwvokDnydZRqk+QgzljkUndBgQFBS6jb/6ntBe
         yS7TLYbVBxKBnOXDJ86iqZe0mWbBbWlagzdTwlZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 223/267] PCI: Add Loongson vendor ID
Date:   Fri, 19 Jun 2020 16:33:28 +0200
Message-Id: <20200619141659.407201367@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
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
index a81fcb2f2cb7..14baae112a54 100644
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



