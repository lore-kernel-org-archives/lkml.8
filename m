Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A23C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B50120842
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRqR7NCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgHETy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgHEQsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:48:38 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6655EC03461F;
        Wed,  5 Aug 2020 06:03:08 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o23so18868977ejr.1;
        Wed, 05 Aug 2020 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o31JkXgtZ4KmGQwREdAQtnazhwrTeZbjodMq4WKIsR8=;
        b=oRqR7NCwVz0YdCOq5y9Di9yY2c14OhBELXKVnCpcy4Sxg4toCn7APCbmlrHy8z8lws
         rf5C587r2BGbwSCMjqJ5OXfM5DYCz39WS8x+eWVItfNkCF63iWBXoILLxWWzpumDFuJa
         irLEN6Nlv3fAKULI0N963VBidezMzWD/fBHbD6Xv7BAIPnjFO0av2I/q0GprRI78SUrk
         W/RfWxrBVe7c/6RazTgf15EvRN0noN1dKSyWjYuuBVUAVia0/CghPoH1dsXhfR33qpgL
         RlZdAZNk4kmRhjHZmyLbUTIiNpRLmhbapykPgm13yM7tGXp3gPXrcNNprDozeRngTkgJ
         0TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o31JkXgtZ4KmGQwREdAQtnazhwrTeZbjodMq4WKIsR8=;
        b=Bm9dynqgxw+qGhxkr3VWYZdM/Hbi48cJLGF3jha/OUVTJGGiYC86QOnLQJMV0fOvIr
         kP0mrH21tVkCEZj/VYeruQ+gMgfaOL9Z0YIbw/JaatGx+Dnm/2vFwHTl58efnRHqP46T
         F83aVY6YqjmXLHOEupR6kTz51qE355srgVTaT+E4YXtnIdJ1m6tthxnmD0VJGLnazCv0
         9AoW93DWticUusI9Z48ovUDURijUetLSkzmZILq56B3+Qdjo7XegBs/1DWrZgcLU/f4E
         5q5yY3pJaQIMTUo/KWnm4Meq7fFPvkmZtkIRU5ib6PKnXdgRNjk4FfnpvmuSI6NcyHbW
         /D7g==
X-Gm-Message-State: AOAM531grTnp+ppNFZM/FGqOs1RokwFrfBMX7WdgNRGyBmLqS80YQ3uo
        4k9rx5wmIeRHHFq9WUZ1oyBwgczM+A1WTg==
X-Google-Smtp-Source: ABdhPJwpV6jay6HnA4JCyBzViq2LRupyjuqyy2vGtx3iu8UAE5labTelSaY8awWs/xVtKFK9jILnnQ==
X-Received: by 2002:a17:907:7090:: with SMTP id yj16mr2980056ejb.73.1596632586279;
        Wed, 05 Aug 2020 06:03:06 -0700 (PDT)
Received: from ci00583-linux.xsens-tech.local (2001-1c06-0702-ba00-8940-6ad0-42ef-6a6f.cable.dynamic.v6.ziggo.nl. [2001:1c06:702:ba00:8940:6ad0:42ef:6a6f])
        by smtp.googlemail.com with ESMTPSA id o14sm1401851edi.27.2020.08.05.06.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:03:04 -0700 (PDT)
From:   Patrick Riphagen <ppriphagen@gmail.com>
X-Google-Original-From: Patrick Riphagen <patrick.riphagen@xsens.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     patrick.riphagen@xsens.com
Subject: [PATCH] USB: serial: ftdi_sio: add IDs for Xsens Mti USB converter
Date:   Wed,  5 Aug 2020 15:02:52 +0200
Message-Id: <20200805130252.41973-1-patrick.riphagen@xsens.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device added has an FTDI chip inside.
The device is used to connect Xsens USB Motion Trackers.

Signed-off-by: Patrick Riphagen <patrick.riphagen@xsens.com>
---
 drivers/usb/serial/ftdi_sio.c     | 1 +
 drivers/usb/serial/ftdi_sio_ids.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 9ad44a96dfe3..2c08cad32f1d 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -713,6 +713,7 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(XSENS_VID, XSENS_AWINDA_STATION_PID) },
 	{ USB_DEVICE(XSENS_VID, XSENS_CONVERTER_PID) },
 	{ USB_DEVICE(XSENS_VID, XSENS_MTDEVBOARD_PID) },
+	{ USB_DEVICE(XSENS_VID, XSENS_MTIUSBCONVERTER_PID) },
 	{ USB_DEVICE(XSENS_VID, XSENS_MTW_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_OMNI1509) },
 	{ USB_DEVICE(MOBILITY_VID, MOBILITY_USB_SERIAL_PID) },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index e8373528264c..b5ca17a5967a 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -160,6 +160,7 @@
 #define XSENS_AWINDA_DONGLE_PID 0x0102
 #define XSENS_MTW_PID		0x0200	/* Xsens MTw */
 #define XSENS_MTDEVBOARD_PID	0x0300	/* Motion Tracker Development Board */
+#define XSENS_MTIUSBCONVERTER_PID	0x0301	/* MTi USB converter */
 #define XSENS_CONVERTER_PID	0xD00D	/* Xsens USB-serial converter */
 
 /* Xsens devices using FTDI VID */
-- 
2.25.1

