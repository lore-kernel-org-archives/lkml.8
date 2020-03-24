Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448E7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C98420775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055611;
	bh=cWF3WUe2wPdnGgifyfwwVAofNRCsrR9G7UqKaQgj4Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tcx9bX/SsPqJzqY4jAvAlpQrlargU3K4AFYiCJZSKppgIMchjpg7m3TyDkHyVMwyc
	 7ZdZvzag8/CHhjV6YlD/c0odUlANJ+wDA3/wu9GOOv1mQoyw2NuNQjOgZlFDUuF9I8
	 vXli38xihYQFnFnikL1hBJ01QsEUd2YhCLvci3ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgCXNNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727752AbgCXNNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:13:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E69FE20B80;
        Tue, 24 Mar 2020 13:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055605;
        bh=cWF3WUe2wPdnGgifyfwwVAofNRCsrR9G7UqKaQgj4Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+t6PUq/vxPxYQ41TZnScuyhKYG63inwPDa4jGWmZ9e+ZH163tGaFSnxj4rVv0GyQ
         7pC4T07UytQV7F3qZu8swMBracxIHd+svbv5Cv+MgFl0qu4POZM3dXZ01A+Qc3CCJ7
         nU+baa4cF+wRm/kd6noiXsMgk42fbtRxCSXH4RiM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4.19 37/65] staging: rtl8188eu: Add device id for MERCUSYS MW150US v2
Date:   Tue, 24 Mar 2020 14:10:58 +0100
Message-Id: <20200324130801.912227286@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Straube <straube.linux@gmail.com>

commit bb5786b9286c253557a0115bc8d21879e61b7b94 upstream.

This device was added to the stand-alone driver on github.
Add it to the staging driver as well.

Link: https://github.com/lwfinger/rtl8188eu/commit/2141f244c3e7
Signed-off-by: Michael Straube <straube.linux@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200312093652.13918-1-straube.linux@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -38,6 +38,7 @@ static const struct usb_device_id rtw_us
 	{USB_DEVICE(0x2001, 0x331B)}, /* D-Link DWA-121 rev B1 */
 	{USB_DEVICE(0x2357, 0x010c)}, /* TP-Link TL-WN722N v2 */
 	{USB_DEVICE(0x2357, 0x0111)}, /* TP-Link TL-WN727N v5.21 */
+	{USB_DEVICE(0x2C4E, 0x0102)}, /* MERCUSYS MW150US v2 */
 	{USB_DEVICE(0x0df6, 0x0076)}, /* Sitecom N150 v2 */
 	{USB_DEVICE(USB_VENDER_ID_REALTEK, 0xffef)}, /* Rosewill RNX-N150NUB */
 	{}	/* Terminating entry */


