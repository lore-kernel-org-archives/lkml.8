Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB568C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AEA421D80
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444255;
	bh=r22kJpkaw3xZhTgw3O801kzZRzM5D2whyI7HfVm1ddo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kSZmTRwsWD1J0xVOl4Ex9ssz6ra3D9C1CQRdyJxNcMiafpn0BbjDkwA8ltwWSAFX9
	 VF7+qY2SfK26Y7/P73gGofhkemYJQdm58aX99XwBQlC5GvjeXwv1J5VdRGFZ3tIO9i
	 7exHLpIFiFsTxJ/agj2Q8IGA2BxoDs8191Htjat8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgFRBhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731939AbgFRBar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:30:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C742E221EC;
        Thu, 18 Jun 2020 01:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443847;
        bh=r22kJpkaw3xZhTgw3O801kzZRzM5D2whyI7HfVm1ddo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JbF9hCkAB0X6szbo0l4TjldDeVCs1CqoElFUGwSt2WE90jd1claniPscJBaBtiVmm
         lMSYkWZI1TF87JNe9dsp9qI03LdVK4UW6PL0CZ4EAc00koMyZWGZrDeV1znbk5DuGa
         rsXLxWw+q7h3orgmCEr6Hl7w5jmosD7JFzBrS4V4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 32/60] power: supply: smb347-charger: IRQSTAT_D is volatile
Date:   Wed, 17 Jun 2020 21:29:36 -0400
Message-Id: <20200618013004.610532-32-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618013004.610532-1-sashal@kernel.org>
References: <20200618013004.610532-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit c32ea07a30630ace950e07ffe7a18bdcc25898e1 ]

Fix failure when USB cable is connected:
smb347 2-006a: reading IRQSTAT_D failed

Fixes: 1502cfe19bac ("smb347-charger: Fix battery status reporting logic for charger faults")

Tested-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/smb347-charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/smb347-charger.c b/drivers/power/smb347-charger.c
index 072c5189bd6d..0655dbdc7000 100644
--- a/drivers/power/smb347-charger.c
+++ b/drivers/power/smb347-charger.c
@@ -1141,6 +1141,7 @@ static bool smb347_volatile_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case IRQSTAT_A:
 	case IRQSTAT_C:
+	case IRQSTAT_D:
 	case IRQSTAT_E:
 	case IRQSTAT_F:
 	case STAT_A:
-- 
2.25.1

