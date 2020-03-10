Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE86C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0136208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846210;
	bh=WLTWQkKSnLnhF6Yiww78OxYvtR69QxHf5Yt/kkUHpaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CaMq6wsu0gXtc5BkCSSrgXwydgWoqey9c+GfS7C2Ve7XPnDes+O4faHTHvcREozpu
	 n/kGHcSnfj45/eON0RzhQAnVL920XXEd3aTBKAfoWDhnx4kg2CTSqLZoUT7jNVW1TB
	 we4Wc8Sk7LyrsX924GgYiOoJ1n3Q8wF+07oZVGMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbgCJNMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730768AbgCJNMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:12:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCF4124691;
        Tue, 10 Mar 2020 13:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845955;
        bh=WLTWQkKSnLnhF6Yiww78OxYvtR69QxHf5Yt/kkUHpaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J63h+RXhEsfeSwWPx861EQd0l6Ir4LJiEF52Cx/miLpnEXS4jkNpD087iOFWgwJiG
         ZqHSwaK8lRXCzWsR6Wf6f9ZriECOZqM5hEorUZugd62h13ahqcsjieyBmLmSjXD4nq
         F3bxI9TV6GJ+hgDuLp1D33Uhh7rPGuI1+a26RHFk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Lin <jilin@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.19 35/86] usb: storage: Add quirk for Samsung Fit flash
Date:   Tue, 10 Mar 2020 13:44:59 +0100
Message-Id: <20200310124532.673612074@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124530.808338541@linuxfoundation.org>
References: <20200310124530.808338541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Lin <jilin@nvidia.com>

commit 86d92f5465958752481269348d474414dccb1552 upstream.

Current driver has 240 (USB2.0) and 2048 (USB3.0) as max_sectors,
e.g., /sys/bus/scsi/devices/0:0:0:0/max_sectors

If data access times out, driver error handling will issue a port
reset.
Sometimes Samsung Fit (090C:1000) flash disk will not respond to
later Set Address or Get Descriptor command.

Adding this quirk to limit max_sectors to 64 sectors to avoid issue
occurring.

Signed-off-by: Jim Lin <jilin@nvidia.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/1583158895-31342-1-git-send-email-jilin@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/unusual_devs.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1258,6 +1258,12 @@ UNUSUAL_DEV( 0x090a, 0x1200, 0x0000, 0x9
 		USB_SC_RBC, USB_PR_BULK, NULL,
 		0 ),
 
+UNUSUAL_DEV(0x090c, 0x1000, 0x1100, 0x1100,
+		"Samsung",
+		"Flash Drive FIT",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_MAX_SECTORS_64),
+
 /* aeb */
 UNUSUAL_DEV( 0x090c, 0x1132, 0x0000, 0xffff,
 		"Feiya",


