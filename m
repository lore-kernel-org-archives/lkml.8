Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E3AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5CE720702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2u2YFLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbgGAMrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730622AbgGAMrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4400FC03E97A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so23668061wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jvkMg3srHyqJh6fgDfE889EmXjO6nBv1Rtq+H+tpC1c=;
        b=e2u2YFLpA8LpvDLvaHlAIRYF4TjmLrKeAmTHVJZcWeakRJrp85FcAGANacHaeC43IE
         GwT0zARyiqQqJkx2Z0jikJGsiPsqyVH6E6KLJN3pF7P+VJ6Boi9Bw2GF7/CYiIeZb1gm
         yAuuqSK20elxyeP0Nlf612iMeF7pF+IeCeAo8RRLLm05q9EF5rHY8bH+hhUcOr/LOOoE
         ChoJFEuj9WxUbgNvpCUXTY3AxUIt43te77sTOfpALDyw8aU4ycLu8q/k6yLPD/1A5i4H
         G1YxImumTxqHp8cEv/qHa1thvJ7T1IcJQ9dCxQwSWR8BABPukm8QzuVXPU4l/W766fZS
         7pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvkMg3srHyqJh6fgDfE889EmXjO6nBv1Rtq+H+tpC1c=;
        b=VHlfJV9dmeD6QAkSUGzJymg75NryqnC3PIR89fg1w18z/5N0gSLjarOVlhLmjcevxO
         nsOMTm9/UINxXto7cOE6fn/aBjnotkVKB0fohXRvu8Jhn6Dd5Xr1URjQQOO304FKVS0m
         kxmasDxWdTLQPFiFCghKqi8o6K7KUB8ttluhBjwPcI0dyc3O6NUdcC9LqySesAtlZwok
         XK4uK7aBvmGd8aN4Aopz/au5++Nq3TIZUsdZUy0k8Qpc89L3zR+eiO4GyzZ2tbWIEJG1
         9SVcrlMxCxPvjzWWk/ZH4cnKuTkwyAXginx06lfx9Acq1Mqh335EedRo46nlTZ2STAxe
         4P4Q==
X-Gm-Message-State: AOAM531wjVwB4vjemJCqp4dwWfsxYHmSHBxBUHzOUp4ezORlEDvujs5k
        mBbq1OTZ6K4h1l9uAABlsa1c7kqyrPs=
X-Google-Smtp-Source: ABdhPJwDlLXVXyGj9D0oFqPhwo60exrY7bLbST3n/Wr+UX1G4tJFRxrcFA/CqPK08eQzMC2jmrnXiA==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr25932837wru.8.1593607628989;
        Wed, 01 Jul 2020 05:47:08 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 02/15] mmc: core: sdio_io: Provide description for sdio_set_host_pm_flags()'s 'flag' arg
Date:   Wed,  1 Jul 2020 13:46:49 +0100
Message-Id: <20200701124702.908713-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701124702.908713-1-lee.jones@linaro.org>
References: <20200701124702.908713-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing kerneldoc entry for sdio_set_host_pm_flags()'s 'flag'
function argument.

Fixes the following W=1 kernel build warning:

 kernel/drivers/mmc/core/sdio_io.c:722: warning: Function parameter or member 'flags' not described in 'sdio_set_host_pm_flags'

Cc: Pierre Ossman <drzeus@drzeus.cx>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/core/sdio_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 2ba00acf64e64..b5dd893bbcb6f 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -709,6 +709,7 @@ EXPORT_SYMBOL_GPL(sdio_get_host_pm_caps);
 /**
  *	sdio_set_host_pm_flags - set wanted host power management capabilities
  *	@func: SDIO function attached to host
+ *	@flags: Power Management flags to set
  *
  *	Set a capability bitmask corresponding to wanted host controller
  *	power management features for the upcoming suspend state.
-- 
2.25.1

