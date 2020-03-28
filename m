Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0276BC2D0EB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 06:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADB82072F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 06:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHkzn15h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgC1GGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 02:06:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36450 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgC1GGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 02:06:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so14323988wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 23:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BUUZ6nzVONK+blk4chCmCKkx96rDIegQpK/XZUn6XmE=;
        b=HHkzn15hN+SVYEBnyxtPwckF/8L7+u1V9LuYJGyb5xwQ/FGTMaqBLEzHiDa5eqa43I
         VMOmVU4zoM+pP91+5XGLfIgDq/ihi6Qvh688pTQQMXOyM57xIhTiKrIngmkpNujmoUTj
         1PTCyMvBh1QcKUoAWqVq44DXK0xAeyR/wTPNlPRX7RgOyOgtj4EsTmg01H0vGqyuBo0a
         l75GUu1rWZT5gQzS4xjcWorO7XrebX+QzchVh/WwQhRrkCsbtEjCS7/WAlEfVhBDS9eO
         Fz8gNdXJoF0VHRuPOlWDdHWXe3OsdSo3Ws8zus4O6SZCyaIl1qUvcKcIXbOdjeWy1+Gn
         MBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BUUZ6nzVONK+blk4chCmCKkx96rDIegQpK/XZUn6XmE=;
        b=W5HEP9/1KFvDUOuHmUXx+nKesT9iOQFkct5uAzMw61k9qwMlLqzwsKs1qnI2IdDbTh
         Dhn9af2kDn5N3DGzr39FhJrFI9JRruvSAVUbgHm4GTHvlVCybjCr8uDmv4+GcB7HSAY+
         ijqujMnrWDkY523+bbuK9dJ6gqjHEBIADoieBZNGZ6p4zrPbJtqQxdHOpnwdPXSYn/mx
         bHxAHBnmvyfapWhoPM/bh9th/ZKLb2fHx2pTSUr6uH7UxuqZ9QeU6KgX+s9D1CSQYU1s
         CUX1RTZDYIqp7YwQ/bbl9LJ30TFzS2FVrDhYh054V1m85ChXPBR/1bZRFNCdOgctaSi4
         E14w==
X-Gm-Message-State: ANhLgQ1w6XSEsyJa3v5OcDbFbGRsf0WA0gtJjkaszYV6G+qF1oVw4QN/
        gL1XaxNK6yz/9G4JWJiYZ48=
X-Google-Smtp-Source: ADFU+vuoscb5qUswTMJY9JhIFuKoRbiDEjYT3ClleQdVv32S5WeSAfMrJCNUnVEM63WwVMIwO+OU7w==
X-Received: by 2002:adf:9b9d:: with SMTP id d29mr3229523wrc.294.1585375571758;
        Fri, 27 Mar 2020 23:06:11 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id m19sm11229021wml.48.2020.03.27.23.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 23:06:11 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/3] mm/swapfile.c: explicitly show ssd/non-ssd is handled mutually exclusive
Date:   Sat, 28 Mar 2020 06:05:19 +0000
Message-Id: <20200328060520.31449-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200328060520.31449-1-richard.weiyang@gmail.com>
References: <20200328060520.31449-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code shows if this is ssd, it will jump to specific tag and skip the
following code for non-ssd.

Let's use "else if" to explicitly show the mutually exclusion for
ssd/non-ssd to reduce ambiguity.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/swapfile.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 52afb74fc3d1..adf48d4b1b63 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -760,9 +760,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 			goto checks;
 		else
 			goto scan;
-	}
-
-	if (unlikely(!si->cluster_nr--)) {
+	} else if (unlikely(!si->cluster_nr--)) {
 		if (si->pages - si->inuse_pages < SWAPFILE_CLUSTER) {
 			si->cluster_nr = SWAPFILE_CLUSTER - 1;
 			goto checks;
@@ -870,10 +868,8 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 			goto checks;
 		else
 			goto done;
-	}
-
-	/* non-ssd case, still more slots in cluster? */
-	if (si->cluster_nr && !si->swap_map[++offset]) {
+	} else if (si->cluster_nr && !si->swap_map[++offset]) {
+		/* non-ssd case, still more slots in cluster? */
 		--si->cluster_nr;
 		goto checks;
 	}
-- 
2.23.0

