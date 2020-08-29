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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BEBC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820132075B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8+rGLm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgH2IYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 04:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgH2IX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 04:23:57 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7E4C061236;
        Sat, 29 Aug 2020 01:23:57 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id m22so2106748eje.10;
        Sat, 29 Aug 2020 01:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IpoKm5/3JoLUqPX+Ac824VZnOs1RqTg58WRmSIzzp18=;
        b=k8+rGLm6XT2GrraZQMIDKy6TtpDGS50MHthnB+6MkPd95dtU03y3ldF1O+ekVEoznV
         IGCmbKso5IDtJE3s6NTsw/eAdVK2JscqGFR7vCQwkVizRbeIX+TscuzuUXo1qaFa4jss
         rOpTSWVDVjj+kaI/C3TfvpVrM8UaCcSRnxrhPpDnrLPj8ajjn8jl9POZRgSCcTM/rNCO
         9fjyRndhNiCibqAp/aYlu5qni7+IlS2z1wgurFchiHzlKJMnHuDK4gaYepQpWLEcmI8h
         PktRvzMOG1qS71AVLIQL8l1Pj4tUkL+X6jFP0hBsdGaPfX2NsmQn4yRbLAv6/CLEwnlx
         +Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IpoKm5/3JoLUqPX+Ac824VZnOs1RqTg58WRmSIzzp18=;
        b=Elz43IRM1MfOUgDcV8+ckIgOvYR9kw1Of/l6Q5TVDsLiCaf4O6CCWPctvClpJIXRKz
         pnYJkW3a5hQnHMwaylmjV5JkJ/hk9awpurLVt/+WAbTqM5KQl/kfPAHeodX6sPWgfXnl
         Yqk8g509JcNz0Rje/nBDkVFNKFU1QHGhgc3W7ONq3dot22ENgxQKp/c2GnAbZ/j1mGyR
         AXnR/4iCpypFL2MgdLVdptKWNNAEkZFOzX0BrfcZHcJTwNC0wMVndLvpFJiNt1ZXRu3k
         Ujvvjj8MmCNmBUDqgoAy2Tb06IQel09g+6B9T17wJE6NfulnBkoNriAY9nwtB8AgB+Uv
         ffgg==
X-Gm-Message-State: AOAM532VKlF8r7Zo6LBfZ03Wshs07v7DMWwsQ/jqVKUvjTdiaJN3i6Rq
        SY7NbzCtKUXQ7gkFVbsY9fY=
X-Google-Smtp-Source: ABdhPJy0q+qzuXt7n5SNVSjgDYYz+20FYVL9TnA7KMtI8tfIw56s6nyAMVlHEeGNbvMJ5xmyY/DHrQ==
X-Received: by 2002:a17:906:a185:: with SMTP id s5mr2563297ejy.472.1598689435927;
        Sat, 29 Aug 2020 01:23:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id o8sm1589184eji.34.2020.08.29.01.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:23:55 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 2/2] Documentation/kokr/howto: Wordsmith
Date:   Sat, 29 Aug 2020 10:23:43 +0200
Message-Id: <20200829082343.2979-3-sj38.park@gmail.com>
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

