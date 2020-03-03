Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC333C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92E824684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583203680;
	bh=DJ7m9Kjn2gggjYhzhVkrVZAJu0ldu3G8qeweFwR+9ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZG7OyrngRcaWvFoc6X7hlnB7nIlnKg0JjLpLseDHMNlVM7ixbFsxVEE9xVEvoUebA
	 a7yXMUWJ2Jkwx5WLTme424Ixppew2inXpk7/DlzqvClZK3LEIYk/fMVp8oAhu0UMHt
	 Y/LSD6xrN2HO6SkM3H2TYRXAWYeTQhMJGJzfYXeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgCCCr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:47:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbgCCCrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:47:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F6E824673;
        Tue,  3 Mar 2020 02:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203671;
        bh=DJ7m9Kjn2gggjYhzhVkrVZAJu0ldu3G8qeweFwR+9ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2C1O/2lkvWDZaqyNpbskr7xok96PvxPXHlcg+kRFuxMXikwysnyx6F9heD1+xgcF
         zzMuPedRiP8zi6JlBwl5tyAlO6tLsosH73/wd1FN+4d2MS03OolGohj38s84+PYET2
         QK8o1jnQNRIMILo7t8HPpsb4iO5seMYagjCU1lCU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Omer Shpigelman <oshpigelman@habana.ai>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 09/58] habanalabs: do not halt CoreSight during hard reset
Date:   Mon,  2 Mar 2020 21:46:51 -0500
Message-Id: <20200303024740.9511-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024740.9511-1-sashal@kernel.org>
References: <20200303024740.9511-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

[ Upstream commit a37e47192dfa98f79a0cd5ab991c224b5980c982 ]

During hard reset we must not write to the device.
Hence avoid halting CoreSight during user context close if it is done
during hard reset.
In addition, we must not re-enable clock gating afterwards as it was
deliberately disabled in the beginning of the hard reset flow.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index eb9c07833a517..a7a4fed4d8995 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -600,7 +600,9 @@ int hl_device_set_debug_mode(struct hl_device *hdev, bool enable)
 			goto out;
 		}
 
-		hdev->asic_funcs->halt_coresight(hdev);
+		if (!hdev->hard_reset_pending)
+			hdev->asic_funcs->halt_coresight(hdev);
+
 		hdev->in_debug = 0;
 
 		goto out;
-- 
2.20.1

