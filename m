Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558A1C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34754206B8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNgqJVtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDSFxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 01:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSFxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 01:53:36 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE901C061A0C;
        Sat, 18 Apr 2020 22:53:35 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u10so5200829lfo.8;
        Sat, 18 Apr 2020 22:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xFwe9ZwouejBf4AlmJwEBZFdUiqcwR+jV5dE/3vh35w=;
        b=ZNgqJVtzaRN5PPPIigiNaHTejpdnCylOekthURv06SYaJv3P7pn/ERtFEaXtNJhkJS
         BQjAXPCkZdLwMIvT0vKyzuNgftX/NAvH3gQTIM0jxHTob9YST/hWFKXZVr5BwS/mJ3Pa
         +y+FtnEmGgut4ZZBZbMno8QNHja+PqECz4wEdekBD+JYoTX2kKElnvyO+9KxnWLO2qPE
         dqJIkQuFrfmwXcm6G5xjtNk1iZuGTtgzeOtGZAsXr4wS7Vxq1kMJlMkQJukjtVRclJv/
         SjFnfiLpVVhk4WV+MjcWrVg6BVjNdRinozLlSnHnGEOdlfqA0Jajz5CPV8zZE5tT1SUB
         U49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xFwe9ZwouejBf4AlmJwEBZFdUiqcwR+jV5dE/3vh35w=;
        b=ERNGR2AXTVrCfQS+KwytzHnXhVBxrVAHOcsiDaWaxYLFvyO0LpYJH37ICRsp316m//
         WYYG3HK6rQG9K2A0HShciOASbwt4pTV5VAb2kmHCGTfTLbIeSUfhU5byH1dQK7EHrRxt
         ymT9MavgWLKywdF05ylvBH7KQlGJygerhJX849864aelKYszKlMfMU5ZokJs/LDVdVhn
         kXtB/v+sq0UaNUXX9gerZ0J7WKtRYos2EWCssEZUOtiq3zEZvHU/AS0cWRzumm+AxNUC
         cv/DNQWkB5lfeIDF/Cfj8p8i9wl+g96JrFr4znuPh1cQ+jk/4edOxB/nOt0fSaip2uvP
         yYcA==
X-Gm-Message-State: AGi0Pua0/yqaGRJp/DC10Ag+I0atUWqHcQie56FROOdDNw8pylhZwG6c
        ZYQvt1hX3FPO6qYb2GH2wTw=
X-Google-Smtp-Source: APiQypIioYm05i3CpljKQVso1nnH5eeIqBtCIE/EOLm5YSWkwdB6a0iJBxTTdBbfUBFxtdOhly4jTA==
X-Received: by 2002:ac2:4187:: with SMTP id z7mr6678820lfh.113.1587275614312;
        Sat, 18 Apr 2020 22:53:34 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id h7sm3366247ljg.37.2020.04.18.22.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 22:53:33 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 3/4] dt-bindings: arm: amlogic: add support for the Beelink GT-King Pro
Date:   Sun, 19 Apr 2020 05:53:21 +0000
Message-Id: <20200419055322.16138-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419055322.16138-1-christianshewitt@gmail.com>
References: <20200419055322.16138-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shenzen AZW (Beelink) GT-King Pro is based on the Amlogic W400 reference
board with an S922X chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 6bf9bbcf4968..215e0668663a 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -149,6 +149,7 @@ properties:
         items:
           - enum:
               - azw,gtking
+              - azw,gtking-pro
               - hardkernel,odroid-n2
               - khadas,vim3
               - ugoos,am6
-- 
2.17.1

