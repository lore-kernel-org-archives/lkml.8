Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE367C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC04322B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259595;
	bh=GjzTNAD2SRCoK8sJDxSQRELwKr0irgmWB87gKjOlOwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BtH45o2W3b5EJpze0eD+yJFx2JpnYoPe9wul0P54Bkv7HOJv0DSYxlvQaKfhyqnqa
	 T3/aAtEnUN8mmhRzfWHmkxhJjsJAvhm7VePDXc6X1E7wYrIh0OXmukbKgM0j60ADTg
	 5JXh/IGal6MPtYUNg1Nb7QfCDF7Fu6TyQ+iKgwUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgGTPjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbgGTPjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:39:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCCCA22B4E;
        Mon, 20 Jul 2020 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259591;
        bh=GjzTNAD2SRCoK8sJDxSQRELwKr0irgmWB87gKjOlOwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HxcbpdTChaqauxquYR1XRzXoSzAwbRrw57zkxzeb7cP08QC33Mg822j+zB2x66f2M
         hwienKBCdpR09kEo1I3udOuHDb9/aqVY/RF+6oB78cz5jKMpx/Xi2AnI0KMI8VispK
         iVCo8YC5l4UpEMRuMu97GPTDhYMSc833YxDLGD10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Moura <imphilippini@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 46/58] USB: serial: ch341: add new Product ID for CH340
Date:   Mon, 20 Jul 2020 17:37:02 +0200
Message-Id: <20200720152749.536769940@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152747.127988571@linuxfoundation.org>
References: <20200720152747.127988571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Moura <imphilippini@gmail.com>

commit 5d0136f8e79f8287e6a36780601f0ce797cf11c2 upstream.

Add PID for CH340 that's found on some ESP8266 dev boards made by
LilyGO. The specific device that contains such serial converter can be
seen here: https://github.com/LilyGO/LILYGO-T-OI.

Apparently, it's a regular CH340, but I've confirmed with others that
also bought this board that the PID found on this device (0x7522)
differs from other devices with the "same" converter (0x7523).
Simply adding its PID to the driver and rebuilding it made it work
as expected.

Signed-off-by: Igor Moura <imphilippini@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ch341.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -71,6 +71,7 @@
 
 static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x4348, 0x5523) },
+	{ USB_DEVICE(0x1a86, 0x7522) },
 	{ USB_DEVICE(0x1a86, 0x7523) },
 	{ USB_DEVICE(0x1a86, 0x5523) },
 	{ },


