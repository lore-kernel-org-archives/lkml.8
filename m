Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE552C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 960AD206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WsVM4w8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbgGVKIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbgGVKIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:08:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD319C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so1294786wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IgrMyzpm2qTOF6KQzko+Yr8RR9uR6bR44PpctbroAdQ=;
        b=WsVM4w8YjDYhkQgj5FWERfZIZ5M2LkmlvbMvLJLd97uLrLIU9H3ZXhi7MeTiBKA5Zb
         Z3RxrcIviPTT9gXPWV0a9rAprxrvZ+1d6GdvlU1qBYUNyfgT8QoCc84hVbgwPUrUYmAb
         ODH0sKQtgq63s/kaTzMQl+kR4AM0c8mBV+v949hWMYmXy60ljNX9R8Q5FSt6WJPYL/x6
         EECphUI1cgQSaMXWYjef0LedH+HyNIT6jXOQEFm1LSOhM+EOYxyNzaKc24Wi3p5Qb5lF
         RvzyYzw/hMpCja4uVDg/gQrSrU5bImYZ4KWQCUEkP3zMGHK2N0YOBhte+waFKk4aO/k7
         EtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IgrMyzpm2qTOF6KQzko+Yr8RR9uR6bR44PpctbroAdQ=;
        b=IVYmO6S1ydgjAIOpBS/ROxn0b9PgupZe0cqaA+bcISLDpfll49KjQ3CVJiA9wXqYig
         f12GT8p7DYWp/MIBoSFmbeUhqmKpNnEIPfxvHLF6/Yk3L7ISC6EIrkgxCnXncF9vn1T6
         MgV9RUbuv984iPTGKcoSK/0Z+UaO8BqIwTVkRSg9inPnlTkyyVXaUEgF65C2G63nwqON
         JMrPjSTgbjdKwix2hQeUUP6vZ8X+PANwEHNNvidkpMnwxiAN+R6v6AsqJbDp9Jq8u/d9
         JiiM7mUyJ1HVIplFgztMZmC6kfVwh1/SzYbZg980zEGBXiM7HCn3XKXa64J5cRDnZe1v
         J0CQ==
X-Gm-Message-State: AOAM533z7D7wiTL8VHx+C0bbgZaoLPkUCS42U0n1lf1ObhQFldQA7Huk
        eiCquasNF0+uEkXu4nmxZtzFsY0kaM8=
X-Google-Smtp-Source: ABdhPJxgZPCk8QS16626UJw3+D7N6dbD9raXG/JiAEAp5lsVfXCjZ8MOjfbQ5LQXIM3dBfmLVOQq5w==
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr31807588wrm.92.1595412492652;
        Wed, 22 Jul 2020 03:08:12 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t13sm17098623wru.65.2020.07.22.03.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:08:12 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/14] MAINTAINERS: Add git tree for NVMEM FRAMEWORK
Date:   Wed, 22 Jul 2020 11:06:53 +0100
Message-Id: <20200722100705.7772-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
References: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

There is no git tree for NVMEM FRAMEWORK in MAINTAINERS, it is not
convinent to rebase, add it.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..83078661cd2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12260,6 +12260,7 @@ F:	drivers/nvme/target/
 NVMEM FRAMEWORK
 M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git
 F:	Documentation/ABI/stable/sysfs-bus-nvmem
 F:	Documentation/devicetree/bindings/nvmem/
 F:	drivers/nvmem/
-- 
2.21.0

