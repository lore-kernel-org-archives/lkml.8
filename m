Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47349C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D3420707
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ytz4kozT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgH2Qdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 12:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgH2Qdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 12:33:41 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FDBC061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 09:33:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so1942331pgl.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 09:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGoI0Ukde5f+T5RdhyoqC2Vyh2NxruRDSw/PCmJ5yyE=;
        b=Ytz4kozTp8JHB3Kr1KqCfEscAfIEhScIPQddPrKNmx3BJLEPqx6qHskUj7R340QrMj
         4iB//fZ+ipdcLk5SskpCsNXy1DQoIBw69MnclHtkZu0SWtlpQCkFJVmhfXBDPrUFjsrY
         LiXUo05Sy4ydXSgEkHxGnGgwxwkU0ITXXzkqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGoI0Ukde5f+T5RdhyoqC2Vyh2NxruRDSw/PCmJ5yyE=;
        b=rbxNqyctjjPttScgXOjqEgFfTB202yBlixW14pdo98Is//MIGtBX1iIbvtWQBKiF5z
         ycFARv+1bwfRmQpSY4nXEEzs3WhaqrhHGqBRrqINTw3v0i8lrXsQ2NBe45uThandTY3A
         cDaghK44CUPIf/7LYX4TPBSTioTM7gue3CIPXwMZOgAg/7JYRyLfUlfK9fKLoR7tM3vc
         ja0yQjTzXEEBrciwTnLqT6l1ASBr++nc0b06Ik8RF6iUo0IMRx3toIAkYV0q17OPCIds
         HR4N8j5paExh5PEBWtcav7qFoaOmLcTbp9BxyM42w2izqFl3zUzSHN/qqkLDRb1xU2ce
         0eMw==
X-Gm-Message-State: AOAM530ryupJzfgmJJchFW0YXO1m+0OWLJnfBO9OM2OuMDGu5LMQIpAq
        PRBVOZGHBdOCbaLcc/ExsUMCzervlJOorw==
X-Google-Smtp-Source: ABdhPJxnRj9/9TzRPftUS0YznqkGB8zAJFCBjQNDnLh2OUsp9vVRDPJtX6C7whEEyjCG5VdhHXX6Tw==
X-Received: by 2002:a63:d14b:: with SMTP id c11mr420597pgj.64.1598718819609;
        Sat, 29 Aug 2020 09:33:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9460:cfb8:90a:fedd])
        by smtp.gmail.com with ESMTPSA id o6sm2457934pju.25.2020.08.29.09.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 09:33:38 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/2] dt-bindings: display: simple: Add AM-1280800N3TZQW-T00H
Date:   Sat, 29 Aug 2020 22:03:27 +0530
Message-Id: <20200829163328.249211-1-jagan@amarulasolutions.com>
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
Changes for v2:
- none

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

