Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FC9C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF45B20771
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQeRvJhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgDQRFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgDQRFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:05:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1363CC061A0C;
        Fri, 17 Apr 2020 10:05:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d17so3857110wrg.11;
        Fri, 17 Apr 2020 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6vSpgIMmBWZUkn/2wzSE1YfGSB1WXikRLlIM0P2tsM=;
        b=hQeRvJhnisjkFrQAbi2gCklzGQ+A8Yh/gPgG7AvNJ+iZvw5L4O1EDuYnLhe9D+bAIG
         wMyvk/8/wHDT9Vbjdk/Jo9VIgFAfRrT7rcOIZNKDR46hovtvdn8OOS1Bd5ZU8bKuL4yZ
         tRXxZ8zftPK4dhm/1HoTZFhFbigx5jRJzZD3YniCudE8zw8ebFBG/ps+wftR7PB7dowo
         PbzmYMHTxbGNt50K0zvyYDJiNWFhRGJEkU0i3tqM9LP0JhQlubg2krtZFs4KUgBBhwti
         UznvQKHpjNL7BJ163UdxcGvu13VDOWoBH7fqLR1ElYlAMg5GtagFMF1DR9fyaVxNXPzv
         /r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6vSpgIMmBWZUkn/2wzSE1YfGSB1WXikRLlIM0P2tsM=;
        b=e8JtdQBMSvoqlZHQACHoUuhqHE1q3dK2hDZNrsyshdVw4gD8djS9Ph9Cm6yZe6D51E
         rpwgJ6idBBw0Hq3NYJA5QZMFyD20JtKaZ4/K01WPxfJXs6iDMqrP0FSbEtQbJax54bHt
         RMwY/Suy5gjfKboEEivrbyv7CT614p0Vo4D4WYJtTN62YEstn0ln+w9MkW+Fa9NrmM+p
         lAC8/Hz14FI8clqLM1whAETd8atvyiilpGo8PH+oG6m+nj4hkWb3BqxxdGAmDARkP57d
         8V4WL0BxVPN4Aifp37mwTo4sZfcKJbk95D4e89LlXVoRGdGdJzyPltl/QlymtMYDhKCS
         dbcg==
X-Gm-Message-State: AGi0PubQnyXHiM6EN9U0sXA2n2GxPEA0On0AJEYlcKaHYCr3+JiWxKNI
        c/1pZOZuwmUDk01ba9iexos=
X-Google-Smtp-Source: APiQypKD5Ch9ByBWdQAM3T/RtbqnzvMnjJN3d6GJWE47dWN1TipwNjJL8C3rgGR5diX1QS52jeQvPA==
X-Received: by 2002:adf:db41:: with SMTP id f1mr4725933wrj.13.1587143147648;
        Fri, 17 Apr 2020 10:05:47 -0700 (PDT)
Received: from localhost (pD9E51D62.dip0.t-ipconnect.de. [217.229.29.98])
        by smtp.gmail.com with ESMTPSA id u15sm30741852wrn.46.2020.04.17.10.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 10:05:46 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Nagarjuna Kristam <nkristam@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: tegra-xudc: Fix idle suspend/resume
Date:   Fri, 17 Apr 2020 19:05:37 +0200
Message-Id: <20200417170537.2540914-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

When the XUDC device is idle (i.e. powergated), care must be taken not
to access any registers because that would lead to a crash.

Move the call to tegra_xudc_device_mode_off() into the same conditional
as the tegra_xudc_powergate() call to make sure we only force device
mode off if the XUDC is actually powered up.

Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device mode controller")
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 52a6add961f4..dfabc54cdc27 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3840,11 +3840,11 @@ static int __maybe_unused tegra_xudc_suspend(struct device *dev)
 
 	flush_work(&xudc->usb_role_sw_work);
 
-	/* Forcibly disconnect before powergating. */
-	tegra_xudc_device_mode_off(xudc);
-
-	if (!pm_runtime_status_suspended(dev))
+	if (!pm_runtime_status_suspended(dev)) {
+		/* Forcibly disconnect before powergating. */
+		tegra_xudc_device_mode_off(xudc);
 		tegra_xudc_powergate(xudc);
+	}
 
 	pm_runtime_disable(dev);
 
-- 
2.24.1

