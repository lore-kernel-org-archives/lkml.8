Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811B5C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B0224956
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQt+ZF9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgEHQ3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgEHQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:29:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DC8C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 09:29:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so2600106wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+iuOH/WKVgDwlOpqLtEZz1Xk/okLvZZF5WbQRpij0D4=;
        b=AQt+ZF9/H2qk/OzomabTHPI7WvMlnn1Z6hG6gqNJIe5EizYLqFoDrDWpINidOLAgaq
         qkxTNC5J00AzTlAZQvnF/dbaHsDAfE/fqpCtkW3hlE9kjdjAD2q5eUUncCpBNBKPnrdk
         2wk+lL8bnj8EForOpu5KW38XHvLpS//BMB7EkbmGLPrMNq3FjPdICxV0v9XVmU+jc4kp
         1fEPrrVGBkose3eZ3JXKQscdx2Fq7231IQxf8FdX6I8EeAomwFNy7dhjmQ01wP6ryr5h
         eH5eNWJrEHOenSXHxlSlCIxzCFu3/8/Fr8Nu6qAxo7p87nmqcfk0mWMEd+JSCV8IHaUm
         FvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+iuOH/WKVgDwlOpqLtEZz1Xk/okLvZZF5WbQRpij0D4=;
        b=qZkIYPdLVKVyf6NGNgcDYG5DEj1ARxc6ENPjbuAtcD1YtthDFHNqyCmoMRmqIVpCq5
         bSyP0VFSHqw4dBfvK3OgKHfH+LHqgmIBHwW7KTuLXUYd3m+sd3R4w4Xatgyy71cm/F4X
         /DNKhtlw424UKJ789wa4rZLBOYkN2vPapXwZ1fodov3IMYt9NcsNYGVSP5Af6pGDBfOr
         /B0vfXuHyq2G3O+KJYJHYb1Ywjsy3FU2iroMfabLiBvZ1AVtqk3IiiTpJFpMCY4LMoAZ
         Db6dEDKH5Sko9bK9d4nZZC3aesg5aPkr8uKQlVCA6wlSVamkgUraPhOePr0rqD8F1rQF
         hpVg==
X-Gm-Message-State: AGi0PuY1r7ioY1/3UWWEnwSLYrpBDXYb1gz41m6/Z03YrxBBdHUDGeuY
        PiYTSDmTA6bGKnfcysTItotZ0w==
X-Google-Smtp-Source: APiQypIvwEN8ANKN3qCA5nhSd3XIXtCZSkyca1PpubPK0GASNJT8ODNwqlF/DEWhTVLbHg8aa6qFlA==
X-Received: by 2002:a5d:61c5:: with SMTP id q5mr3933822wrv.398.1588955384626;
        Fri, 08 May 2020 09:29:44 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id w15sm3602749wrl.73.2020.05.08.09.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 09:29:43 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, bryan.odonoghue@linaro.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        chenqiwu <chenqiwu@xiaomi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: roles: Switch on role-switch uevent reporting
Date:   Fri,  8 May 2020 17:29:37 +0100
Message-Id: <20200508162937.2566818-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now we don't report to user-space a role switch when doing a
usb_role_switch_set_role() despite having registered the uevent callbacks.

This patch switches on the notifications allowing user-space to see
role-switch change notifications and subsequently determine the current
controller data-role.

example:
PFX=/devices/platform/soc/78d9000.usb/ci_hdrc.0

root@somebox# udevadm monitor -p

KERNEL[49.894994] change $PFX/usb_role/ci_hdrc.0-role-switch (usb_role)
ACTION=change
DEVPATH=$PFX/usb_role/ci_hdrc.0-role-switch
SUBSYSTEM=usb_role
DEVTYPE=usb_role_switch
USB_ROLE_SWITCH=ci_hdrc.0-role-switch
SEQNUM=2432

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Wen Yang <wenyang@linux.alibaba.com>
Cc: chenqiwu <chenqiwu@xiaomi.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/roles/class.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 5b17709821df..27d92af29635 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -49,8 +49,10 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
 	mutex_lock(&sw->lock);
 
 	ret = sw->set(sw, role);
-	if (!ret)
+	if (!ret) {
 		sw->role = role;
+		kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
+	}
 
 	mutex_unlock(&sw->lock);
 
-- 
2.25.1

