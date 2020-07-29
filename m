Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875F1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6725D2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG4mVC9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbgG2CLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgG2CLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 22:11:35 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82305C061794;
        Tue, 28 Jul 2020 19:11:35 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f14so6796001ejb.2;
        Tue, 28 Jul 2020 19:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RHigTyCdmEWcFxPDFOlkMvwmWwW2V+UhAWzDoW748d4=;
        b=GG4mVC9H0Dbo6VeooizSjCbp4n2ie+ucPPTZCaQGiGTP9jcmwGH+fKwyB/fy8O46iu
         prIrOxuEzaP94qGSqqyWqkOlaaX2OuSW62BWvuysZ7XcS/CmkOfzSBRbPUetFRWtL4El
         456TtlpqblRKoAHUi21wX3oCUtxhK1srW9+Nx4IAgGNS+PS9L3oikksbn8ra70ioL51l
         cuPi4PLu4n+3rF3rejaWnKdv5EBC39tbEv2EQXbeKGY1t3iyPfJXFtrmCSr3Sts1MWOx
         85b0Kl9/DFUcQ1lYP+lHHP8i4T01Lr+rJvc3FK5Ng2p6s7lu1Uy0pDUuWa/lu85yHQuB
         t0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RHigTyCdmEWcFxPDFOlkMvwmWwW2V+UhAWzDoW748d4=;
        b=cg6jrhwZaY/HvA+gDKP/a9+Oe8cporx9A4y//wb7LYavptynLjdDMAdLvSGx1ywazP
         A6Ak3fmBgZLj4u2vW39sdjYLjzOfN7v3btC94h0IBevSU6gIgsg+j7OYXm2fR/aZiDix
         ngi7+qOKolzJOEcdWqkXEdqziXsWT48I22BI1sTw92Au/Hnq4f7jQwmsjXZIFHgicaQ7
         +HflejB74gs3gn5PSxz/ARrg3z9wrB8ToJw6X3JzM/8PGMhRZh//YQNq/SQB11NcWMMW
         ynRqp83elGyI5IMoEVsV1zHgzrA45bXGrMrxJOBG2FxmN+/gDAhbd4Z9jvq3Jja5/SMq
         2lPA==
X-Gm-Message-State: AOAM530q/RojbbTxhoju5dzs0HC+5LT5hk4dxEwda9Ekz1CIf7wkUger
        YGIX5gVCouLfBeUQTblRIA4=
X-Google-Smtp-Source: ABdhPJy6mk5/xcGZhkwNBgVHmoVS3PIT/+jdNP2xbWM0wEQbQfDYpufjw2SFL1XOrcqpsuihJya9uQ==
X-Received: by 2002:a17:906:7153:: with SMTP id z19mr26025593ejj.319.1595988694241;
        Tue, 28 Jul 2020 19:11:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:1ca2:9977:56d4:bad3])
        by smtp.gmail.com with ESMTPSA id t6sm356828ejc.40.2020.07.28.19.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 19:11:33 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: remove stray HTML entity in '<slash>'
Date:   Wed, 29 Jul 2020 04:11:20 +0200
Message-Id: <20200729021120.35901-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An excerpt from POSIX contains three occurrences of '<slash>' but
the first two are spelled starting with an HTML entity: '&lt;slash>'

Fix this by replacing the stray HTML entity by a '<'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index e2ba15146365..d46688d6770d 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -78,8 +78,8 @@ particular, ``mkdir()`` and ``rmdir()`` each create or remove a directory named
 by the final component, and they are required to work with pathnames
 ending in "``/``".  According to POSIX_
 
-  A pathname that contains at least one non- &lt;slash> character and
-  that ends with one or more trailing &lt;slash> characters shall not
+  A pathname that contains at least one non-<slash> character and
+  that ends with one or more trailing <slash> characters shall not
   be resolved successfully unless the last pathname component before
   the trailing <slash> characters names an existing directory or a
   directory entry that is to be created for a directory immediately
-- 
2.27.0

