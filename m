Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B45CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56AA02089D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lssD7wLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgFZNGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgFZNFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:05:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB33C08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:41 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so6446847wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ANELz34YBsSGQN7d0PesCj0UqV7NJ8u8B5Ne0MQu0g=;
        b=lssD7wLqAJ0gJ+IzPKc8xCcG8BbMd7WxfU4aZ1PnxbgyuJuJJKMUg2E0Ncry6QBvL3
         ldpGHJOw45mbzIlGcVPNAN/4EifoPDi7u3mGWe3FjBIIJzp+ZiLBdQ3KGT89eRn3XDZa
         LvTdr7vyqiv8LYUrxWAPKfXhMizTs+8VM3nOqmbVaaK1U1DQhlZQPfvreyntL3S5XHuh
         3kxtwFKo6y3ZCqypb55xeMvUL5EPM1Iti+A/AURIU8A05l3thR5Jc6nlcTi/iX7MwU+m
         rfs+UWRblseM4HJb0sQODTWcGMNDBrVGSDKnGsyRc25pTlmFk09o94sn7U9dj2AEpDvb
         QXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ANELz34YBsSGQN7d0PesCj0UqV7NJ8u8B5Ne0MQu0g=;
        b=AvSkUnHWlgZ+zt8MGYxG4709bedVqJ9w5rbgZvzxU3ezO/DLMDO+pAoCbWZMmoZ4bA
         cDP668K079ap6PpRtYQjteE0XuH1golGiVV02FrjJ2VeCP6JqZvxjME56osgBRj1/2/N
         /cmyB6/0ni35Dv5ysoZG3Vf5HjMrdFcwrprnVB61qnTy8AazfI7aRm75DD1+XXiH+UAE
         +Nk94SV2/fTri9blyI+L+eZIcmyz0NAou325QjGA0+XsK2ZRt15L9pU00Ll7R8MyDvxf
         quro4oZZHU318miksByE9KYK6FcO7HYviBIUH03hq8KvIIiQ2zpGlBbYTm00f0G4kZ2G
         fHVg==
X-Gm-Message-State: AOAM532OFlFYq9XgJloqMqZfNlOAd5IJLOtQuIkdltTsd/FOl8eXzHEe
        tQk09yyCmE92tQkbZmFBA1y0LQ==
X-Google-Smtp-Source: ABdhPJzGWHVPd8vU4+Qbx/bdjmxkJJaSh3IiL55zDdAssidkE68VRfBSl22gKPmVsY+9Ihcaf3wkdw==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr3711643wro.413.1593176739993;
        Fri, 26 Jun 2020 06:05:39 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id u20sm16746904wmc.44.2020.06.26.06.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:05:39 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Oded Gabbay <oded.gabbay@gmail.com>
Subject: [PATCH 09/10] misc: habanalabs: irq: Add missing struct identifier for 'struct hl_eqe_work'
Date:   Fri, 26 Jun 2020 14:05:24 +0100
Message-Id: <20200626130525.389469-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626130525.389469-1-lee.jones@linaro.org>
References: <20200626130525.389469-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kerneldoc format, data structures have to start with 'struct'
else the kerneldoc tooling/parsers/validators get confused.

Squashes the following W=1 warning:

 drivers/misc/habanalabs/irq.c:19: warning: cannot understand function prototype: 'struct hl_eqe_work '

Cc: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/habanalabs/irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
index fac65fbd70e81..4e77a73857793 100644
--- a/drivers/misc/habanalabs/irq.c
+++ b/drivers/misc/habanalabs/irq.c
@@ -10,7 +10,8 @@
 #include <linux/slab.h>
 
 /**
- * This structure is used to schedule work of EQ entry and armcp_reset event
+ * struct hl_eqe_work - This structure is used to schedule work of EQ
+ *                      entry and armcp_reset event
  *
  * @eq_work          - workqueue object to run when EQ entry is received
  * @hdev             - pointer to device structure
-- 
2.25.1

