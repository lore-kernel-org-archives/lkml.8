Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2856BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088C821556
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323028;
	bh=rD/bwrRxEpefQW38GRQL6xrFKiUVHbl4w5atnj3+/nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nltNU/JMp4GP8pN+zeeLe6/7SPsEGYpz/Sjymy3WfKOXtCwNp1ZqrBqVHbqAVTwzN
	 tLVv7Sq6lXws7zajAyF5OTFJwInWcpfs7yL0M9ASZ76vj2djNUGAlNKGHcjj4QIvEq
	 1jrXWqNC5BhuJ/J+qs8KlLGYdTkIZaQCcbZkRw9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733076AbgFPPz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733047AbgFPPzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:55:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20EB0208D5;
        Tue, 16 Jun 2020 15:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322910;
        bh=rD/bwrRxEpefQW38GRQL6xrFKiUVHbl4w5atnj3+/nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIxqqQgVSkrk+5fzIpTgvJ3gEAAc52ga7GaTa+rpUslbRmbSew4P1I7mQGxX1AEGH
         tj3r0BZCPlAMFCMzi5mH5vlcKrBNu8U1IRl93MyiL+4+1JXOZNzOVvoKU/IyPriIK4
         jaqsDRImlkwexJ7i845cBWIpP/d3v4JYZ51i80mE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.6 151/161] mmc: tmio: Further fixup runtime PM management at remove
Date:   Tue, 16 Jun 2020 17:35:41 +0200
Message-Id: <20200616153113.534402978@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.402291280@linuxfoundation.org>
References: <20200616153106.402291280@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

commit 4bd784411aca022622e484eb262f5a0540ae732c upstream.

Before calling tmio_mmc_host_probe(), the caller is required to enable
clocks for its device, as to make it accessible when reading/writing
registers during probe.

Therefore, the responsibility to disable these clocks, in the error path of
->probe() and during ->remove(), is better managed outside
tmio_mmc_host_remove(). As a matter of fact, callers of
tmio_mmc_host_remove() already expects this to be the behaviour.

However, there's a problem with tmio_mmc_host_remove() when the Kconfig
option, CONFIG_PM, is set. More precisely, tmio_mmc_host_remove() may then
disable the clock via runtime PM, which leads to clock enable/disable
imbalance problems, when the caller of tmio_mmc_host_remove() also tries to
disable the same clocks.

To solve the problem, let's make sure tmio_mmc_host_remove() leaves the
device with clocks enabled, but also make sure to disable the IRQs, as we
normally do at ->runtime_suspend().

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200519152434.6867-1-ulf.hansson@linaro.org
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/tmio_mmc_core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1286,12 +1286,14 @@ void tmio_mmc_host_remove(struct tmio_mm
 	cancel_work_sync(&host->done);
 	cancel_delayed_work_sync(&host->delayed_reset_work);
 	tmio_mmc_release_dma(host);
+	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	if (host->native_hotplug)
 		pm_runtime_put_noidle(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
+
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
 


