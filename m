Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01F7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C77E21D7B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592473438;
	bh=Wy9ApHk7lhW5ubr5Fi337sJMoRNgbw7hh2p3KGOQabI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l8vDgG4t4tt1PKyFu5lWNPtl7QGjQOMzF1K+uKXwNKeCq3QvsYJo+ApCJUuzxnUIl
	 OWDyPNXg37zOQRzUPIVrqPr8DruMFx1Iq7oZykIx9q4dwMKKleb1GnFl65bUJKxU0q
	 DT1fAALjmEp23iT7CeQiFbDnz0x8ZRqhztUECsc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgFRJnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729266AbgFRJnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:43:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FAC621548;
        Thu, 18 Jun 2020 09:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592473402;
        bh=Wy9ApHk7lhW5ubr5Fi337sJMoRNgbw7hh2p3KGOQabI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyjR7KH+cdc7/MGMLakGNRVrBmXHVIhGogIxqzMsMTzwXMIUfSurmVkfeKXV+EUiC
         9eZDl1Pcpcv+7VM9s+ywT00spmVFHnwezYUxXQdKVr48UE5B8TZvvkJUU4ZzaPGjQt
         yb62QSdDWwGoQ5uZz7soAzDjnInyb3okzu6JZkdE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/8] USB: serial: qcserial: fix up wording in a comment
Date:   Thu, 18 Jun 2020 11:42:56 +0200
Message-Id: <20200618094300.1887727-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
References: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Better describe what is happening with a list of devices that are being
ignored by the driver.

Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/qcserial.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index d147feae83e6..5dfbbaef38bb 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -365,9 +365,8 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 		 * a specific function, while the subclass indicate a
 		 * specific firmware source
 		 *
-		 * This is a blacklist of functions known to be
-		 * non-serial.  The rest are assumed to be serial and
-		 * will be handled by this driver
+		 * This is a list of functions known to be non-serial.  The rest
+		 * are assumed to be serial and will be handled by this driver
 		 */
 		switch (intf->desc.bInterfaceProtocol) {
 			/* QMI combined (qmi_wwan) */
-- 
2.27.0

