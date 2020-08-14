Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C421C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B2520866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cy7nHqzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgHNLkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgHNLk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3282AC061347
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c15so8039012wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jf/h0xGTx4mpZcVBL2eVQ18732vxKkSbgbH3BUucf5M=;
        b=cy7nHqzIvq0wnNuENxd5Y9IJY69qjarY/BmFqukoFAcDqsWc+en9MQgxUT2RtCUHBq
         ACbrCgua82jSK9AkVyMdXbs4qjdXH8yrvTVxm2hVWVtU27SeKr7epWd6N0I4MhVpa1X3
         8pOqzGd5rm8rZoqHy2PYUWi1fGK5THyhalMgVwSZwQO15p86Eo0efiKHDpvV8V7BTMo5
         P1G6HbbdwfWBtqNzTjmc/Tl2k4BjqQrMVFtSweOieoe29nVoYUcGOaqxskLPCJ609ylV
         x6hZzedmfaXM8fA2c44FyCnESqqyrA/v/ybo5i/UhBjuavSk8sGCfrJ5U2KCoE93yt+A
         lqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jf/h0xGTx4mpZcVBL2eVQ18732vxKkSbgbH3BUucf5M=;
        b=hE0rthGj/JB/s5MUNq1Pw1kMg03PLnhOtsr22Bz7/JIl1i+h0xPI3GNDwZ2Nr4ikuY
         Rnct60dAmJ9vcmOAEVIUmcuIhGmiPsCHbXc8iTJP781pXBwhcUmPC64vZhojfu3o277n
         swTBDWwMjBwYc/uuSI8XEK/rdnvp6wR1jbnf8lmaieyBHgH80n2zzL1E5Wjm2xygLOnJ
         4P1+t4VYYpYBhBLk9ohJhgHXKHeuPg3Nj+C398/LEfaoNOShyrLyZOdONc31xUT/juye
         XH3OjMcnHEhmnhXTu8yU9bs20PiHO817gbS0k/ibAR1ylA5jZM57v4Ja4sbJuW9dQMqO
         ahug==
X-Gm-Message-State: AOAM532qyF367/KxCI1LeY4eVfNVRYcJ7WtYVPQafk/j+x5VUyQpM4vN
        TXpzE7Se5JEmjB6b+Xyc4P5V4Q==
X-Google-Smtp-Source: ABdhPJxz0kJNTMRg+DEd79XtboLvi2BDUMerrPdgfPEO4OpbwtS9WSNMfJ61LuO3kEwk1OkaXnSCVA==
X-Received: by 2002:adf:82d5:: with SMTP id 79mr2306897wrc.282.1597405224944;
        Fri, 14 Aug 2020 04:40:24 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:40:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        netdev@vger.kernel.org
Subject: [PATCH 29/30] net: fddi: skfp: cfm: Remove seemingly unused variable 'ID_sccs'
Date:   Fri, 14 Aug 2020 12:39:32 +0100
Message-Id: <20200814113933.1903438-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is present in many source files and has not been used
anywhere (at least internally) since it was introduced.

Fixes the following W=1 kernel build warning(s):

 drivers/net/fddi/skfp/cfm.c: In function ‘cfm’:
 drivers/net/fddi/skfp/cfm.c:211:6: warning: variable ‘oldstate’ set but not used [-Wunused-but-set-variable]
 drivers/net/fddi/skfp/cfm.c:40:19: warning: ‘ID_sccs’ defined but not used [-Wunused-const-variable=]

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/fddi/skfp/cfm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/fddi/skfp/cfm.c b/drivers/net/fddi/skfp/cfm.c
index 668b1d7be6e23..4eea3408034be 100644
--- a/drivers/net/fddi/skfp/cfm.c
+++ b/drivers/net/fddi/skfp/cfm.c
@@ -36,10 +36,6 @@
 #define KERNEL
 #include "h/smtstate.h"
 
-#ifndef	lint
-static const char ID_sccs[] = "@(#)cfm.c	2.18 98/10/06 (C) SK " ;
-#endif
-
 /*
  * FSM Macros
  */
-- 
2.25.1

