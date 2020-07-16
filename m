Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6377C433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EAF2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7ZMHEaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgGPPTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgGPPTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:19:48 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62031C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:19:48 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so3998531ply.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SkAb+ZQCHMOj0PuOUxDCiufP7aMc1qYndOmat4SVlkE=;
        b=s7ZMHEaD8l3hfQKladU34x3lpBaJxaoIxB++2ycJ1zXb3XIZbdSyy8xQv3VGmyKDCM
         fpRlsvCOtRQ/FvmjUOLy1u1qEj2svVDSflYceA2Yunq0V5Ho0X/FjIQWBi8Hgtdfjdm7
         157Oww5hjIsgB/zLrBPaGTP9Ho30ggFcdq4Hx1nstOpGyWcUFUwG87PvdAfF5Z22h/c8
         q5U2Sd/f22Hf5TTlvSi2wxR3zq43kHwtMGdWQHhTl+XK7d5AfjmILt21wsL9ogLWw3Wd
         2y0OWsRf2+z+u6O1kw5oIXRQ66SIwX2ywhOlqTYTBnop1MnoYWFDMYiPbM/uZr7SSFpC
         ftFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SkAb+ZQCHMOj0PuOUxDCiufP7aMc1qYndOmat4SVlkE=;
        b=hv/oiyYqkASNP5HVYkiEn/lck62tN8URxl8NOSL6Ghz6FOX6ofX1iMAJWLZYHZ+ieV
         NNizLZR0nfJI87EQf5QsV0RHyohP18hE5Pf81/9aWf/nRdupr+TLwY4pS594vOFC0BMI
         4dFatBOvZqFR9bdMQETICdcJAlPb9PvS6MlfxkAUoEBSAU6mKQ+jBL1eIwmSLK6NPZ4P
         aO28DtkmOclSNg42XFSrTJjpgbGl3vE2q4Ih+M7FoCr5SSAGI1/VMLfL+6kVLsMjQUkF
         NNUXUcNOWcPTcMGKKE1RfhvMmgR6qV6rbm3eXaNJcCgsDPQipECS4gNO6kUMg3u4CWM4
         ja1g==
X-Gm-Message-State: AOAM533vHJ8xwSP4vdluJV3gZjfX0zO4h1VXpppvkE0tDoXcLnAQbd2p
        08ELlVUv3/kmjsfod4WSQY0=
X-Google-Smtp-Source: ABdhPJzbMM63DHJxy9yrgW/roY6OGog39Bc5HtyluVWwo5o97FmFHv12o1ezNvYHvf0HAC3xarpXFQ==
X-Received: by 2002:a17:90a:e017:: with SMTP id u23mr5438552pjy.179.1594912787778;
        Thu, 16 Jul 2020 08:19:47 -0700 (PDT)
Received: from thinkpad.teksavvy.com ([69.172.171.109])
        by smtp.gmail.com with ESMTPSA id l17sm5502252pgn.48.2020.07.16.08.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:19:47 -0700 (PDT)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rustam Kovhaev <rkovhaev@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        syzbot+80899a8a8efe8968cde7@syzkaller.appspotmail.com
Subject: [PATCH] staging: rtl8712: handle firmware load failure
Date:   Thu, 16 Jul 2020 08:13:26 -0700
Message-Id: <20200716151324.1036204-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when firmware fails to load we should not call unregister_netdev()
this patch fixes a race condition between rtl871x_load_fw_cb() and
r871xu_dev_remove() and fixes the bug reported by syzbot

Reported-by: syzbot+80899a8a8efe8968cde7@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=80899a8a8efe8968cde7
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
---
 drivers/staging/rtl8712/hal_init.c |  3 ++-
 drivers/staging/rtl8712/usb_intf.c | 11 ++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
index 40145c0338e4..42c0a3c947f1 100644
--- a/drivers/staging/rtl8712/hal_init.c
+++ b/drivers/staging/rtl8712/hal_init.c
@@ -33,7 +33,6 @@ static void rtl871x_load_fw_cb(const struct firmware *firmware, void *context)
 {
 	struct _adapter *adapter = context;
 
-	complete(&adapter->rtl8712_fw_ready);
 	if (!firmware) {
 		struct usb_device *udev = adapter->dvobjpriv.pusbdev;
 		struct usb_interface *usb_intf = adapter->pusb_intf;
@@ -41,11 +40,13 @@ static void rtl871x_load_fw_cb(const struct firmware *firmware, void *context)
 		dev_err(&udev->dev, "r8712u: Firmware request failed\n");
 		usb_put_dev(udev);
 		usb_set_intfdata(usb_intf, NULL);
+		complete(&adapter->rtl8712_fw_ready);
 		return;
 	}
 	adapter->fw = firmware;
 	/* firmware available - start netdev */
 	register_netdev(adapter->pnetdev);
+	complete(&adapter->rtl8712_fw_ready);
 }
 
 static const char firmware_file[] = "rtlwifi/rtl8712u.bin";
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index a87562f632a7..2fcd65260f4c 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -595,13 +595,17 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
 	if (pnetdev) {
 		struct _adapter *padapter = netdev_priv(pnetdev);
 
-		usb_set_intfdata(pusb_intf, NULL);
-		release_firmware(padapter->fw);
 		/* never exit with a firmware callback pending */
 		wait_for_completion(&padapter->rtl8712_fw_ready);
+		pnetdev = usb_get_intfdata(pusb_intf);
+		usb_set_intfdata(pusb_intf, NULL);
+		if (!pnetdev)
+			goto firmware_load_fail;
+		release_firmware(padapter->fw);
 		if (drvpriv.drv_registered)
 			padapter->surprise_removed = true;
-		unregister_netdev(pnetdev); /* will call netdev_close() */
+		if (pnetdev->reg_state != NETREG_UNINITIALIZED)
+			unregister_netdev(pnetdev); /* will call netdev_close() */
 		flush_scheduled_work();
 		udelay(1);
 		/* Stop driver mlme relation timer */
@@ -614,6 +618,7 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
 		 */
 		usb_put_dev(udev);
 	}
+firmware_load_fail:
 	/* If we didn't unplug usb dongle and remove/insert module, driver
 	 * fails on sitesurvey for the first time when device is up.
 	 * Reset usb port for sitesurvey fail issue.
-- 
2.27.0

