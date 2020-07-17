Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41969C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D902076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOKWHDXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgGQS6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgGQS63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:58:29 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15486C0619D2;
        Fri, 17 Jul 2020 11:58:29 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id m9so4704459qvx.5;
        Fri, 17 Jul 2020 11:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=407sI7tDkkcS7hnHew6iLrde/ox7y6OHMpz2jDsv8WU=;
        b=iOKWHDXyUKkbTZEupx4H1TXquLQ+HEDyuPBlq1AlvUzLJamZ8if/SPKc2diyuFFxzP
         swInkmuncSuqi4pyOrjoNGQP5RIuYRWI6xagSWqra6gaS/323qlDdFjw5I8wK8T3XbVy
         zw/d/qTpjve5yqqyA2wB5iUHf0XlyU7tOUjGD8MgcTFn06b8/WI0MVV+NZ6YwQP4Kv+H
         ZMKT9FohOHh63tbOA9WTABerr2kUnBtwKwPc6iUt3HR1A2ojc30Lluv1F9ZHegYjfaOQ
         RkZ2Z0R5lUW00lrWzkdS9pRN7Wk8OTOd2gfWkHZoQEcPBLeBxYcbOau/y6bGO1TpW7bZ
         +5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=407sI7tDkkcS7hnHew6iLrde/ox7y6OHMpz2jDsv8WU=;
        b=s+MIX7vrbWdgXajPUfXodoSVVy+4ywWiKS2aQrZrvbAhLuLcmVupP5Rf4dBj5GXx8W
         Pfs0Yv1XSz13fR63NZzY8LdRUuj6x+yw1wJU3bzVsr42pgV3zxCMs9zaGEI0eKl+xYWM
         9bxQKCR/NDIYNqIQkkXqqPP8I1G/sWYLyRVcNupOfzRJDbhw0xVYTXXJVKpmFy3S+Tkm
         W1Oe2S0JC57GhhyNv+0RANp3wcD5uJRnkMDr5bj9dBlFgNlzk4unqKqKNlNKBk/ZbXuF
         XB/MQDRV84ySciEEnybawhGq9AuR2WC49I/VIZg59X0h+/VedrKGVyISpbE+TY0kJPv7
         nR6Q==
X-Gm-Message-State: AOAM533MsGNCt3GdkLRsuwnertBNyTX3JToLiUBLar5hqRJ67sKaAc2T
        XDaxZIm5KNy0HRQfkflFA1Q8MiRXQx0=
X-Google-Smtp-Source: ABdhPJxSrKECrPTW/aFWa490oIZjJRC6pfEGFZQKO5fHJWySRx++ksrSHAfQNTaF4XP1gIfODQy8dg==
X-Received: by 2002:a05:6214:13b4:: with SMTP id h20mr10312796qvz.248.1595012308289;
        Fri, 17 Jul 2020 11:58:28 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:58:27 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/25] Documentation/bpf/index.rst: fix sphinx warning:
Date:   Fri, 17 Jul 2020 15:56:21 -0300
Message-Id: <20200717185624.2009393-22-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warning

Documentation/bpf/ringbuf.rst: WARNING: document isn't
included in any toctree

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/bpf/index.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 38b4db8be7a2b..0f60b95e83c40 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -58,6 +58,14 @@ Testing and debugging BPF
    s390
 
 
+Other
+=====
+
+.. toctree::
+   :maxdepth: 1
+
+   ringbuf
+
 .. Links:
 .. _Documentation/networking/filter.rst: ../networking/filter.txt
 .. _man-pages: https://www.kernel.org/doc/man-pages/
-- 
2.27.0

