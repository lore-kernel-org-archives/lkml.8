Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EE9C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB7F206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587049654;
	bh=SHXiNoVv/c349s6EeJRbHdte8+NwLkK+cl56nrQhST4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DNnJMD7URpKP3SZM1rTrLXBDuAXBj88uV7MH63CyNEpEdFafqwIBouveI1rVpo9I5
	 +Zfl3PqGkVwnYt2JdatSokhyilyeTC6ZGPG9bYByXsI0+RQFve4Be7CdRASeYHRsU3
	 Fzu2QePjS6VPusqcZfc/hLWNRPoJRX5L8HsrIjhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441241AbgDPPHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392426AbgDPNvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:51:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA95120732;
        Thu, 16 Apr 2020 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045102;
        bh=SHXiNoVv/c349s6EeJRbHdte8+NwLkK+cl56nrQhST4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piZe+r+zVzH1xdmn92T34UKLcCiRpdhz2TzpBGg5flrYxExh4D4NAtp9J2lwu0rWG
         wphnTnuayU4nBnWTjHwnVeyHB5n128jIpEQrJwA0NKVyYp6qo4XG9U2Dm0oTgxK3iP
         ceA1bPKdOQJxic3QTNAmcME/Xs+Vfz/7HqHYghOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 231/232] mmc: sdhci: Convert sdhci_set_timeout_irq() to non-static
Date:   Thu, 16 Apr 2020 15:25:25 +0200
Message-Id: <20200416131344.445663960@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

[ Upstream commit 7907ebe741a7f14ed12889ebe770438a4ff47613 ]

Export sdhci_set_timeout_irq() so that it is accessible from platform drivers.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20200116105154.7685-6-faiz_abbas@ti.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4478b94d47915..4c40fd4ba21b1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -981,7 +981,7 @@ static void sdhci_set_transfer_irqs(struct sdhci_host *host)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
-static void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable)
+void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable)
 {
 	if (enable)
 		host->ier |= SDHCI_INT_DATA_TIMEOUT;
@@ -990,6 +990,7 @@ static void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable)
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
+EXPORT_SYMBOL_GPL(sdhci_set_data_timeout_irq);
 
 static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index fe83ece6965b1..4613d71b3cd6e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -795,5 +795,6 @@ void sdhci_end_tuning(struct sdhci_host *host);
 void sdhci_reset_tuning(struct sdhci_host *host);
 void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
 void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode);
+void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
 
 #endif /* __SDHCI_HW_H */
-- 
2.20.1



