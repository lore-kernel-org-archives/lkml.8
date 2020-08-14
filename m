Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AEDC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935FD207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaeMj5Yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgHNJFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 05:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgHNJFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 05:05:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB353C061383
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 02:05:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k20so7301384wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 02:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRiW1Elr/x8IcnH5oDivRHtQDqhp3psZM/q1XqqJd+8=;
        b=IaeMj5YrQjmeSYlQymZF5ltHBecSzZN1LBxijJpTup6E+ri1rV9KZciVcKE9+xX9Zr
         zqqex1do9T8NRAOAnsvEe9SCUVdbZ5vgkeWNFiAiG5oOe7yf1WJSWeE/+TTjig4g0CGO
         C8iby88ZvVnUaBImRH7Eh7NIiWZJMua5dZnMS9NazDHKFwWL86qsQKyazcNcWOy/4Qte
         /Il56dDTM3YH21sIZOKzgi73ULtlzvxHnV0XL0oaFdfgxA8uY33eT/OkMXFaWg1NaKvE
         NSZx1QF5gZhixel8bKXip8GrL6yzBW82e7yt+3uRV4UR8YcS2SrRRYfiemMrm7SnUYS+
         CywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRiW1Elr/x8IcnH5oDivRHtQDqhp3psZM/q1XqqJd+8=;
        b=t8jJofwjCIYi2JQYfozIf0QtmZrPoEjKWkVMkootGgJknnsIRL1ONRGp29+tOScjE6
         /Kub6hXLWm+OWQCDHwcWCu/aMB8M5I99S5inGofEa0Ojw+C3c+bg7ahdh8AnYRIIZQM5
         23sPQ6cHb/MkrIYtTmn4DqyIYVkx1lX5HyzIl9ZEoeKKf3JnfhOq9+/jWMbK3EmsBRMo
         KpicSvo/qCVZoMI8KQ5Rm4yVCsVsOTk3oeEuOzIVhU5zV36Svr+pwoc8SJN56ZJQs4NX
         i/fmltgT5k8drrW5BEcX+ptTuMhJDE2F2SRfc3ALqSN5Q6OJf9Xge8jGkAt8oKuIu/X2
         wN/w==
X-Gm-Message-State: AOAM53197SXRuQ3W1noAcdz7oG37tJGvhe1lBNts3P9KeDJ8Rsmk/9ol
        gBOs3NjrK4/e8Q1aaH3+zwM0vQLLiNiiLA==
X-Google-Smtp-Source: ABdhPJxcA0z3DyBBeEfPBHlnZCHhDaVgwVd4ie4kjFb6CqHsvDp8ta/YN5s9RU5snoxuowNrYSXomw==
X-Received: by 2002:a05:600c:4112:: with SMTP id j18mr1573533wmi.187.1597395929922;
        Fri, 14 Aug 2020 02:05:29 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id m14sm14046745wrx.76.2020.08.14.02.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 02:05:29 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     cphealy@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/4] drm/etnaviv: call perf_reg_read(..)
Date:   Fri, 14 Aug 2020 11:05:02 +0200
Message-Id: <20200814090512.151416-3-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200814090512.151416-1-christian.gmeiner@gmail.com>
References: <20200814090512.151416-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the open coded access pattern with a function call.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
index 1f0402f7a7de..782732e6ce72 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
@@ -58,8 +58,7 @@ static u32 pipe_perf_reg_read(struct etnaviv_gpu *gpu,
 		clock &= ~(VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE__MASK);
 		clock |= VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE(i);
 		gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, clock);
-		gpu_write(gpu, domain->profile_config, signal->data);
-		value += gpu_read(gpu, domain->profile_read);
+		value += perf_reg_read(gpu, domain, signal);
 	}
 
 	/* switch back to pixel pipe 0 to prevent GPU hang */
-- 
2.26.2

