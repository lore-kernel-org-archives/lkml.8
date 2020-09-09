Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AE5C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D53B20C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670811;
	bh=sA+LLjFnYe1xhNIVyej80xZ8cWbaGG48uMqipjGVTpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vXRKNVPgvLZgHK8vkurq4k+Gton/xdAPOLXKmxGIOAXCr4OMhFI7hI1LT9seZmd3K
	 0mrK7JiOgpz1ZK/7M7n/vjUWLpslHNvgZWO01ra7/O6BZjJ0iN9hsSDacJcvq6rui8
	 x2RD+2hFhlLvzd0VK/RUFwNq3ZAU3AKwnrwvg+zo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbgIIRAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730650AbgIIPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:12 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 357B121D95;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=sA+LLjFnYe1xhNIVyej80xZ8cWbaGG48uMqipjGVTpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y0s4UGw8uwPhFFL1bqO4NHlJLwLH44WwGwavmTdZ2+/uRWioUCN2P7be5w5+41mPa
         KPOpfqRkXaeEpEpIUknf7/FU0tesknPh8airdPYYL8XQcRa7A20Ns+XRZxTVHQ2N+X
         RENYU7F34Jmu9EF4mEBk7OZ5DT1jyOSPW3aNBg+g=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUWx-Al; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/30] drivers: net: hamradio: fix document location
Date:   Wed,  9 Sep 2020 16:10:41 +0200
Message-Id: <fae51e67eb39e808352bbd9010add75bb8ede118.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hamradio docs were moved to a different dir.
Update its location accordingly.

Fixes: 14474950252c ("docs: networking: move z8530 to the hw driver section")

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/net/hamradio/scc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
index 1e915871baa7..36eeb80406f2 100644
--- a/drivers/net/hamradio/scc.c
+++ b/drivers/net/hamradio/scc.c
@@ -7,7 +7,7 @@
  *            ------------------
  *
  * You can find a subset of the documentation in 
- * Documentation/networking/device_drivers/wan/z8530drv.rst.
+ * Documentation/networking/device_drivers/hamradio/z8530drv.rst.
  */
 
 /*
-- 
2.26.2

