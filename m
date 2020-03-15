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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0593DC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 14:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30D8205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 14:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmSOmYmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgCOOGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 10:06:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45279 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgCOOF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 10:05:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id b22so6617491pls.12;
        Sun, 15 Mar 2020 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5p9hAR+TP1rlnfI8UdpzmDcEZvHyP3ScF9yDKrwPuZo=;
        b=HmSOmYmMvkdYTaGSpcuEw8IqYUTcvdW6veN0tE2hkdWAVbQDVlFlV9zcEhPUuAjTgY
         lOauWi2LP61H/d9zfi9iGRhH5dM49bp9Ib/tv9IMl3ejqGUDESQn8zBFMJ4QRjgiDL0q
         XwWq3CarExzl6k4FwfH8D/J/v/G0htqJcPj5RflqoGZq86snJQ/cp2G/ME9ClP2DuS9y
         3xzxfbOX5O4VXNlqLHBR8FiT/4FA/ITKygEfJRV3TTbvrweMuzMo6wOINK5LDYpyu68B
         ds49yEs2CzdpO70sgRc6gyBzu1qg3xlsENeAyjtJ2ZpItZryYM/qZZ42HYk6+z3zxnPV
         JFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5p9hAR+TP1rlnfI8UdpzmDcEZvHyP3ScF9yDKrwPuZo=;
        b=gBU5KGC2n4xRz692VswcEEdB1bxLqh5ZKVVT5lim0FzI6QkeUr9KjaNPruPA6bvRHI
         MgKUl0x1t69idAHExaKrTLyqwvc8kIXsTrIuZ2PPtxIDSSe6kzNkgRvFrsi617GKQFE+
         EKLtodwFmlyT3NAyt4qQeo2ft52nDI7cKfDWLZt5PQ1iMHrojW4L6OMQxVlYJjIxGplh
         yKCK0lUwwYStUhSKG8V6jwjLl2Qm5jTd3+IiYNV15cv8xcdacjR8cs0VssEsNtv7cxUM
         OsMV1f+/g825mMi7e5o7lhWr90NdqhVL9W1GxyrwQLRWZafHzwpsn7wL4QCMbbxq3Urt
         d1Dg==
X-Gm-Message-State: ANhLgQ0z0p19lZdDb7RvNtVvzOTwM8Gx85KPWt1cDJKDdA/6z5pEptdX
        lvWlKP7jBuloknG6xiMMI7E=
X-Google-Smtp-Source: ADFU+vte7KPVcF/oGBxDkv0R9KAqbvxNQf3+KEElOLeJQOpBPeWCEa3hDss6gexhAkC9Az4Y/KwUKg==
X-Received: by 2002:a17:902:778c:: with SMTP id o12mr22862922pll.324.1584281154040;
        Sun, 15 Mar 2020 07:05:54 -0700 (PDT)
Received: from localhost (216.24.188.11.16clouds.com. [216.24.188.11])
        by smtp.gmail.com with ESMTPSA id f127sm65130840pfa.112.2020.03.15.07.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 07:05:53 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        jeffrey.t.kirsher@intel.com, hdegoede@redhat.com,
        treding@nvidia.com, tglx@linutronix.de, tomas.winkler@intel.com,
        suzuki.poulose@arm.com, sergei.shtylyov@cogentembedded.com,
        geert@linux-m68k.org, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v3 4/5] usb: dwc2: convert to devm_platform_get_and_ioremap_resource
Date:   Sun, 15 Mar 2020 22:05:24 +0800
Message-Id: <20200315140525.21780-5-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200315140525.21780-1-zhengdejin5@gmail.com>
References: <20200315140525.21780-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify code, which
contains platform_get_resource() and devm_ioremap_resource(), it also
get the resource for use by the following code.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v2 -> v3:
	- call the rename function devm_platform_get_and_ioremap_resource()

v1 -> v2:
	- add this patch for add some real users of this function. 
 
 drivers/usb/dwc2/platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 3c6ce09a6db5..8a68e89749d2 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -392,8 +392,7 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		return retval;
 	}
 
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	hsotg->regs = devm_ioremap_resource(&dev->dev, res);
+	hsotg->regs = devm_platform_get_and_ioremap_resource(dev, 0, &res);
 	if (IS_ERR(hsotg->regs))
 		return PTR_ERR(hsotg->regs);
 
-- 
2.25.0

