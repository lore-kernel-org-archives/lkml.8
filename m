Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8724CC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577CD2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="GlLQA9Jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgDITwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:52:04 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39700 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgDITwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:52:04 -0400
Received: by mail-qv1-f68.google.com with SMTP id v38so6157946qvf.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 12:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurabindo.in; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANUP3YZD262275//lsq8+uVDyv1HIJJWCv3ypaHwBe0=;
        b=GlLQA9JruJ0tDP/ebRypZKl/ikKfEo+JOM90JdeHPdeBOcNiPWMJwSr+1YolmG1PS+
         7BYyw1Z5icRcs2+3+zYkCpLVRyI5xw/37dDee8aasMTWGvfj9OwyQ1iZcCFzncHcAUXa
         FKmkv3176CI2m4sZUFc0SDaXmnL0cMN6cHmjCUgGgdxAkrwQ1SUtqGWeqOC3r5Bxm86G
         /CxxfmOPFgbBWu/m0gZe8ZAZhukFxLcThVq0BLH4htf0rI4KefXWDriScFhg0w4FdfsB
         bLX3tZSFEIVVfiow2ouIXVBo4E5sehfdl3M88t/3KVgUu0r5BV2nrxI9/Dk0IeQfT6yr
         SO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANUP3YZD262275//lsq8+uVDyv1HIJJWCv3ypaHwBe0=;
        b=qRkIo2A6a6CtkZMrrNtt3O1uRZ2YJEvGNBK8aHhjvQ3nW7kMjhKBi8H6eJrTG5edZk
         blyvJkeqzgyN+1Ygk2kopobp8gbf14uhdCscaJZD0iLn4Q2Mt5BF/h/7TwnI1GW+TMAu
         4uNNbfM+EABhfhKUFcvDEiTuLXw3YT7VPLWnfZXKp0C9y1Nd0IuR851k4Q6tp/4FYT+j
         hN0aLGDgKk2YQVglk/i8X85E1v5SwA0cftMJ6PqAh5cdsU5N4Rjjq08JUCcFTuiBkvkx
         udxzVHb6PyK/Fa1uUvB0rYrEmyZ4TfdSU6GMIs1pQaGoryNs4e2FpiR0tNFEv6S9EffP
         5Plg==
X-Gm-Message-State: AGi0PuaUbhTWZA90hPV9w4YrQPmLqbkjMNlYn8lLt+AYGKJwHt7/knjV
        iXGcAUbvCzKE5WohtewL5IrZWg==
X-Google-Smtp-Source: APiQypIARh6HRTAFS+noiNzYrXQBRkmIJ81vsg5CL3eyh6tX29IaEYqtTVgI116gGUn3k6ptFSFPOw==
X-Received: by 2002:a0c:8326:: with SMTP id j35mr1792441qva.205.1586461923828;
        Thu, 09 Apr 2020 12:52:03 -0700 (PDT)
Received: from localhost.localdomain (135-23-249-169.cpe.pppoe.ca. [135.23.249.169])
        by smtp.gmail.com with ESMTPSA id 189sm19775200qko.123.2020.04.09.12.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 12:52:03 -0700 (PDT)
From:   Aurabindo Pillai <mail@aurabindo.in>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: dpcd: Print more useful information during error
Date:   Thu,  9 Apr 2020 15:52:00 -0400
Message-Id: <20200409195200.5483-1-mail@aurabindo.in>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DPCD access errors occur, knowing the register and request
associated with the error helps debugging, so print the
details in the debug message.

Signed-off-by: Aurabindo Pillai <mail@aurabindo.in>
---
 drivers/gpu/drm/drm_dp_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index a5364b519..545606aac 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -257,7 +257,9 @@ static int drm_dp_dpcd_access(struct drm_dp_aux *aux, u8 request,
 			err = ret;
 	}
 
-	DRM_DEBUG_KMS("Too many retries, giving up. First error: %d\n", err);
+	DRM_DEBUG_KMS("dpcd: Too many retries, giving up. First error: %d\t"
+		      "address: %x\trequest: %x\t size:%zu\n",
+		      err, msg.address, msg.request, msg.size);
 	ret = err;
 
 unlock:
-- 
2.26.0

