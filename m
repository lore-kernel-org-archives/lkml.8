Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC0BC35240
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 10:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A66A2067C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 10:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="I1jxxEPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgBBKJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 05:09:55 -0500
Received: from propper.duncanthrax.net ([91.207.61.48]:58352 "EHLO
        smtp.duncanthrax.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725942AbgBBKJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 05:09:55 -0500
X-Greylist: delayed 1891 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Feb 2020 05:09:53 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WurKxM7UmPaX2EoryhZt0kZuwKh/DaWByeBrukvwGUY=; b=I1jxxEPL15RFdU7G1Ycbh3vAM1
        GhJtK/0uckkGPN7+/uv0E9HH8H8rvwWCdx4jabDL1wkckMyAmtpvhrDw13lHTNJvRLTVb4x1WJmMM
        i1ro6/GOq7iksbb+xFVC0xVYMq5HvpRVMZDualHTYOe1xAEQ7LhaITDv51X5JxUU3EEM=;
Received: from [134.3.47.90] (helo=x280.stackframe.org)
        by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
        (envelope-from <svens@stackframe.org>)
        id 1iyBhq-00009N-L8; Sun, 02 Feb 2020 10:38:18 +0100
From:   Sven Schnelle <svens@stackframe.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 2/2] usb-storage: Add support for Ratoc U2SCX multiple device mode
Date:   Sun,  2 Feb 2020 10:37:49 +0100
Message-Id: <20200202093750.4439-3-svens@stackframe.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200202093750.4439-1-svens@stackframe.org>
References: <20200202093750.4439-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ratoc U2SCX can support more than one device but uses another
USB ID in that case (0584:0222) with a Vendor specific class. The
used protocol is still USB Mass storage, but we need to fetch the
maximum LUN number as otherwise the controller would address all
devices on the SCSI bus when an invalid LUN is probed. It looks like
U2SCX maps SCSI ID to LUN numbers, so we must not enable
US_FL_SCM_MULT_TARG.

dmesg with the driver enabled looks like this:

[  133.157337] usb 1-2: new high-speed USB device number 6 using xhci_hcd
[  133.170273] usb 1-2: New USB device found, idVendor=0584, idProduct=0222, bcdDevice= 1.11
[  133.170279] usb 1-2: New USB device strings: Mfr=1, Product=3, SerialNumber=2
[  133.170283] usb 1-2: Product: USB-SCSI Converter
[  133.170286] usb 1-2: Manufacturer: RATOCSystems,Inc.
[  133.170289] usb 1-2: SerialNumber: 020301002197
[  133.171576] usb-storage 1-2:1.0: USB Mass Storage device detected
[  133.172084] scsi host1: usb-storage 1-2:1.0
[  134.199245] scsi 1:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-4163B A100 PQ: 0 ANSI: 2
[  134.202744] scsi 1:0:0:1: Direct-Access     SyQuest  SQ5200C          A0L  PQ: 0 ANSI: 2
[  134.219300] scsi 1:0:0:2: Direct-Access     SyQuest  SQ3270S          1_24 PQ: 0 ANSI: 2
[  134.224660] sr 1:0:0:0: Power-on or device reset occurred
[  134.343256] sr 1:0:0:0: [sr0] scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
[  134.343262] cdrom: Uniform CD-ROM driver Revision: 3.20
[  134.350873] sr 1:0:0:0: Attached scsi CD-ROM sr0
[  134.351120] sr 1:0:0:0: Attached scsi generic sg1 type 5
[  134.351438] sd 1:0:0:1: Attached scsi generic sg2 type 0
[  134.351685] sd 1:0:0:2: Attached scsi generic sg3 type 0
[  134.362141] sd 1:0:0:1: Power-on or device reset occurred
[  134.483977] sd 1:0:0:1: [sdb] Attached SCSI removable disk
[  134.513922] sd 1:0:0:2: Power-on or device reset occurred
[  134.579802] sd 1:0:0:2: [sdc] Spinning up disk...
[  135.602397] ......
[  141.707017] sd 1:0:0:1: [sdb] Spinning up disk...
[  151.346332] .ready
[  151.353990] sd 1:0:0:2: [sdc] 524288 512-byte logical blocks: (268 MB/256 MiB)
[  151.361560] sd 1:0:0:2: [sdc] Write Protect is off
[  151.361566] sd 1:0:0:2: [sdc] Mode Sense: 99 00 00 08
[  151.368868] sd 1:0:0:2: [sdc] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  151.428485]  sdc: sdc1
[  151.465364] sd 1:0:0:2: [sdc] Attached SCSI removable disk
[  152.178231] .....ready
[  156.535115] sd 1:0:0:1: [sdb] 173456 512-byte logical blocks: (88.8 MB/84.7 MiB)
[  156.606445]  sdb: sdb1

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 drivers/usb/storage/initializers.c | 27 +++++++++++++++++++++++++++
 drivers/usb/storage/initializers.h |  2 ++
 drivers/usb/storage/unusual_devs.h |  5 +++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/usb/storage/initializers.c b/drivers/usb/storage/initializers.c
index f8f9ce8dc710..089d67e99aa9 100644
--- a/drivers/usb/storage/initializers.c
+++ b/drivers/usb/storage/initializers.c
@@ -44,6 +44,33 @@ int usb_stor_euscsi_init(struct us_data *us)
 	return 0;
 }
 
+/* Function to get the maximum LUN (Logical Unit number) from Ratoc. */
+int usb_stor_ratoc_u2scx_init(struct us_data *us)
+{
+	int i, result;
+	uint8_t *idmap = (uint8_t *)us->iobuf;
+
+	result = usb_stor_control_msg(us, us->recv_ctrl_pipe,
+					0xe6, USB_DIR_IN | USB_TYPE_VENDOR |
+					USB_RECIP_INTERFACE,
+					0x0, 0x0, idmap, 8, 5 * HZ);
+
+	if (result < 0) {
+		usb_stor_dbg(us, "fetching max lun failed: %d\n", result);
+		return result;
+	}
+
+	for (i = 0; i < 7; i++) {
+		if (idmap[i] == 0xff)
+			break;
+	}
+
+	if (i == 0)
+		return -EIO;
+
+	us->max_lun = i - 1;
+	return 0;
+}
 /*
  * This function is required to activate all four slots on the UCR-61S2B
  * flash reader
diff --git a/drivers/usb/storage/initializers.h b/drivers/usb/storage/initializers.h
index 2dbf9c7d9749..b3ad7bfadf41 100644
--- a/drivers/usb/storage/initializers.h
+++ b/drivers/usb/storage/initializers.h
@@ -37,3 +37,5 @@ int usb_stor_ucr61s2b_init(struct us_data *us);
 
 /* This places the HUAWEI E220 devices in multi-port mode */
 int usb_stor_huawei_e220_init(struct us_data *us);
+
+int usb_stor_ratoc_u2scx_init(struct us_data *us);
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index 1cd9b6305b06..46b95944533c 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2372,6 +2372,11 @@ UNUSUAL_DEV( 0xed10, 0x7636, 0x0001, 0x0001,
 		"Digital MP3 Audio Player",
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL, US_FL_NOT_LOCKABLE ),
 
+UNUSUAL_DEV(0x0584, 0x0222, 0x0000, 0xffff,
+		"Ratoc",
+		"U2SCX USB SCSI converter",
+		USB_SC_DEVICE, USB_PR_DEVICE, usb_stor_ratoc_u2scx_init, 0),
+
 /* Unusual uas devices */
 #if IS_ENABLED(CONFIG_USB_UAS)
 #include "unusual_uas.h"
-- 
2.24.1

