Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4357DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20873206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461641;
	bh=FiEHmqM87VSgRAol1qZ7txeTDXYO/hi6h94peLWxic8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aN7Eh33SxBkJ5Prkuc1EmhmNfRTglrRnEQ6JHucNvxn9sO7Q/t7tKh1bCf7MMoBU+
	 2IiXXWPyzED8Bf9xU5PkVH+QbWkir31fgBSEhY9uln5K1wwMqd66bAnCB2Q7STf6dN
	 hkXwAqhl2lND+yh9vi8c6zGMjv3YjNrLo3anLH+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbgF2UN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:13:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732840AbgF2TaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0EA525234;
        Mon, 29 Jun 2020 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444950;
        bh=FiEHmqM87VSgRAol1qZ7txeTDXYO/hi6h94peLWxic8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GIQg1fC13gQLW0NL35j4UhNsvNotV+i6B6krLg2GI/ArfnUrfhAsqNcOm/CAa6qWl
         MTBLNp99luLGv3GTY//x+GwYNq97IKkhvLyZUzSVbvYbTAtOGRmWASn0D8C1TzsvMG
         7633HC6a9CInsCHY4UEu5utzpVlMa+iGRC/myuD8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li Jun <jun.li@nxp.com>, John Stultz <john.stultz@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19 048/131] usb: typec: tcpci_rt1711h: avoid screaming irq causing boot hangs
Date:   Mon, 29 Jun 2020 11:33:39 -0400
Message-Id: <20200629153502.2494656-49-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Jun <jun.li@nxp.com>

commit 302c570bf36e997d55ad0d60628a2feec76954a4 upstream.

John reported screaming irq caused by rt1711h when system boot[1],
this is because irq request is done before tcpci_register_port(),
so the chip->tcpci has not been setup, irq handler is entered but
can't do anything, this patch is to address this by moving the irq
request after tcpci_register_port().

[1] https://lore.kernel.org/linux-usb/20200530040157.31038-1-john.stultz@linaro.org

Fixes: ce08eaeb6388 ("staging: typec: rt1711h typec chip driver")
Cc: stable <stable@vger.kernel.org> # v4.18+
Cc: John Stultz <john.stultz@linaro.org>
Reported-and-tested-by: John Stultz <john.stultz@linaro.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Li Jun <jun.li@nxp.com>
Link: https://lore.kernel.org/r/20200604112118.38062-1-jun.li@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpci_rt1711h.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/typec/tcpci_rt1711h.c b/drivers/usb/typec/tcpci_rt1711h.c
index 017389021b96a..b56a0880a0441 100644
--- a/drivers/usb/typec/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpci_rt1711h.c
@@ -179,26 +179,6 @@ static irqreturn_t rt1711h_irq(int irq, void *dev_id)
 	return tcpci_irq(chip->tcpci);
 }
 
-static int rt1711h_init_alert(struct rt1711h_chip *chip,
-			      struct i2c_client *client)
-{
-	int ret;
-
-	/* Disable chip interrupts before requesting irq */
-	ret = rt1711h_write16(chip, TCPC_ALERT_MASK, 0);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_request_threaded_irq(chip->dev, client->irq, NULL,
-					rt1711h_irq,
-					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
-					dev_name(chip->dev), chip);
-	if (ret < 0)
-		return ret;
-	enable_irq_wake(client->irq);
-	return 0;
-}
-
 static int rt1711h_sw_reset(struct rt1711h_chip *chip)
 {
 	int ret;
@@ -260,7 +240,8 @@ static int rt1711h_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	ret = rt1711h_init_alert(chip, client);
+	/* Disable chip interrupts before requesting irq */
+	ret = rt1711h_write16(chip, TCPC_ALERT_MASK, 0);
 	if (ret < 0)
 		return ret;
 
@@ -271,6 +252,14 @@ static int rt1711h_probe(struct i2c_client *client,
 	if (IS_ERR_OR_NULL(chip->tcpci))
 		return PTR_ERR(chip->tcpci);
 
+	ret = devm_request_threaded_irq(chip->dev, client->irq, NULL,
+					rt1711h_irq,
+					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+					dev_name(chip->dev), chip);
+	if (ret < 0)
+		return ret;
+	enable_irq_wake(client->irq);
+
 	return 0;
 }
 
-- 
2.25.1

