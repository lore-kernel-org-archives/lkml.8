Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D288C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4DE208B3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591657692;
	bh=NwARTSH7XyqllZL+B+8gV7JlC9yF8Y14manG+jnxrHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LW1qMhEJ3vcUPraHAEgJMSoGPOa+2LIObnLaxWhKDPSko67rpO2NUGOLWGJuWBuRn
	 QbyMHb1oXHV4eHDZDcm0BXz0+u5fnxicI8OSA/NfvVjjYbE9eIrV0IRbf5nkFKvMKh
	 Ikalc/JNSX76vEjbTxN1xANeO0p8YBlGzzgClo1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgFHXIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbgFHXHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 956FC20774;
        Mon,  8 Jun 2020 23:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657643;
        bh=NwARTSH7XyqllZL+B+8gV7JlC9yF8Y14manG+jnxrHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zeeQbzI+C7l6AJdOTDXWL/+QJdfblQMBYzt6X9JCalFpjpTKCJzMEspEgYrYQPbzX
         PZ5+tAb9uSSyUxBBtQRoG67XA+ZovteIOPUeJ65Tj9CgkAucA/wkOG0nsTVX59+fNG
         pLDkCIYuZuIg8OwXnrzax6siDf1p3FWoIXO8S99g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Pearson <mpearson.lenovo@gmail.com>, jendrina@lenovo.com,
        Mark Pearson <mpearson@gmail.com>,
        Lyude Paul <lyude@redhat.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 060/274] drm/dp: Lenovo X13 Yoga OLED panel brightness fix
Date:   Mon,  8 Jun 2020 19:02:33 -0400
Message-Id: <20200608230607.3361041-60-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Pearson <mpearson.lenovo@gmail.com>

[ Upstream commit 0df3ff451287d71c620384eb7bb2cd3a8106412c ]

Add another panel that needs the edid quirk to the list so that
brightness control works correctly. Fixes issue seen on Lenovo X13 Yoga
with OLED panel

Co-developed-by: jendrina@lenovo.com
Signed-off-by: Mark Pearson <mpearson@gmail.com>
[fixed commit message, sobs]
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200519025635.22846-1-mpearson@lenovo.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_dp_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index c6fbe6e6bc9d..41f0e797ce8c 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1313,6 +1313,7 @@ static const struct edid_quirk edid_quirk_list[] = {
 	{ MFG(0x06, 0xaf), PROD_ID(0xeb, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
 	{ MFG(0x4d, 0x10), PROD_ID(0xc7, 0x14), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
 	{ MFG(0x4d, 0x10), PROD_ID(0xe6, 0x14), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
+	{ MFG(0x4c, 0x83), PROD_ID(0x47, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
 };
 
 #undef MFG
-- 
2.25.1

