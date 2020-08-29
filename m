Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B10C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 09:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8AE20791
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 09:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aleksander-es.20150623.gappssmtp.com header.i=@aleksander-es.20150623.gappssmtp.com header.b="YACj5OvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgH2JF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 05:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgH2JFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 05:05:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EB1C061239
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 02:05:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v4so470458wmj.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 02:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aleksander-es.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QE5D//VreLHMPziiM2vl+h2p5SBjzAjfcvuXZshVHrw=;
        b=YACj5OvQ3KyH1Q7+kB5LcxBtxADXRmMgaAqrGqpfGNN1KmJLVFxbknU+6cMzTz1kk9
         Z6FrX6xsSJNyhZBBlTz+S7kRW/+tfZOwu5GO8fOgIsquj6vmDu2WvjDLs8jFZyvJydLP
         oXI1l5H/OzjN66OwB1jDqW5Za4AaeYPtDqcjulF3JDpMq04YKLclhMI2o6Nm96WF6eu5
         ih0Gvdm9tZQYg3dqYLoYIwBcya0B9mpq3RlfdY75RdZ1GD0lbizlzYlI4GDeSx/U/zCd
         kjnwmWo4K+M0vT6qQAPjGo8OREvkBXcIfgIfF1Sl+nUCUzSBgKpqcs56yMmX6G6It/Hg
         EykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QE5D//VreLHMPziiM2vl+h2p5SBjzAjfcvuXZshVHrw=;
        b=dfRD4lY3lhXAg0T7GWeKp2dEmDDNaY0MA/ZcG1M4d4QkPYHgdB0rXwpAn0njhmdepb
         PoFWNE7MRu4f7zUhrH1paegSJUzmSQlg+vArwDma/6Tzn0Tw+3PcN6O88r20/C4Let4Y
         Svfvbi/dmaXOgXr9ksxXUwHchsfQnygEmgRHIcz8DRrBRQn3QRe9G2j2ZLktoPtJ2ydM
         OmuNt322KkaL5+J+XHxBcostee8XzWhUBggJu7IMdtogR0hPASiEkeP3Uz1pYfbXd6gF
         KxmV4Bo2IZf+xHKTNsQA/sFtn/9E5p4h2TrfvCNgIgXVDBYaJspqzjLLLbEmHtEaff+M
         3w6w==
X-Gm-Message-State: AOAM5300vXMUbQ6nS+2oIE0fJHuxBvPjW9UaNLWmqNKC1qci9R6GxLVB
        8YJG4Xcz22VCcNRJCVXD3NQahQ==
X-Google-Smtp-Source: ABdhPJzn8lVS69nj85tYjy6Ko0MyExr6pjPMl6fAG+YuIIE4/HGv6LpsFT8fR6/hZ478RnuukH8qIg==
X-Received: by 2002:a1c:a953:: with SMTP id s80mr1902732wme.70.1598691943764;
        Sat, 29 Aug 2020 02:05:43 -0700 (PDT)
Received: from localhost.localdomain (158.red-83-58-181.dynamicip.rima-tde.net. [83.58.181.158])
        by smtp.gmail.com with ESMTPSA id g9sm2884529wrw.63.2020.08.29.02.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 02:05:43 -0700 (PDT)
From:   Aleksander Morgado <aleksander@aleksander.es>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksander Morgado <aleksander@aleksander.es>
Subject: [PATCH] USB: serial: option: add support for SIM7070/SIM7080/SIM7090 modules
Date:   Sat, 29 Aug 2020 11:05:39 +0200
Message-Id: <20200829090539.80140-1-aleksander@aleksander.es>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These modules have 2 different USB layouts:

The default layout with PID 0x9205 (AT+CUSBSELNV=1) exposes 4 TTYs and
an ECM interface:

  T:  Bus=02 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  6 Spd=480 MxCh= 0
  D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
  P:  Vendor=1e0e ProdID=9205 Rev=00.00
  S:  Manufacturer=SimTech, Incorporated
  S:  Product=SimTech SIM7080
  S:  SerialNumber=1234567890ABCDEF
  C:  #Ifs= 6 Cfg#= 1 Atr=e0 MxPwr=500mA
  I:  If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
  I:  If#=0x1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
  I:  If#=0x2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
  I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
  I:  If#=0x4 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
  I:  If#=0x5 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether

The purpose of each TTY is as follows:
 * ttyUSB0: DIAG/QCDM port.
 * ttyUSB1: GNSS data.
 * ttyUSB2: AT-capable port (control).
 * ttyUSB3: AT-capable port (data).

In the secondary layout with PID=0x9206 (AT+CUSBSELNV=86) the module
exposes 6 TTY ports:

  T:  Bus=02 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  8 Spd=480 MxCh= 0
  D:  Ver= 2.00 Cls=02(commc) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
  P:  Vendor=1e0e ProdID=9206 Rev=00.00
  S:  Manufacturer=SimTech, Incorporated
  S:  Product=SimTech SIM7080
  S:  SerialNumber=1234567890ABCDEF
  C:  #Ifs= 6 Cfg#= 1 Atr=e0 MxPwr=500mA
  I:  If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
  I:  If#=0x1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
  I:  If#=0x2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
  I:  If#=0x3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
  I:  If#=0x4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
  I:  If#=0x5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option

The purpose of each TTY is as follows:
 * ttyUSB0: DIAG/QCDM port.
 * ttyUSB1: GNSS data.
 * ttyUSB2: AT-capable port (control).
 * ttyUSB3: QFLOG interface.
 * ttyUSB4: DAM interface.
 * ttyUSB5: AT-capable port (data).

Signed-off-by: Aleksander Morgado <aleksander@aleksander.es>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 89b3192af326..01c5b452c6ea 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1819,6 +1819,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9003, 0xff) },	/* Simcom SIM7500/SIM7600 MBIM mode */
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9011, 0xff),	/* Simcom SIM7500/SIM7600 RNDIS mode */
 	  .driver_info = RSVD(7) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9205, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT+ECM mode */
+	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9206, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT-only mode */
 	{ USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_X060S_X200),
 	  .driver_info = NCTRL(0) | NCTRL(1) | RSVD(4) },
 	{ USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_X220_X500D),
-- 
2.28.0

