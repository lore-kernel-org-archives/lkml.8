Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F288CC52D25
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0C324691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812845;
	bh=PdxD+UsOCm92zdrHfwVzToyI5Itmc/7U/eA+Aed9TJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R/SI3nlikM17yLxrI/XdR9iT19BnOn8j4H2xNMDERCle39u1VPJQZ3usVoSLIV6Wk
	 1s7ltu1YJwMvWW+2aiqvhVZaB5D2F7yYQhfm+i6gM56b0maXuqIk2ipHKwRk7aC8ds
	 LpO8OutDY3Sfd0wGme+iAmv65UkNIwCcqJtd2U7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388215AbgB0OOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:14:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389056AbgB0OOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:14:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80D9220801;
        Thu, 27 Feb 2020 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812841;
        bh=PdxD+UsOCm92zdrHfwVzToyI5Itmc/7U/eA+Aed9TJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUTSps8KEvndpazxbjdyuHNCjc0TdvKHhC8wRWwgD7rp+NmcdNF4rhefHFfXhixKL
         S0xjR0asFNhfxher4Fz87WkkwKiIHA2TkvQJOGUXL11b7v2VqHylRZh94xbXpUaL8q
         Y/N8rbLA4HINQ9PHstnbHnNb1n7cf+EX6gINS+8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, EJ Hsu <ejh@nvidia.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 5.5 037/150] usb: uas: fix a plug & unplug racing
Date:   Thu, 27 Feb 2020 14:36:14 +0100
Message-Id: <20200227132238.261820299@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: EJ Hsu <ejh@nvidia.com>

commit 3e99862c05a9caa5a27969f41566b428696f5a9a upstream.

When a uas disk is plugged into an external hub, uas_probe()
will be called by the hub thread to do the probe. It will
first create a SCSI host and then do the scan for this host.
During the scan, it will probe the LUN using SCSI INQUERY command
which will be packed in the URB and submitted to uas disk.

There might be a chance that this external hub with uas disk
attached is unplugged during the scan. In this case, uas driver
will fail to submit the URB (due to the NOTATTACHED state of uas
device) and try to put this SCSI command back to request queue
waiting for next chance to run.

In normal case, this cycle will terminate when hub thread gets
disconnection event and calls into uas_disconnect() accordingly.
But in this case, uas_disconnect() will not be called because
hub thread of external hub gets stuck waiting for the completion
of this SCSI command. A deadlock happened.

In this fix, uas will call scsi_scan_host() asynchronously to
avoid the blocking of hub thread.

Signed-off-by: EJ Hsu <ejh@nvidia.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200130092506.102760-1-ejh@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/uas.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -45,6 +45,7 @@ struct uas_dev_info {
 	struct scsi_cmnd *cmnd[MAX_CMNDS];
 	spinlock_t lock;
 	struct work_struct work;
+	struct work_struct scan_work;      /* for async scanning */
 };
 
 enum {
@@ -114,6 +115,17 @@ out:
 	spin_unlock_irqrestore(&devinfo->lock, flags);
 }
 
+static void uas_scan_work(struct work_struct *work)
+{
+	struct uas_dev_info *devinfo =
+		container_of(work, struct uas_dev_info, scan_work);
+	struct Scsi_Host *shost = usb_get_intfdata(devinfo->intf);
+
+	dev_dbg(&devinfo->intf->dev, "starting scan\n");
+	scsi_scan_host(shost);
+	dev_dbg(&devinfo->intf->dev, "scan complete\n");
+}
+
 static void uas_add_work(struct uas_cmd_info *cmdinfo)
 {
 	struct scsi_pointer *scp = (void *)cmdinfo;
@@ -982,6 +994,7 @@ static int uas_probe(struct usb_interfac
 	init_usb_anchor(&devinfo->data_urbs);
 	spin_lock_init(&devinfo->lock);
 	INIT_WORK(&devinfo->work, uas_do_work);
+	INIT_WORK(&devinfo->scan_work, uas_scan_work);
 
 	result = uas_configure_endpoints(devinfo);
 	if (result)
@@ -998,7 +1011,9 @@ static int uas_probe(struct usb_interfac
 	if (result)
 		goto free_streams;
 
-	scsi_scan_host(shost);
+	/* Submit the delayed_work for SCSI-device scanning */
+	schedule_work(&devinfo->scan_work);
+
 	return result;
 
 free_streams:
@@ -1166,6 +1181,12 @@ static void uas_disconnect(struct usb_in
 	usb_kill_anchored_urbs(&devinfo->data_urbs);
 	uas_zap_pending(devinfo, DID_NO_CONNECT);
 
+	/*
+	 * Prevent SCSI scanning (if it hasn't started yet)
+	 * or wait for the SCSI-scanning routine to stop.
+	 */
+	cancel_work_sync(&devinfo->scan_work);
+
 	scsi_remove_host(shost);
 	uas_free_streams(devinfo);
 	scsi_host_put(shost);


