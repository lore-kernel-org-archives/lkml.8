Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D136AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFAA520768
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLjxvkNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbgFWCAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732054AbgFWB65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:58:57 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397CEC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:58:56 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id v13so14994641otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MCboGWFBBNPNJ/zfMw0rp0TzXUHVpcQYHjnFLH8yUdQ=;
        b=qLjxvkNrlmv9bZtdi41+BLOddpG6V7lZaLJjhq8RArMcRBmAKDvsjPPLJHnV4ydSGn
         GaKG3kxvVulXCk2am/E9uf+wj4TGhQOdy9bRoiRHovkgPww0KWMxV25tRl3V6aiMWFg1
         nY261RRBvZrywjkdsL9j4E4E2JRvqrcfQH214hpYZlYtgcqxTZ3jbZ77AN56RmyuZhhZ
         pMqtFXd+9nAAWKesiSId/W+EuIDq3oe3sHX3MRnSTyiHNmBlvGGbC9AdTm3zQmwGUf2Y
         FCe2fBrlaGtzJdGfS2nG5gjePKv3hlP0QdOwxXt6O/WCMmx3lKN5XHZx2AJx3cG7f90Y
         +4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MCboGWFBBNPNJ/zfMw0rp0TzXUHVpcQYHjnFLH8yUdQ=;
        b=GmuBw8SS9A/en+H/I1beHRPlb814Ue5OMr2xc9Y7ptxlFFOAK1X52UDmW/MZwyDt+z
         gxRYkDJyl384ZghFyd3sC7VwdPKGZ9qVHvK9Esq1UF2GDfBwMkt4V8/j4peyb7UzuyOB
         JNLZVr6AgIiFCP+Sm9VorgCTCaWnnRxyRy9aJF1vP8Djt//a7pjOecnYu9D/FhquokBC
         mcTITmzvxkj3nSzWgsXiSYnuo3J+UkfY/EtRqU6G3B0wb3Rb6Le3cuWRzw0jOjG2Fq1W
         Vljgg5t/j9mhoilfFBsqKoDrYyKln4zJcsviMQVH+zritnV3A74gUZ2sgG/wdadZwwy+
         2l5A==
X-Gm-Message-State: AOAM532SoCMJn7EgoJ+BGjr+bhcn2u3aa5Zvn9JxkvI9E99Tt5/4CE+v
        9YkicPh5dHYgjwQDcH+9OFEJn+jnGfg=
X-Google-Smtp-Source: ABdhPJxSrcCKKCRUeHD30M3AQeo8rvHO/2WJtjHDNVQeOBS9Zj04/iDKzYH41GdocnqTxlMNektlKA==
X-Received: by 2002:a9d:5a12:: with SMTP id v18mr15905043oth.90.1592877535459;
        Mon, 22 Jun 2020 18:58:55 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id c13sm3737990otm.78.2020.06.22.18.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 18:58:54 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Barry Song <song.bao.hua@hisilicon.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] mm: cma: Return cma->name directly in cma_get_name
Date:   Mon, 22 Jun 2020 18:58:40 -0700
Message-Id: <20200623015840.621964-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns:

mm/cma.c:55:14: warning: address of array 'cma->name' will always
evaluate to 'true' [-Wpointer-bool-conversion]
        return cma->name ? cma->name : "(undefined)";
               ~~~~~^~~~ ~
1 warning generated.

After commit e7f0557d7de9 ("mm: cma: fix the name of CMA areas"),
cma->name will be an array with some value worth printing so we do not
need to check for NULL.

Link: https://github.com/ClangBuiltLinux/linux/issues/1063
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 mm/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index 31a61d410c59..6cf08817bac6 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -52,7 +52,7 @@ unsigned long cma_get_size(const struct cma *cma)
 
 const char *cma_get_name(const struct cma *cma)
 {
-	return cma->name ? cma->name : "(undefined)";
+	return cma->name;
 }
 
 static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,

base-commit: 27f11fea33608cbd321a97cbecfa2ef97dcc1821
-- 
2.27.0

