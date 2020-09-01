Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E76C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB2A20866
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974654;
	bh=4XZChSonufT3q06m5nVNuIAve7CPg3nWB8K8EqYwj6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yW/uvEJuUoiWGsJ5qHOwGg/T3ZyMc9+nDuZrRlQAkjeaOhPuRaxOihNp/3Oa0/ZiD
	 hNd//Jue6YdKSJsnZxPz/dk43YbGMZzvTyL5vtulf3H0S62H0ewcgk3aBkB6yYWX9P
	 nXeDGf5wydyAn+lOUxSnXxeBssp+Ss5/UvaY8iyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgIAPhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728742AbgIAPf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:35:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E394C21707;
        Tue,  1 Sep 2020 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974558;
        bh=4XZChSonufT3q06m5nVNuIAve7CPg3nWB8K8EqYwj6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GzbijrLT+0sOS21ucty74D9krxrABdkGrOTsIpU31NGhzYcwl3+cGgYGbKb3wPzAs
         diRuxqKBXHO3oAp1mRY4XxIqkAGd04vBtMLXK+/Pry6dwqvyPB0zxDEc5dli3s9gUJ
         1hqNoM1gEy+2jPYIStWe876sP5qlJ31QeorHvdGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 5.4 191/214] USB: quirks: Add no-lpm quirk for another Raydium touchscreen
Date:   Tue,  1 Sep 2020 17:11:11 +0200
Message-Id: <20200901151002.098805180@linuxfoundation.org>
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 5967116e8358899ebaa22702d09b0af57fef23e1 upstream.

There's another Raydium touchscreen needs the no-lpm quirk:
[    1.339149] usb 1-9: New USB device found, idVendor=2386, idProduct=350e, bcdDevice= 0.00
[    1.339150] usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.339151] usb 1-9: Product: Raydium Touch System
[    1.339152] usb 1-9: Manufacturer: Raydium Corporation
...
[    6.450497] usb 1-9: can't set config #1, error -110

BugLink: https://bugs.launchpad.net/bugs/1889446
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200731051622.28643-1-kai.heng.feng@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -465,6 +465,8 @@ static const struct usb_device_id usb_qu
 
 	{ USB_DEVICE(0x2386, 0x3119), .driver_info = USB_QUIRK_NO_LPM },
 
+	{ USB_DEVICE(0x2386, 0x350e), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* DJI CineSSD */
 	{ USB_DEVICE(0x2ca3, 0x0031), .driver_info = USB_QUIRK_NO_LPM },
 


