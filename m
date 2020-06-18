Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E663C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB44621D7B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444994;
	bh=hviPfHuYHn7yXMIW6qqR39TKTdiniUR1z8s3DQP+CAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E8ibwuRQ/ahf5xtKmKp4VgfZRw5Jey1q3fo8RTDOlxy1pP+ayYkf+oNUFM5KW7H7v
	 p9l4U1loRwMikEGR24q4THuXk25oM+a35H6rJVWKza6qCWJLedmdj8qlk42jz8+hua
	 TlwA+2HdLLQn8RPnahYvyRxhXZWTHh75u91jtkAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbgFRBtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731884AbgFRB1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:27:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB512221FA;
        Thu, 18 Jun 2020 01:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443653;
        bh=hviPfHuYHn7yXMIW6qqR39TKTdiniUR1z8s3DQP+CAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2gt6psi/7h5EloCpE2EB32j7BR6H25s10ORVl9fDqnEKw2aoClCbYYEhO8PgZhu/B
         BxhUo4bvdtAYU1GbtUBm0c0HP6KSfZScxw8EkIrqf6QgeKPkH2TRf3bErAZvt43Yu/
         ezVVsVte6rlxPmNLQraKq3Vg0X3ZFLmbniaMmO9E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 073/108] usb: dwc2: gadget: move gadget resume after the core is in L0 state
Date:   Wed, 17 Jun 2020 21:25:25 -0400
Message-Id: <20200618012600.608744-73-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012600.608744-1-sashal@kernel.org>
References: <20200618012600.608744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

[ Upstream commit 8c935deacebb8fac8f41378701eb79d12f3c2e2d ]

When the remote wakeup interrupt is triggered, lx_state is resumed from L2
to L0 state. But when the gadget resume is called, lx_state is still L2.
This prevents the resume callback to queue any request. Any attempt
to queue a request from resume callback will result in:
- "submit request only in active state" debug message to be issued
- dwc2_hsotg_ep_queue() returns -EAGAIN

Call the gadget resume routine after the core is in L0 state.

Fixes: f81f46e1f530 ("usb: dwc2: implement hibernation during bus suspend/resume")

Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/core_intr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index b8bcb007c92a..e3e0a3ab31da 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -364,10 +364,13 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 			if (ret && (ret != -ENOTSUPP))
 				dev_err(hsotg->dev, "exit hibernation failed\n");
 
+			/* Change to L0 state */
+			hsotg->lx_state = DWC2_L0;
 			call_gadget(hsotg, resume);
+		} else {
+			/* Change to L0 state */
+			hsotg->lx_state = DWC2_L0;
 		}
-		/* Change to L0 state */
-		hsotg->lx_state = DWC2_L0;
 	} else {
 		if (hsotg->params.hibernation)
 			return;
-- 
2.25.1

