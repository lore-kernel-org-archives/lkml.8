Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0E0C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 21:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7833D2067D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 21:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3A+6gm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgGLVvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 17:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbgGLVvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 17:51:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79F2C061794;
        Sun, 12 Jul 2020 14:51:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x9so4596190plr.2;
        Sun, 12 Jul 2020 14:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bRSG2fZqVT4UeuTbHHFbHUXJz86oOqdjBc6h69wvdUc=;
        b=L3A+6gm/qGuAhnjgrHWu0oqNx2eS3AT7oikDojM4JII4c4BgBEIat3m7S10TmxMxHa
         wp/YtZP75apPUfRqIbXxcAMMpurIsfUXXyUce/OA2Z9rXU+Imb7Y5mWh5bylEskNqqDS
         hQrGXgdLeXFGcApZRRrASuE7C1oECkGkygnKn6WyLRRQk1LjT04V95ydK0QMflkIJGVe
         Wnqi6D3SflhQ1XtIZsa4fxXpgT2TpQbx/fteqAArF5MpX1z10ccVGSI4xHIZR+CHfnYj
         Itp04XZAnuMyIjOkoi7Ooz/adD/F7wqmk37Ly4+4iX5jAZOu7YzpBwddnDEJSrA1cbiT
         8QjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bRSG2fZqVT4UeuTbHHFbHUXJz86oOqdjBc6h69wvdUc=;
        b=NHQl5QY4C3z6oqNF9nl3ZFMmJOfsl3/HN7a2j2hRDA/0nkLKsFc+EEH9IZBJQrMP5V
         6TvSW/y7jvAv/9iD9QhgJwariYhwoo33sCuWz8ZlxtX3UK28NmNUiux9WWMFz6GwFp8S
         +ftendQNmuW2G+hIDaTIDxEURrRnuSxEU89QdvZhXmWvuSCrOEFqKBv9MUue1nAR0v6B
         YaW+WIEF0mZXnSB0q8X7InB/w/oa3ho2uXwP7sNfEBCMpphpmXsEM8J+UDhsMu2TXV1h
         x4qDRt2YFxEq1L1cUlcW4I4DtxSA3SG1W0WJ5BW7BkIj1dThvA6A6cEu7fpcdU+QknEW
         K6cg==
X-Gm-Message-State: AOAM530eWKt8N9pqCsKPwimVJjBZlt4uXBU2Z8wuWkXFK0cj9YAuR0d0
        uLjTfDqfiS3PXI0j/c2psqyWcorV3tmspg==
X-Google-Smtp-Source: ABdhPJzq/mlsVJQ8ODerlTyOAvWaF1gJn7w2kQbdx/KvRg3k1SXaWsgUMDIs2/feg500Rkmtx3tDKQ==
X-Received: by 2002:a17:902:bb8a:: with SMTP id m10mr11610550pls.137.1594590684353;
        Sun, 12 Jul 2020 14:51:24 -0700 (PDT)
Received: from austin-fedora.cs.nctu.edu.tw (IP-168-124.cs.nctu.edu.tw. [140.113.168.124])
        by smtp.googlemail.com with ESMTPSA id a68sm12800964pje.35.2020.07.12.14.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 14:51:23 -0700 (PDT)
From:   Austin Chang <austin880625@gmail.com>
To:     dm-devel@redhat.com
Cc:     Austin Chang <austin880625@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dm-cache: document zeroing metadata device step
Date:   Mon, 13 Jul 2020 05:47:00 +0800
Message-Id: <20200712214700.337298-1-austin880625@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200712211045.GA332416@austin-fedora>
References: <20200712211045.GA332416@austin-fedora>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inform dmsetup users to zero the first 4k of the metadata device at
cache creation in examples, just as mentioned in thin-provisioning
documentation. Instructions to use lvmcache for end users may be added
as well.

Link: https://www.redhat.com/archives/dm-devel/2013-April/msg00124.html
Signed-off-by: Austin Chang <austin880625@gmail.com>
---
Changes in v2:
- Correct the dd arguments

 Documentation/admin-guide/device-mapper/cache.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/device-mapper/cache.rst b/Documentation/admin-guide/device-mapper/cache.rst
index f15e5254d05b..16a1c96946a6 100644
--- a/Documentation/admin-guide/device-mapper/cache.rst
+++ b/Documentation/admin-guide/device-mapper/cache.rst
@@ -330,6 +330,10 @@ https://github.com/jthornber/device-mapper-test-suite
 
 ::
 
+  # When using dmsetup directly instead of volume manager like lvm2,
+  # the first 4k of the metadata device should be zeroed to indicate
+  # empty metadata.
+  dd if=/dev/zero of=/dev/mapper/metadata bs=4k count=1
   dmsetup create my_cache --table '0 41943040 cache /dev/mapper/metadata \
 	  /dev/mapper/ssd /dev/mapper/origin 512 1 writeback default 0'
   dmsetup create my_cache --table '0 41943040 cache /dev/mapper/metadata \
-- 
2.26.2

