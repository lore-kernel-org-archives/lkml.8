Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4581EC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A9A21D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFz3/GaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgIJVRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgIJVOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 17:14:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CBAC06179E;
        Thu, 10 Sep 2020 14:14:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so2083207wmb.4;
        Thu, 10 Sep 2020 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jWW6UX3HmW0Dt+N5OuweWd2CbkDlmY1nY82pjiQoCNQ=;
        b=dFz3/GaLqVtVgNimlyBsMr0QaxlG4q1K/0fyxYmdNovlkI59QvVd3wkeiWRyXHbI43
         0GCdeE9iKQvW6uHE5I2StBD/0g6UOqndpMKn/bIfE3HCcwslUtntP5TWAEYzUvHBIZoG
         ySLKcIK/86ZIGhTq6tRblaHhK8CFJngBXZ8l/fRuWaqoQ/pBa7CDLgcPO1PyxUJuxcNW
         exHctKr3oo0iv2cgiXXZjKQUks110yos+1IArF18vOHHoiJ9TBm8pk9sVcm2ZVo0lgLP
         bkuvoRJynKIVQWevR+sKlUDCA4Sxz9tdk4JXrdcuIIoFEmL0Oc08UrNkKW5BSnV5sBah
         Fj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jWW6UX3HmW0Dt+N5OuweWd2CbkDlmY1nY82pjiQoCNQ=;
        b=IdsIz1vW3cRwG1AMVXzVS1INeY+fPyc5s45wn8cjfVXqCQG66YlRsGdkFOObVQIB3D
         LJfJdru8QhJ8c1xfPU2zeP8248SvVikpk0NzsZScwHf1RnPn2GKCD25jXzLL7PXX6ctf
         wCayJMDC3amdgr2s4GwcmbCk7O/FLT/ce0vaUT2aTng9ieEdBcvf5RSCJXJ1xqagKegW
         eI8YZp46GTu4XSz8IzxHCVeqto0VdjIkXOihiI5VUdQ51k6uMWELcOtgeH9gE9tjvZ3p
         REqU7Zr+UMQtTPSKdjNo5sGEDaTHHSd0UoHPQu6FTYoKy1t9U/6CsOEIReWGFhc+03m0
         kR3g==
X-Gm-Message-State: AOAM531JtjBadzX+KiF9pPVTLea8LotgvZ5oJ+bU3tkvgtA8oDUvgnLc
        jgmB1QipeLRD/STau3HGh8I=
X-Google-Smtp-Source: ABdhPJwR057zEjMaa/YKnQmFSx7cF1dkOuwp0Qr+jr4V8MZRLMH91wPUfuHmNb9cXBBwYjU/P8pEDQ==
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr1925649wmf.40.1599772463252;
        Thu, 10 Sep 2020 14:14:23 -0700 (PDT)
Received: from localhost.localdomain ([170.253.60.68])
        by smtp.googlemail.com with ESMTPSA id l10sm111502wru.59.2020.09.10.14.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 14:14:22 -0700 (PDT)
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Colomar <colomar.6.4.3@gmail.com>
Subject: [PATCH 12/24] getgrent_r.3: Use sizeof() to get buffer size (instead of hardcoding macro name)
Date:   Thu, 10 Sep 2020 23:13:33 +0200
Message-Id: <20200910211344.3562-13-colomar.6.4.3@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910211344.3562-1-colomar.6.4.3@gmail.com>
References: <20200910211344.3562-1-colomar.6.4.3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alejandro Colomar <colomar.6.4.3@gmail.com>
---
 man3/getgrent_r.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man3/getgrent_r.3 b/man3/getgrent_r.3
index 81d81a851..76deec370 100644
--- a/man3/getgrent_r.3
+++ b/man3/getgrent_r.3
@@ -186,7 +186,7 @@ main(void)
 
     setgrent();
     while (1) {
-        i = getgrent_r(&grp, buf, BUFLEN, &grpp);
+        i = getgrent_r(&grp, buf, sizeof(buf), &grpp);
         if (i)
             break;
         printf("%s (%d):", grpp\->gr_name, grpp\->gr_gid);
-- 
2.28.0

