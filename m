Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5A2C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946F72076E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNF0650A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgCRRmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:42:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50239 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgCRRme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:42:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id z13so4455864wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SXYvZUKw48+Ck5Wybv4+Su9NrVtZlX39A1lTy9a75F4=;
        b=vNF0650AC6FtDq0LXoHq3IdM/z961LETQCOwPFrilDlesnvTcHlUvUpgnuuABKIu89
         vcUt9IWuryOXKaIIf4sdK38VBEhbA84Uf1wM1Ank/fSw3I53Qb+9jY2DV8j1xFY8OGN/
         ObbNP2s+SXbeM67fY7tDS1vbb9HW1f29Vu4EZp73FIwYevcVn1UMmPbGEGuhrSrMwBqD
         5kS/3FeEtkU8QImMf92zP7edal013wOMP97NUr0R04F9fcw9ASn2N6uvZwPmslkj8hRh
         BIUsxBjCfXT2ROupoCbtUz+IKCqWcDKOrAjao+tQlzpiRBrzQTm/fdJo+b7RyqFglVV1
         R1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXYvZUKw48+Ck5Wybv4+Su9NrVtZlX39A1lTy9a75F4=;
        b=QfssYPKNyLfRVQ21TMutqPiFy+lI1MEOnStMkIOA8J4py0QwOwAuAmUXFu/rTZvqnH
         ntGTZDHvEIw1I0f7UfQ6uA6IBXY+A0899kcekaVxtLT0aOV5WPz4onXLY+VO2ZZE3zi/
         ThHl6xbELPC9PsuNkCsyZzR+ZcRJiLBpehXptgyNWBYjTm1+rSDQ40YG0JzIWQu2nA53
         G7uqFIIT3pVC2oNCbd9qR5xcpuPr3AFcYHccDr8XrLMRzhvcaXlQi9XDppvqOp8h+Ii0
         aoRGogYb6cYbiXPrBMp3ek7aPtmMfcqIJOXyzrkg4+5/8ZI1z5IsPpVWL4X+4j0YNfsi
         Z2qw==
X-Gm-Message-State: ANhLgQ1iYdcYgAphQkY/RbFfU34PZQ7nUK8MMuhwdLa0wpjjDhMQm9tT
        2z6NGyHWaXX3PABK+niBj7Tngw==
X-Google-Smtp-Source: ADFU+vtKJ52lknJzAyioRURlbAqNI2fcsTUsrCdYnAxXI6ZEw5gSqT4pj0RiVYMMWskZDNC0qn/69A==
X-Received: by 2002:a1c:25c5:: with SMTP id l188mr6650191wml.105.1584553352549;
        Wed, 18 Mar 2020 10:42:32 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:42:32 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>, Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 08/21] dt-bindings: timer: Add X1000 bindings.
Date:   Wed, 18 Mar 2020 18:41:18 +0100
Message-Id: <20200318174131.20582-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>

Add the timer bindings for the X1000 Soc from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1582100974-129559-3-git-send-email-zhouyanjie@wanyeetech.com
---
 Documentation/devicetree/bindings/timer/ingenic,tcu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
index 0b63cebc5f45..91f704951845 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
@@ -10,6 +10,7 @@ Required properties:
   * ingenic,jz4740-tcu
   * ingenic,jz4725b-tcu
   * ingenic,jz4770-tcu
+  * ingenic,x1000-tcu
   followed by "simple-mfd".
 - reg: Should be the offset/length value corresponding to the TCU registers
 - clocks: List of phandle & clock specifiers for clocks external to the TCU.
-- 
2.17.1

