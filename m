Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E48C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC4C221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SsrdoWR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgIKJjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgIKJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:39:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9C9C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:39:36 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kk9so1432925pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rOvkQbHcqdEEW6imcqo512VuspBp3Sjb9vemZ7YeXi8=;
        b=SsrdoWR2xJuerEVchmJHs77EJDNTQwhJJ3BSD7dyycqxfJRgwEXXeZLoufITYzxwdf
         KubMausaC28CReuRTTMNmIOWAOttM0CgeQmKXPHCPJI389V06KhtJx8/5NJYJa9b7l4m
         5HXcxWMAP0vD3X1sXf+tvQ2B3z34erifCxIDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rOvkQbHcqdEEW6imcqo512VuspBp3Sjb9vemZ7YeXi8=;
        b=XmwEJ+ZUq33tJiIGze2tx5i5VhRRho5oZqJIklPMJoRRA6ZvRG82P0cMCW3ebZAOLw
         Hi3iFVo50Rssoi3sfiLwpBQIvpq5lvzFs9Sn25h3jKWOwyd/3nQs6yVMaRdlGalYAusa
         mbLwVHn5Ihd+RnJu8HqpJfwner+eYUqPfYryzmd9/jM1u1GRwt+EXhLrBuzIPQVByf5a
         ucY3w10gZWNSMMlagaKfIgaetvvHuju2mUqaZaqF9oJn2kb6RoZKkH/CGSiWCyzf1Yq+
         MzOXfgULL6Ne6l/bKNlVngYMMvUbQMEaYyX1AUZ1dsbJBXxY1Hsa1Zx+VENATbQOkIXI
         OvkA==
X-Gm-Message-State: AOAM533XliRN9W4SQTx3Ly3em/ab2s7C+5VfzTZUV7yRKy2UU1Gc3AVS
        EqHZeppRnUc5a6/b01g93w2Flw==
X-Google-Smtp-Source: ABdhPJwmX6yZWnZDIEx+xL+1xsLKAJsdIGcvlBqJnTBWOdo/WI0JBf49uctm86uYeq7xvEW3CgA8Qg==
X-Received: by 2002:a17:90a:2ec8:: with SMTP id h8mr1461759pjs.173.1599817175625;
        Fri, 11 Sep 2020 02:39:35 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id v1sm1433465pjh.16.2020.09.11.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 02:39:34 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Changqi Hu <changqi.hu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 1/2] tty: serial: print earlycon info after match->setup
Date:   Fri, 11 Sep 2020 17:39:26 +0800
Message-Id: <20200911093927.608024-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8250 devices may modify iotype in their own earlycon setup. For example:
8250_mtk and 8250_uniphier force iotype to be MMIO32. Print earlycon info
after match->setup to reflect actual earlycon info.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/tty/serial/earlycon.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 2ae9190b64bb9..22f0876f72d49 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -56,7 +56,6 @@ static void __init earlycon_init(struct earlycon_device *device,
 				 const char *name)
 {
 	struct console *earlycon = device->con;
-	struct uart_port *port = &device->port;
 	const char *s;
 	size_t len;
 
@@ -70,6 +69,12 @@ static void __init earlycon_init(struct earlycon_device *device,
 	len = s - name;
 	strlcpy(earlycon->name, name, min(len + 1, sizeof(earlycon->name)));
 	earlycon->data = &early_console_dev;
+}
+
+static void __init earlycon_info(struct earlycon_device *device)
+{
+	struct console *earlycon = device->con;
+	struct uart_port *port = &device->port;
 
 	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM16 ||
 	    port->iotype == UPIO_MEM32 || port->iotype == UPIO_MEM32BE)
@@ -140,6 +145,7 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 
 	earlycon_init(&early_console_dev, match->name);
 	err = match->setup(&early_console_dev, buf);
+	earlycon_info(&early_console_dev);
 	if (err < 0)
 		return err;
 	if (!early_console_dev.con->write)
@@ -302,6 +308,7 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 	}
 	earlycon_init(&early_console_dev, match->name);
 	err = match->setup(&early_console_dev, options);
+	earlycon_info(&early_console_dev);
 	if (err < 0)
 		return err;
 	if (!early_console_dev.con->write)
-- 
2.28.0.618.gf4bc123cb7-goog

