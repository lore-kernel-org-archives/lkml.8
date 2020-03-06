Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BD3C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF0220848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJXKccIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCFN2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:28:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39715 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgCFN2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:28:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id j1so2367700wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l0753ioxbAPf/XAPghmG1eWdLr2jDSu4uvwHYqISpUE=;
        b=GJXKccIXYhtSv6vXeqTHPXu03DjzWWFPmE/k4I1cAtmzKPhXUw6TW9pBcFvqKJON1i
         EtHMynUyVZ59/pNCPASagVEh7/tZ1h6gdHirsjJLo6H5YXdebW0h8TSYObV67tD1wNAT
         YZ6DGBeUeRlcqLZn7mQtVllaxuHRZ0imk9IsOFGLMXuh3uZeoOZM5l94FJW30CQY5DT7
         x+5aO45M+JhORnnqXmoC0foP22mmqTU1FQruGO9jHfwBJpl1sijDARm/0DKR/4EsB6a5
         jwPNgWncYYtzjUeW3p21xIIaVvl9hEG5NLfqTOXJoJaD18vgRLt8f1fMMVqSiVHjkan2
         /htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l0753ioxbAPf/XAPghmG1eWdLr2jDSu4uvwHYqISpUE=;
        b=kfXYGqk0KvhZ27qtu++LJTYpjgKU+BfV+UB+92JcgoWlrH/YiLVp47dMzwjIisuzAT
         2uYpzBuaQtJLcq58m0GsPBcfqDKz30VVQCHLdXxOvsHUSMRZRt1bdFQ1KBrI6+rNFISo
         kbzfxHr8CEqZhAyQhzj48qHBUW8JITTT92TLhzR0BOgpr5beDjUlNLs0If7ywrejw7g+
         3gJB9ycbiXfn5fCXuziswXwUmS7QDXWeu+V9TbBbxoJvM7LEUvx97PlbSbESCvqKWoPD
         ensUWnQX6pwJ7I2x7nWh5jh8lVYTGhFiv/aCgfgtzfx8hT5Q85DlB8CXEz9Z/sppajD6
         4IVw==
X-Gm-Message-State: ANhLgQ0gkJ7ByiDO8tMOkvl/3iL7lj+XdygO75ME/NJoc9ERdMMX5VwF
        hg0Lc+a8YL5F0i/oYZDHRIrp+Q==
X-Google-Smtp-Source: ADFU+vvFAL6t94Px6BzYAVsj2oEIZBnA3NwxwlqG0OuAe/dK6SNKzCDjT5t8fHLRzEcpjjNgS0s8sQ==
X-Received: by 2002:a1c:df07:: with SMTP id w7mr3933609wmg.7.1583501293500;
        Fri, 06 Mar 2020 05:28:13 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t1sm53349237wrs.41.2020.03.06.05.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 05:28:12 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 2/2] ASoC: wcd934x: remove unused headers
Date:   Fri,  6 Mar 2020 13:28:06 +0000
Message-Id: <20200306132806.19684-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200306132806.19684-1-srinivas.kandagatla@linaro.org>
References: <20200306132806.19684-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like there are some unused headers, remove them.
Seems to be missed while moving to mfd.

Reported-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 83d643a07775..5269857e2746 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -3,7 +3,6 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/wcd934x/registers.h>
@@ -11,10 +10,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_clk.h>
-#include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
-- 
2.21.0

