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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E329CC433F8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC79A208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNN5Buzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgGQS5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgGQS5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:57:17 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C1CC0619D2;
        Fri, 17 Jul 2020 11:57:17 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id u12so8375574qth.12;
        Fri, 17 Jul 2020 11:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CguGr4FHVrPkRGsMeKgPvOrZnbuic3mwstdNwyosH2c=;
        b=SNN5BuzwjfYrZ8GhD3hLMzEHQIGnDjMkQByfOWEyjMYw/u/8x9mS5NlhEQ/WDDPyJA
         OM3zjjIQKKXfyA8AjA6jP+XZlmwMPIvbIxLaEoPQp9MI3xvor2ORmPbPK8BKLyIt5eGY
         jLbheyc+Y7RdFsnlLNHtld28tclIsnvK9XBvDKDCUY6Wx084UpMxo2uDC6dQ75fx6kaY
         Jtig00UhaqwPOMkH7WxEBo0uV5ZA5gVCjx/U72WrDw1Tn916yOuBTmSYDkHBbfO8aArV
         40+73t2M4ERczxsvQvPTLAhj6UjdPjpRad8XaoLHk4E9/l2iYSk37poaMdCthYEZYQ7p
         lvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CguGr4FHVrPkRGsMeKgPvOrZnbuic3mwstdNwyosH2c=;
        b=deTHLtU0pe0Cj/fRRhxCT3G/K90Uo7rjPdlu7BdMgaNBgPerM22kkTZAWfWRsILP8I
         j4CVXicUS9tqq1eMe9g8ALfs2y9W0FhO4akz/CW/Qi9KQFT6OT0OfWJuQ6yf0qziIrht
         sscmOZN2gFdmqPoqABBKDamoYn73wLqwQJrWHXlDvtfYMX0b7LybVS8fAmXc3BBlrOLL
         moynE7MUD5HihYPNW8Tizk1zNYNRNX/4ujMFU4/PQ4dEJDGcPqbgpBMzhX6M9kzvVn59
         Idlj+DmY796d5fl6aD3Exc3pNf4OtoYwO6tu0IJtRlnnvwUUwciy2ZtAOSqMUd8SA4rN
         gOkg==
X-Gm-Message-State: AOAM533DCHiSSCpIWiNYwck0Xi5+KTJd3Xe/p3mQjeYZB76t7TBUqGbi
        xCnkjP449O52YICl6vU28zU=
X-Google-Smtp-Source: ABdhPJw68litj6byZk1enWWXza6gm7E1mPQ1foBGbeWVLRLSi1P6R9NaFHBhboLNX68RR/3Q4gqXrg==
X-Received: by 2002:ac8:197b:: with SMTP id g56mr11969284qtk.105.1595012236965;
        Fri, 17 Jul 2020 11:57:16 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:57:16 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/25] Documentation: rculist.h: fix sphinx warning
Date:   Fri, 17 Jul 2020 15:56:09 -0300
Message-Id: <20200717185624.2009393-10-dwlsalmeida@gmail.com>
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

Fix the following warning:

warning: bad line: [@right ][node2 ... ]

This was missing a '*' at the start.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 include/linux/rculist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index df587d181844b..7eed65b5f7130 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -512,7 +512,7 @@ static inline void hlist_replace_rcu(struct hlist_node *old,
  * @right: The hlist head on the right
  *
  * The lists start out as [@left  ][node1 ... ] and
-                          [@right ][node2 ... ]
+ *                        [@right ][node2 ... ]
  * The lists end up as    [@left  ][node2 ... ]
  *                        [@right ][node1 ... ]
  */
-- 
2.27.0

