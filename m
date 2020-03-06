Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EBBC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFA52072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="R6V+2Bss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCFNkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:40:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33855 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgCFNkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:40:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id x3so4297974wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E/6gF09OIYAAYDcV57fzVa8XqTwVQognyAPormZwLXA=;
        b=R6V+2BssLDKIwIQo4cQgyU6yIRe9UfLS08WujK48X+C7VGSQBAqjKnkarNeqwMCiMW
         jF639ahQFVkwlVgzDnqnNg/tMsGAKjbHvdd8ZDNi7aq0yqGE+R8Wbq5AIkgV6Qh56CBK
         hJQoYMXlT5pN9Q7KXn7NhRM2vVXqDXWiJs9LqNniwHRfE4L21K0nAfsYvkUpHJFcGavT
         iy9wOPPjefvBcoW8ZZ7gsApK+1vwUXCIb86rvjn7Ggk4FBawo/HlFNC9aN3i4Lbpwl6z
         9nmZw6CFGtsu1GNT15BqtJ9s9mUl4nbvEACcgfLIgj9NfxmQxkVcYy2caf29NzmLCeEE
         eMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E/6gF09OIYAAYDcV57fzVa8XqTwVQognyAPormZwLXA=;
        b=oJ/SkR6vHu6IcKL6cxk/Cn2yoOLJOyEd6QeBYHR+PPOPRBE0nD79WijLFUcXJEmw6f
         ILdXCwqUjK0lvB+EuICOZznKORP62j8Xh+ijF6dy0Wl3XkPhPCCBjU80z1Ap5GW1ww+j
         RSeNgDg65QjadX2zeWdlK5OSpBQ8J36rjIm/FEhlnNLdqGpg1RClavD/b8DQyBNuhif8
         AvXFocct+EH2h+NnGX7PDdO6DD0nCvOprvQuw0giKnJONTx4LtgObcK5pZTTxEte89QY
         /S23dX+U0aT8GjPMwtvB9vIeyI/6GCuaz8+nXabBo2wYppGcsWyUx/fbTKz4IpOdAKqz
         xIRw==
X-Gm-Message-State: ANhLgQ11MWmQ9LN8xF8E/W5yWANTx8ZCYSg57vQ5q9A/k8I4mbgngo1Z
        jcg9rGwu9FUxe+OnHUCIFadw/A0s5lYxWw==
X-Google-Smtp-Source: ADFU+vuUka/yk6YbdJy0yvjTDbB0XaMlyHi/ejIC+Xp7ZZ4NB0EVk8gIlOV2hfAqBcbExLEOdfhv7g==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr4062292wmo.11.1583502049670;
        Fri, 06 Mar 2020 05:40:49 -0800 (PST)
Received: from localhost.localdomain (89-82-119-43.abo.bbox.fr. [89.82.119.43])
        by smtp.gmail.com with ESMTPSA id g7sm47178086wrm.72.2020.03.06.05.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Mar 2020 05:40:49 -0800 (PST)
From:   Nicolas Belin <nbelin@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com,
        devicetree@vger.kernel.org
Cc:     baylibre-upstreaming@groups.io, Nicolas Belin <nbelin@baylibre.com>
Subject: [PATCH v3 1/3] dt-bindings: Document shiji vendor-prefix
Date:   Fri,  6 Mar 2020 14:40:08 +0100
Message-Id: <1583502010-16210-2-git-send-email-nbelin@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583502010-16210-1-git-send-email-nbelin@baylibre.com>
References: <1583502010-16210-1-git-send-email-nbelin@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen Shiji Lighting Co.,Ltd is a LED manufacturer.

Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9e67944bec9c..a463286c3960 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -863,6 +863,8 @@ patternProperties:
     description: SGX Sensortech
   "^sharp,.*":
     description: Sharp Corporation
+  "^shiji,.*":
+    description: Shenzhen Shiji Lighting Co.,Ltd
   "^shimafuji,.*":
     description: Shimafuji Electric, Inc.
   "^si-en,.*":
-- 
2.7.4

