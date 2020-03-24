Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE82DC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F01320775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056179;
	bh=AhLIt3Be5ynfJ9W7ht0BWEQsj+TQFznIuCiV6H4xBNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u28yyXWPv6qt0hNePtXXKjw/FXjrsqP8xmuzQAzz8Ai0FGrSPk0Gn9phcy8PoX5Si
	 vlsW7oYb4oq+gFp57fYJxB8MkO7QpJaLFO4ltxI5YbDokm5VvM48q/FxiDA36qyKgQ
	 jWefcmWOcvSdzS+FoZ+79O0kCUx933WwxdnQT3Bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgCXNW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:22:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbgCXNWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:22:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7256B206F6;
        Tue, 24 Mar 2020 13:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056170;
        bh=AhLIt3Be5ynfJ9W7ht0BWEQsj+TQFznIuCiV6H4xBNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1SXiMystIGPPUm+KcPIEDp2ig6QYQTKjgBN1SFi6et1gQOlOoo5g+Aw4CIZQUyNqm
         vppgGMQOhqfkAGOztSun3JtxpdVevhOu4Lzlf9xviaeZRJeUT39FdgpMY0iiOKpTaq
         E8+dYlrCyZuXwf2CYPlLoNw+43uOxO7HKU7tSnNI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuji sasaki <sasakiy@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 009/119] spi: qup: call spi_qup_pm_resume_runtime before suspending
Date:   Tue, 24 Mar 2020 14:09:54 +0100
Message-Id: <20200324130808.912212224@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuji Sasaki <sasakiy@chromium.org>

[ Upstream commit 136b5cd2e2f97581ae560cff0db2a3b5369112da ]

spi_qup_suspend() will cause synchronous external abort when
runtime suspend is enabled and applied, as it tries to
access SPI controller register while clock is already disabled
in spi_qup_pm_suspend_runtime().

Signed-off-by: Yuji sasaki <sasakiy@chromium.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20200214074340.2286170-1-vkoul@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-qup.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index dd3434a407ea6..a364b99497e26 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1217,6 +1217,11 @@ static int spi_qup_suspend(struct device *device)
 	struct spi_qup *controller = spi_master_get_devdata(master);
 	int ret;
 
+	if (pm_runtime_suspended(device)) {
+		ret = spi_qup_pm_resume_runtime(device);
+		if (ret)
+			return ret;
+	}
 	ret = spi_master_suspend(master);
 	if (ret)
 		return ret;
@@ -1225,10 +1230,8 @@ static int spi_qup_suspend(struct device *device)
 	if (ret)
 		return ret;
 
-	if (!pm_runtime_suspended(device)) {
-		clk_disable_unprepare(controller->cclk);
-		clk_disable_unprepare(controller->iclk);
-	}
+	clk_disable_unprepare(controller->cclk);
+	clk_disable_unprepare(controller->iclk);
 	return 0;
 }
 
-- 
2.20.1



