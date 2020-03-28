Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773A8C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DE520716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YctLzhJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgC1LLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:11:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40668 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgC1LLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:11:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id c20so3327384pfi.7;
        Sat, 28 Mar 2020 04:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xruqb6jEnmWjvxMbTPam+szn/AYnmpl2M5rImhrizxc=;
        b=YctLzhJbDzZxK5JrFGXRdp4RDARocAeMysOE9B5eGXBg3MkrbR0fIk2k/8GTO3yVia
         JUw5mPnM+N+9Pa85YkcSRB6XFgmoew9LBVsqB4cvz708EEW76FcMgdb8uzmpMVAQ//G7
         X1/C13LvLm8rShAmm2hwPMEBwGN/MrnLDnNxJ30CTmlbPilpIA08Q235gbBFjwJuz0bd
         F/QvyChxuzid5YbGKmIqK8BFMOLVx0xegzmGN7OFTSgmPrEcDvinpJ3P2KkVSBIGZTqq
         oR2xn6PQgfPZLg0+3NBYt2ACLwSnwgPURrUbKn1ell23q38KmRhiDJc1hUCsNRMI344G
         rbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xruqb6jEnmWjvxMbTPam+szn/AYnmpl2M5rImhrizxc=;
        b=CZ/DA6BU//M+2t8F9+Sdz9T7UMHQIEJNwdPSCKUUkPdgPGczjJfkVSFH12qBqy3Jhy
         X0cwwFe1rHxfshXcfa6QUEoY2VzeeMKfDJf6NYkrtOInjaJLfdWr3LI6E24ywGuPDVa+
         hW7ux1WeZIjlgeVa/eEvxa0ZZngDNTqcjyJPfNRmmAhXt4SJOfc3eLfTp/R0sX5NKCl5
         Qm6Cp40iTJpVPSFh0zQPcosb9fupu8lGv3G1ERL4Yy69VHGU2DaDb1j7kxx8Yn2cV3uO
         rfnqOwHQuR4NJlsX9h3bn4OmwLEyM/QEQEMXW7XI+mCp9af+eXsTnx7bp36L+x+9BoIX
         /VNw==
X-Gm-Message-State: ANhLgQ0OGhl1IS9hD5Ox4IcA12T/fNh2+CkBLPwRsZWBVr43rgjQhhe6
        DP8ANXhnliYVdcneSes1H2VQuuQd8c8YYQ==
X-Google-Smtp-Source: ADFU+vtdiUutUFxOOwRP56BRgZhBfVAH65AZis9CslhUHFmHGd9M3FgaTAlLudNbyjo71ZCLVbkXVg==
X-Received: by 2002:a63:dd0a:: with SMTP id t10mr3814098pgg.50.1585393882487;
        Sat, 28 Mar 2020 04:11:22 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id r14sm5605697pjj.48.2020.03.28.04.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 04:11:22 -0700 (PDT)
Date:   Sat, 28 Mar 2020 16:41:15 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: gadget: Use the correct style for SPDX License
 Identifier
Message-ID: <20200328111112.GA7219@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to USB peripheral controller drivers.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/usb/gadget/function/f_uvc.h            | 2 +-
 drivers/usb/gadget/function/rndis.h            | 2 +-
 drivers/usb/gadget/function/u_audio.h          | 2 +-
 drivers/usb/gadget/function/u_ecm.h            | 2 +-
 drivers/usb/gadget/function/u_eem.h            | 2 +-
 drivers/usb/gadget/function/u_ether.h          | 2 +-
 drivers/usb/gadget/function/u_ether_configfs.h | 2 +-
 drivers/usb/gadget/function/u_fs.h             | 2 +-
 drivers/usb/gadget/function/u_gether.h         | 2 +-
 drivers/usb/gadget/function/u_hid.h            | 2 +-
 drivers/usb/gadget/function/u_midi.h           | 2 +-
 drivers/usb/gadget/function/u_ncm.h            | 2 +-
 drivers/usb/gadget/function/u_phonet.h         | 2 +-
 drivers/usb/gadget/function/u_printer.h        | 2 +-
 drivers/usb/gadget/function/u_rndis.h          | 2 +-
 drivers/usb/gadget/function/u_serial.h         | 2 +-
 drivers/usb/gadget/function/u_tcm.h            | 2 +-
 drivers/usb/gadget/function/u_uac1.h           | 2 +-
 drivers/usb/gadget/function/u_uac1_legacy.h    | 2 +-
 drivers/usb/gadget/function/u_uac2.h           | 2 +-
 drivers/usb/gadget/function/u_uvc.h            | 2 +-
 drivers/usb/gadget/function/uvc.h              | 2 +-
 drivers/usb/gadget/function/uvc_configfs.h     | 2 +-
 drivers/usb/gadget/function/uvc_v4l2.h         | 2 +-
 drivers/usb/gadget/function/uvc_video.h        | 2 +-
 25 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.h b/drivers/usb/gadget/function/f_uvc.h
index a81a17765558..1db972d4beeb 100644
--- a/drivers/usb/gadget/function/f_uvc.h
+++ b/drivers/usb/gadget/function/f_uvc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  *	f_uvc.h  --  USB Video Class Gadget driver
  *
diff --git a/drivers/usb/gadget/function/rndis.h b/drivers/usb/gadget/function/rndis.h
index c7e3a70ce6c1..f6167f7fea82 100644
--- a/drivers/usb/gadget/function/rndis.h
+++ b/drivers/usb/gadget/function/rndis.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * RNDIS	Definitions for Remote NDIS
  *
diff --git a/drivers/usb/gadget/function/u_audio.h b/drivers/usb/gadget/function/u_audio.h
index 81d3d4ed6dfb..5ea6b86f1fda 100644
--- a/drivers/usb/gadget/function/u_audio.h
+++ b/drivers/usb/gadget/function/u_audio.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * u_audio.h -- interface to USB gadget "ALSA sound card" utilities
  *
diff --git a/drivers/usb/gadget/function/u_ecm.h b/drivers/usb/gadget/function/u_ecm.h
index 098ece573a5e..77cfb89932be 100644
--- a/drivers/usb/gadget/function/u_ecm.h
+++ b/drivers/usb/gadget/function/u_ecm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_ecm.h
  *
diff --git a/drivers/usb/gadget/function/u_eem.h b/drivers/usb/gadget/function/u_eem.h
index 921386a375cf..3bd85dfcd71c 100644
--- a/drivers/usb/gadget/function/u_eem.h
+++ b/drivers/usb/gadget/function/u_eem.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_eem.h
  *
diff --git a/drivers/usb/gadget/function/u_ether.h b/drivers/usb/gadget/function/u_ether.h
index 332307d54292..10dd640684e2 100644
--- a/drivers/usb/gadget/function/u_ether.h
+++ b/drivers/usb/gadget/function/u_ether.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * u_ether.h -- interface to USB gadget "ethernet link" utilities
  *
diff --git a/drivers/usb/gadget/function/u_ether_configfs.h b/drivers/usb/gadget/function/u_ether_configfs.h
index d8b92485b727..bd92b5703013 100644
--- a/drivers/usb/gadget/function/u_ether_configfs.h
+++ b/drivers/usb/gadget/function/u_ether_configfs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_ether_configfs.h
  *
diff --git a/drivers/usb/gadget/function/u_fs.h b/drivers/usb/gadget/function/u_fs.h
index f9b0cf67360d..f102ec23f3af 100644
--- a/drivers/usb/gadget/function/u_fs.h
+++ b/drivers/usb/gadget/function/u_fs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_fs.h
  *
diff --git a/drivers/usb/gadget/function/u_gether.h b/drivers/usb/gadget/function/u_gether.h
index ce4f07626f96..2f7a373ed449 100644
--- a/drivers/usb/gadget/function/u_gether.h
+++ b/drivers/usb/gadget/function/u_gether.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_gether.h
  *
diff --git a/drivers/usb/gadget/function/u_hid.h b/drivers/usb/gadget/function/u_hid.h
index 1594bfa312eb..84e6da302499 100644
--- a/drivers/usb/gadget/function/u_hid.h
+++ b/drivers/usb/gadget/function/u_hid.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_hid.h
  *
diff --git a/drivers/usb/gadget/function/u_midi.h b/drivers/usb/gadget/function/u_midi.h
index 29bf006c0a13..f6e14af7f566 100644
--- a/drivers/usb/gadget/function/u_midi.h
+++ b/drivers/usb/gadget/function/u_midi.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_midi.h
  *
diff --git a/drivers/usb/gadget/function/u_ncm.h b/drivers/usb/gadget/function/u_ncm.h
index 70da3201a1d0..5408854d8407 100644
--- a/drivers/usb/gadget/function/u_ncm.h
+++ b/drivers/usb/gadget/function/u_ncm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_ncm.h
  *
diff --git a/drivers/usb/gadget/function/u_phonet.h b/drivers/usb/gadget/function/u_phonet.h
index 12fb613f85d1..c53233b37192 100644
--- a/drivers/usb/gadget/function/u_phonet.h
+++ b/drivers/usb/gadget/function/u_phonet.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * u_phonet.h - interface to Phonet
  *
diff --git a/drivers/usb/gadget/function/u_printer.h b/drivers/usb/gadget/function/u_printer.h
index 78797764f478..318205fb778e 100644
--- a/drivers/usb/gadget/function/u_printer.h
+++ b/drivers/usb/gadget/function/u_printer.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_printer.h
  *
diff --git a/drivers/usb/gadget/function/u_rndis.h b/drivers/usb/gadget/function/u_rndis.h
index 1e148b76f339..a8c409b2f52f 100644
--- a/drivers/usb/gadget/function/u_rndis.h
+++ b/drivers/usb/gadget/function/u_rndis.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_rndis.h
  *
diff --git a/drivers/usb/gadget/function/u_serial.h b/drivers/usb/gadget/function/u_serial.h
index e5b08ab8cf7a..dbe75b289be6 100644
--- a/drivers/usb/gadget/function/u_serial.h
+++ b/drivers/usb/gadget/function/u_serial.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * u_serial.h - interface to USB gadget "serial port"/TTY utilities
  *
diff --git a/drivers/usb/gadget/function/u_tcm.h b/drivers/usb/gadget/function/u_tcm.h
index 3f7ccecb0f9b..2cd15d9a1c0d 100644
--- a/drivers/usb/gadget/function/u_tcm.h
+++ b/drivers/usb/gadget/function/u_tcm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_tcm.h
  *
diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/function/u_uac1.h
index 6f1a9d73defe..39c0e29e1b46 100644
--- a/drivers/usb/gadget/function/u_uac1.h
+++ b/drivers/usb/gadget/function/u_uac1.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_uac1.h - Utility definitions for UAC1 function
  *
diff --git a/drivers/usb/gadget/function/u_uac1_legacy.h b/drivers/usb/gadget/function/u_uac1_legacy.h
index 5c1bdf46fe32..b5df9bcbbeba 100644
--- a/drivers/usb/gadget/function/u_uac1_legacy.h
+++ b/drivers/usb/gadget/function/u_uac1_legacy.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * u_uac1.h -- interface to USB gadget "ALSA AUDIO" utilities
  *
diff --git a/drivers/usb/gadget/function/u_uac2.h b/drivers/usb/gadget/function/u_uac2.h
index 82048791eb6e..b5035711172d 100644
--- a/drivers/usb/gadget/function/u_uac2.h
+++ b/drivers/usb/gadget/function/u_uac2.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_uac2.h
  *
diff --git a/drivers/usb/gadget/function/u_uvc.h b/drivers/usb/gadget/function/u_uvc.h
index 16da49a2fcf2..9a01a7d4f17f 100644
--- a/drivers/usb/gadget/function/u_uvc.h
+++ b/drivers/usb/gadget/function/u_uvc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_uvc.h
  *
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 1473d25ff17a..920763b56f2e 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  *	uvc_gadget.h  --  USB Video Class Gadget driver
  *
diff --git a/drivers/usb/gadget/function/uvc_configfs.h b/drivers/usb/gadget/function/uvc_configfs.h
index 341391dbc81f..7e1d7ca29bf2 100644
--- a/drivers/usb/gadget/function/uvc_configfs.h
+++ b/drivers/usb/gadget/function/uvc_configfs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * uvc_configfs.h
  *
diff --git a/drivers/usb/gadget/function/uvc_v4l2.h b/drivers/usb/gadget/function/uvc_v4l2.h
index 452d71059b3f..1576005b61fd 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.h
+++ b/drivers/usb/gadget/function/uvc_v4l2.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *	uvc_v4l2.h  --  USB Video Class Gadget driver
  *
diff --git a/drivers/usb/gadget/function/uvc_video.h b/drivers/usb/gadget/function/uvc_video.h
index dff12103f696..3e87ac7e2c05 100644
--- a/drivers/usb/gadget/function/uvc_video.h
+++ b/drivers/usb/gadget/function/uvc_video.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *	uvc_video.h  --  USB Video Class Gadget driver
  *
-- 
2.17.1

