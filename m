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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDA3C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 19:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A923206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 19:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy3e2XBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgGLTk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 15:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgGLTk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 15:40:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FC8C061794;
        Sun, 12 Jul 2020 12:40:57 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ch3so5056442pjb.5;
        Sun, 12 Jul 2020 12:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9buC95cnJzujQoCsS6dEnvpWRaAnbJrXb6bBm8BLPgM=;
        b=Fy3e2XBQn0yO2cx1BjAQW2XFbmpDkCUczX/fbfiLRZ6cXWYl6GwzC1eEjn+GHgITfd
         cLRxI4epNGcFL5xD2cDdhJpBhU4iVem/XMM0DLT2xNvoKo0q3k+KO3PutiPYb2ZtycS0
         BZ6Puto71cnDGiVVrnA0YJRkZdSalAHAUAjtPz+nnj/9bJzc52SZfcbjJZ3MuqjFuZe3
         1IOlrsvucOm1kFMTd+m9PGY5h5D7w+FNnV1RVdAlPMItRuex49CO4Z+/VIw8UFh8B/4d
         QlnV8vZMWpQAW5eyhuGWEhwlanDHDAYlixTQqVATeLBFzaJQgzoooTKYEsOczdwS2Su7
         P6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9buC95cnJzujQoCsS6dEnvpWRaAnbJrXb6bBm8BLPgM=;
        b=axXowmFg9zIS5j8zJZx8RKvYKxMceBJDAkzJkHaTxoYejrVQzx21ClJaUYByZ9a4R3
         WcwbuFG0I6lf6Nok+UbKQ8RW5TMdGJDtOB6LTLmFJafe5KdsK9r39g1+JJ9LpOEMR4Ws
         1B3cnsgglBECGF/zMoa8/vYLhGBksralQ5XR9Yzsf7EvduX4AorhUJwlz5wwExcJtswp
         azXj5F9OtJje9bqhIUAAiANMfnttbeqHsQeU3VV8kKJvRvthp69e9Gkd5gkxB6zd6gFd
         6snyR5EobUDazpnkIti6NGoLa12u9ljJfVfa9cH8QmM/QO23Qm3KhH+UMMpuzoHOTods
         WC8w==
X-Gm-Message-State: AOAM531PU3AWQLAwGl2v98z5VD7pg8HEzy/QY0HwC2jQe1SunW8kfcMD
        OpJIczda2ZJ1ntgmmG5fC3g=
X-Google-Smtp-Source: ABdhPJwBZgFDS5BbNuVabr/inCzFSsgd1JbaUvpTumREOnUuorknifA0z738HWJAWGAgT+/UpD4LRw==
X-Received: by 2002:a17:90b:2350:: with SMTP id ms16mr16982933pjb.127.1594582857254;
        Sun, 12 Jul 2020 12:40:57 -0700 (PDT)
Received: from austin-fedora.cs.nctu.edu.tw (IP-168-124.cs.nctu.edu.tw. [140.113.168.124])
        by smtp.googlemail.com with ESMTPSA id a3sm11463222pgd.73.2020.07.12.12.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 12:40:56 -0700 (PDT)
From:   Austin Chang <austin880625@gmail.com>
To:     dm-devel@redhat.com
Cc:     Austin Chang <austin880625@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dm-cache: document zeroing metadata device step
Date:   Mon, 13 Jul 2020 03:40:39 +0800
Message-Id: <20200712194039.329035-1-austin880625@gmail.com>
X-Mailer: git-send-email 2.26.2
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
 Documentation/admin-guide/device-mapper/cache.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/device-mapper/cache.rst b/Documentation/admin-guide/device-mapper/cache.rst
index f15e5254d05b..ef9a82d50d19 100644
--- a/Documentation/admin-guide/device-mapper/cache.rst
+++ b/Documentation/admin-guide/device-mapper/cache.rst
@@ -330,6 +330,10 @@ https://github.com/jthornber/device-mapper-test-suite
 
 ::
 
+  # When using dmsetup directly instead of volume manager like lvm2,
+  # the first 4k of the metadata device should be zeroed to indicate
+  # empty metadata.
+  dd if=/dev/zero of=/dev/mapper/metadata bs=4k conv=notrunc
   dmsetup create my_cache --table '0 41943040 cache /dev/mapper/metadata \
 	  /dev/mapper/ssd /dev/mapper/origin 512 1 writeback default 0'
   dmsetup create my_cache --table '0 41943040 cache /dev/mapper/metadata \
-- 
2.26.2

