Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59914C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 08:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B4F207F9
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 08:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXoVtgJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgFFIiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 04:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgFFIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 04:38:04 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EF3C08C5C3;
        Sat,  6 Jun 2020 01:38:02 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c35so9301726edf.5;
        Sat, 06 Jun 2020 01:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U+mZMH7FZT8/XDSN90bizQnNTdFgeLrPvSbFGEBIcJo=;
        b=ZXoVtgJW9HaOKOdiTNRUlO/fYPFU+K4Ji4FBaE8E1PlsjaLrIz98H/jL+JaYeGvg28
         bIl0uXXTdIGrC2GRP6D9XrXwZjlYB8QkT4/H3GU2FrGHQ1+RNNV9/D3Cvu2B5Lh0ok6r
         qarjPzmBvDWP4BjARLo4XjeBiYKTJvEKmSrd+i8Tr0N9xk/a5rcKxBBGfAghB8xSBFCB
         AOX+95E6fkmpXkGDIm0ZFxN7YOBhomCT7EkXV+VJO4p2bqU9IIqEW9Hstfpxes5L13JQ
         uk8c6fEZHPkYKq4SS7pC3i5+0671lOKkCUAdhU8w4uz+S1eReffPTeAd8kTdgYhemn9D
         LwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U+mZMH7FZT8/XDSN90bizQnNTdFgeLrPvSbFGEBIcJo=;
        b=FI+LSUXidmwxEC0ZlHA3oATYFMcNQZhPtBGmtq0oek0LArF0C3NaM0BJ/9FuCwJn25
         SYgFZjbAjHkMwbnAeROOiGQqwkSYhhD6c5sWsEJ4pwo+AB1XS/gFbdpfhCWhEkf2dtoU
         s5EqX73ax+b19wCFUg4p3cbMoWVZw9OyWz0LL4cZT+R2GNlU7g4J+ciEcCZLjMEYpzBt
         l1OI/Zt32CbGNQoNPtgK2hJ54/zdz9OUqgm/rNq41erEwOlttEnSFrsNFdJD4cHfsYlK
         bdu3chA1hT1kVuR+7zXq48CgaQCbWf54xEEtGWtGSW29MxQGrfHG0gVf3/it7F9Hibtg
         6EAg==
X-Gm-Message-State: AOAM533qWQQT71umbwx10S8sEJ/HfJASpSdRDeoWK5DdYv86w0g+kkLY
        Oz5pHKYRDqhN8qSmIo83hdwRN91U
X-Google-Smtp-Source: ABdhPJxtqWd1EEMgXjTYYraJgnUhL4ABolgArVH5GMZiLm1nR99OWZjf7PijLYaGEFfnk/hMqC431g==
X-Received: by 2002:a05:6402:30ae:: with SMTP id df14mr12643516edb.310.1591432681267;
        Sat, 06 Jun 2020 01:38:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:18e0:2e8c:fd0:e5fb])
        by smtp.gmail.com with ESMTPSA id c17sm6174320eja.42.2020.06.06.01.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 01:38:00 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH] docs/memory-barriers.txt/kokr: smp_mb__{before,after}_atomic(): update Documentation
Date:   Sat,  6 Jun 2020 10:37:46 +0200
Message-Id: <20200606083746.20869-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate this commit to Korean:

  39323c64b8a9 ("smp_mb__{before,after}_atomic(): update Documentation")

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Yunjae Lee <lyj7694@gmail.com>
---
 .../translations/ko_KR/memory-barriers.txt        | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 2e831ece6e26..b74c32d7c584 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -1842,12 +1842,15 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
  (*) smp_mb__before_atomic();
  (*) smp_mb__after_atomic();
 
-     이것들은 값을 리턴하지 않는 (더하기, 빼기, 증가, 감소와 같은) 어토믹
-     함수들을 위한, 특히 그것들이 레퍼런스 카운팅에 사용될 때를 위한
-     함수들입니다.  이 함수들은 메모리 배리어를 내포하고 있지는 않습니다.
-
-     이것들은 값을 리턴하지 않으며 어토믹한 (set_bit 과 clear_bit 같은) 비트
-     연산에도 사용될 수 있습니다.
+     이것들은 메모리 배리어를 내포하지 않는 어토믹 RMW 함수를 사용하지만 코드에
+     메모리 배리어가 필요한 경우를 위한 것들입니다.  메모리 배리어를 내포하지
+     않는 어토믹 RMW 함수들의 예로는 더하기, 빼기, (실패한) 조건적
+     오퍼레이션들, _relaxed 함수들이 있으며, atomic_read 나 atomic_set 은 이에
+     해당되지 않습니다.  메모리 배리어가 필요해지는 흔한 예로는 어토믹
+     오퍼레이션을 사용해 레퍼런스 카운트를 수정하는 경우를 들 수 있습니다.
+
+     이것들은 또한 (set_bit 과 clear_bit 같은) 메모리 배리어를 내포하지 않는
+     어토믹 RMW bitop 함수들을 위해서도 사용될 수 있습니다.
 
      한 예로, 객체 하나를 무효한 것으로 표시하고 그 객체의 레퍼런스 카운트를
      감소시키는 다음 코드를 보세요:
-- 
2.17.1

