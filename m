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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB34C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E88852076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6MCPOJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgH2IFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 04:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgH2IEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 04:04:46 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E65C061236;
        Sat, 29 Aug 2020 01:04:46 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id u1so1134388edi.4;
        Sat, 29 Aug 2020 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UY44jksmMK7RyH1F4FOWUFZjSe590NscJQi4GJx+zr0=;
        b=P6MCPOJycpd0WE4xiWXLpiyS2dhCn+zUfRvn/bHXDOHLVxisGOmyG0Y4KlBAmF72ee
         agknfYS8IQ/m7Bs5i0oZsWUUP3VjqRGkIu8lP3XM/C7/zJtOyncWXpfySFY2JTjKYvnz
         M+eg0zshELjz4sK33oDpTNcnsStEkbn5zwt2jINK0zdcdx+fuRtNa2aNQo/fw1JVbAx8
         5PL9GdMwaEESGWx7wBFCtcog9txS0vaPwwbKwUVnvpkORucoVzkYKKyrc626nIH5D+n9
         smpl75E+vfb5wRf2D22VBhdYMZA9oJVXAtDX3KLnyLm1QnlC9H4tix2OZ3T8PyiLVfDo
         wp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UY44jksmMK7RyH1F4FOWUFZjSe590NscJQi4GJx+zr0=;
        b=PhmOhPRRcRA7l9C+qJVaLE0vecHFuxvFpnHs09M6IxNWJhqDN6BY8k/mPcH5TTXwQZ
         YwXwEXXV7uICoStjptFcMjf0N9cxkqCtidF3r2NabPLpgguzqeGd7TaxLvRbByLPMeTV
         juAouDRCh5mmfbbcfeb0AiKUw+ejp8Gt0x6QihICdwb59Y+IBWVhviiiRpKRrCzHl1Y2
         qr483UZKzK2kZXTF/Qfrg7fKsBrX6jEPH6MclhrN3/n4LJuMtgASPT+Zvq0iE62YBNBu
         0x3vsflzyDScSz7MhKib501mylHiRL0Jwpy9c5w/0rShl7TKlmgWjSDYw+tqe4UqnlJG
         tcNA==
X-Gm-Message-State: AOAM532AX7gPLyVbOev4xoKpFosoKskBNdJ4L8xdU1K33WE7MHpVN+/Y
        8tR1tyICGPjprt43omgJEFU=
X-Google-Smtp-Source: ABdhPJzMnwvpoSYRqC5lg/gzs6KsEaad6T4ob1i4GZeQH7SI6lSdUebOcTNSL/8W38ekfzPTrg939w==
X-Received: by 2002:aa7:ca4f:: with SMTP id j15mr1146496edt.378.1598688285127;
        Sat, 29 Aug 2020 01:04:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id ec11sm1512036ejb.123.2020.08.29.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:04:44 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 1/2] Documentation/kokr: bring process docs up to date
Date:   Sat, 29 Aug 2020 10:04:27 +0200
Message-Id: <20200829080428.1219-2-sjpark@amazon.de>
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

