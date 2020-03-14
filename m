Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97525C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFA22071C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8W0+FWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgCOCXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:23:53 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35291 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgCOCXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:23:52 -0400
Received: by mail-il1-f196.google.com with SMTP id v6so1926964ilq.2;
        Sat, 14 Mar 2020 19:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bolGqQxhWdWgpU69XRMnXiz0W60KCuDWQ2z7xXlvj8E=;
        b=B8W0+FWWYJN6WqgwttmprjGZlMBoY9aBQyq3jJHauz+tUTSsJhMYccjD+haAXovvGZ
         uYXGReUyVM1xMUHz3ikiugYUTqM/xfrZ7UL0yCorZWLbFGaH1aDbuLd42pj/acAqqMB3
         +eyDeQGvDxDBAdHnGnSwSzVdxtyO6/Qy0AXC4tzz8LhVC7Am4Xx0/oUj9yy1JVdgwa+7
         +2QuCA5Ui1x6YchRfuADgUBNsIM//sAEWH+2qGt6yybMQkivhoWBT9qJtu4qrPx99D2V
         rEomakD2K2od0Yj6D2pmWeA7JINHnwt6y3bumHe65bYWQFO7MLY2xnoJSt3/nIt0y3zh
         AXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bolGqQxhWdWgpU69XRMnXiz0W60KCuDWQ2z7xXlvj8E=;
        b=HjKgulUOENWpZZq+XviiRaQl7WV+JHPQFznUdb6hhmCx5THRDmdTuetzcZh9NTyGDV
         V0Vz5AgTsj7GdGYjGQ/oOoDby2I11DxhBdNAJo7gQudYqpKYUQrsBnvGhQTgnhCfUEMN
         Ux3LnZ/IQ+AWytnXzbAtiyqeZA1zWplVQKS1VPEJxRBjUenMd/hX0qbStDVzKuNc++mg
         nAxLJyYLdT7cK3puT3hE3iOV6MVm94gaj4N6UUFxAE/9333B3jkp2etyUWWhr2RQCJGj
         fR3QLYdVEJns3e511VGY97GUkxGHuVRN9EI0gmgQlZzCAJeuPcyuDne3R2Cs863Mr/Fe
         S8DQ==
X-Gm-Message-State: ANhLgQ3KuhoxN682wS6XUZ936V28UtF8XiGj15gxW/vJXAflm1MM0HQl
        R74NePzBv72r+8uU4KZ/1VjtAUO5
X-Google-Smtp-Source: ADFU+vv29Ok1TmkzoC9UWO3LDApVs8zw0AH3uafkrwoNY+zDHYFb5jJpLgUc2dBlZokjE3JuF1U5yg==
X-Received: by 2002:a63:f243:: with SMTP id d3mr16185919pgk.254.1584163628426;
        Fri, 13 Mar 2020 22:27:08 -0700 (PDT)
Received: from localhost ([216.24.188.11])
        by smtp.gmail.com with ESMTPSA id z20sm29316118pge.62.2020.03.13.22.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 22:27:08 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        geert@linux-m68k.org, mchehab+samsung@kernel.org,
        treding@nvidia.com, tglx@linutronix.de, suzuki.poulose@arm.com,
        hdegoede@redhat.com, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v2 4/4] usb: dwc2: convert to devm_platform_ioremap_and_get_resource
Date:   Sat, 14 Mar 2020 13:26:38 +0800
Message-Id: <20200314052638.6008-5-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200314052638.6008-1-zhengdejin5@gmail.com>
References: <20200314052638.6008-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_and_get_resource() to simplify code, which
contains platform_get_resource() and devm_ioremap_resource(), it also
get the resource for use by the following code.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/usb/dwc2/platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 3c6ce09a6db5..56eec2b95eaf 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -392,8 +392,7 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		return retval;
 	}
 
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	hsotg->regs = devm_ioremap_resource(&dev->dev, res);
+	hsotg->regs = devm_platform_ioremap_and_get_resource(dev, 0, &res);
 	if (IS_ERR(hsotg->regs))
 		return PTR_ERR(hsotg->regs);
 
-- 
2.25.0

