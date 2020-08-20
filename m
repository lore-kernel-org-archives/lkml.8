Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC1FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B4120658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KDovPjyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgHTM73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgHTM6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:58:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D531C061386
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 05:58:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so1510024wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 05:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Iq37qxt4ApCtNPIQEjJk0Rbx9WzjB2AgIUR9gKuVHQ=;
        b=KDovPjyI1i8eioVe3eJKSfg+aKPguLqoB0+DUyh6iB+vJjv0JVJlMrRxBv4tmlxebL
         m9S/zM3cy/mnIZ4FzSrs1vzamHLVW7FPeFl4PVADYD1xusO4RHh+/5mvg3/l2p3ZiSqW
         nCUuz2f0Y3fDQvcR1sLD/ykVUridBCF2Z1qlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Iq37qxt4ApCtNPIQEjJk0Rbx9WzjB2AgIUR9gKuVHQ=;
        b=jZwuzm+iat+HybvN1PHXLLFSyBpwE7xYSnEyK0GA4wUwM34ki2KtgUyplKpJnAN3Z8
         X09bSNCts8v0S5tCka6ayRNZ+UiwQRMwZABn+9BGSdrvsVsaf6XbImOrQ5vURW7cTT2G
         Xu8fBCAg8IX+yRW7vBR1/UX0RrDzPNwkkSyhcIh8MMUqNN1HtQvKS4PlKWhxSyxbiXDM
         w/iS7AJ/3UqPg3+xwaXR/+kAmy+JJW6HpgHc0pT2BnBdkT6eEHJN6OBAUU1Jk8gBFeqW
         zm10s9Fq7bYxgtKWW6RRIejMv649W5bML1RHxEfRtuG8l+L7mYg+XAtvtn82x0il0KCb
         VGkg==
X-Gm-Message-State: AOAM531rTvmG7B4ZpXSVswB5BkPyzJSqknhBwYUYJBQU2DQn3jSc7p2t
        f2lIyg/eeTN/SgnlP6Yvu45Qbw==
X-Google-Smtp-Source: ABdhPJxseh6U+kNgHzIrowaWyWZqFtWENlrz7ury1P/hngomKwWsWutckSMM8O0q1+QqbpHhh+2FGg==
X-Received: by 2002:a7b:c4ce:: with SMTP id g14mr3574056wmk.51.1597928310544;
        Thu, 20 Aug 2020 05:58:30 -0700 (PDT)
Received: from tfiga.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id o66sm4517760wmb.27.2020.08.20.05.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 05:58:30 -0700 (PDT)
From:   Tomasz Figa <tfiga@chromium.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho hehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        =?UTF-8?q?Pawe=C5=82=20O=C5=9Bciak?= <posciak@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Pawel Osciak <pawel@osciak.com>,
        Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH 1/3] MAINTAINERS: Make Tomasz the main maintainer of videobuf2
Date:   Thu, 20 Aug 2020 12:58:23 +0000
Message-Id: <20200820125825.224788-2-tfiga@chromium.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200820125825.224788-1-tfiga@chromium.org>
References: <20200820125825.224788-1-tfiga@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz is the most active member from the people listed currently in the
MAINTAINERS file, but is currently listed as a reviewer. Change the
entry into a maintainer and move to the top of the list.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..8623365ad0d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18297,10 +18297,10 @@ S:	Maintained
 F:	drivers/media/platform/video-mux.c
 
 VIDEOBUF2 FRAMEWORK
+M:	Tomasz Figa <tfiga@chromium.org>
 M:	Pawel Osciak <pawel@osciak.com>
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
 M:	Kyungmin Park <kyungmin.park@samsung.com>
-R:	Tomasz Figa <tfiga@chromium.org>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/common/videobuf2/*
-- 
2.28.0.220.ged08abb693-goog

