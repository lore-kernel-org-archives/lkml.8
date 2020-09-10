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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D419FC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D878221E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/N/MFtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgIJVRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgIJVOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 17:14:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B67C0617A0;
        Thu, 10 Sep 2020 14:14:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so2108433wmi.0;
        Thu, 10 Sep 2020 14:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vzrGVrRL8cPFnEaLd6Z9+xAt3xUa09Ej8wf0gXFfgvo=;
        b=R/N/MFtLtRB40jFJNMf/l5xHFm4vAOULXq5k+u01FvaAySurNetF8+R8h48oZ+JLC2
         mbDVbLS8lL+1DTVHCJZm82lqJeCDYsRZeDANnXBADGudM2e/yyObduQTPyDiDZnEwXay
         OFcirsRlMfe3/YcdhUosFrinTXUAc5R3pdvDJEGZpR1kazVur9l2RHIlFZJdjBNH+Uwk
         8/Ed/MLQRSjKybS2XgdIKIZiNzut2TUGovnqDCsHZg2VwKINWeca7ZYKMlue/cPyB1aB
         DnVJGhsROqmOc6RZp7abfAWZVDcZ+VbV2jd+elrENHNlGmQWLun62huqaNv+JL98/IpN
         6nYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzrGVrRL8cPFnEaLd6Z9+xAt3xUa09Ej8wf0gXFfgvo=;
        b=R7SDHAHdZ/Od9c0Ywta/Lg6WEN2F+D8cfnjcxbYmwaj/AlFuLMEV35mq3vukj7O2/m
         /YwI7CDnZw/1XjGZWj6kPi3xjKWV8oVR6RnY1bVYALqGdm7WkZekcPICtHZ+ZmAnYUhR
         r/Q0GunFaubSqKAbm329tvItrdn392wezQSDiOvTpjUU7iUsuQSev93zeavrGv6agbI8
         qXtJIdafTOr+sEtAtQwkreLH9ZcybQ8Tt/4BQVQ0hO/5PFZ6HcSUdSeevU5v5+uLaMJ3
         8vpkvKOOlrfRrFz1rhz99YNtZgK8nKerfle4PLJNfRnIKzDIiTSfqySNh447cvhtqYop
         lnGQ==
X-Gm-Message-State: AOAM533f9PZoZdg+l5DoJ4QfQctTd/TIEPIqFjKQ2y5cWvJoh3QPKOqm
        eDZXzQv9jLxpc59L00HEJ89DRT8b6cLcJQ==
X-Google-Smtp-Source: ABdhPJwHAK+86eDYiTSP6rEdUUyTa2J1rnOrqU0thk+vcWEqbEo6VDp8nvhPGQxnY4B1Tu6yYv3YJg==
X-Received: by 2002:a1c:e256:: with SMTP id z83mr1982676wmg.33.1599772464290;
        Thu, 10 Sep 2020 14:14:24 -0700 (PDT)
Received: from localhost.localdomain ([170.253.60.68])
        by smtp.googlemail.com with ESMTPSA id l10sm111502wru.59.2020.09.10.14.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 14:14:23 -0700 (PDT)
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Colomar <colomar.6.4.3@gmail.com>
Subject: [PATCH 13/24] getpwent_r.3: Use sizeof() to get buffer size (instead of hardcoding macro name)
Date:   Thu, 10 Sep 2020 23:13:34 +0200
Message-Id: <20200910211344.3562-14-colomar.6.4.3@gmail.com>
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
 man3/getpwent_r.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man3/getpwent_r.3 b/man3/getpwent_r.3
index 64f27dbfb..0f7581091 100644
--- a/man3/getpwent_r.3
+++ b/man3/getpwent_r.3
@@ -190,7 +190,7 @@ main(void)
 
     setpwent();
     while (1) {
-        i = getpwent_r(&pw, buf, BUFLEN, &pwp);
+        i = getpwent_r(&pw, buf, sizeof(buf), &pwp);
         if (i)
             break;
         printf("%s (%d)\etHOME %s\etSHELL %s\en", pwp\->pw_name,
-- 
2.28.0

