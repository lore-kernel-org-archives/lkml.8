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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132F2C433E8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0AFA22B48
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fupKiPbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgGRQwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 12:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgGRQwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 12:52:18 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CF4C0619D2;
        Sat, 18 Jul 2020 09:52:18 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c139so11558892qkg.12;
        Sat, 18 Jul 2020 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWK+OhKM+6E7gTYVTtn/ebABsl1ngVz4xx5O1/yoGq8=;
        b=fupKiPbGDwYlEdciQLhhRJ0X3Sj7k98kWbQ4pV21qENfIGhiUuQe5sxqrtlrnoVTpo
         EXYD1jNTEilHUkeJTr/r3RwI7j28a1cv47xEr13mmDl4HzZq8N90lD8FEGfrH3FnaKbz
         sIZhviMp+FAuVHS1h1H7VtXj3OqPe4gJAYe7dm/995Rt34YxBmH/rZVUlaRMwz0jDYlg
         3GdezsKg59mH/ETXwlgK5f8nzPPZ5++u8Asst6lbnsLwB0Sr7XtAF78rbd3zK0WtupIo
         4rge5/AK/nafOsmV5mGgV305/bv9I9V9xcWBZHo1veZBUUIMy+NPnm4n1qnW46QL0mN1
         9uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWK+OhKM+6E7gTYVTtn/ebABsl1ngVz4xx5O1/yoGq8=;
        b=RfaHlGcuLrKPZ7YErJvHCjGdCGs9Ntp8XiJmxKW+fjs+AtpSH1GrpNBqxOfq1oWoSs
         L5J12TuHt7d/pcmuAuuXWyp/kAXuHBUht15z+g2Ug4eda0I9JBem+YoQ21k3KfNLiggC
         ivNEF67DqqErH+iABjBIWSsK/YDc4gJKbf3B5OZ449IqW0OxBgK9cTKkCfUdtrSOZ0Eb
         RyZiTWw4mXKRZay26RdUMoK6JAPuQS870Ibf+TAHfzShKyxAgIbc2NKvYXdkNKRohoZC
         cy9GPITaWwZVhEDYtB5Gl0lXi5XGN+qI6O4B6fXxMtDQOT4hCz0geETcaDenVCMo1JO3
         vYWg==
X-Gm-Message-State: AOAM530U+euuGD6lDQpV/4FAqOx1PDGL0XHNwyQl6ENXhrA6CZyV1D3i
        AyEBS+NsM7AhglcZFVZ98dI=
X-Google-Smtp-Source: ABdhPJxmhFzlicvnj7HnA2m/x4zSBr7MeZpXnHQ+hb26kZxEoJU7inmS48lkumd8i4Ifiakwr8oC4Q==
X-Received: by 2002:a37:9147:: with SMTP id t68mr13875428qkd.34.1595091138021;
        Sat, 18 Jul 2020 09:52:18 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:602d:16d:d038:1a92:190d:65d2])
        by smtp.gmail.com with ESMTPSA id q5sm15361801qtf.12.2020.07.18.09.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 09:52:17 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mathieu.poirier@linaro.org, mhiramat@kernel.org,
        tranmanphong@gmail.com, mike.leach@linaro.org
Cc:     "Daniel W . S . Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: trace/index.rst: add histogram-design.rst
Date:   Sat, 18 Jul 2020 13:51:06 -0300
Message-Id: <20200718165107.625847-12-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200718165107.625847-1-dwlsalmeida@gmail.com>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Fix the following warning:

Documentation/trace/histogram-design.rst:
WARNING: document isn't included in any toctree

By adding 'histogram-design.rst' to the index.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/trace/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 7d83156c9ac1f..f44794c8fd840 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -19,6 +19,7 @@ Linux Tracing Technologies
    events-msr
    mmiotrace
    histogram
+   histogram-design
    boottime-trace
    hwlat_detector
    intel_th
-- 
2.27.0

