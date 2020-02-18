Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27F7C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0E324125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xQkcyhd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgBRTdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:33:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35618 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgBRTdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so4241241wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ayr0vaOngDA+VkwhWRpdM5V1skhfB+el5GXKIwRxryc=;
        b=xQkcyhd9mpgYZo1ph9KEAbwqPZXD3q7Xx5fqMyOGprcnJ5fdXq73iZaS/fQ+qrso1T
         93FKEqFyelBvQVLjeti8uHKmxCdP6zeXqoOY2zzLQwEp70BQpaxuSVk2MX2WQX0X1RAL
         LNGQp9YBsRwrdCdhh9ydHE2VSaL1o55fVz0ewVwRo77qpyBXCDcmiWtTL0qt2HWJxkAS
         P/WJq0lsxEAdVunCc3N3MuNJuc1li4p4oR7/7MTzD4VmeL/gPVf+4LTEH6AYGqnv9bDD
         CDk+mzo5puPYxdtlOs+lXn0zoA/zKsvce2heh37g6R46RZFknCfkbRmrFAR1tVfc3L9l
         ze6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ayr0vaOngDA+VkwhWRpdM5V1skhfB+el5GXKIwRxryc=;
        b=uXwH1/HWE+pV2cE4b79v9FIlg9KcI0AXWHi/Db8c8bgzjg0/a9GjJAbqC2scPB+Hn+
         oXJ9YdTtV0Y/36nsoI3p4/kywvetQv8mGVUqqdgVKx1GWWz5I9Avq5iLnIZCwXHY+4Fi
         mgUw9o6yyH77naQQ37lcILh4CaAnStruzgP3oGZXYw+4djiWqU1qyjncC02R+hCrZUls
         zXFiu2wGo5Q3ZwMYwCRhi2foOWQexOOPJD1E4mW7xnwI3nt2crNyAiW4w1pgPAJ5k8Nr
         DwCp7Uf29/Lcq4VfQlVHjJuhhwmwVtzK0dSV40xkH70mIYzJV+9rgQ6JezRQIRkdwEO4
         U63A==
X-Gm-Message-State: APjAAAX6jUiLz3s9WPbBTCwv2u9DTAYsuUiMU/329FWLfJ4PUVhzDxPq
        0Q+0F2j3dEwZsD4ffFEw2gqwjA==
X-Google-Smtp-Source: APXvYqzDsjJ38h0gWD0g2s11Gr1Lmz6VBAIYHUJDGPLQPQMDv1f+ZTd+/40BghBPL7gZYdi1jG1GBg==
X-Received: by 2002:a1c:1d13:: with SMTP id d19mr4920253wmd.163.1582054411665;
        Tue, 18 Feb 2020 11:33:31 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:31 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 18/20] usb: host: uhci-pci: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:33:01 +0000
Message-Id: <1582054383-35760-19-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_driver name is const char pointer, so it not useful to cast
hcd_name (which is already const char).

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/usb/host/uhci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/uhci-pci.c b/drivers/usb/host/uhci-pci.c
index 0fa3d72bae26..957c87efc746 100644
--- a/drivers/usb/host/uhci-pci.c
+++ b/drivers/usb/host/uhci-pci.c
@@ -294,7 +294,7 @@ static const struct pci_device_id uhci_pci_ids[] = { {
 MODULE_DEVICE_TABLE(pci, uhci_pci_ids);
 
 static struct pci_driver uhci_pci_driver = {
-	.name =		(char *)hcd_name,
+	.name =		hcd_name,
 	.id_table =	uhci_pci_ids,
 
 	.probe =	usb_hcd_pci_probe,
-- 
2.24.1

