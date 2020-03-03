Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FCBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E888924680
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583203596;
	bh=EmVp/FvO12B6npsKyvEA08xNMu5dfLgtPtThwfKw6fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U4yBaUz1DyDIOtt9izXiAyYlDZ4oXUSPhRNvm6zZQA3c47lWznAWafF2rhOt0kz+z
	 +WB33hHFpFOKfKCypKG1KOwo/Wh5l3TkGpfe3VvJfTU9BvjgEYV+PsO3h/Tmk7402d
	 rybbkHX6XMBbOPHDd8lGCl3CHJs6OK8l+ePyBrVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgCCCqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:46:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:40810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbgCCCq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:46:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DB672468E;
        Tue,  3 Mar 2020 02:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203587;
        bh=EmVp/FvO12B6npsKyvEA08xNMu5dfLgtPtThwfKw6fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEEitbjR7afgHqnc/zV9Pyw+9KcL8aze3fDHiRScUK/crkukrFLkjB/HS+DSpmBd1
         TuwRt/GL9nUNI5+r20gtcS8pXhjIcd8TDRmnx1X4ayGAohb6qCd0F3ilZHrHz86i1x
         /EMpdoReH2dEvYCNft48sNdjNfEHvR2SGxoVa8W8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Omer Shpigelman <oshpigelman@habana.ai>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 10/66] habanalabs: do not halt CoreSight during hard reset
Date:   Mon,  2 Mar 2020 21:45:19 -0500
Message-Id: <20200303024615.8889-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024615.8889-1-sashal@kernel.org>
References: <20200303024615.8889-1-sashal@kernel.org>
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
index 166883b647252..b680b0caa69be 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -598,7 +598,9 @@ int hl_device_set_debug_mode(struct hl_device *hdev, bool enable)
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

