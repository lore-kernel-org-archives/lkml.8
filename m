Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1327DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DEB204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976847;
	bh=M6mO7aD4g3nwn2ky5GQ939Xtf4Z8vXz99rt/x9hNkn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ViNfUgnO25FGp5TkDwqA0vI4Bua4XySlO2cqeo2zkYXCfTH9Vi46XPhsEEe7gz+5i
	 E2PX3vlWITGenih8OXDLeyJI2vK75bEpDboK1OzMgOfyuok94rNMv9hG883zY3fTcT
	 RocSTKGQcPfpcNwuVQJ4PBspM7yySxuq4Ynjxyd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbgIAQOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbgIAPfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:35:53 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A339521655;
        Tue,  1 Sep 2020 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974553;
        bh=M6mO7aD4g3nwn2ky5GQ939Xtf4Z8vXz99rt/x9hNkn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOe10bmI/ans1MFvsr9qUam3OPzwHp+OwKX1OXL2phHDwrA4RgfxqJkrUofv5j9P0
         UjwuxaQo0pYeJWEOBdStV5ZODQBnHcYn8QzIAmoEIiXt4OXB/eWH6Krgk6QHeL/IYC
         tQ1kLgDwJ5mNeQ0IPzekUFX0x97ZtCOWEI0CUKsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        =?UTF-8?q?Till=20D=C3=B6rges?= <doerges@pre-sense.de>
Subject: [PATCH 5.4 199/214] usb: storage: Add unusual_uas entry for Sony PSZ drives
Date:   Tue,  1 Sep 2020 17:11:19 +0200
Message-Id: <20200901151002.479554955@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit 20934c0de13b49a072fb1e0ca79fe0fe0e40eae5 upstream.

The PSZ-HA* family of USB disk drives from Sony can't handle the
REPORT OPCODES command when using the UAS protocol.  This patch adds
an appropriate quirks entry.

Reported-and-tested-by: Till Dörges <doerges@pre-sense.de>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200826143229.GB400430@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/unusual_uas.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -28,6 +28,13 @@
  * and don't forget to CC: the USB development list <linux-usb@vger.kernel.org>
  */
 
+/* Reported-by: Till Dörges <doerges@pre-sense.de> */
+UNUSUAL_DEV(0x054c, 0x087d, 0x0000, 0x9999,
+		"Sony",
+		"PSZ-HA*",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_NO_REPORT_OPCODES),
+
 /* Reported-by: Julian Groß <julian.g@posteo.de> */
 UNUSUAL_DEV(0x059f, 0x105f, 0x0000, 0x9999,
 		"LaCie",


