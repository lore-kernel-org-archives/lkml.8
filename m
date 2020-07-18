Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC72C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 10:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F60207EA
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 10:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkapY+La"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgGRKyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 06:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgGRKxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 06:53:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7815EC0619D2;
        Sat, 18 Jul 2020 03:53:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id f12so13454534eja.9;
        Sat, 18 Jul 2020 03:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qnyjF/um+2YYiK5qPE8V6I4qNVycmbw1qA8+p5LbHz8=;
        b=pkapY+LaAJsadMb/9iil5YYiB4qt45BxLP8jBr4/qZcjUnk7/QgKrLuYTgmm5VQPj2
         T1Ft4sWfUqzOf9Witdvv6vIeeIoIdPkiZGH69+nh3WAQTvHtm/U2dffYTeelRSnfgh2t
         9FpGgBVFZroIGxvGgXqjPdbVwBPi1BnuqV+30mYuM8upbPaUQZA7PXR071vLjDAhLSjc
         UtCZ+mznUNMDF8Qxsexa2VKPXLlaJEUnw2UYIBqVHPkYcxOvYvrJs+wdbKLmchWg4nk8
         SIJD8d28I1lIKwZ/+bO9rv6ZMgbMepKbRSSvaROmrShppxzDnG7PRTqi09kk7vGzja4B
         xBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qnyjF/um+2YYiK5qPE8V6I4qNVycmbw1qA8+p5LbHz8=;
        b=pqhcEFuucPfSoz7H78rP2/LFCC40bP8Br+MoN214dSe3M7UDIU3/NgYyTRL0ppV9jO
         vRqh9aH8T602o2rABO1Y8gW/L2o5aStFCoALAJQVd1ebjS0yn+RMb8DFq1RNJ9+w+oFv
         jiD2RYr79V8znwcQlgTyW5GNlOhoJ9CybdwDNxPj9VLdSuI/m7bCrCQI035pSKZDmvUE
         hrePVBbclv9s9ObyXG8hureOX10WH2mDWxjdO/TSBjNEZCeEKVXXNr/18EcB3HWRkO2c
         cMYYCLn+9KPUvjFlb8HgjpAyDCWAAhNESQB4LQLdvqX4Aj/wUzpOe+njUATWRvfEV+iY
         pyQA==
X-Gm-Message-State: AOAM5306/HBH7Jm9EbN9JgwmdD1z+QBDw2KsngFdJUKFL4lDMTzbLcxS
        PMpvb1hWqyFhwXHg49eZp5xWAc1Z3DA=
X-Google-Smtp-Source: ABdhPJy3vMP+m37dlJZkyVfjKou6Tqt9/YVeCE2JUtKFDPsze60yOjmge+nBjbLAAn/pudJLvLC8aA==
X-Received: by 2002:a17:906:144b:: with SMTP id q11mr11964922ejc.511.1595069632173;
        Sat, 18 Jul 2020 03:53:52 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r19sm10776381edp.79.2020.07.18.03.53.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 03:53:51 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: Add vendor prefix for Shenzhen Zkmagic Technology Co., Ltd.
Date:   Sat, 18 Jul 2020 12:53:41 +0200
Message-Id: <20200718105343.5152-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200718105343.5152-1-jbx6244@gmail.com>
References: <20200718105343.5152-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Shenzhen Zkmagic Technology Co., Ltd.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9aeab66be..5ab3d7c93 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1181,6 +1181,8 @@ patternProperties:
     description: Shenzhen Zidoo Technology Co., Ltd.
   "^zii,.*":
     description: Zodiac Inflight Innovations
+  "^zkmagic,.*":
+    description: Shenzhen Zkmagic Technology Co., Ltd.
   "^zte,.*":
     description: ZTE Corp.
   "^zyxel,.*":
-- 
2.11.0

