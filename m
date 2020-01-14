Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98DAC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8149A2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996550;
	bh=Iol7IohHZdICWIhHVeucpDdX7I4/XMk4XVEm9fizVxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qzEHuP7dNQHf9TCZkPCdDLT2lFBiJnGQE7vrg794sx6lfgJZ5slErJJY8pOOu2xtn
	 iBYBUbr6hpGm8QDTBTZcxhisxD3O+yDx5ubGcXEoMaAom3/3PYDCOYjWcslip92HSd
	 NqIpM0GVw4THjz4EMNwdS/vAFerMbG5R4HIpO3Xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgANKJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:09:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgANKJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:09:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1EC920678;
        Tue, 14 Jan 2020 10:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996547;
        bh=Iol7IohHZdICWIhHVeucpDdX7I4/XMk4XVEm9fizVxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgWhnz9R1fV2CJmTtQlCOGAGm3c31y4WsXev9QI+D0Ef+RlJD39Xp1F2lSLje8CHm
         gjhB4u61PoaMfYFMq8WPWhaw2jyld24zz8KhDy7FsfvRO4IdNtoGAVp5QCE1OGoWn2
         X3IhjRAKgay1aldF+70mMlGyNtwRRLkupYziQDo0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Hans de Goede <hdegoede@redhat.com>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH 4.19 32/46] serdev: Dont claim unsupported ACPI serial devices
Date:   Tue, 14 Jan 2020 11:01:49 +0100
Message-Id: <20200114094346.827991943@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
References: <20200114094339.608068818@linuxfoundation.org>
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
@@ -526,6 +526,12 @@ static acpi_status acpi_serdev_register_
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
@@ -535,6 +541,10 @@ static acpi_status acpi_serdev_add_devic
 	if (acpi_bus_get_device(handle, &adev))
 		return AE_OK;
 
+	/* Skip if black listed */
+	if (!acpi_match_device_ids(adev, serdev_acpi_devices_blacklist))
+		return AE_OK;
+
 	return acpi_serdev_register_device(ctrl, adev);
 }
 


