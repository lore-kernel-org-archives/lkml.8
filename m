Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40E7C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 01:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D1720857
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 01:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="NlMqSZt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDIB2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 21:28:24 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39425 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgDIB2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 21:28:22 -0400
Received: by mail-qv1-f65.google.com with SMTP id v38so4755044qvf.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 18:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurabindo.in; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a8mBf/x6tKmxXEyAN6VSKYHc9JSU+mIaA50Z6TnFau4=;
        b=NlMqSZt8QFI8sd/DDnRRiuydXjaYLzxItlei1QSWHbiyShTaKKSGURBOkhrkk91CxW
         /X+Qgb5kT/Tps0tzjntpYhBtxqSIyEiUAJrD28KSW+Ak6UERz5KiIAuFmidnFOXF3saq
         y5hxwSo82HWB2DKzD+N3OLxUlzmHRmC7x9lEqr/VOOaWRmBSLLr5JZ1o1m2bcGFp2N8K
         CMMceFTqTpBOdT8lUa6F6lNm7O38kfcGVYWCp2tJIxAZHD7mDG/r8vp2SL6SxRNJ0j6b
         ewLTd/FthX6hcv+JmkjXbKfzvZNfibmvWUqRC0qmB1IZrqJkjbZSCFgDsIDSquzFIxOR
         J1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a8mBf/x6tKmxXEyAN6VSKYHc9JSU+mIaA50Z6TnFau4=;
        b=MSMUrJ+CvOnUHe0975JspBNQeFz68TV/klWKT8ZyKGJ5DeDiE1tdM3Kq0q1OQ255sl
         tX3S0I87jl7+1Uli4nLmG5YwMXY3XxQ979S3kJHqx1rWD8VyJSQy2BNLXhEv1N2frqrR
         cftzXeZ38JEVdocYQcq43TIIV2qqICHn0+U59T0mjfundeBOugMCFOS5CHdgFWtXnIl4
         OH+F7BB9kukCvfd48q6M67GxhRZDEfckTgGF0plnp7pLL8puVVGgfeLWANuJWHFTHR+E
         A4nNkfzA8a3FgoSVnv9DhO6sYN38fiWCszHrWDynnyXXFepZox5iZ/1b45RtneApUyDw
         0mnQ==
X-Gm-Message-State: AGi0PuY5hm1u18mX0U0XT21CcCuu4k7h4XozoPpiBCd0YG7Q6PK5OBAI
        gSJb3n1Ugv3Xsn1xhnIx1OpMsw==
X-Google-Smtp-Source: APiQypLHyltpW2woM041SGTay/GRNOYCz+x3AjvXnaurPcRm5EFzWLaZMasX8iJ0rPqFFM0GH+KX3Q==
X-Received: by 2002:a0c:bd99:: with SMTP id n25mr10491345qvg.149.1586395700553;
        Wed, 08 Apr 2020 18:28:20 -0700 (PDT)
Received: from localhost.localdomain (135-23-249-169.cpe.pppoe.ca. [135.23.249.169])
        by smtp.gmail.com with ESMTPSA id h13sm11710186qkj.21.2020.04.08.18.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 18:28:20 -0700 (PDT)
From:   Aurabindo Pillai <mail@aurabindo.in>
To:     christian.koenig@amd.com, alexander.deucher@amd.com,
        David1.Zhou@amd.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, Felix.Kuehling@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/amd/amdgpu: add prefix for pr_* prints
Date:   Wed,  8 Apr 2020 21:28:13 -0400
Message-Id: <20200409012815.22309-2-mail@aurabindo.in>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200409012815.22309-1-mail@aurabindo.in>
References: <20200409012815.22309-1-mail@aurabindo.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amdgpu uses lots of pr_* calls for printing error messages.
With this prefix, errors shall be more obvious to the end
use regarding its origin, and may help debugging.

Prefix format:

[xxx.xxxxx] amdgpu: ...

Signed-off-by: Aurabindo Pillai <mail@aurabindo.in>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index da3bcff61..67d654a89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -28,6 +28,12 @@
 #ifndef __AMDGPU_H__
 #define __AMDGPU_H__
 
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) "amdgpu: " fmt
+
 #include "amdgpu_ctx.h"
 
 #include <linux/atomic.h>
-- 
2.26.0

