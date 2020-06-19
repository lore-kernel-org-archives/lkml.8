Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9100C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFC921974
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578689;
	bh=hAWr0Dq4DWCd3YCGURfNx79O6opztkOeSirdgo20uJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uqd4SggdSxfjn5MMrUNMwLJvK5javOjMKI4c7bK8xEC1xJAnVvWY1FCxDgZ2a2dAX
	 ZANCmGZ5EvEMxKzpRRafRafLQogU//YUmc8SCOXQtSAbFX79VeYuZf6cjm7f0rdvKw
	 uJGcd/oNFNPAa79hTyX0R0XCLElZXlv99pL4T+rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390319AbgFSO6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:58:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390336AbgFSO6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:58:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7D5C217D8;
        Fri, 19 Jun 2020 14:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578681;
        bh=hAWr0Dq4DWCd3YCGURfNx79O6opztkOeSirdgo20uJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3ja+I+16wXzqfVrkd+EoPoxgpNcRAzU23rBOCzmtjQK1fhAXhsnJQHhdl3ePB0Ki
         ViFouc8hZXqquAsl9oBJt2iy4dcShMbbfyRN7RpEsD+BoLYd4ZsX7gqQWPaJx1OeRt
         ZWgzkLdqx0o3yElxR4mk0jdbbvdl3HUHUNVRjx/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 088/267] mmc: sdhci-msm: Clear tuning done flag while hs400 tuning
Date:   Fri, 19 Jun 2020 16:31:13 +0200
Message-Id: <20200619141653.095322399@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

commit 9253d71011c349d5f5cc0cebdf68b4a80811b92d upstream.

Clear tuning_done flag while executing tuning to ensure vendor
specific HS400 settings are applied properly when the controller
is re-initialized in HS400 mode.

Without this, re-initialization of the qcom SDHC in HS400 mode fails
while resuming the driver from runtime-suspend or system-suspend.

Fixes: ff06ce417828 ("mmc: sdhci-msm: Add HS400 platform support")
Cc: stable@vger.kernel.org
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Link: https://lore.kernel.org/r/1590678838-18099-1-git-send-email-vbadigan@codeaurora.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-msm.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1084,6 +1084,12 @@ static int sdhci_msm_execute_tuning(stru
 	msm_host->use_cdr = true;
 
 	/*
+	 * Clear tuning_done flag before tuning to ensure proper
+	 * HS400 settings.
+	 */
+	msm_host->tuning_done = 0;
+
+	/*
 	 * For HS400 tuning in HS200 timing requires:
 	 * - select MCLK/2 in VENDOR_SPEC
 	 * - program MCLK to 400MHz (or nearest supported) in GCC


