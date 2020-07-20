Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2534CC433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAFC2176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261780;
	bh=H+smV+qEcnqWC28KdhQAXgm2WNqvM/MrL5wnUDP/we4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j8BeCG44Cp89RrjR3bsdppgCXQynAgTMDRTy3Pe9vHuVHOxWmmhFaZgAACRBPta2H
	 m9x+30lvkr6qpucXKiSza3MziNBvFx5bEIp3OxlDfCHg+I9kZ+L3CNfBF2wy7zJEGc
	 uTmzY0mUkcOVjEbpvHxKIubQtv+/g+FLItf0aWcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbgGTQQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388496AbgGTQQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:16:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 930212064B;
        Mon, 20 Jul 2020 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261772;
        bh=H+smV+qEcnqWC28KdhQAXgm2WNqvM/MrL5wnUDP/we4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoAx2e/473xJ5E/a5VGZcc8KszTQxDQAk2mjI7ZlM3vp842oNxFt5QWC2G60Guikz
         FH3sZ8ArzUYzdDM56u+HQkT3VvdHk+q6UfAHLMMN8rwf5UjxqXVSQea4HSIRI+Grh5
         K5jFTMBNrf+Kuvi7IdRE+DZUWH3TafdEcgwRrrDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lingling Xu <ling_ling.xu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.7 235/244] spi: sprd: switch the sequence of setting WDG_LOAD_LOW and _HIGH
Date:   Mon, 20 Jul 2020 17:38:26 +0200
Message-Id: <20200720152837.016645798@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lingling Xu <ling_ling.xu@unisoc.com>

commit 8bdd79dae1ff5397351b95e249abcae126572617 upstream.

The watchdog counter consists of WDG_LOAD_LOW and WDG_LOAD_HIGH,
which would be loaded to watchdog counter once writing WDG_LOAD_LOW.

Fixes: ac1775012058 ("spi: sprd: Add the support of restarting the system")
Signed-off-by: Lingling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Link: https://lore.kernel.org/r/20200602082415.5848-1-zhang.lyra@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-sprd-adi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -389,9 +389,9 @@ static int sprd_adi_restart_handler(stru
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_CTRL, val);
 
 	/* Load the watchdog timeout value, 50ms is always enough. */
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOAD_HIGH, 0);
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOAD_LOW,
 		       WDG_LOAD_VAL & WDG_LOAD_MASK);
-	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOAD_HIGH, 0);
 
 	/* Start the watchdog to reset system */
 	sprd_adi_read(sadi, sadi->slave_pbase + REG_WDG_CTRL, &val);


