Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9513BC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA2F20661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2ncpFHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437026AbgAPSs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:48:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38374 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390036AbgAPSsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:48:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so4920338wmc.3;
        Thu, 16 Jan 2020 10:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W6L5M8NGDU85SsLDQmYbLaPSihnBnJlX3fanr790LTQ=;
        b=M2ncpFHVDkDQJXFmSFyILtg5dfcgBMwp+/GDwfV0ypOJ3vRQp74CewosmQhXTj7EdA
         TK1BjIlnP/mh+uYnRk77S/ysqHcbubzppvOap7bkqwZ09LK+pMxYdyA75Yx/NorPI4rj
         XCP+iEcl2TmRooOl3ZAGi1kJcq4tU/dX8636my5k00oyhmBwN5ezSxXkEJjNJjy1u+tY
         wIT+JqJw1sCuCCFy8N2CoaCSW2NM8iJbG4eaWe6UkXTXUn6ydkC3ws3cDEjfilCtqemD
         /1FYY92btOopD1j1Jnv2q90KRWgiddRpdZhIBhXLxm5XGNLmUxJMdlEI51Ecvjls/uwB
         yZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W6L5M8NGDU85SsLDQmYbLaPSihnBnJlX3fanr790LTQ=;
        b=V0owF16lujqJ0riKGVAj19c4pKakKzkjN5PrRwNlV7MWdp/QNbit4j72+KqYi/9PLM
         ksr7imVAFsQ5hj2FE2iBjmimZNFRRVBQ2aaXFY7oTgZrIkSWvjG6OV3e7jEKiTSkt/AQ
         YvootNORMago/yoOBfjJO6ZFqmGd+C1hO+6fWbNmSuVqf8Ek5PX6MI7RryD3xr1Bh7oL
         DYcpRM83rplELk65bSqp35WblYmOErIbwmoSDW56/XPRzfSXdjIu9qCfeV+xvX9iHCW0
         A0o+U7EFH/DVvkTUUbZiezecmB6PLzI2DuLWPakFt9c095SV52KqcyYrs9HJhS+UhhyH
         UMPQ==
X-Gm-Message-State: APjAAAWikHLx8fKDsw2k8+XX8ar+24WljUcISIx8QGkQBqKxQEwUVTnO
        VusnYsA9X1dp6c3JLmqteWI=
X-Google-Smtp-Source: APXvYqxhkMJzX4Sq/b4oFH8dHiEfu0uRVsCPQXLvta8K0yXhLaMLfpTTKQzh6yknwnzeizGJswmEAQ==
X-Received: by 2002:a1c:628b:: with SMTP id w133mr438122wmb.25.1579200529189;
        Thu, 16 Jan 2020 10:48:49 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dbe:4a00:e092:254d:41ed:2e49])
        by smtp.gmail.com with ESMTPSA id n67sm6090068wmf.46.2020.01.16.10.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:48:48 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Joe Perches <joe@perches.com>, kernel@pengutronix.de,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] MAINTAINERS: fix style in RESET CONTROLLER FRAMEWORK
Date:   Thu, 16 Jan 2020 19:48:36 +0100
Message-Id: <20200116184836.10256-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 37859277374d ("MAINTAINERS: add reset controller framework
keywords") slips in some formatting with spaces instead of tabs, which
./scripts/checkpatch.pl -f MAINTAINERS complains about:

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #14047: FILE: MAINTAINERS:14047:
  +K:      \b(?:devm_|of_)?reset_control(?:ler_[a-z]+|_[a-z_]+)?\b

Fixes: 37859277374d ("MAINTAINERS: add reset controller framework keywords")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on v5.5-rc6 and next-20200116
Philipp, please pick this patch.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d2aa9db61ab6..83eae48ad4f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14067,7 +14067,7 @@ F:	include/dt-bindings/reset/
 F:	include/linux/reset.h
 F:	include/linux/reset/
 F:	include/linux/reset-controller.h
-K:      \b(?:devm_|of_)?reset_control(?:ler_[a-z]+|_[a-z_]+)?\b
+K:	\b(?:devm_|of_)?reset_control(?:ler_[a-z]+|_[a-z_]+)?\b
 
 RESTARTABLE SEQUENCES SUPPORT
 M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
-- 
2.17.1

