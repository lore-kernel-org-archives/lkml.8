Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCE9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CFA207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583428748;
	bh=mtnlBCmHerKf8Q879eLnDJEOQK8W1BiYUPGGqs279ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wd2e4lPz6Xr4LPcEZmZlNfWpTv9+1S1EECglNXxF4rQ2x/zB5q/t2+bpuk0ZUh2VB
	 i5m9cUhY1ovaYaB15g6rWKu8uQ7KJdvpK7McYKHCfkihQWrJt5PkqW8DPMaWu9XkMM
	 ZWeNrk0hZmUsdoCPonfLbc4tAWnN42aXARh3If7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgCERTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:19:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbgCERPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:15:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0D420848;
        Thu,  5 Mar 2020 17:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428519;
        bh=mtnlBCmHerKf8Q879eLnDJEOQK8W1BiYUPGGqs279ZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gcTMk0c0XJyXoflPwfogG8ytv590dFdRKPrb0dNH8pZemhM6Kes5T0ezqRk0UBNZ1
         etF8Nzq/nmi6DxvRyR47Ky7twy4OxBSsYMAiSVPkx5mODHJ8iKbBCB3M+yPpKZ2qdv
         Za4360iu/SXhiNbKMPJdjXibLtnPe1uGPEVvklHU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mansour Behabadi <mansour@oxplot.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/31] HID: apple: Add support for recent firmware on Magic Keyboards
Date:   Thu,  5 Mar 2020 12:14:46 -0500
Message-Id: <20200305171516.30028-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171516.30028-1-sashal@kernel.org>
References: <20200305171516.30028-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mansour Behabadi <mansour@oxplot.com>

[ Upstream commit e433be929e63265b7412478eb7ff271467aee2d7 ]

Magic Keyboards with more recent firmware (0x0100) report Fn key differently.
Without this patch, Fn key may not behave as expected and may not be
configurable via hid_apple fnmode module parameter.

Signed-off-by: Mansour Behabadi <mansour@oxplot.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-apple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index d0a81a03ddbdd..8ab8f2350bbcd 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -343,7 +343,8 @@ static int apple_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		unsigned long **bit, int *max)
 {
 	if (usage->hid == (HID_UP_CUSTOM | 0x0003) ||
-			usage->hid == (HID_UP_MSVENDOR | 0x0003)) {
+			usage->hid == (HID_UP_MSVENDOR | 0x0003) ||
+			usage->hid == (HID_UP_HPVENDOR2 | 0x0003)) {
 		/* The fn key on Apple USB keyboards */
 		set_bit(EV_REP, hi->input->evbit);
 		hid_map_usage_clear(hi, usage, bit, max, EV_KEY, KEY_FN);
-- 
2.20.1

