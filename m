Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADD2C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8B92064B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgH3OZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:25:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42194 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgH3OZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 10:25:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id c8so2090320lfh.9;
        Sun, 30 Aug 2020 07:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IV+yFxxwpQ0Xw6dmwqTaElxTbkcDYhyvv8ZvJBYCDow=;
        b=MCdeg0AgvnLCOhENvkrOt3TPIZXFD9wXllKNsc8fSiaRJVyk8Rk2jkm/U2tAZx4APM
         zZCUzDTniSDmzYmNufVV7HBaqG7Js72iK0Eq01dMLaFGconUK8ez5eQQJWWKcN2rwv+0
         hdZHHFz0gfSaGGIv95moo9//pX7EhBmdozfzc86bux6fEu0JEMH79p8/AT6hBH5VAbQp
         QBbfh4LMAN4kEgNGrvl1G8yPV/yf0k9bhImxgiRYBaE9IhBRNQRyaS+8J2euHM/o535j
         ZmK5r1oPWAotLHcIDqk9yobguEw1336m859Mh7z6oiBoO6dys8C6nmELsQEzuqePb1tJ
         F+1g==
X-Gm-Message-State: AOAM530TvlClGRLxMxnKd2tfWT3lCPbJ5wLqYOJgIEltc/pKyTzLh96z
        vV6KnbtUxiD/nY+lFVA2vOs2e/4DtLHqEA==
X-Google-Smtp-Source: ABdhPJyzt5EuUp4VD/mc3H46Yr8npNHlCdnK8Y6zpiJBuTKB1l+sQNmmXjHQqKUQ+mOYvrZ/Jsh9yg==
X-Received: by 2002:a05:6512:3084:: with SMTP id z4mr3573651lfd.141.1598797527807;
        Sun, 30 Aug 2020 07:25:27 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id x20sm285282ljc.38.2020.08.30.07.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 07:25:27 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Denis Efremov <efremov@linux.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: remove current_security() reference
Date:   Sun, 30 Aug 2020 17:25:09 +0300
Message-Id: <20200830142509.5738-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 15322a0d90b6 ("lsm: remove current_security()") removed
current_security() from the sources.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 Documentation/security/credentials.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
index d9387209d143..357328d566c8 100644
--- a/Documentation/security/credentials.rst
+++ b/Documentation/security/credentials.rst
@@ -323,7 +323,6 @@ credentials (the value is simply returned in each case)::
 	uid_t current_fsuid(void)	Current's file access UID
 	gid_t current_fsgid(void)	Current's file access GID
 	kernel_cap_t current_cap(void)	Current's effective capabilities
-	void *current_security(void)	Current's LSM security pointer
 	struct user_struct *current_user(void)  Current's user account
 
 There are also convenience wrappers for retrieving specific associated pairs of
-- 
2.26.2

