Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2688C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC85420809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584752;
	bh=G9JCdUl7GSSDm+UDRH8Khp6PG1HH7a9Evvm9/yGrlUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BtB4jI6x+vgXjooeKtlnubWgHEuAGOMhiNy9vr2sy4clkNR5UAAp+6anICwcUJP7A
	 kHVxq6vO3zxp6/4qMh5oY3lSb5dm3PuWyE/qtACanT3ENOOGdB7J1kDR/YbAS27x9S
	 PdyH5UfX5bUu/3Bkfmlhed3Fi6rMDdJrN9DN/1Bo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395260AbgFSQjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388867AbgFSOqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:46:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 963B82083B;
        Fri, 19 Jun 2020 14:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578003;
        bh=G9JCdUl7GSSDm+UDRH8Khp6PG1HH7a9Evvm9/yGrlUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUuG5EKhhCFUeAACeM+wUXS4i+ZKfu5+2Ao2GNAOT0VF4RGG7QDkmMSWrAwo7MNOT
         wS9g8k1fIDI9U8Zb+m4KOBqYBn1git1xEk5I1Z4d004yiPt1IaeeTc98S/eANwebCk
         Dur9HVBcHQJHpyni/+94ztdeV0ZvfIQ74rG6nDd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 045/190] spi: No need to assign dummy value in spi_unregister_controller()
Date:   Fri, 19 Jun 2020 16:31:30 +0200
Message-Id: <20200619141635.843592227@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit ebc37af5e0a134355ea2b62ed4141458bdbd5389 ]

The device_for_each_child() doesn't require the returned value to be checked.
Thus, drop the dummy variable completely and have no warning anymore:

drivers/spi/spi.c: In function ‘spi_unregister_controller’:
drivers/spi/spi.c:2480:6: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]
  int dummy;
      ^~~~~

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 56035637d8f6..8cc1b21d00d3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2264,7 +2264,6 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 {
 	struct spi_controller *found;
 	int id = ctlr->bus_num;
-	int dummy;
 
 	/* First make sure that this controller was ever added */
 	mutex_lock(&board_lock);
@@ -2278,7 +2277,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	list_del(&ctlr->list);
 	mutex_unlock(&board_lock);
 
-	dummy = device_for_each_child(&ctlr->dev, NULL, __unregister);
+	device_for_each_child(&ctlr->dev, NULL, __unregister);
 	device_unregister(&ctlr->dev);
 	/* free bus id */
 	mutex_lock(&board_lock);
-- 
2.25.1



