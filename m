Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA85C43461
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3DA22D01
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281085;
	bh=bsvqLDOLlUmaBR5IRdHrcZS4+AMxNdAhjU/AXGsiBvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M+AMwzMR1ABo6TmPQN2UfZhYqlCBCfOioIRRYXNG3QNQV0kr8qYQdYogHB+x4VKfA
	 hmuhuO9LU+PvqnUa6Z5THhk4J42KFW0wVOSgz0k1t8VumkogZFLxivnfEqbdvTqAds
	 CD4Dc90AEtiwvVuH/kyikAXqRkgD5YSWY5+CUPnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGTViC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbgGTVhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:37:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 590A222CBB;
        Mon, 20 Jul 2020 21:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281074;
        bh=bsvqLDOLlUmaBR5IRdHrcZS4+AMxNdAhjU/AXGsiBvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p4mgNMmYXqP6dKdYltxoAqjn2s0lqOXVMWnfnpM1ROL3QIzlJ4oTFX1VSPIB3hMfn
         B6ga1+6Je79MmL+a+Qu0DWgpf3V7qMI9NuSQtRqAkyH5jjB647/uWmf3gLLA1c/q96
         3+33YHPnmuqe3Zro2vyDayXSf2aE82FbZNchK3vM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 31/40] hwmon: (scmi) Fix potential buffer overflow in scmi_hwmon_probe()
Date:   Mon, 20 Jul 2020 17:37:06 -0400
Message-Id: <20200720213715.406997-31-sashal@kernel.org>
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

From: Cristian Marussi <cristian.marussi@arm.com>

[ Upstream commit 3ce17cd2b94907f6d91b81b32848044b84c97606 ]

SMATCH detected a potential buffer overflow in the manipulation of
hwmon_attributes array inside the scmi_hwmon_probe function:

drivers/hwmon/scmi-hwmon.c:226
 scmi_hwmon_probe() error: buffer overflow 'hwmon_attributes' 6 <= 9

Fix it by statically declaring the size of the array as the maximum
possible as defined by hwmon_max define.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://lore.kernel.org/r/20200715121338.GA18761@e119603-lin.cambridge.arm.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/scmi-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 286d3cfda7de8..d421e691318b3 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -147,7 +147,7 @@ static enum hwmon_sensor_types scmi_types[] = {
 	[ENERGY] = hwmon_energy,
 };
 
-static u32 hwmon_attributes[] = {
+static u32 hwmon_attributes[hwmon_max] = {
 	[hwmon_chip] = HWMON_C_REGISTER_TZ,
 	[hwmon_temp] = HWMON_T_INPUT | HWMON_T_LABEL,
 	[hwmon_in] = HWMON_I_INPUT | HWMON_I_LABEL,
-- 
2.25.1

