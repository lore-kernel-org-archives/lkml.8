Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6009BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CFF20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+QlbAmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgEOFfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726241AbgEOFfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:35:16 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A7BC05BD0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:35:14 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id q4so1478136qve.19
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DX4XT+k02Ir/KDfouowfMsuBfYhxf4GU86W0BHIaHtQ=;
        b=h+QlbAmrwT3Qk4XUER329GnhkSmrKvVq49brjpGM/uyL/DEiMw6DIaqHwVX6GqCOIB
         TknypZylAeb9WhesT1jWWEO02DyLbugXMPf5rmRsRnZpaiaTUzo1fs0oLRyuhWXbpsjX
         Pm8gJKEfiAsoM8LYcey7kctMNCeL/9WKjacPxTokZ+UIIzANPDcR9JeLWvI6uWYrHNub
         sFN6BSjBRFFZy9Pwb5Gjo8WOwwMO3bxjCGrUOBF46x30sYznw9flhLN/Gzgy35+RvJm4
         l5cZChSPp7ithvlffbtvdVokmYA3Pm1O94rTPKB8RtxdWUkQjt+64irBeKpJWbv5xSlg
         dgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DX4XT+k02Ir/KDfouowfMsuBfYhxf4GU86W0BHIaHtQ=;
        b=OvQn4eAKujtVPq1ET59SHKMQ0ZG6PVVveJA0DoTUwi6Kf+yZif/rlqtIMl5mfchoyJ
         olzVSCmnt6ilhCJlj0DIewzYaJxo6i0jOMBVHM7Q3NcySO8yeGhSSgdPV40huziOTT8h
         uN98Upesa5CZoihAML10EJ3w4rOQagOMikpmIluVxvYoXdeQpwfj5ncm3ol1k8Q22KST
         vVowZebA6bypGJp5aBZX6qdMIbmFx2v8DikGej9Fp12SseHbx9VP+/Yln4Hj76paytP9
         s71uOTXXiz5huJPoFnoQORuH0WV+xOCDq9zn+rWchgPr/ROTwd03hr0LeNKAjWNpqx+3
         sn4A==
X-Gm-Message-State: AOAM5322Yv+85KuyYK54dNWU4ih0gS8ld/OgcxW3ko7/+/fPp8odIrJ9
        YXKdIM8uOY4O+GjnLzIyt/9Ui9ZA2o/IKnA=
X-Google-Smtp-Source: ABdhPJwU9KkQfudVyjXyuE1Z396eMGSwdCB1SS/UClNjOPAmBPGEnfF7OqgDxMbxzOdUKsYQeJryPfZDxQez2Aw=
X-Received: by 2002:a05:6214:42f:: with SMTP id a15mr1851765qvy.170.1589520913709;
 Thu, 14 May 2020 22:35:13 -0700 (PDT)
Date:   Thu, 14 May 2020 22:35:00 -0700
In-Reply-To: <20200515053500.215929-1-saravanak@google.com>
Message-Id: <20200515053500.215929-5-saravanak@google.com>
Mime-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v1 4/4] of: platform: Batch fwnode parsing when adding all top
 level devices
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ji Luo <ji.luo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fw_devlink_pause() and fw_devlink_resume() APIs allow batching the
parsing of the device tree nodes when a lot of devices are added. This
will significantly cut down parsing time (as much a 1 second on some
systems). So, use them when adding devices for all the top level device
tree nodes in a system.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 3371e4a06248..55d719347810 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -538,7 +538,9 @@ static int __init of_platform_default_populate_init(void)
 	}
 
 	/* Populate everything else. */
+	fw_devlink_pause();
 	of_platform_default_populate(NULL, NULL, NULL);
+	fw_devlink_resume();
 
 	return 0;
 }
-- 
2.26.2.761.g0e0b3e54be-goog

