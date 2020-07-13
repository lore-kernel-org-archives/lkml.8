Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72058C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD6B20791
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CkZ69wB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgGMOuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbgGMOtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8893C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:52 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so180404wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kYHKuzSRZW2pgI75+9BhMiR0lmiLVyArtYOYZ4zdXms=;
        b=CkZ69wB415MviJkg4zRJn+beBy9bX2MMg9Jisvlhmq6L7OMczSmD5kCqw6qiQV2wWT
         f+bYeNEhbbnIo9rbQQGCRtGcpPc9J53DUlaC2nUJdiJHbN+ccfA0UYDXIM7O+55oNIHQ
         HG4qHvuZ8TPGw2IDsHAQYg9491cBy1xw2wxuUWT3zn+IKivPT5A03cJoZgiJcqJ/q2Mo
         ttECc8UNsz/Ild+2UzIWoM0PH1e57nKUpkTSOqnw6N8/iBA2HJC4ujAEcqubj07ZAReN
         LQgUybSRNEL1PGQNc0yVbgh1P0qIN4dSI2lFMbLfFRRxvxztMSLBnPtoihHOo1FZYj1Y
         OlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kYHKuzSRZW2pgI75+9BhMiR0lmiLVyArtYOYZ4zdXms=;
        b=h+u/egy2CYlWr6ZPcTIVQV0+aQJLjZHYsl8ILE6WosUXIDIwhbzc80LagfALebPh6b
         8wLwh/IOUYCcZ1ARtcYwKhEr3h7gzZLu9ueSuS1eksNz9ORWNybp430KiEovzEolx+GF
         EyBWdgP76W1HlflVsztUZ58i9zJ0THQmcSJcgjWAnMn8/qTFvaHHGVnB22fCaRbB/l7y
         rbFu5bl8hgZ3KVG5NZUChGTah4928LXuqGQ0dSjKuOYNJ6xYFH5soHOB5Yzfa7mvV7eW
         dcJr0tHPHpJaMLdT2wzfNI+H3eGLpVP6ugHQLtzcQgEFIHh+yAODnpsLKWeelH8SRKBV
         +aXg==
X-Gm-Message-State: AOAM530uMmbNAQP/8cpdE9b9Z03doHJtGnEKbZaYI2vh0KW23PykcUxt
        InQ3yi5seTB0BUzlxyi/o0XAEQ==
X-Google-Smtp-Source: ABdhPJz7hrmOvAspGEd4WX05KuXDtMLMHcNxPLhyyfObQj28nOWtLpzcOds3unTAiI6rpPbg7qgr9g==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr315832wmc.150.1594651791331;
        Mon, 13 Jul 2020 07:49:51 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH 17/25] pinctrl: pinctrl-at91: Demote non-kerneldoc header and complete another
Date:   Mon, 13 Jul 2020 15:49:22 +0100
Message-Id: <20200713144930.1034632-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation header for 'struct at91_pinctrl_mux_ops' was missing
entries for {g,s}et_drivestrength and {g,s}et_slewrate.

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/pinctrl-at91.c:77: warning: cannot understand function prototype: 'enum drive_strength_bit '
 drivers/pinctrl/pinctrl-at91.c:187: warning: Function parameter or member 'get_drivestrength' not described in 'at91_pinctrl_mux_ops'
 drivers/pinctrl/pinctrl-at91.c:187: warning: Function parameter or member 'set_drivestrength' not described in 'at91_pinctrl_mux_ops'
 drivers/pinctrl/pinctrl-at91.c:187: warning: Function parameter or member 'get_slewrate' not described in 'at91_pinctrl_mux_ops'
 drivers/pinctrl/pinctrl-at91.c:187: warning: Function parameter or member 'set_slewrate' not described in 'at91_pinctrl_mux_ops'

Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinctrl-at91.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 37997e5ab0538..77e1b9ed3a634 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -66,7 +66,7 @@ static int gpio_banks;
 #define DEBOUNCE_VAL_SHIFT	17
 #define DEBOUNCE_VAL	(0x3fff << DEBOUNCE_VAL_SHIFT)
 
-/**
+/*
  * These defines will translated the dt binding settings to our internal
  * settings. They are not necessarily the same value as the register setting.
  * The actual drive strength current of low, medium and high must be looked up
@@ -162,6 +162,10 @@ struct at91_pin_group {
  * @set_pulldown: enable/disable pulldown
  * @get_schmitt_trig: get schmitt trigger status
  * @disable_schmitt_trig: disable schmitt trigger
+ * @get_drivestrength: get driver strength
+ * @set_drivestrength: set driver strength
+ * @get_slewrate: get slew rate
+ * @set_slewrate: set slew rate
  * @irq_type: return irq type
  */
 struct at91_pinctrl_mux_ops {
-- 
2.25.1

