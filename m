Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB77EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB0420724
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="Rg6pnT7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733009AbgF2VTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390848AbgF2VSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:18:52 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DFAC03E97E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:18:51 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c139so16651359qkg.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I8kRZdRWy2CNksnUvA4vMT2OP8+RWTSu608AfsNc9EI=;
        b=Rg6pnT7yfj5lzyQZ8HdjS8EYIb5iXpCetvxP7lOrnqRoZaDYSUrCuIs1gr+r1pOMlG
         E5YZ6C7kjz/ROgjQNK6NMId9M5AMc0UL/6FFdD+m38QU1WqPOGVsIuqcIKYKAAjBklVH
         jKTKlrXj3FzMxdQdyV083PuAk3Q9LGa6bVSTj1TwVxXHSQ8azOxN6ihQh8qjEwswetvD
         hVBdf6ksFfb3azl/a+RsY8SFpU6DSSYO53oaFTcQ4MOZpFEAe9YJJgbh4rvxCDcuQ+ty
         m+F/OeciGyN17eQN/QWpVQBJNlLhLyN6FSHWJ0eyfEJ7JQDoBklpprSbi2xgMJZC2sWs
         MH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I8kRZdRWy2CNksnUvA4vMT2OP8+RWTSu608AfsNc9EI=;
        b=OPbp8GcxaQpIc/yk3oZw/rfgOxfm2bdHWZIOHq7iCKXRstGrAL7TTse0qP99FQrOl7
         j80AHKEeJ1cZ0pLZKWX77Nj4Mq4lFWV+DdnMX/fU0V7jSUJsg2/Tn/jmCPm4QT0AY5O+
         DiZsiAQEp/ADd9O6zQMccr9s3EkGiuStLgcDS4wcLRkbB0qcqPXSd5W1ff+3IdWSCW6j
         ccAvmIpmrqNmrkWLBxDqrR4SYiTGZOUMsg0TFqzPZXn8GJD4PkDoKcYIGtR3mNj7kzwE
         mnqlm5Hbr6m0R90yBsei/rqaDPhsr8vKSEKHFQyyA6dm+KKA2qAmLFM1TmKiJ9PM91e0
         uf3Q==
X-Gm-Message-State: AOAM531Gw7PKEnS70V07nahyGnos7Jsfdcs8vfvUK/NgiU9HnK6AdTN6
        VOfxLc8wGBY0mXRVQ/w4iX6vaA==
X-Google-Smtp-Source: ABdhPJwxd3sF4eWK7ZEDXYCKcDtWgafQp0K5B4mgWjBLrbtRARnR0quNrGVhebTT0Labylj/YCB0IQ==
X-Received: by 2002:ae9:f814:: with SMTP id x20mr16916546qkh.253.1593465531137;
        Mon, 29 Jun 2020 14:18:51 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id b196sm1169078qkg.11.2020.06.29.14.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:18:50 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v2 11/13] dt-bindings: power: Add missing rpmpd rpmh regulator level
Date:   Mon, 29 Jun 2020 17:17:17 -0400
Message-Id: <20200629211725.2592-12-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200629211725.2592-1-jonathan@marek.ca>
References: <20200629211725.2592-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RPMH_REGULATOR_LEVEL_SVS_L0, used by sm8250.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 include/dt-bindings/power/qcom-rpmpd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index dc146e44228b..5e61eaf73bdd 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -55,6 +55,7 @@
 #define RPMH_REGULATOR_LEVEL_MIN_SVS	48
 #define RPMH_REGULATOR_LEVEL_LOW_SVS	64
 #define RPMH_REGULATOR_LEVEL_SVS	128
+#define RPMH_REGULATOR_LEVEL_SVS_L0	144
 #define RPMH_REGULATOR_LEVEL_SVS_L1	192
 #define RPMH_REGULATOR_LEVEL_SVS_L2	224
 #define RPMH_REGULATOR_LEVEL_NOM	256
-- 
2.26.1

