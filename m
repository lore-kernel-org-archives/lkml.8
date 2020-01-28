Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5E0C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768CD2468D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221338;
	bh=2rjCoQ6/I7YPt/RGPbGMpMOxxajYnKF5yuaiOGbmEpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=otDtUqAJoxzS6BJw8p+WqHO2xTd0VXPAe52wESGxjYYvylE9Z9RnRhs4lQ0d9xDIX
	 Jwmgg1KyqiXaKj/ZNsC4zani3mmhuee81sxt5/o3oEAGd7unfp0rJMJ0motjHCd9wR
	 DHxjdfvDt/kyf0R8xT3TRCd33dbo3jhygjc2rXJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgA1OWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:22:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:47958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731190AbgA1OWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:22:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB62524693;
        Tue, 28 Jan 2020 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221333;
        bh=2rjCoQ6/I7YPt/RGPbGMpMOxxajYnKF5yuaiOGbmEpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K643VxjYniNpfRFrBrlK87F8Oe3/tc2BXE4krZOuQfiUbHvGWRSijSeMXemLmu926
         OuPYrpy3GgnZFgIhznfZ6BMlfjThGDyuKHaDdVGC79ws9Ii2DvwE6UAskIxqJozKR3
         CJBtrchK/G558EHFiByegvPZ2lo+Kipiz8zQlqoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 181/271] ASoC: cs4349: Use PM ops cs4349_runtime_pm
Date:   Tue, 28 Jan 2020 15:05:30 +0100
Message-Id: <20200128135906.011118753@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 9b4275c415acca6264a3d7f1182589959c93d530 ]

sound/soc/codecs/cs4349.c:358:32: warning:
 cs4349_runtime_pm defined but not used [-Wunused-const-variable=]

cs4349_runtime_pm ops already defined, it seems
we should enable it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e40da86 ("ASoC: cs4349: Add support for Cirrus Logic CS4349")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815090157.70036-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs4349.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index 231ca935cdf3b..c232c42ccead0 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -380,6 +380,7 @@ static struct i2c_driver cs4349_i2c_driver = {
 	.driver = {
 		.name		= "cs4349",
 		.of_match_table	= cs4349_of_match,
+		.pm = &cs4349_runtime_pm,
 	},
 	.id_table	= cs4349_i2c_id,
 	.probe		= cs4349_i2c_probe,
-- 
2.20.1



