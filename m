Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F115EC47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE72520757
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339569;
	bh=CX7U7DU7t3Ya7Z9Q+P+Uq8o3g8D0HfAOR0whle/rmlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DAzSjVEj1IiaZRZM8zU+VF5LxJLa8YC6vj3dF7zRmxeGLbLn0uV6VrO9peTZGsZ4y
	 8ddeVIXOD4qtMuaTcCDXRbE39RFn3f4AQSiZ5AAFgmj/p6lYFXXCsiJnm4NRxOfFSv
	 WPKCHHPUq+VVPG1rzzOQhd3cRu7LvbkrA0OHQk5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgEAN0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbgEAN0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:26:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C09E020757;
        Fri,  1 May 2020 13:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339566;
        bh=CX7U7DU7t3Ya7Z9Q+P+Uq8o3g8D0HfAOR0whle/rmlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TtoAglTFcbbPmz0ZQ6K7S9uoEqaLGjgt07GpGD5ZZKEmZQp2BGInX84JlDl2IgATd
         eFl0vXLvWyp18r3qF1Q5nTdUbR6PywhctJ9qfeyIVyMAvHbLG3loRAW2KbPFyFr4Yf
         t3S5SbHTBVTXflMIDoyM6QxLL5D/+F3GQfN5GgW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changming Liu <liu.changm@northeastern.edu>
Subject: [PATCH 4.4 30/70] USB: sisusbvga: Change port variable from signed to unsigned
Date:   Fri,  1 May 2020 15:21:18 +0200
Message-Id: <20200501131523.639274148@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.302599262@linuxfoundation.org>
References: <20200501131513.302599262@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changming Liu <liu.changm@northeastern.edu>

commit 2df7405f79ce1674d73c2786fe1a8727c905d65b upstream.

Change a bunch of arguments of wrapper functions which pass signed
integer to an unsigned integer which might cause undefined behaviors
when sign integer overflow.

Signed-off-by: Changming Liu <liu.changm@northeastern.edu>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/BL0PR06MB45482D71EA822D75A0E60A2EE5D50@BL0PR06MB4548.namprd06.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/sisusbvga/sisusb.c      |   20 ++++++++++----------
 drivers/usb/misc/sisusbvga/sisusb_init.h |   14 +++++++-------
 2 files changed, 17 insertions(+), 17 deletions(-)

--- a/drivers/usb/misc/sisusbvga/sisusb.c
+++ b/drivers/usb/misc/sisusbvga/sisusb.c
@@ -1243,20 +1243,20 @@ static int sisusb_read_mem_bulk(struct s
 
 #ifdef INCL_SISUSB_CON
 int
-sisusb_setreg(struct sisusb_usb_data *sisusb, int port, u8 data)
+sisusb_setreg(struct sisusb_usb_data *sisusb, u32 port, u8 data)
 {
 	return sisusb_write_memio_byte(sisusb, SISUSB_TYPE_IO, port, data);
 }
 
 int
-sisusb_getreg(struct sisusb_usb_data *sisusb, int port, u8 *data)
+sisusb_getreg(struct sisusb_usb_data *sisusb, u32 port, u8 *data)
 {
 	return sisusb_read_memio_byte(sisusb, SISUSB_TYPE_IO, port, data);
 }
 #endif
 
 int
-sisusb_setidxreg(struct sisusb_usb_data *sisusb, int port, u8 index, u8 data)
+sisusb_setidxreg(struct sisusb_usb_data *sisusb, u32 port, u8 index, u8 data)
 {
 	int ret;
 	ret = sisusb_write_memio_byte(sisusb, SISUSB_TYPE_IO, port, index);
@@ -1265,7 +1265,7 @@ sisusb_setidxreg(struct sisusb_usb_data
 }
 
 int
-sisusb_getidxreg(struct sisusb_usb_data *sisusb, int port, u8 index, u8 *data)
+sisusb_getidxreg(struct sisusb_usb_data *sisusb, u32 port, u8 index, u8 *data)
 {
 	int ret;
 	ret = sisusb_write_memio_byte(sisusb, SISUSB_TYPE_IO, port, index);
@@ -1274,7 +1274,7 @@ sisusb_getidxreg(struct sisusb_usb_data
 }
 
 int
-sisusb_setidxregandor(struct sisusb_usb_data *sisusb, int port, u8 idx,
+sisusb_setidxregandor(struct sisusb_usb_data *sisusb, u32 port, u8 idx,
 							u8 myand, u8 myor)
 {
 	int ret;
@@ -1289,7 +1289,7 @@ sisusb_setidxregandor(struct sisusb_usb_
 }
 
 static int
-sisusb_setidxregmask(struct sisusb_usb_data *sisusb, int port, u8 idx,
+sisusb_setidxregmask(struct sisusb_usb_data *sisusb, u32 port, u8 idx,
 							u8 data, u8 mask)
 {
 	int ret;
@@ -1303,13 +1303,13 @@ sisusb_setidxregmask(struct sisusb_usb_d
 }
 
 int
-sisusb_setidxregor(struct sisusb_usb_data *sisusb, int port, u8 index, u8 myor)
+sisusb_setidxregor(struct sisusb_usb_data *sisusb, u32 port, u8 index, u8 myor)
 {
 	return(sisusb_setidxregandor(sisusb, port, index, 0xff, myor));
 }
 
 int
-sisusb_setidxregand(struct sisusb_usb_data *sisusb, int port, u8 idx, u8 myand)
+sisusb_setidxregand(struct sisusb_usb_data *sisusb, u32 port, u8 idx, u8 myand)
 {
 	return(sisusb_setidxregandor(sisusb, port, idx, myand, 0x00));
 }
@@ -2849,8 +2849,8 @@ static int
 sisusb_handle_command(struct sisusb_usb_data *sisusb, struct sisusb_command *y,
 							unsigned long arg)
 {
-	int	retval, port, length;
-	u32	address;
+	int	retval, length;
+	u32	port, address;
 
 	/* All our commands require the device
 	 * to be initialized.
--- a/drivers/usb/misc/sisusbvga/sisusb_init.h
+++ b/drivers/usb/misc/sisusbvga/sisusb_init.h
@@ -811,17 +811,17 @@ static const struct SiS_VCLKData SiSUSB_
 int SiSUSBSetMode(struct SiS_Private *SiS_Pr, unsigned short ModeNo);
 int SiSUSBSetVESAMode(struct SiS_Private *SiS_Pr, unsigned short VModeNo);
 
-extern int sisusb_setreg(struct sisusb_usb_data *sisusb, int port, u8 data);
-extern int sisusb_getreg(struct sisusb_usb_data *sisusb, int port, u8 * data);
-extern int sisusb_setidxreg(struct sisusb_usb_data *sisusb, int port,
+extern int sisusb_setreg(struct sisusb_usb_data *sisusb, u32 port, u8 data);
+extern int sisusb_getreg(struct sisusb_usb_data *sisusb, u32 port, u8 * data);
+extern int sisusb_setidxreg(struct sisusb_usb_data *sisusb, u32 port,
 			    u8 index, u8 data);
-extern int sisusb_getidxreg(struct sisusb_usb_data *sisusb, int port,
+extern int sisusb_getidxreg(struct sisusb_usb_data *sisusb, u32 port,
 			    u8 index, u8 * data);
-extern int sisusb_setidxregandor(struct sisusb_usb_data *sisusb, int port,
+extern int sisusb_setidxregandor(struct sisusb_usb_data *sisusb, u32 port,
 				 u8 idx, u8 myand, u8 myor);
-extern int sisusb_setidxregor(struct sisusb_usb_data *sisusb, int port,
+extern int sisusb_setidxregor(struct sisusb_usb_data *sisusb, u32 port,
 			      u8 index, u8 myor);
-extern int sisusb_setidxregand(struct sisusb_usb_data *sisusb, int port,
+extern int sisusb_setidxregand(struct sisusb_usb_data *sisusb, u32 port,
 			       u8 idx, u8 myand);
 
 void sisusb_delete(struct kref *kref);


