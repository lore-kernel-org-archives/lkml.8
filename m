Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66951C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 058D8207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pU7BCLjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgIJSVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgIJSQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:16:22 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD58C061795
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:43 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o8so10094306ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W7DkithE56mdCnccMk8ckYJ6D2qQymaSzvDlewPXko4=;
        b=pU7BCLjxJo/Mi+b16jr77l9RK1nhhRcCrD9Oo8mS3jQqthePjZCuEkyHK9FENw5WXD
         BQNh/7wn8OGlysNdtumO9NHgMe4fLSWhftIMGLpybakmzXjNIcCL56bC9oQHqMJHBhTG
         H2I1pufK3uJu8u+fDrknk+iDb09VGyHncDoMsSR6AxkdZHUbOBwk4q8/tw4ewxNYMiW9
         jpL+m8ZFLg2gJ5y5gvahgguIkRVH821yNsR8idnABiLDWH9P6bNXvSTMYMv5VJ6TY6/b
         XwaboqHXoKhf9MaN1KbyH6ST2U/Bt+6sjMUuXt4lI5pVzrbxwkJW1JmJv9lVqT4qoxng
         YtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W7DkithE56mdCnccMk8ckYJ6D2qQymaSzvDlewPXko4=;
        b=nKMiDIuQbGxLEOC5vSmhEu32mzrteMnilajcEzzkDGXl4GLgCGt5TWnYgx7HH48+Nw
         jdNi+acWwA861boOzsTiDEmER/EmmryqLBCePiw8L/5YJ3zs98lQ18fTx+/+izKVG0d9
         KUDjYTFi3/awZcG2FNAeydaqHFURRm8NSOTL9uA9lTASFOurhAxCqqJ4Cmw1mUhvhpnj
         2gxxN5IgpD+5qB2ZV1jjUlj6kw0Xg54t8eSdD4iFjoKXYPf17LCLtdIYHeVJGYmo3BXM
         0azDtbAWh/oVHEzFMnRI0P+KCUGsgYExwXJzADsEWkTT3V+RGQYW+LXrzKSAWxOt6OjQ
         h+3w==
X-Gm-Message-State: AOAM5303NEdcnVRUazJlC/8A4/DAT6JIrVryvFrXQLM0pIfYc+t3oH+u
        2YGr5/bjj5sN/ytLGSE+lPBQHrOS6vo=
X-Google-Smtp-Source: ABdhPJxPes+uwxZTUg8jaYjZYWMtC5eEBfTkL7HMyK36oLNrYuPLeEMaYhpLPmSCv44aGcn6nLK7tg==
X-Received: by 2002:a17:906:a4b:: with SMTP id x11mr10749299ejf.368.1599761741166;
        Thu, 10 Sep 2020 11:15:41 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id y6sm8636117edj.50.2020.09.10.11.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:15:40 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 06/11] habanalabs/gaudi: increase timeout for boot fit load
Date:   Thu, 10 Sep 2020 21:15:19 +0300
Message-Id: <20200910181524.21460-6-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910181524.21460-1-oded.gabbay@gmail.com>
References: <20200910181524.21460-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware running in the boot stage takes more time to execute due to
increased security mechanisms. Therefore, we need to increase the timeout
we wait for the boot fit to finish loading.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudiP.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index dd222bc128f9..b70b810c21c9 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -42,7 +42,7 @@
 #define MAX_POWER_DEFAULT_PCI		200000		/* 200W */
 #define MAX_POWER_DEFAULT_PMC		350000		/* 350W */
 
-#define GAUDI_CPU_TIMEOUT_USEC		15000000	/* 15s */
+#define GAUDI_CPU_TIMEOUT_USEC		30000000	/* 30s */
 
 #define TPC_ENABLED_MASK		0xFF
 
-- 
2.17.1

