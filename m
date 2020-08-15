Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8CCC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B95206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPW4OFMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgHOV4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbgHOVwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:15 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BD5C08E817;
        Sat, 15 Aug 2020 03:27:08 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t15so8602811edq.13;
        Sat, 15 Aug 2020 03:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KCvvDovVelQsjukCt54W9h2hfe/Jnwyhb4n9drmTFH8=;
        b=VPW4OFMHG4Kn59Ky0h+BLbJKtRnd7cH9ldi2a3jWJZAuYX7qYrYFmqkryaaJockO4F
         HANwg/RqP+w0Y2CANWp2vSHbJi3+xDZKuOeciaQaWsZIWx/GI+ulRJ89UOxW5MlWwE5E
         324PAVMQ8vT3t9/CYSuHghs0yjyaKTTd0WXo1zYfYtTyHSvEPgkWd49YD1YkcCV1V03X
         sad4ck/Xex73lYPuPAl2gQUICrmPU7oaXdaPbGCXMh8VA/nNIXvlgSvCSvessBH0/P9A
         1DnAWZ90Swm9KfhVhtTCZHV9KB4lbABAW8LynMTFlwxqpbcNCCIDtQREsEp4Hgglmyds
         9nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KCvvDovVelQsjukCt54W9h2hfe/Jnwyhb4n9drmTFH8=;
        b=b91dvNkrTEJiwD2rjpAMK02qNnc1TkAJUOFg4YHWiRIxoaq+LFFkzweDEDCOpT47M7
         wDG2GvJfAtl02vHdG5g9I8gi4MmEYg3jmAdwr1NSKEp+S7vqAbjAZbhX8OlETwhWvJpe
         Pf7oyeb9BylZZ7dnK68RXLqTuZUPs+Ntl0voMSe7JHeSQxnfAYcVfLB5uPKpEjyBd2tF
         J8pcI8lZo99kEMLCKsrY1Jt1HIRnsGxyRwRL85NfZlABE5w1M/OtZmXj8Q31FpO1uX5I
         JzW62He6Tgx/cLIPnLjvY4H+XZCCUcPS+YmWWE8MMga8xnl6U+8VyFJqO6nu0vJ1tqyx
         OAVA==
X-Gm-Message-State: AOAM5302DJ6ph7RTKRbcsheIA/A1fdzCTj1uaf1jEiFZKAEkCFi91rBA
        H4BBYRlgCPhxqmpkcrSK00bTOtZK2L8=
X-Google-Smtp-Source: ABdhPJyGzaUSH20/hMKrOsKocRXQn393jRF0hxbVDhfLZUpWmLpELHLDScY11/Iyc1ypX1m/6VJ8UQ==
X-Received: by 2002:a05:6402:22d9:: with SMTP id dm25mr6225087edb.2.1597487226582;
        Sat, 15 Aug 2020 03:27:06 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d69:b900:61e5:2d94:8d77:6e0f])
        by smtp.gmail.com with ESMTPSA id c2sm6351286edl.28.2020.08.15.03.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 03:27:06 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: mention documentation maintainer entry profile
Date:   Sat, 15 Aug 2020 12:26:58 +0200
Message-Id: <20200815102658.12236-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 53b7f3aa411b ("Add a maintainer entry profile for
documentation"), the documentation "subsystem" has a maintainer entry
profile, and it deserves to be mentioned in MAINTAINERS with a suitable
P: entry.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on docs-next, and was checkpatch-ed.

Jonathan, please pick this patch.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f520202fa1ef..8aa1369d5926 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5178,6 +5178,7 @@ DOCUMENTATION
 M:	Jonathan Corbet <corbet@lwn.net>
 L:	linux-doc@vger.kernel.org
 S:	Maintained
+P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
 F:	scripts/documentation-file-ref-check
-- 
2.17.1

