Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9E7C2D0F1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C0A2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gucp0oNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbgDAKRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:17:39 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:55710 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732006AbgDAKRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:17:36 -0400
Received: by mail-vk1-f201.google.com with SMTP id t206so7915820vke.22
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 03:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bqlNdECR01eLEMLPFpBUwIDjw5hjyGCsJb8UrwtQ8N8=;
        b=Gucp0oNn9xVn8KAbK0ZLd1fAjM5CHK9gumkh0dBMYtFotegI2VGiYKMx32uOq5f0w6
         NAGqlNatFyjvpuV/ekiRw5vfJL+xqBjo6bZp6B3F7aOThN8U0oULLFmpocs/RgvN087x
         6OtLMMcvT9isYkeW1FpWFeJO1cdDSSf29OFdcTIbdZMAanOz8/ihu/h4HmZJMmWqS+R0
         3eOfsNVxBZqsCNsom30f5DrCs+1pDnJslKiQbZLU66qf916m9WPh4QUTXcX2WJ87vV6p
         HOiUV1xfXChNBlBnC1UyUUqEcd9Nfyb9WkPu04BoUtNwzYwv6dQgRTqwu+AkLAyzPFqv
         jUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bqlNdECR01eLEMLPFpBUwIDjw5hjyGCsJb8UrwtQ8N8=;
        b=jLV6oiafYLEjc1toa4pXMBJbaeCJk8HUik6I4rMaS0ABgTcuOahffM+2eSaJE564L6
         w3gENXaMIBDj45fKOJNSm8TE45wg2d0OPfZnlhMG0KWf92zvlunyeszjzHX+q9eX92vG
         /CkoyahWbyVOiao14pgFpvghT8DMf9ZubVejCX/XHspvlRsR+EyBgitVm6D4oIIcb4hJ
         JJX7bdEmX5zOc18h8iuMiX5ogWFk8AypYk+eKM974iELiZ1Rpsst9jthdfIYS+U4KUw1
         4HbBxX126Ffoe3WceAJpj3rZ+NBy9vpP89OBupHky7r5bDjKuERt9WTHsCNYFBkcInzb
         iQgA==
X-Gm-Message-State: AGi0Pua9pOpkzEZthYHGncogqdUanpzxAZnherBMLwz+BKl8b88vSun9
        pQzr++MVIzzAa+RXWbNtbyoVNPGTkw==
X-Google-Smtp-Source: APiQypIRQDZYQx4QlK0W0hkuZ1CH69h1mXN5TDxQYxV4bkc2PmVzH03xsWjRMdXETX7ZOc5wF/+ScgTH9g==
X-Received: by 2002:a67:647:: with SMTP id 68mr14157321vsg.23.1585736255163;
 Wed, 01 Apr 2020 03:17:35 -0700 (PDT)
Date:   Wed,  1 Apr 2020 12:17:14 +0200
Message-Id: <20200401101714.44781-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH] checkpatch: Warn about data_race() without comment
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warn about applications of data_race() without a comment, to encourage
documenting the reasoning behind why it was deemed safe.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a63380c6b0d2..48bb9508e300 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5833,6 +5833,14 @@ sub process {
 			}
 		}
 
+# check for data_race without a comment.
+		if ($line =~ /\bdata_race\s*\(/) {
+			if (!ctx_has_comment($first_line, $linenr)) {
+				WARN("DATA_RACE",
+				     "data_race without comment\n" . $herecurr);
+			}
+		}
+
 # check for smp_read_barrier_depends and read_barrier_depends
 		if (!$file && $line =~ /\b(smp_|)read_barrier_depends\s*\(/) {
 			WARN("READ_BARRIER_DEPENDS",
-- 
2.26.0.rc2.310.g2932bb562d-goog

