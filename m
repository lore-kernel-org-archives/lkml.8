Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76A7C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2472065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXFr13WQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgG1Gqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgG1Gqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:46:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6364DC061794;
        Mon, 27 Jul 2020 23:46:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t6so9392941plo.3;
        Mon, 27 Jul 2020 23:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1D5NWd41kMndxnWdrdFPOpE+/nIFfGGDshnUmn2lO8g=;
        b=vXFr13WQkvzQOxy+9Tcf28GOJVQlAX+oDRZF65S5MzfeRbuiCQD06RwgGt2LYV/wrk
         BLGniXLJj4iooDz/mfXiy08LmqQYi2VU+//FWRFIO1oj/IIwAFveNj1VBf7YsrQBUgDI
         HQpFYVJKgdX0X1jpysyl73OHGWQq0V9ZdX6pD2sgqdrud5s8c7ax6Wa45rw/yrzUeuxZ
         XzEDSlwu0EErRhZXd0Qa5+Yx9c5xsYlNESW6/DyNFAF57jSLuTyeB8UyEWiMXCn6QAny
         mSi55LduDGyDUzLCHvHZo3yIn9HJTbpFYkj91IwxDlPP1+bpJ+nEYIh+gTr8ITnIDTWD
         QaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1D5NWd41kMndxnWdrdFPOpE+/nIFfGGDshnUmn2lO8g=;
        b=SRd52UaAKzlZDXmc0hdzjOGUMCMihMmeOf51KsBi9+W9JSgwYgYbeGUuQb6M/R6OgV
         cJQIaCzLTSn+NNVEr2wSFkWydk5b6MlaogbSL8eDPklyQ3pX8YNu4PVa5avpVYPZz4Cv
         Mw5mntCgrEnuAR927lv+tKXgGSMuqGWCzuEWtOhgh+8stIh8eADtxTXY2phQaTyubu2v
         jaMBbDqIulaJiRUQ2UuQMnk1gr5vOmna2jGzDSfBIdP9N49J+2EVOmT+97LJHyqEKDHF
         U6rj31/zy1//UauAoV4Caub5Jg/dA2DLzmt72pRnhWU1G6WPqADZET+bOknA+Of6Qp9Y
         GONg==
X-Gm-Message-State: AOAM530KRpPhlFCI7RKXj56/5YfUMPV9G2ZAFsBLhsvVZQZyohm1JJxN
        4+v4uPKA+6ZXuNF0dLF4FuM=
X-Google-Smtp-Source: ABdhPJzBifg6rr736i3OxlVnn+10Ym7t9h+YYq0pt/1qEMaBewqCMJfSyXgLtMUzvncQK+A5jjzUKw==
X-Received: by 2002:a17:90b:23c9:: with SMTP id md9mr3038586pjb.173.1595918791808;
        Mon, 27 Jul 2020 23:46:31 -0700 (PDT)
Received: from thinkpad.teksavvy.com ([69.172.171.109])
        by smtp.gmail.com with ESMTPSA id u73sm17524438pfc.113.2020.07.27.23.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 23:46:31 -0700 (PDT)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     Rustam Kovhaev <rkovhaev@gmail.com>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: hso: check for return value in hso_serial_common_create()
Date:   Mon, 27 Jul 2020 23:42:17 -0700
Message-Id: <20200728064214.572158-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in case of an error tty_register_device_attr() returns ERR_PTR(),
add IS_ERR() check

Reported-and-tested-by: syzbot+67b2bd0e34f952d0321e@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=67b2bd0e34f952d0321e
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
---
 drivers/net/usb/hso.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 5f123a8cf68e..d2fdb5430d27 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2261,12 +2261,14 @@ static int hso_serial_common_create(struct hso_serial *serial, int num_urbs,
 
 	minor = get_free_serial_index();
 	if (minor < 0)
-		goto exit;
+		goto exit2;
 
 	/* register our minor number */
 	serial->parent->dev = tty_port_register_device_attr(&serial->port,
 			tty_drv, minor, &serial->parent->interface->dev,
 			serial->parent, hso_serial_dev_groups);
+	if (IS_ERR(serial->parent->dev))
+		goto exit2;
 
 	/* fill in specific data for later use */
 	serial->minor = minor;
@@ -2311,6 +2313,7 @@ static int hso_serial_common_create(struct hso_serial *serial, int num_urbs,
 	return 0;
 exit:
 	hso_serial_tty_unregister(serial);
+exit2:
 	hso_serial_common_free(serial);
 	return -1;
 }
-- 
2.27.0

