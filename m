Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87557C38158
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5DC206F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281530;
	bh=Fdxxx/6s/07AQaFKa9HaHxd0Er/Fjo+qamSOf3sgGZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vHOUFpN7bR85pSAG51waSUurbiTs3OG6QwOCKbUcmOnqMKtFLSx0So3px4IB8LF94
	 QgPmr0AcsCRyxX28o+wjEzUybd3UG5Ei05MM+zI94ZNOgMladUAQ4uwlyXlx2VhCTT
	 Jg//Y/6myKRRzWY6CjyHZbTLQ4TpYf4NsYb0MIoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgGTVp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgGTVhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:37:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E2122CB3;
        Mon, 20 Jul 2020 21:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281054;
        bh=Fdxxx/6s/07AQaFKa9HaHxd0Er/Fjo+qamSOf3sgGZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d2cqq1TWLpgsvpxJOgnCV/pB5ClpfwRvjgnl8YOFYeuwNb0sLK65Uq5ciAJM6+hNt
         7h4X6MTynSzR5SSwFYw+YG2BQkEu9NR6z8f4pdI+9YfT2SjhWIvzA56CMaf4q4oMBN
         jczx5VlNnfctnHv41jxkqLr2GR2Ev1G/jQbHvcPI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.7 15/40] hwmon: (aspeed-pwm-tacho) Avoid possible buffer overflow
Date:   Mon, 20 Jul 2020 17:36:50 -0400
Message-Id: <20200720213715.406997-15-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213715.406997-1-sashal@kernel.org>
References: <20200720213715.406997-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeny Novikov <novikov@ispras.ru>

[ Upstream commit bc4071aafcf4d0535ee423b69167696d6c03207d ]

aspeed_create_fan() reads a pwm_port value using of_property_read_u32().
If pwm_port will be more than ARRAY_SIZE(pwm_port_params), there will be
a buffer overflow in
aspeed_create_pwm_port()->aspeed_set_pwm_port_enable(). The patch fixes
the potential buffer overflow.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Link: https://lore.kernel.org/r/20200703111518.9644-1-novikov@ispras.ru
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/aspeed-pwm-tacho.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 33fb54845bf6d..3d8239fd66ed6 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -851,6 +851,8 @@ static int aspeed_create_fan(struct device *dev,
 	ret = of_property_read_u32(child, "reg", &pwm_port);
 	if (ret)
 		return ret;
+	if (pwm_port >= ARRAY_SIZE(pwm_port_params))
+		return -EINVAL;
 	aspeed_create_pwm_port(priv, (u8)pwm_port);
 
 	ret = of_property_count_u8_elems(child, "cooling-levels");
-- 
2.25.1

