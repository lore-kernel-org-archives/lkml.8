Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32484C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE31206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUCyo6Hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbgEKPNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729955AbgEKPNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:13:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082B6C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:13:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e26so18415930wmk.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78AgJ42s3Q16hO+wDB1aQPKCwHIWi6iB2h6vI6aZe/0=;
        b=DUCyo6HvLO9kLMdy+40UVDXO11UmGRGFfOpgWRexn0KaIVV+k1cwYN2fFn7Q7SJTsK
         +G5FB4DwzqUzxtjX1ySwYKaW5253gpRqkbLSFYu9Bxkhuv9qLrF4Hqrg5pAqnvJO2s9P
         JjNAeM1pyJf2iZgqwx2rQp448fypOfj5ip/8t0Ku9ChjBhPcbZEu8xkqA0TkX/8cVnaJ
         lkrAMZ1qKRzGRB8rKWLvwuc2WdJ7oH+gz+wmK66qiAYZ+N7UrEUacC5BUMi0+v7vm+Qw
         L+LaDrAxeJbAZLA/9KijBpm9D101HNrPn7vMkhVazxIQ0fAv9Y8nvONmpde+LQAhOmfu
         uz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78AgJ42s3Q16hO+wDB1aQPKCwHIWi6iB2h6vI6aZe/0=;
        b=ZuxK1xuXt3ExWtxzuB6Nx4o+Gk0Zvpx7GtYjdmppXG3DatWyaVZqGwYOedb/5lh3eN
         B6dwspX3ELM7jQzLpW4dC1IV+nkf1ZrQBiEU9Wb2h1BpJNDksu08ZoJPAPsCvKUWIh93
         jf+9u8wtyn5dm8qdCAaZw1vqnYF9bbFUNbiRKo4mITNXJce0VKrQ2NUNetJh+u2gwcaO
         i21G9I0x08L25gsaprTIr2eRAZAtL98X6dgVBJJ+hxkPpdcipFFSAnILasAcllKCw3Lq
         M1UV+k1vcM4Qs5ed7jYLCrvc/x75bdP70mkdCvNUZrDLU+yF3g0puEuv0cRELfNSZ1RF
         Xqag==
X-Gm-Message-State: AGi0Pua/P/G8qCNUvakMZhDpi78XUQwMuNzucohoPri5WDHELeE36kTG
        a9DXFgLPO0/kv4DEmxf/aPiNRg==
X-Google-Smtp-Source: APiQypJHsCP/nIMdk6EEkgGCx//CIdFuDrJFlr8SwGlgNFmTEZ1ajUaL/dx2un6IoYGeHw+Oh53Muw==
X-Received: by 2002:a1c:2b46:: with SMTP id r67mr33766791wmr.160.1589210022758;
        Mon, 11 May 2020 08:13:42 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t7sm15462181wrq.39.2020.05.11.08.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:13:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] slimbus: core: Fix mismatch in of_node_get/put
Date:   Mon, 11 May 2020 16:13:34 +0100
Message-Id: <20200511151334.362-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200511151334.362-1-srinivas.kandagatla@linaro.org>
References: <20200511151334.362-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

Adding missing corresponding of_node_put

Fixes: 7588a511bdb4 ("slimbus: core: add support to device tree helper")
Signed-off-by: Saravana Kannan <saravanak@google.com>
[Srini: added fixes tag, removed NULL check and updated log]
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 1f3beee74fdf..ae1e248a8fb8 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -282,6 +282,7 @@ EXPORT_SYMBOL_GPL(slim_register_controller);
 /* slim_remove_device: Remove the effect of slim_add_device() */
 static void slim_remove_device(struct slim_device *sbdev)
 {
+	of_node_put(sbdev->dev.of_node);
 	device_unregister(&sbdev->dev);
 }
 
-- 
2.21.0

