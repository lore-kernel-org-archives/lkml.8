Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520B9C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3043D2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCxKjVqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgH2IFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 04:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgH2IEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 04:04:50 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1536AC061239;
        Sat, 29 Aug 2020 01:04:50 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n13so1099474edo.10;
        Sat, 29 Aug 2020 01:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NScaUaUB/lFvvOsMW5OFZGDv5IzEPsheGuFUDe0DEQ0=;
        b=sCxKjVqXS1qPmF21kWPqjJb/g979i2SuPgYy7RJVKNW7l6SFAllCdCFXgK5mrI9jVF
         CPbrBXifLRVTCwBxnrCWbaJmlg+C4HpY0hlbkM8x4UkFNYzr/O7EnbLtO/wceoL1O67z
         QfwQ7VgU8nSvzRtXoHL38ZoEssZumpESb0h+5Ja3GP+JkpA3F+r3S1bY1F1YB+L9FfM8
         /4fiF45VeeFzqdBuYZJjTMW2KzO9KcEP4yLNc9VFDvF9dfivaTKB1tYskYuwvXKj/9JK
         JGseD9cW8cXTH1qxcjgPvgI0HDb1bTCPCdjLQXYkm9K55b0vwF4/hH2nKcpZl84735MP
         DYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NScaUaUB/lFvvOsMW5OFZGDv5IzEPsheGuFUDe0DEQ0=;
        b=ma75AtkajfG5ip1x4bGzgsZHzdepSa4ba5RZ2rSyHnQhvON+tnvDbjv9rsSCeAa31K
         s5tw0vSBaYKDRKpYPHPvNeI48Ab6THzrXUXkKzUmnm4Xp1/hBxfZuFx9LfYpinZqxJtk
         rfJ3lXforLLlqTFsFhVJu+BG8zw6w/kxZZxJpkjyrtb45bfqnUdcyn5V/rVQQ9Q48v15
         fflTtvFIfFDsWSvMIPtUlfVKYwJWcqojM/YHnp3nXRm1UeFz5apof/1AzRdRleB0mDtm
         vxFc7dtnM4XfnIWWyIIBslmRKfJ1bIZEN4r+8AEiYkf+31zOHD39VRzcWowQfy+U98e6
         9ORA==
X-Gm-Message-State: AOAM5336jDmO+a8uCGNwp+og7hEGmZ4+U5zMD6oBXW03T359mPQz3Nag
        /wMzTOnl9OQwiDg4qCa+o4E=
X-Google-Smtp-Source: ABdhPJwozVWYZA8ThsgkhN7l67eONiDdpyKZ0QRjbnyfqHdv1jNJOD+baUfc6Cfu85Qhbis1IokVCw==
X-Received: by 2002:a05:6402:1d12:: with SMTP id dg18mr2364480edb.183.1598688288708;
        Sat, 29 Aug 2020 01:04:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id ec11sm1512036ejb.123.2020.08.29.01.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:04:48 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 2/2] Documentation/kokr/howto: Wordsmith
Date:   Sat, 29 Aug 2020 10:04:28 +0200
Message-Id: <20200829080428.1219-3-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829080428.1219-1-sjpark@amazon.de>
References: <20200829080428.1219-1-sjpark@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sentence regarding version numbers of '-stable' kernels is quite
ambiguous.  This commit makes the sentence more clear and fix
inconsistent uses of the terms for 'version'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/translations/ko_KR/howto.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index 6731378bd842..240d29be38f2 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -284,10 +284,10 @@ Andrew Morton의 글이 있다.
 여러 메이저 넘버를 갖는 다양한 안정된 커널 트리들
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-3 자리 숫자로 이루어진 버젼의 커널들은 -stable 커널들이다. 그것들은 해당 메이저
-메인라인 릴리즈에서 발견된 큰 회귀들이나 보안 문제들 중 비교적 작고 중요한
-수정들을 포함한다.  주요 stable 시리즈 릴리즈는 세번째 버전 넘버를 증가시키며
-앞의 두 버전 넘버는 그대로 유지한다.
+세개의 버젼 넘버로 이루어진 버젼의 커널들은 -stable 커널들이다. 그것들은 해당
+메이저 메인라인 릴리즈에서 발견된 큰 회귀들이나 보안 문제들 중 비교적 작고
+중요한 수정들을 포함한다.  주요 stable 시리즈 릴리즈는 세번째 버젼 넘버를
+증가시키며 앞의 두 버젼 넘버는 그대로 유지한다.
 
 이것은 가장 최근의 안정적인 커널을 원하는 사용자에게 추천되는 브랜치이며,
 개발/실험적 버젼을 테스트하는 것을 돕고자 하는 사용자들과는 별로 관련이 없다.
@@ -317,7 +317,7 @@ Andrew Morton의 글이 있다.
 제안된 패치는 서브시스템 트리에 커밋되기 전에 메일링 리스트를 통해
 리뷰된다(아래의 관련 섹션을 참고하기 바란다). 일부 커널 서브시스템의 경우, 이
 리뷰 프로세스는 patchwork라는 도구를 통해 추적된다. patchwork은 등록된 패치와
-패치에 대한 코멘트, 패치의 버전을 볼 수 있는 웹 인터페이스를 제공하고,
+패치에 대한 코멘트, 패치의 버젼을 볼 수 있는 웹 인터페이스를 제공하고,
 메인테이너는 패치를 리뷰 중, 리뷰 통과, 또는 반려됨으로 표시할 수 있다.
 대부분의 이러한 patchwork 사이트는 https://patchwork.kernel.org/ 에 나열되어
 있다.
-- 
2.17.1

