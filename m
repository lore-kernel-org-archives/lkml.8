Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1A9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A99208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kryo-se.20150623.gappssmtp.com header.i=@kryo-se.20150623.gappssmtp.com header.b="eSpAOLNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgGQSwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgGQSwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:52:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9421FC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 11:52:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s10so12116197wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kryo-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xqe7Qw0WyiL+wuTbQ9VtGHN4HAGXDzdIwIBa2ghU0+w=;
        b=eSpAOLNjgPO+4ynK1QeAGem06+PQJ2ELwabhowXGkKNcNIOKlhjQXSyrMab6cu80wB
         h3KpRAKPqbORG88Byyr8kWY1AYBus+orCbkYF0+xNY1K0cR0HjDN6CMJHMVSHcqWVbQG
         GkOBz45cCyLeEomJlPA+2sLt+XcfAj84jkWQUFXkTGaUjDqkAXwJF+cFDVyfj14w8u8K
         ELQIAEq+cbPQD4ca5Bz3w4T2rZq1YYzg/8uGcockqM9PMVamgWLvacGIDXanT0mtlhoE
         ls7cveTn0aFTeL9YcYrDz7aoOEdRld+bpGDiy0NcOmAwzKC4+IntR3KdwwTVDXK45V72
         Igbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xqe7Qw0WyiL+wuTbQ9VtGHN4HAGXDzdIwIBa2ghU0+w=;
        b=LDJBgKZcWisXaldOptW6odas+JJD6DvuHwZhzBL3tUJt+HwtznJ6n+wyJy96XyT9p+
         gHIf7CUUpGBMJLRKhoO58KVXAY5Z18TQGX95wvY57aYq2UOtVIm5lJOQlSbEcsthkCJO
         M8FsSZC5UCAaWw8z/7cOH8zbCDJ+ceMXbXzl3oybqSNYIThV2K5yhffSMO9cXcbW4hbj
         JKYoeUsYy88hPcpXQ7/BDos75cS/raC+GZcNjbDAe39wc8d7U/IPdfKteqcjl7LopBgU
         5m9kj4eGdJkpPkgc72t29fXCitOTD9jGgGTEeep5/HMgePZj5ixHA4Qj/gmylNgAqdGl
         8gsw==
X-Gm-Message-State: AOAM533zwu9EkHaSGsg1ehDFu7p+VpaGyx5xuXtxOC62UodPzDL3CU87
        EWcIDAhC5JkXCEK71wLBBae1NQ==
X-Google-Smtp-Source: ABdhPJzE5d0dkM9a09oOZDz+u5hpxgBvisFeklfsljGHZjkDPndRCBU2CjXLXgTfp47+WNblU4jIbg==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr11165656wrs.320.1595011972128;
        Fri, 17 Jul 2020 11:52:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:168:9619:0:a7b:e9f6:ea26:8845])
        by smtp.gmail.com with ESMTPSA id a15sm18030455wrh.54.2020.07.17.11.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:52:51 -0700 (PDT)
From:   Erik Ekman <erik@kryo.se>
To:     Johan Hovold <johan@kernel.org>
Cc:     Erik Ekman <erik@kryo.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: qcserial: add EM7305 QDL product ID
Date:   Fri, 17 Jul 2020 20:51:18 +0200
Message-Id: <20200717185118.3640219-1-erik@kryo.se>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running qmi-firmware-update on the Sierra Wireless EM7305 in a Toshiba
laptop, it changed product ID to 0x9062 when entering QDL mode:

usb 2-4: new high-speed USB device number 78 using xhci_hcd
usb 2-4: New USB device found, idVendor=1199, idProduct=9062, bcdDevice= 0.00
usb 2-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-4: Product: EM7305
usb 2-4: Manufacturer: Sierra Wireless, Incorporated

The upgrade could complete after running
 # echo 1199 9062 > /sys/bus/usb-serial/drivers/qcserial/new_id

qcserial 2-4:1.0: Qualcomm USB modem converter detected
usb 2-4: Qualcomm USB modem converter now attached to ttyUSB0

Signed-off-by: Erik Ekman <erik@kryo.se>
---
 drivers/usb/serial/qcserial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index d147feae83e6..0f60363c1bbc 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -155,6 +155,7 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x1199, 0x9056)},	/* Sierra Wireless Modem */
 	{DEVICE_SWI(0x1199, 0x9060)},	/* Sierra Wireless Modem */
 	{DEVICE_SWI(0x1199, 0x9061)},	/* Sierra Wireless Modem */
+	{DEVICE_SWI(0x1199, 0x9062)},	/* Sierra Wireless EM7305 QDL */
 	{DEVICE_SWI(0x1199, 0x9063)},	/* Sierra Wireless EM7305 */
 	{DEVICE_SWI(0x1199, 0x9070)},	/* Sierra Wireless MC74xx */
 	{DEVICE_SWI(0x1199, 0x9071)},	/* Sierra Wireless MC74xx */
-- 
2.26.2

