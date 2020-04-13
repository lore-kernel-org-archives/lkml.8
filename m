Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2E3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:13:58 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F9920735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcY3b047"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F9920735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgDMGN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 02:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgDMGN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:13:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD04C0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:13:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h11so3053307plk.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jmTgJXaLwyZ9DI2Qq1UyQHj9ZZxvCoU5WPlpEcK3Uj8=;
        b=FcY3b0474M9s1gZ2Hz1HkN86a+tR/wT45NElJwhYaY96lYMkcLu7LgI973tTs1Ggf+
         rsIJJhLykjIjXQZ6kBbvCEpMI6eI7UACATTtWNTtbrzNyQQvdxcoiYPl5jr6gtl9eYKI
         e5FUSusqJdCPPIR92TwGad/W2z6gkK/9xbNKB/h5oNJIggyQFKu1h7MVgiwWbhv64upg
         P292tIrDb61b+eRQuxqj6s9upOyDtZNA+B1mgOI9pkdcdZjlm60ryr+EbTYuvZVsbmfL
         Bx4z7N8nNv0PsIp6Tcbu4BC+xBDCRNbDjh9mbLCYxpEzrJnUGK0bajfbXS9pCNRYwm7Y
         nhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jmTgJXaLwyZ9DI2Qq1UyQHj9ZZxvCoU5WPlpEcK3Uj8=;
        b=ixb3iNP28QtWN0m7YBAs3WsLBAnGmLT3Yo02WqUWEU7OV09aQzXxbCUY799FiZZb0D
         lluYbMwZkx9OS+ehcdP3n3rteDMMWP7NGlu21K8L0shXUHqfsIHZ0ZOorUxv1K6O15uT
         9Qv+ZhGIbAAphbYhA32xoPK97QTkIGjQfGLXGnWh6ztc6UiMYputVVb1iUnB2FUfm8uY
         PQ/VP4qANaax5YOzVCbXFQ7StcbbvDyrVsGemQiBCuhLuR2ks2rXEi3NPIawvnfvqlN0
         hGr3lirz+lGzhE9FGY+4NfLKgPExfnSatVUL3JrhCHgt2PUBSuY7L3nEBrepj5mPcmvH
         FvPg==
X-Gm-Message-State: AGi0PuZApoxsgYRRKvBS/z1H6fTgoWOA2qbfhgtd7RHXPQlYC6jF2ye1
        GiwLPqIUVyTlBmTQnXUpnW0=
X-Google-Smtp-Source: APiQypLH2dgwVCivyefuj606YYimT6Rn06iziVdLYjwJ+8y/tajrHiP+QMf5DSAsByTQTleHgvjUvQ==
X-Received: by 2002:a17:90a:8c10:: with SMTP id a16mr10740674pjo.78.1586758435815;
        Sun, 12 Apr 2020 23:13:55 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.19])
        by smtp.gmail.com with ESMTPSA id w5sm7712645pfw.154.2020.04.12.23.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 23:13:55 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org, arnd@arndb.de, broonie@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/3] regmap: Add bus reg_update_bits() support
Date:   Mon, 13 Apr 2020 14:13:20 +0800
Message-Id: <df32fd0529957d1e7e26ba1465723f16cfbe92c8.1586757922.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1586757922.git.baolin.wang7@gmail.com>
References: <cover.1586757922.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1586757922.git.baolin.wang7@gmail.com>
References: <cover.1586757922.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reg_update_bits() support in case some platforms use a special method
to update bits of registers.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/base/regmap/regmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 59f911e57719..553d92aa0c68 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -827,6 +827,7 @@ struct regmap *__regmap_init(struct device *dev,
 	} else if (!bus->read || !bus->write) {
 		map->reg_read = _regmap_bus_reg_read;
 		map->reg_write = _regmap_bus_reg_write;
+		map->reg_update_bits = bus->reg_update_bits;
 
 		map->defer_caching = false;
 		goto skip_format_initialization;
-- 
2.17.1

