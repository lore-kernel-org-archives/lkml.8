Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFD1C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4652076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwuRFi8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgH2IX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 04:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgH2IX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 04:23:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F0DC061236;
        Sat, 29 Aug 2020 01:23:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c10so1147750edk.6;
        Sat, 29 Aug 2020 01:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jtqbviuBRXiV+075fJRtM/ZbwqVFrctM1n/ZmaFUIhc=;
        b=IwuRFi8s8D1wqyG2+4rckTLKe1W1JHz2aqX28zVpmkdNILpdQbmkSN3pxjB5i48GEI
         Wr2S7wrgX7Z8+3pn9FIbltSiI7nYapSrKwiz4hc9qzu2wc8euSnH4kmi3potTNUjWdkg
         VNt8H0WMziY6J6QGg1imGLcZmhvz635pBqfMN2//PciB65F7QejhOJ7Lb/tuMnUPP4Mq
         n7Y654HK4/2QPJmeZ8vFyOTRNv3kRR2zXmkb42vJB4i29sGUtZLF9Xt7wF6O+jfLBOW8
         HddbP8u3+TP7iHItBuqOKQxVMB5rxL9itDGq/KTtG1NkGge0GrYREKv6Z5eVKwbp8DIr
         b7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jtqbviuBRXiV+075fJRtM/ZbwqVFrctM1n/ZmaFUIhc=;
        b=DEpFGxq8G7jPjSSDDgjPCsYt5XY3kC5S1Ws9TEln86D5+npMjU3DBNTWzpa+cX/o8V
         0FjH6kZJnRbwdeEdPcjhqiCQHsen7jbLh+GRLTLmolcVUqZ05VhFetZNdEe6KBpwsWxs
         idDL9Mz8TaoLp5C8oBMo5muRuDzMeQQY6NRJCnaeIy98aVFhCbRYs6XNzJy0q0EcSGNQ
         G6lbO8NHCxH+o1VjIFqtRaLGcYP4Jh40CZoa8HBLWtbNAYvMPh2/Vw0DN8uWNSZOF13+
         PFeq2iOVQgDxTXSycMtPKYjDKsRBC7o3qVR49BQ/HMTxVhB0OVA7h3sAGGwXggM6w66N
         fTAw==
X-Gm-Message-State: AOAM5313zpAUL7FDyTPBI8hKsfKEX8vl4pe2rqTv9CvphPmuERHd0RJC
        VqMzWFJydhwnADiwaQWS72A=
X-Google-Smtp-Source: ABdhPJyh6M/iseLbc4KgG0PvDRaJpBJcZbY4DTgdLS/7XRVxvy0W5EFphR8nOVMxnUGLXCxAd/ZJVw==
X-Received: by 2002:aa7:d284:: with SMTP id w4mr2665816edq.258.1598689434597;
        Sat, 29 Aug 2020 01:23:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id o8sm1589184eji.34.2020.08.29.01.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:23:54 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 1/2] Documentation/kokr: bring process docs up to date
Date:   Sat, 29 Aug 2020 10:23:42 +0200
Message-Id: <20200829082343.2979-2-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829082343.2979-1-sj38.park@gmail.com>
References: <20200829082343.2979-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Translate this commit to Korean:

    fb0e0ffe7fc8 ("Documentation: bring process docs up to date")

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/translations/ko_KR/howto.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index 71d4823e41e1..6731378bd842 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -286,7 +286,8 @@ Andrew Morton의 글이 있다.
 
 3 자리 숫자로 이루어진 버젼의 커널들은 -stable 커널들이다. 그것들은 해당 메이저
 메인라인 릴리즈에서 발견된 큰 회귀들이나 보안 문제들 중 비교적 작고 중요한
-수정들을 포함하며, 앞의 두 버전 넘버는 같은 기반 버전을 의미한다.
+수정들을 포함한다.  주요 stable 시리즈 릴리즈는 세번째 버전 넘버를 증가시키며
+앞의 두 버전 넘버는 그대로 유지한다.
 
 이것은 가장 최근의 안정적인 커널을 원하는 사용자에게 추천되는 브랜치이며,
 개발/실험적 버젼을 테스트하는 것을 돕고자 하는 사용자들과는 별로 관련이 없다.
-- 
2.17.1

