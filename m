Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F75C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748EF20B80
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653024;
	bh=aLKc2SmUfn8SIjJJkUSZ8J7RkjL7/t9i+FwVY1Z71rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k9sOIfC+kVdp6AydiSKaou0brrl0QH1UvhMaQNzubcyUs7Cros79uroStXzvTnnoT
	 xZt7N0Sj4e39dKOfLXwVzIbFp5mX5hzBNaBr0m5oac5PrWGWQ8AdCGY7G56XkiVOcI
	 GNQCkcc4GY9vHvryQ58lH+kMfpVR+G607nbmiK9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgGBBXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:23:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbgGBBXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:23:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA05920885;
        Thu,  2 Jul 2020 01:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653016;
        bh=aLKc2SmUfn8SIjJJkUSZ8J7RkjL7/t9i+FwVY1Z71rM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QimUm+gRXX0PT1bE9/5JKenWEs4ZB/uZmFrdhA8QgmsW+T+3SryKeLJOieJubU8Q6
         /IlR5a8ie44j/xAYxFcJO4IrU4hp51HL9AnZKpV/7qRP+MMBo7o9PgRLMsmmLsyR/m
         iSuNCOOcTgc2ulVG0j8WYWqlSCC8hLKH/oVfKyN0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 33/53] drm: panel-orientation-quirks: Add quirk for Asus T101HA panel
Date:   Wed,  1 Jul 2020 21:21:42 -0400
Message-Id: <20200702012202.2700645-33-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012202.2700645-1-sashal@kernel.org>
References: <20200702012202.2700645-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 6c22bc18a3b93a38018844636557ad02e588e055 ]

Like the Asus T100HA the Asus T101HA also uses a panel which has been
mounted 90 degrees rotated, albeit in the opposite direction.
Add a quirk for this.

Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200531093025.28050-1-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index ffd95bfeaa94c..d11d83703931e 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -121,6 +121,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100HAN"),
 		},
 		.driver_data = (void *)&asus_t100ha,
+	}, {	/* Asus T101HA */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T101HA"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* GPD MicroPC (generic strings, also match on bios date) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Default string"),
-- 
2.25.1

