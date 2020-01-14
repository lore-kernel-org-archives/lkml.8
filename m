Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBB8C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34E92467E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996318;
	bh=IA4zhxySlZan7pfY5mjPaJZUUfUKv3XdLULsUDAO+GU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gVw+tzfvVGfNJtNi7GwwExP2YyfyS37vP8uEhmfSfdoYB5SuDWpB541fuS3Lwrlhd
	 bMUkiHCyLqY+4CD9ykuOjX5djvZChkwO2ShiLSMJP/w/Ge+0psPLameJfMc9M5VbPW
	 hStaICeVdZlJhkcp7yALn57KEcFcMTHSiUWaKQGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgANKFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729650AbgANKFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:05:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7267E2467A;
        Tue, 14 Jan 2020 10:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996312;
        bh=IA4zhxySlZan7pfY5mjPaJZUUfUKv3XdLULsUDAO+GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7y2Z1OPaM2/J1MpQK/71c6WxvJLRTQlNjCoGnzXb7GknERLaRtxl/juz7ELClR3B
         vkO6O7R4a4k6JgH5DlUQFIrDSkCPrnjyRsZZ+pb7QQD6h07CA3RUdhAfmJHWxzlwxc
         fI9w5FRgYbpdnaZbo0LRpjol6h1ywFUzat7H5GIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Hans de Goede <hdegoede@redhat.com>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH 5.4 53/78] serdev: Dont claim unsupported ACPI serial devices
Date:   Tue, 14 Jan 2020 11:01:27 +0100
Message-Id: <20200114094400.596438147@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

commit c5ee0b3104e0b292d353e63fd31cb8c692645d8c upstream.

Serdev sub-system claims all ACPI serial devices that are not already
initialised. As a result, no device node is created for serial ports
on certain boards such as the Apollo Lake based UP2. This has the
unintended consequence of not being able to raise the login prompt via
serial connection.

Introduce a blacklist to reject ACPI serial devices that should not be
claimed by serdev sub-system. Add the peripheral ids for Intel HS UART
to the blacklist to bring back serial port on SoCs carrying them.

Cc: stable@vger.kernel.org
Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20191219100345.911093-1-punit1.agrawal@toshiba.co.jp
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serdev/core.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -582,6 +582,12 @@ static acpi_status acpi_serdev_register_
 	return AE_OK;
 }
 
+static const struct acpi_device_id serdev_acpi_devices_blacklist[] = {
+	{ "INT3511", 0 },
+	{ "INT3512", 0 },
+	{ },
+};
+
 static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
 				       void *data, void **return_value)
 {
@@ -591,6 +597,10 @@ static acpi_status acpi_serdev_add_devic
 	if (acpi_bus_get_device(handle, &adev))
 		return AE_OK;
 
+	/* Skip if black listed */
+	if (!acpi_match_device_ids(adev, serdev_acpi_devices_blacklist))
+		return AE_OK;
+
 	return acpi_serdev_register_device(ctrl, adev);
 }
 


