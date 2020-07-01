Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D5EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A1420722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIPs+WpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgGAIbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbgGAIba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837B8C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so621627wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pdyAQzGUZDqA1eYmqwW6m9OLrHYQ+P2llVYkgd4FTX8=;
        b=gIPs+WpOisWYzVI85xj2tWSQIjYJARS6BWS56jsrBGs2mUxI8p1Q10NmhZwxQ3oKp0
         Z6fLAcH3O+E6uAQ6xqNJf6MixV13xwGg7Z0Af+EumRBu4cyW5qffSF3TdBI05K6lVCfe
         u6PP8PRLsLREA5Or5q7kA9XM5e8UptU0i8FCcvuS9ORvpf9PBpchVBOflq2VipJ0Xubk
         +n/dNjI+BJty8qg/Z6xo/Xzq53gaV8D1282M5y+aUiYZGo5DnYyMTPrVcEwGK1c8IRbb
         iYJNjcRA0Un95iZLXTU4Uv6IAvJ1NxA5ZOlyrINAw3inr0ossGnNZOYuInoOTFXarSS6
         +t7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pdyAQzGUZDqA1eYmqwW6m9OLrHYQ+P2llVYkgd4FTX8=;
        b=kgSQcrWyEYgnIVLlVDmUdCnJTxD3sHmErq/PhfGogbW2e9XsebjAxe/z53ipdZ1zeR
         rYmofZi+LXZ6C3XHLAXzJcPvVSLBI58TP9JydYzFNXei8bZhGru+7UqIZ6G7ag87H4FA
         ELFyBVrtnhJnTLy9Vvc/eOqyS4XCS2S7bF3l81YG3ZCb4deGq5R15Cv3iCZc++KbKGOi
         lLHOYW6cnC1nKmxhKjvMn9P1CFWuKgc8wVqnKhiWOb8V6v2XPHP4p88hieThQtbVv2hR
         JVO5NHZNTp06xx87Nu4ExKp9MbY6LYqAv2/Ef+8e4LoQvNJF8l1WW5RocLMBZ/BNLkig
         JwSg==
X-Gm-Message-State: AOAM531pmhtd6xrp94T0GR8I3ugTCGKemjVd2RuD83mcCac33k0HDU5A
        SKNUaZCtM5dwYLomfTV1vfaf6Q==
X-Google-Smtp-Source: ABdhPJySuW4/1ooV7a2fazAlt7N4HD24EgrmkwnofxeJdZ4KO7z/IEUUWxMP6NBitxCt1ja4kazfzA==
X-Received: by 2002:adf:a49c:: with SMTP id g28mr27602202wrb.118.1593592289275;
        Wed, 01 Jul 2020 01:31:29 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Cliff Whickman <cpw@sgi.com>,
        Robin Holt <robinmholt@gmail.com>, Dean Nelson <dcn@sgi.com>
Subject: [PATCH v2 04/30] misc: sgi-xp: xp_main: Staticify local functions xp_init() and xp_exit()
Date:   Wed,  1 Jul 2020 09:30:52 +0100
Message-Id: <20200701083118.45744-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are not exported and no external prototypes exist

Fixes W=1 kernel build warning(s):

 drivers/misc/sgi-xp/xp_main.c:227:1: warning: no previous prototype for ‘xp_init’ [-Wmissing-prototypes]
 227 | xp_init(void)
 | ^~~~~~~
 drivers/misc/sgi-xp/xp_main.c:250:1: warning: no previous prototype for ‘xp_exit’ [-Wmissing-prototypes]
 250 | xp_exit(void)
 | ^~~~~~~

Cc: Cliff Whickman <cpw@sgi.com>
Cc: Robin Holt <robinmholt@gmail.com>
Cc: Dean Nelson <dcn@sgi.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/sgi-xp/xp_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/sgi-xp/xp_main.c b/drivers/misc/sgi-xp/xp_main.c
index 5fd94d8360707..61b03fcefb134 100644
--- a/drivers/misc/sgi-xp/xp_main.c
+++ b/drivers/misc/sgi-xp/xp_main.c
@@ -223,7 +223,7 @@ xpc_disconnect(int ch_number)
 }
 EXPORT_SYMBOL_GPL(xpc_disconnect);
 
-int __init
+static int __init
 xp_init(void)
 {
 	enum xp_retval ret;
@@ -246,7 +246,7 @@ xp_init(void)
 
 module_init(xp_init);
 
-void __exit
+static void __exit
 xp_exit(void)
 {
 	if (is_uv())
-- 
2.25.1

