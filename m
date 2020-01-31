Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23177C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C44214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9b11W5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgAaUxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:53:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34070 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgAaUw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:52:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so10273229wrr.1;
        Fri, 31 Jan 2020 12:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NytGLiAbgaIenPPBzIa6Br9kKd1BuxX95HeKI2bqq58=;
        b=j9b11W5jME+kkKjEPJ2R1XsUse01oaQ8qzWomH4PrMsriLs27sj+yo8tz4iOVN8b34
         h3AGXe0A222+nwudVFMgetGbclQCXQg/Dk9ee8gGCUu006AKcvJ+V2SK801Jg2xI2nGL
         qa1welFMjZ27my7hXKYLaLlBx+L4E2NPV/7eJxmXc+fEip6OQipKrl1weAJ+Y+c/Wsm6
         AjzGrLC3s3f0I9WAMrbS+MhJ2tShnbrsqFJkBujloTbJFYwsvKt9h/0No0gjf+rl5UaW
         8lXmlmfGMQk8kRkswh+p8e8aH3Cv8dHF5cjSMn19IW2yJO+mhFn/kfPyOXjUnR7lsb2S
         aWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NytGLiAbgaIenPPBzIa6Br9kKd1BuxX95HeKI2bqq58=;
        b=WE0iS2hXLOm9a/I4dbTHhOn96Wcuc8z31IozpOA02q6FbQmHTvV25sMz8+SYkP/PAh
         kvtW2U8t7Yq0ChxfXYqzgcDUz9eRZozmZmU5q25y0lNQbHO7UyDy7qRcv3u9g5frqBg0
         I3b160DbAUqlfutEh3t38v+Ps/Rxmdjsp+pKAsk5J/bX1IwoPV0T5FC4frf6onoln2dG
         RqxoNL7wXpF0BfYozYB2LUlry+O3K/uhgeGRRsd1jpWQ57nM6HtkugpOT7oARnILmsPZ
         AV06l+ZvYUI5yKrsoafjpBBHz2cKbz8X8DN/6z1s7miIwZ0ClQU9geW88WsHE2GnHVmO
         L5Jw==
X-Gm-Message-State: APjAAAVzNunwr00L0q9jhX0Iu7j+5ZcgTx+vIx9HB9V8NU1bQyyOjb3p
        Q1RCBVLynxVeYMyjOWCcfrA=
X-Google-Smtp-Source: APXvYqyfnEa5Rdxl8EZWs4CqHYod6MMT5m2L/o09MDJqeBpTGuGRSExATf+apMOaK4NaBFx2xr6maA==
X-Received: by 2002:adf:fd43:: with SMTP id h3mr229084wrs.169.1580503976264;
        Fri, 31 Jan 2020 12:52:56 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:bcd7:b36c:40fc:d163])
        by smtp.gmail.com with ESMTPSA id z3sm13483738wrs.94.2020.01.31.12.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:52:55 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net, paulmck@kernel.org
Cc:     SeongJae Park <sjpark@amazon.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Documentation/ko_KR/howto: Update a broken link
Date:   Fri, 31 Jan 2020 21:52:36 +0100
Message-Id: <20200131205237.29535-5-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131205237.29535-1-sj38.park@gmail.com>
References: <20200131205237.29535-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/translations/ko_KR/howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index 627ce97810d1..92840b7c63ef 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -328,7 +328,7 @@ Andrew Morton의 글이 있다.
 거쳐야 한다. 이런 목적으로, 모든 서브시스템 트리의 변경사항을 거의 매일
 받아가는 특수한 테스트 저장소가 존재한다:
 
-       https://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git
+       https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git
 
 이런 식으로, linux-next 커널을 통해 다음 머지 기간에 메인라인 커널에 어떤
 변경이 가해질 것인지 간략히 알 수 있다. 모험심 강한 테스터라면 linux-next
-- 
2.17.1

