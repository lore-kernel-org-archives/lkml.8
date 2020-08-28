Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF9CC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40D520CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pxyn0T1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgH1QAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgH1P77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:59:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B192C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:59:59 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v16so703294plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rS6Br+S3B2XheGYnh0vsVMxPhFR00mObbIJ1yAl3WW8=;
        b=pxyn0T1rQJWMeU4dPTHRaoMstKXjPxs5eFykfQCEmBJG0HX4+frfFAJZLWBTkS9C+7
         Wsou5DP4u79qFPrcRSG+A9+VopSIJrhoP8tWdblawb2YXaRrtXmLq/XPEDEvBV6RIwDl
         a9rxGq5QOon/H8Wn3xz7W43DXn29/yGUeLWNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rS6Br+S3B2XheGYnh0vsVMxPhFR00mObbIJ1yAl3WW8=;
        b=je++r4C6p11PAbrSvxBuy5+IwULektT9BG1ZjCo0m+jlv+skw1vG8zgSA5F3NgJoiI
         gVxqN9Nba3Fszw3gBxNDpjvcx5iH7sMmXq3BnVpUlwd+VwLUuoY8b91feZfFnJVbrhxo
         cPvwMhX2hs9fTyO3mg1RZbcqb7yqszxEfNzvK2ecfuvV2qzzFiyWQUHQThFZDCkHTgYJ
         httSKsC9yMJNvkvzyW1KEkAo7tAbWu/E5TTICq+UL8sE+MgCGdahn/TiTt6GBtpeqQB9
         xVetS4cF/yumbwuwbvk4IvOITxj8WrvyYF+R0OG4rbG/eJ1FqBoL8srUG7x4kshbOgL4
         keZg==
X-Gm-Message-State: AOAM531eRoc2TZU7tmJdMzOJs8ycrsKnZjwii9Ewm3koK7Xi6SmQWDIM
        z2q6liu7UT05RZn8k/Z9KW/DOQ==
X-Google-Smtp-Source: ABdhPJy/5TUe5e235Wok9fR13sAFnytXVToEAA8QjrE88j1Aha6sZZLEHW5tP98Pju1tC68/jWdUEg==
X-Received: by 2002:a17:90a:2bce:: with SMTP id n14mr1921558pje.20.1598630398312;
        Fri, 28 Aug 2020 08:59:58 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:8ce8:955b:ae1b:d6ef])
        by smtp.gmail.com with ESMTPSA id x13sm2195691pfr.69.2020.08.28.08.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 08:59:57 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/2] dt-bindings: display: simple: Add AM-1280800N3TZQW-T00H
Date:   Fri, 28 Aug 2020 21:29:37 +0530
Message-Id: <20200828155938.328982-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for 10.1" TFT LCD module from Ampire Co. Ltd.
as part of panel-simple.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index d6cca1479633..f629d04f7737 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -29,6 +29,8 @@ properties:
     # compatible must be listed in alphabetical order, ordered by compatible.
     # The description in the comment is mandatory for each compatible.
 
+        # Ampire AM-1280800N3TZQW-T00H 10.1" WQVGA TFT LCD panel
+      - ampire,am-1280800n3tzqw-t00h
         # Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
       - ampire,am-480272h3tmqw-t01h
         # Ampire AM-800480R3TMQW-A1H 7.0" WVGA TFT LCD panel
-- 
2.25.1

