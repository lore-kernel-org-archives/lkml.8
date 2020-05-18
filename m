Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F33C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7B1207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+tYrnNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgERQOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbgERQOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:14:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E674C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:14:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i15so12509736wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6222QPg5rd8aHY5IhgqSSDStDL2vP3VemTOJBPxeI+Q=;
        b=E+tYrnNSSpEVhWYljybZREZPIbDWfVFk3sirdunJRyYFSQ9CEgCgnMrGWE3EqnWwmy
         hCIsG9MjJRWC9sslWsYYtIxT7uycRdDOXnhSZzaav+vA2tAGNX1P/04sLo6MTGL583XR
         gTrYIREjgkxXFNjH3u5DA775UW1ij+WrCINUgpWJzbsQk6ea51PPbWLBd0PfmV8XWeVw
         MeKO/s3uJfwUAbe4gazwgYt/aK8F+2YhAkGsgXbgDIbP3vlzaEHOTSMnHH/yIFlZ5g8y
         /Rqz63sjPV7o41tM/ZcJFQ7XYSpoxCx7+9PZYc7NZWymm9oZMiKSAgLhy2/WbNzOW+K3
         pkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6222QPg5rd8aHY5IhgqSSDStDL2vP3VemTOJBPxeI+Q=;
        b=Mp+TJ/sxevGAv0Zf78L/lAy5SaeMJWBIVpwnEXZplEgdDXdGwnfFAfF0ulQa+7hW1M
         YFBXUJN+DoSh+7UPEhOtr36H3Y0d1l8vqaqYfl7NsY8dLQ5AbtJF6naFcjjScuY/XFBX
         l59fC5c1KS/GpQUXqGT0DCp8+mi4s3j7LS4nKjM7h9r0sJoZsC8zRj67Nt8xJCsuwd1M
         jtGv+9OuP1kD8qubKJqKNKn5wjDdHcdR9DdLiGpzzRg8wIzpkFnAK94jc2ejwsKYqUpx
         lAoy+LCyk2GiwJypBsv1PqK8X+rXZVZqdLpvUzKmWekHs0Urtcupcz7jFf59kConE3E6
         qqTw==
X-Gm-Message-State: AOAM530IVckIsBin6IunGAl5GB98Ys8ekeOu4BpGkz22BrFfn9HtlNUf
        FZnCpAij7mEEICVGNH0ySvfXcw==
X-Google-Smtp-Source: ABdhPJwRciZh1OgPCONHXvA+T2Y9TZFFAj4gF79PtJQ7hN463s0ht/ETkuBMXJk/CO0+cbloTVyWug==
X-Received: by 2002:adf:8287:: with SMTP id 7mr20783887wrc.396.1589818445900;
        Mon, 18 May 2020 09:14:05 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id j190sm32514wmb.33.2020.05.18.09.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 09:14:05 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     square@linaro.org
Cc:     bryan.odonoghue@linaro.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        chenqiwu <chenqiwu@xiaomi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] UPSTREAM: usb: roles: Switch on role-switch uevent reporting
Date:   Mon, 18 May 2020 17:14:40 +0100
Message-Id: <20200518161442.1232821-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200518161442.1232821-1-bryan.odonoghue@linaro.org>
References: <20200518161442.1232821-1-bryan.odonoghue@linaro.org>
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
Link: https://lore.kernel.org/r/20200508162937.2566818-1-bryan.odonoghue@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[cherry-pick commit 3e63cff384e625f09758ce8f4d01ae3033402b63 upstream]
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/roles/class.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 1dd492e89719..5e4d5aa929a1 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -48,8 +48,10 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
 	mutex_lock(&sw->lock);
 
 	ret = sw->set(sw->dev.parent, role);
-	if (!ret)
+	if (!ret) {
 		sw->role = role;
+		kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
+	}
 
 	mutex_unlock(&sw->lock);
 
-- 
2.25.1

