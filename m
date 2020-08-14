Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08981C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF89420771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCCb3jCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgHNLmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgHNLkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EADC06134D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k20so7657236wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G92Ao+f6UU9daDqYyJPelJ9Oma/zXF8WiVDQ6/EyKiQ=;
        b=FCCb3jCc8ESxa9cFJSrHLhg/dqKu1GyVrMcfpJFR/AfZ7hxTgmwU+2hXGAfqpV1l4a
         N6Qs+IMotRajedSDhzcO/Lmy8xqD+XMPjeFAZLDBZHuu8kkIHPu0OotmkJXMgxaWJa2B
         xfOX90wvVzcQKqKAKz8h3YPQyz6LKIy0c+fRFAbFUzXrxpmAw9TKre+BD6fQKqo8g990
         ry9nOnM7gMzwjxCmFrjDZsHrEQed5mI88J05SeEhrrlbVfUAdhBtL2xi0EbmH+I/cnlY
         P7Jd2aoL7pebjWOYkgv3siRUR24TZ98TkpQgeDV7UtilswMZ5y8Oy4Y820OK+hj8CmJh
         oo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G92Ao+f6UU9daDqYyJPelJ9Oma/zXF8WiVDQ6/EyKiQ=;
        b=Hz9+iWAVPPbCF3pQVl2ZuKYd9W9LXKiiOWxz2Fvam3PfKrSy+vruOa9nOMefFV6hOg
         SXwu/trmVZFDf7bsRe4tXc0pdtEpHY7xFoPEz8ZNKZU0KoRp3lTW8/3b6NfvEQ5QsCK6
         JQeXY7PvmfudQRrIGjIo2VZwdtJqACQR0KakSJJhIvpa6D9wJzKEH83mcn/8RzbrIEcs
         HSMtuQgHyWALsukQDTsvqUB17x6V3MkEcKoLaYTfF73VsMZE7PaS+cHhcU5BJ28btp9u
         gh7M2UJjYUDdH+gQHmzD+nvDBlzvgln0e9wY/PQdZ4tXcYiaCdYomIbO/6cQCoQzJB9a
         V9Yw==
X-Gm-Message-State: AOAM530TTEQfeywVtYL87eBDSSOsyCIBmRldFvxV4N8POUOfdTd8skhF
        QlIugi3pXdTkDy3eBVIRtMhDEw==
X-Google-Smtp-Source: ABdhPJyLdf4QkUP+eb0gx0AtBQxdo38TWZ7Di17lJ+2gTouJkLg6XKL07gle+0TlXo0OfEukIxfqmw==
X-Received: by 2002:a1c:9952:: with SMTP id b79mr2231590wme.68.1597405209108;
        Fri, 14 Aug 2020 04:40:09 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:40:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        netdev@vger.kernel.org
Subject: [PATCH 18/30] net: fddi: skfp: hwmtm: Remove seemingly unused variable 'ID_sccs'
Date:   Fri, 14 Aug 2020 12:39:21 +0100
Message-Id: <20200814113933.1903438-19-lee.jones@linaro.org>
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

 drivers/net/fddi/skfp/hwmtm.c:14:19: warning: ‘ID_sccs’ defined but not used [-Wunused-const-variable=]

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/fddi/skfp/hwmtm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/fddi/skfp/hwmtm.c b/drivers/net/fddi/skfp/hwmtm.c
index 3412e0fb0ac4b..1070390565114 100644
--- a/drivers/net/fddi/skfp/hwmtm.c
+++ b/drivers/net/fddi/skfp/hwmtm.c
@@ -10,10 +10,6 @@
  *
  ******************************************************************************/
 
-#ifndef	lint
-static char const ID_sccs[] = "@(#)hwmtm.c	1.40 99/05/31 (C) SK" ;
-#endif
-
 #define	HWMTM
 
 #ifndef FDDI
-- 
2.25.1

