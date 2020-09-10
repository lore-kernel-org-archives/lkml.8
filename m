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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5A3C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF91221E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa2oLGC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgIJVTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgIJVOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 17:14:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB19FC061799;
        Thu, 10 Sep 2020 14:14:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m6so8795131wrn.0;
        Thu, 10 Sep 2020 14:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLBdHdm5cYk8dfxdkOCuHqs4ImelW6eqd8o4yH+DFEY=;
        b=Aa2oLGC+K0Hx85Gvq7caNDqwpIq7iZdPaXmAGheW4YhF+N+GhDbBF8GFZhn1t/XLvX
         oRPkVlgvjUw9N4twwtvPNmCt1JHJ82iBrqx9458llE/WRLLXiX6CBIAjq4EyLuKNtFeo
         nC4gtDn7kaLad8HsGdnHRl6auLHkB8WhIr3vmskR4MaHsl++0QpPGOA4uZiBreavim6g
         iSs8N31PIa1fEKTDU4RsriPGYgz0/Z6U1UqzQbW9pyaT/r9a0tsjjboBlQkD6qNbZsVO
         Y3xQW+PISO3eFmESexmdjwHBLU4n+aJngAgZ4NVLjjQRjLmuxEJ8K8IzC9YX+pB0CspN
         47Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLBdHdm5cYk8dfxdkOCuHqs4ImelW6eqd8o4yH+DFEY=;
        b=NIr+HZaDMCmytks38e58uCV0AC+inenHu/lvWRpkeorcEJPivoeUogYQ4VhYMUsACl
         qXdf5FjTYHi9kOyPZmy5u77e4UeHitoSIX2u6bKpEr/zFzytqOprO/yg9y4D1STww6+R
         ooMYc4ajVnF1DEQ681ShOTUAyn7Zt1/2yBXmTcJql7ozTvD79Jt9rA7RQLdRWoDLeZ/W
         8MyzCV4jSai9zxYkrmX7feBj61y+B6+e92LgnFk00FCNH1M08T44ENzLHrFaAPRpx8jz
         UceQsIKcq96Zp3XeWke8hapw5OZn9Ez72HQdQbN2oIHm3+vesdOsplxO4xRucFzWgCWB
         yi1Q==
X-Gm-Message-State: AOAM530K8bpIVo66pWl1CNSAYi4uMIyX5VT+his5vt25Wc1ypIF9krVy
        SI+5BPQki5L7v+SVTwHkw+s=
X-Google-Smtp-Source: ABdhPJxa75juhj0PLEXC39HhkFgEQbKz0vzH4n5/4eVYyax5GoyyMYp4lKLAVu735xoSw809seMYqw==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr12036829wrn.347.1599772457636;
        Thu, 10 Sep 2020 14:14:17 -0700 (PDT)
Received: from localhost.localdomain ([170.253.60.68])
        by smtp.googlemail.com with ESMTPSA id l10sm111502wru.59.2020.09.10.14.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 14:14:17 -0700 (PDT)
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Colomar <colomar.6.4.3@gmail.com>
Subject: [PATCH 07/24] request_key.2: Cast to 'unsigned long' rather than 'long' when printing with "%lx"
Date:   Thu, 10 Sep 2020 23:13:28 +0200
Message-Id: <20200910211344.3562-8-colomar.6.4.3@gmail.com>
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
 man2/request_key.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/request_key.2 b/man2/request_key.2
index e28c11ded..c14bcb000 100644
--- a/man2/request_key.2
+++ b/man2/request_key.2
@@ -537,7 +537,7 @@ main(int argc, char *argv[])
         exit(EXIT_FAILURE);
     }
 
-    printf("Key ID is %lx\en", (long) key);
+    printf("Key ID is %lx\en", (unsigned long) key);
 
     exit(EXIT_SUCCESS);
 }
-- 
2.28.0

