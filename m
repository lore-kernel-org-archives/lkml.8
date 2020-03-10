Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38202C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E0C2468D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845885;
	bh=oBMNqUX4ZPWgo8M0jSF0Wt24UTeI5DRNxLRhMkgAc7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QW/qPfW21/8KFuw14C4Yi/5sBwfJyrwjnnISTte3b1pP0Gu0O/yFFL5BB4BV7y51u
	 SqOhFQOEuB0OgzXFNFhew70BfrIQKsHFBdMMHT57/gvFpSihDA/oI57bvzkX+e313+
	 bUfgInovMJk+nZnDxxYjX74F9Trm8A6drOevgNiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbgCJNLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:11:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:32802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbgCJNLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:11:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53CEE24649;
        Tue, 10 Mar 2020 13:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845880;
        bh=oBMNqUX4ZPWgo8M0jSF0Wt24UTeI5DRNxLRhMkgAc7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c5WDL7r+XJKaXXApliFrCr5Q9HwEroqmsYE5o43/KSBheGWNP5COtDAJsrLry/oBL
         UQnBjpoun7IA4CEZ+6slubpS/hMWlhwQtIM917dW1t6iGt1lS3TWpWBr6woWRO81Iz
         l9RAraMW8TBKH2ntOnQeTfIVvfhHS+jmmhdz5hgQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Lin <jilin@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.14 092/126] usb: storage: Add quirk for Samsung Fit flash
Date:   Tue, 10 Mar 2020 13:41:53 +0100
Message-Id: <20200310124209.649450172@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
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
@@ -1277,6 +1277,12 @@ UNUSUAL_DEV( 0x090a, 0x1200, 0x0000, 0x9
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


