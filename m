Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BADC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B55206D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341556;
	bh=6ZZjgCH98qpYC/CbtgxU6mXtYtB82jt3T4S206u6knA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pDR7BIcZStQqCbCUyAFA9t+nfEWBQiG2Csxy2SUg8el+5Hsz3xQSj5b2PpBK3m0MY
	 CcuMb7+abNEJV24TU8S65XELlFLZGhDnA26eQfBUdLO+ZoqlSVWb1s5NQoCW3tAQxf
	 O8zPUrfftAUc2+oGKngz4QGIzcFFmWwpcg3xqC0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgEAN7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbgEAN3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:29:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A17208D6;
        Fri,  1 May 2020 13:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339758;
        bh=6ZZjgCH98qpYC/CbtgxU6mXtYtB82jt3T4S206u6knA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cszvBVMzls0sm8ukeYegC72onSDbaSsyfeDSE2nMkeCsmue/17a9oQ1yDrqjR3fcH
         NM03Cn/X4u/oYgbv2iKemeh4hoNUJVBV+qlq725vpkWTv+kR1JWOjYLqfmveD3yICT
         u1XCnzSU/d5UtZmHIGUZOsKzo3ELj4B7XE1AEtwk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Cyril Roelandt <tipecaml@gmail.com>
Subject: [PATCH 4.9 48/80] usb-storage: Add unusual_devs entry for JMicron JMS566
Date:   Fri,  1 May 2020 15:21:42 +0200
Message-Id: <20200501131528.552268132@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.810761598@linuxfoundation.org>
References: <20200501131513.810761598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit 94f9c8c3c404ee1f7aaff81ad4f24aec4e34a78b upstream.

Cyril Roelandt reports that his JMicron JMS566 USB-SATA bridge fails
to handle WRITE commands with the FUA bit set, even though it claims
to support FUA.  (Oddly enough, a later version of the same bridge,
version 2.03 as opposed to 1.14, doesn't claim to support FUA.  Also
oddly, the bridge _does_ support FUA when using the UAS transport
instead of the Bulk-Only transport -- but this device was blacklisted
for uas in commit bc3bdb12bbb3 ("usb-storage: Disable UAS on JMicron
SATA enclosure") for apparently unrelated reasons.)

This patch adds a usb-storage unusual_devs entry with the BROKEN_FUA
flag.  This allows the bridge to work properly with usb-storage.

Reported-and-tested-by: Cyril Roelandt <tipecaml@gmail.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/Pine.LNX.4.44L0.2004221613110.11262-100000@iolanthe.rowland.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/unusual_devs.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2342,6 +2342,13 @@ UNUSUAL_DEV(  0x3340, 0xffff, 0x0000, 0x
 		USB_SC_DEVICE,USB_PR_DEVICE,NULL,
 		US_FL_MAX_SECTORS_64 ),
 
+/* Reported by Cyril Roelandt <tipecaml@gmail.com> */
+UNUSUAL_DEV(  0x357d, 0x7788, 0x0114, 0x0114,
+		"JMicron",
+		"USB to ATA/ATAPI Bridge",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_BROKEN_FUA ),
+
 /* Reported by Andrey Rahmatullin <wrar@altlinux.org> */
 UNUSUAL_DEV(  0x4102, 0x1020, 0x0100,  0x0100,
 		"iRiver",


