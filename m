Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F65C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A7120836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lnCjdUGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgFZNFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgFZNFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:05:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE839C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so9428581wrv.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2h3Gz11K9lz1GWwD6l+glaQop1qQtS3m0z/WOqzfDhk=;
        b=lnCjdUGVWFd64dqs1Pxf1ilLYbrTGBJ6/SubvmW15xt/YFyLhtakePLjr0ysjDZJ6+
         Njj3gSu/JxXkPOFptelL0qEKUuoyL8RLE5TCr7RJrTM8ayJwJIS6Z0ZLv3QGViB/kQo4
         c793ZcLpZEnEEy7QerSJvgMa4N6IYxLOv6670a6u5FR8TR/3nNB+bMe37MjoXrORCZR5
         +kQnpkWYNOVBcLbsLVYz6AqJpI7Rmt8Vd+yyDJtfcoTnE/WnEspWMCBQL9FipWxeO582
         g36+a9+dT2iRl63/Tf+eR3ANQ7A9y30+4Q7N3e0WxvogO7OZ/oqDH24MMYLZYFz1A3p8
         Y+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2h3Gz11K9lz1GWwD6l+glaQop1qQtS3m0z/WOqzfDhk=;
        b=ibRrJLXCwhrGKXGssmEUD8KiaHbBa3MvhFD6wVdDFcrseacbxtwlx3n0BMN03ywTBG
         VnV330lf9Izd8ee7Lh5q8NhNer6dsyr4xwuEKFWWZc5sluk12RQ3r5BEVcZGMrEMJ4nc
         +FVGK0vXqKQtNX2sOrl/BMAbZDqVr4x9vUrdi+jFHnG4095nSEBj5qJZd2CB3feMHR2b
         8G9anR7J8npiOExLf1AGM344rFCZ6d48OTZPEOmnZR4u1ngtM5AIg3l5od9JD4ZOqxhd
         DNUkvtcCX82QbY2uTLTx7i/jzD0IswtUJaSraSAzLmKbP4zKJ1dnZqho5PwYElL/kX9F
         CzUw==
X-Gm-Message-State: AOAM5318uxZoqKWLtJOu2TxEjxf2MHZ58hfx/yUMcife7cNpNLeZe3BK
        REBfDZsN1zXloRXlJCNoVG8CgA==
X-Google-Smtp-Source: ABdhPJxK+YkmbDwzyiNATXYFOhK+8lW4MBKB9U+eFI0+bnZxV5GzvY/YoYYTr1RXZgYTUlzXxu0XIQ==
X-Received: by 2002:adf:b312:: with SMTP id j18mr3472991wrd.195.1593176732336;
        Fri, 26 Jun 2020 06:05:32 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id u20sm16746904wmc.44.2020.06.26.06.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:05:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pavan Savoy <pavan_savoy@ti.com>
Subject: [PATCH 03/10] misc: ti-st: st_kim: Tidy-up bespoke commentry
Date:   Fri, 26 Jun 2020 14:05:18 +0100
Message-Id: <20200626130525.389469-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626130525.389469-1-lee.jones@linaro.org>
References: <20200626130525.389469-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If it's still in use and worth the effort, it sure looks like
this driver could do with a good scrub (clean).

This patch conserns itself with the non-standard comments located
thoughout the file.

It also fixes the following W=1 warnings by demoting the kerneldoc
function headers to standard comments, since there doesn't appear
to be a requirement for the function args to be documented:

 /drivers/misc/ti-st/st_kim.c:42: warning: Function parameter or member 'id' not described in 'st_get_plat_device'
 /drivers/misc/ti-st/st_kim.c:53: warning: Function parameter or member 'kim_gdata' not described in 'validate_firmware_response'
 /drivers/misc/ti-st/st_kim.c:126: warning: Function parameter or member 'kim_gdata' not described in 'kim_int_recv'
 /drivers/misc/ti-st/st_kim.c:126: warning: Function parameter or member 'data' not described in 'kim_int_recv'
 /drivers/misc/ti-st/st_kim.c:126: warning: Function parameter or member 'count' not described in 'kim_int_recv'
 /drivers/misc/ti-st/st_kim.c:272: warning: Function parameter or member 'kim_gdata' not described in 'download_firmware'
 /drivers/misc/ti-st/st_kim.c:445: warning: Function parameter or member 'kim_data' not described in 'st_kim_start'
 /drivers/misc/ti-st/st_kim.c:509: warning: Function parameter or member 'kim_data' not described in 'st_kim_stop'
 /drivers/misc/ti-st/st_kim.c:661: warning: Function parameter or member 'core_data' not described in 'st_kim_ref'
 /drivers/misc/ti-st/st_kim.c:661: warning: Function parameter or member 'id' not described in 'st_kim_ref'

Cc: Pavan Savoy <pavan_savoy@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/ti-st/st_kim.c | 71 +++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index a36ed1ff5967f..f2f6cab97c086 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -30,7 +30,7 @@ static struct platform_device *st_kim_devices[MAX_ST_DEVICES];
 /**********************************************************************/
 /* internal functions */
 
-/**
+/*
  * st_get_plat_device -
  *	function which returns the reference to the platform device
  *	requested by id. As of now only 1 such device exists (id=0)
@@ -43,7 +43,7 @@ static struct platform_device *st_get_plat_device(int id)
 	return st_kim_devices[id];
 }
 
-/**
+/*
  * validate_firmware_response -
  *	function to return whether the firmware response was proper
  *	in case of error don't complete so that waiting for proper
@@ -55,7 +55,8 @@ static void validate_firmware_response(struct kim_data_s *kim_gdata)
 	if (!skb)
 		return;
 
-	/* these magic numbers are the position in the response buffer which
+	/*
+	 * these magic numbers are the position in the response buffer which
 	 * allows us to distinguish whether the response is for the read
 	 * version info. command
 	 */
@@ -79,7 +80,8 @@ static void validate_firmware_response(struct kim_data_s *kim_gdata)
 	kfree_skb(skb);
 }
 
-/* check for data len received inside kim_int_recv
+/*
+ * check for data len received inside kim_int_recv
  * most often hit the last case to update state to waiting for data
  */
 static inline int kim_check_data_len(struct kim_data_s *kim_gdata, int len)
@@ -91,14 +93,16 @@ static inline int kim_check_data_len(struct kim_data_s *kim_gdata, int len)
 	if (!len) {
 		validate_firmware_response(kim_gdata);
 	} else if (len > room) {
-		/* Received packet's payload length is larger.
+		/*
+		 * Received packet's payload length is larger.
 		 * We can't accommodate it in created skb.
 		 */
 		pr_err("Data length is too large len %d room %d", len,
 			   room);
 		kfree_skb(kim_gdata->rx_skb);
 	} else {
-		/* Packet header has non-zero payload length and
+		/*
+		 * Packet header has non-zero payload length and
 		 * we have enough space in created skb. Lets read
 		 * payload data */
 		kim_gdata->rx_state = ST_W4_DATA;
@@ -106,8 +110,10 @@ static inline int kim_check_data_len(struct kim_data_s *kim_gdata, int len)
 		return len;
 	}
 
-	/* Change ST LL state to continue to process next
-	 * packet */
+	/*
+	 * Change ST LL state to continue to process next
+	 * packet
+	 */
 	kim_gdata->rx_state = ST_W4_PACKET_TYPE;
 	kim_gdata->rx_skb = NULL;
 	kim_gdata->rx_count = 0;
@@ -115,7 +121,7 @@ static inline int kim_check_data_len(struct kim_data_s *kim_gdata, int len)
 	return 0;
 }
 
-/**
+/*
  * kim_int_recv - receive function called during firmware download
  *	firmware download responses on different UART drivers
  *	have been observed to come in bursts of different
@@ -216,7 +222,8 @@ static long read_local_version(struct kim_data_s *kim_gdata, char *bts_scr_name)
 		return timeout ? -ERESTARTSYS : -ETIMEDOUT;
 	}
 	reinit_completion(&kim_gdata->kim_rcvd);
-	/* the positions 12 & 13 in the response buffer provide with the
+	/*
+	 * the positions 12 & 13 in the response buffer provide with the
 	 * chip, major & minor numbers
 	 */
 
@@ -263,7 +270,7 @@ static void skip_change_remote_baud(unsigned char **ptr, long *len)
 	}
 }
 
-/**
+/*
  * download_firmware -
  *	internal function which parses through the .bts firmware
  *	script file intreprets SEND, DELAY actions only as of now
@@ -295,7 +302,8 @@ static long download_firmware(struct kim_data_s *kim_gdata)
 	}
 	ptr = (void *)kim_gdata->fw_entry->data;
 	len = kim_gdata->fw_entry->size;
-	/* bts_header to remove out magic number and
+	/*
+	 * bts_header to remove out magic number and
 	 * version
 	 */
 	ptr += sizeof(struct bts_header);
@@ -313,8 +321,10 @@ static long download_firmware(struct kim_data_s *kim_gdata)
 			if (unlikely
 			    (((struct hci_command *)action_ptr)->opcode ==
 			     0xFF36)) {
-				/* ignore remote change
-				 * baud rate HCI VS command */
+				/*
+				 * ignore remote change
+				 * baud rate HCI VS command
+				 */
 				pr_warn("change remote baud"
 				    " rate command in firmware");
 				skip_change_remote_baud(&ptr, &len);
@@ -346,7 +356,8 @@ static long download_firmware(struct kim_data_s *kim_gdata)
 				release_firmware(kim_gdata->fw_entry);
 				return -ETIMEDOUT;
 			}
-			/* reinit completion before sending for the
+			/*
+			 * reinit completion before sending for the
 			 * relevant wait
 			 */
 			reinit_completion(&kim_gdata->kim_rcvd);
@@ -418,14 +429,16 @@ void st_kim_recv(void *disc_data, const unsigned char *data, long count)
 	struct st_data_s	*st_gdata = (struct st_data_s *)disc_data;
 	struct kim_data_s	*kim_gdata = st_gdata->kim_data;
 
-	/* proceed to gather all data and distinguish read fw version response
+	/*
+	 * proceed to gather all data and distinguish read fw version response
 	 * from other fw responses when data gathering is complete
 	 */
 	kim_int_recv(kim_gdata, data, count);
 	return;
 }
 
-/* to signal completion of line discipline installation
+/*
+ * to signal completion of line discipline installation
  * called from ST Core, upon tty_open
  */
 void st_kim_complete(void *kim_data)
@@ -434,7 +447,7 @@ void st_kim_complete(void *kim_data)
 	complete(&kim_gdata->ldisc_installed);
 }
 
-/**
+/*
  * st_kim_start - called from ST Core upon 1st registration
  *	This involves toggling the chip enable gpio, reading
  *	the firmware version from chip, forming the fw file name
@@ -472,8 +485,10 @@ long st_kim_start(void *kim_data)
 		err = wait_for_completion_interruptible_timeout(
 			&kim_gdata->ldisc_installed, msecs_to_jiffies(LDISC_TIME));
 		if (!err) {
-			/* ldisc installation timeout,
-			 * flush uart, power cycle BT_EN */
+			/*
+			 * ldisc installation timeout,
+			 * flush uart, power cycle BT_EN
+			 */
 			pr_err("ldisc installation timeout");
 			err = st_kim_stop(kim_gdata);
 			continue;
@@ -482,8 +497,10 @@ long st_kim_start(void *kim_data)
 			pr_info("line discipline installed");
 			err = download_firmware(kim_gdata);
 			if (err != 0) {
-				/* ldisc installed but fw download failed,
-				 * flush uart & power cycle BT_EN */
+				/*
+				 * ldisc installed but fw download failed,
+				 * flush uart & power cycle BT_EN
+				 */
 				pr_err("download firmware failed");
 				err = st_kim_stop(kim_gdata);
 				continue;
@@ -495,7 +512,7 @@ long st_kim_start(void *kim_data)
 	return err;
 }
 
-/**
+/*
  * st_kim_stop - stop communication with chip.
  *	This can be called from ST Core/KIM, on the-
  *	(a) last un-register when chip need not be powered there-after,
@@ -650,7 +667,7 @@ static const struct attribute_group uim_attr_grp = {
 	.attrs = uim_attrs,
 };
 
-/**
+/*
  * st_kim_ref - reference the core's data
  *	This references the per-ST platform device in the arch/xx/
  *	board-xx.c file.
@@ -729,8 +746,7 @@ static int kim_probe(struct platform_device *pdev)
 		pr_err(" unable to configure gpio %d", kim_gdata->nshutdown);
 		goto err_sysfs_group;
 	}
-	/* get reference of pdev for request_firmware
-	 */
+	/* get reference of pdev for request_firmware */
 	kim_gdata->kim_pdev = pdev;
 	init_completion(&kim_gdata->kim_rcvd);
 	init_completion(&kim_gdata->ldisc_installed);
@@ -772,7 +788,8 @@ static int kim_remove(struct platform_device *pdev)
 
 	kim_gdata = platform_get_drvdata(pdev);
 
-	/* Free the Bluetooth/FM/GPIO
+	/*
+	 * Free the Bluetooth/FM/GPIO
 	 * nShutdown gpio from the system
 	 */
 	gpio_free(pdata->nshutdown_gpio);
-- 
2.25.1

