Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4AAC433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9017E208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859749;
	bh=NX0l8dfROV94VxMJKeLtPTYCNriVw+Y58Z4ap4h0UJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mLeAGfxIjk3ZL0xQC4Ed4WgyaWkAhN9oQVdAZO/ZokanSjWtgPbf1Ad2mFB6BaN3+
	 1wHpoPktCiAPsoMm5NXUdbcGv8WxaFvRY6UrPXiuHjtEf/oZlWELQeYBrvdUGB9Ygi
	 tMWELXOZc51bHnN2fdVIDu+9ckhFGcnbeyDlLQ0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbgG0OW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731868AbgG0OWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:22:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DE1C2075A;
        Mon, 27 Jul 2020 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859742;
        bh=NX0l8dfROV94VxMJKeLtPTYCNriVw+Y58Z4ap4h0UJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxZkny6xhgQnV/f5Rb3q0xSPzxnyS8nMU7wl5os/uNETGZE3PPXEY6GEKfrG9g0X6
         OYgLfFHX4gRP1T1M9DfofE9fHbBt5zmprcHU9zcGJPhig4wZBYZwe1Ca0+yyKoo1aT
         O+A7SoQ9xLSNme7NrVKI/uJepnF5Qb8cAoDNjZXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 057/179] ASoC: Intel: bytcht_es8316: Add missed put_device()
Date:   Mon, 27 Jul 2020 16:03:52 +0200
Message-Id: <20200727134935.448089661@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Xiangfeng <jingxiangfeng@huawei.com>

[ Upstream commit b3df80ab6d147d4738be242e1c91e5fdbb6b03ef ]

snd_byt_cht_es8316_mc_probe() misses to call put_device() in an error
path. Add the missed function call to fix it.

Fixes: ba49cf6f8e4a ("ASoC: Intel: bytcht_es8316: Add quirk for inverted jack detect")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200714080918.148196-1-jingxiangfeng@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index ddcd070100ef4..b3fd7de594d79 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -543,8 +543,10 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 
 	if (cnt) {
 		ret = device_add_properties(codec_dev, props);
-		if (ret)
+		if (ret) {
+			put_device(codec_dev);
 			return ret;
+		}
 	}
 
 	devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
-- 
2.25.1



