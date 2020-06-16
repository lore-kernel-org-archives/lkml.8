Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41881C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A5A2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323564;
	bh=wvkG8oLcFXZiSR2IS2+UDxHhiG4WeeVdy5UKKuQIeE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=He53dUZeNPwFsQdx73Z94rUK+2FGk4MhWNsqUvNr9JsokK+o1uZpccdxfSADtwvU0
	 14eRcCEIa9ND7oxeqXeHuZNP6eDTivIXepThJsEoDMkQJDKcBIyXy1ZkKfU0Ea0fN0
	 lJdJIYNoiwswlNQWJjR9MrB2mLS1I0mMANeSSknk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732814AbgFPQGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732434AbgFPPsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:48:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95B0820776;
        Tue, 16 Jun 2020 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322519;
        bh=wvkG8oLcFXZiSR2IS2+UDxHhiG4WeeVdy5UKKuQIeE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVXK8eJpgy/cUvqNONo3Ih2PBeRThh+NCvWSCjYf0DSuAR/Twkb9UUN0AVNYodzYQ
         rMrdatCVtXGmA06xk4lJQrgrQ0wRI1ROpLD/RPSItBGEBCX48mZz2n2sXXNetrWf+V
         ukuSQBQ0dl12ur7ZznyxYKFHGo62eYNdtIlyFJZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.7 154/163] mmc: uniphier-sd: call devm_request_irq() after tmio_mmc_host_probe()
Date:   Tue, 16 Jun 2020 17:35:28 +0200
Message-Id: <20200616153114.183049678@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit 5d1f42e14b135773c0cc1d82e904c5b223783a9d upstream.

Currently, tmio_mmc_irq() handler is registered before the host is
fully initialized by tmio_mmc_host_probe(). I did not previously notice
this problem.

The boot ROM of a new Socionext SoC unmasks interrupts (CTL_IRQ_MASK)
somehow. The handler is invoked before tmio_mmc_host_probe(), then
emits noisy call trace.

Move devm_request_irq() below tmio_mmc_host_probe().

Fixes: 3fd784f745dd ("mmc: uniphier-sd: add UniPhier SD/eMMC controller driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200511062158.1790924-1-yamada.masahiro@socionext.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/uniphier-sd.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -610,11 +610,6 @@ static int uniphier_sd_probe(struct plat
 		}
 	}
 
-	ret = devm_request_irq(dev, irq, tmio_mmc_irq, IRQF_SHARED,
-			       dev_name(dev), host);
-	if (ret)
-		goto free_host;
-
 	if (priv->caps & UNIPHIER_SD_CAP_EXTENDED_IP)
 		host->dma_ops = &uniphier_sd_internal_dma_ops;
 	else
@@ -642,8 +637,15 @@ static int uniphier_sd_probe(struct plat
 	if (ret)
 		goto free_host;
 
+	ret = devm_request_irq(dev, irq, tmio_mmc_irq, IRQF_SHARED,
+			       dev_name(dev), host);
+	if (ret)
+		goto remove_host;
+
 	return 0;
 
+remove_host:
+	tmio_mmc_host_remove(host);
 free_host:
 	tmio_mmc_host_free(host);
 


