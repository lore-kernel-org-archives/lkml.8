Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC33AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3E42083B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135510;
	bh=CRsp8Ec+JpsS3ZUjCJ42n8X82VJfnOI53L8lqcpxqto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hUmznNfWXGF/zGpN/LCY2NJkcHBecWr2VP4B/QoSCe46HMnpeluTMH5u8ZSG3u21L
	 973JSuIZ89LccItWn/LA6LAFZ3X8HmlKqpFg1Y04PGqoHfxeaMQFE7vU1VTyQ5nExK
	 SxKyB+pi+Evi2yFLd+k8jCD42OBBF1eitkgGzLec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgGGPZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729007AbgGGPZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:25:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 707DA20663;
        Tue,  7 Jul 2020 15:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135505;
        bh=CRsp8Ec+JpsS3ZUjCJ42n8X82VJfnOI53L8lqcpxqto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/V4TTyT8GdBAsl5fIxFLqu0GddUHQ50/P1N3m+HkndMGsyK2FDjOAosdN+aWe25t
         a+dJGIH1FI5z+u0NOw0AibQV8fX3TUCYYah28JAsL7TY3cFmMQrLDjfJ/uFRw6Gvk+
         2gLCjKlUgu4fSvtnAtgs07Ccx9Y2S+hg/64K78Ok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 068/112] thermal/drivers/sprd: Fix return value of sprd_thm_probe()
Date:   Tue,  7 Jul 2020 17:17:13 +0200
Message-Id: <20200707145804.233688901@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145800.925304888@linuxfoundation.org>
References: <20200707145800.925304888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit b4147917ad4ff2c755e01a7ca296b14030d2d507 ]

When call function devm_platform_ioremap_resource(), we should use IS_ERR()
to check the return value and return PTR_ERR() if failed.

Fixes: 554fdbaf19b1 ("thermal: sprd: Add Spreadtrum thermal driver support")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1590371941-25430-1-git-send-email-yangtiezhu@loongson.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/sprd_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index a340374e8c51a..4cde70dcf6556 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -348,8 +348,8 @@ static int sprd_thm_probe(struct platform_device *pdev)
 
 	thm->var_data = pdata;
 	thm->base = devm_platform_ioremap_resource(pdev, 0);
-	if (!thm->base)
-		return -ENOMEM;
+	if (IS_ERR(thm->base))
+		return PTR_ERR(thm->base);
 
 	thm->nr_sensors = of_get_child_count(np);
 	if (thm->nr_sensors == 0 || thm->nr_sensors > SPRD_THM_MAX_SENSOR) {
-- 
2.25.1



