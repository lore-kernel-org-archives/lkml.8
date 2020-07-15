Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D381CC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18652071B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EENkeYdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbgGOMXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgGOMXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:23:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446C7C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 05:23:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so2406337wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KVdISYiS8HEy4aersiAqtxJUUdWsfYZxho+YIECAEc0=;
        b=EENkeYdpmz+Fa/oxs41nGObcWJcqqjRB5xU7cJqLc5cQW53tOkVHHOJktnz14IYzeO
         zY69n3pCHyfUAHCCf2t9Hcb0PhXUn15FIqjzEDVh83Gwn5aK0w28sCLaByaqikWHwgG6
         Ogy+ikd4Avjs6CMSGlYKBUpzEGvMjmLQVJU6yCM5NZac2KBmrWnShRVpYo4GAfe9XkmR
         1scWq8aM+241SZ0CPNxEWkiaHUSU/Sn3oVwMFZC33tXA8eosT+boqtlGMe9QjT0N8hX5
         vUD89hjtG1J4TT0dK1TUS4u5wr6Ogo0GQBLHHv1nEVOHgYIiH9HW2vXuWFegEh6DOVQL
         Dk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KVdISYiS8HEy4aersiAqtxJUUdWsfYZxho+YIECAEc0=;
        b=J8N7E7lIFb1z/UTCrRfic0WFpuXIeDi5shrJgFzDS6VP7AkCMcxrNeUTo7wZzwM5bl
         2fmR5JchralbQtnp2CS2QIOg5Sv7jW2614AojNSsOOhhfQJDBvymGpSE8Ueb9gp8Vzf2
         hsevxg4hZnEe51V9oNHYQb5fmkmCH6BhcGxut+SnNso59Xpmxzybd4HaofvCtVd06OIz
         g1SNtOvOzAiWTCUc1ZVIdD7exFBDI7NjZllvLknZQNwsvLqgtIstT0Ch3COm31ieqoqv
         czvfxPZrhDIA5PvWfZDA+m8KtsU0OdODxSoC89vB6Ljxcouk4UpCfXbdmyGgKA1i1s7b
         lbsA==
X-Gm-Message-State: AOAM5327uwE/tGUbLhvU9SU/70L/S+BanmUBTSu2YK8bRUgKGkQzH4oA
        TxvLlYDpmSv0DmDmgJuiUx8RFA==
X-Google-Smtp-Source: ABdhPJyeV0wB0fonR/LRwQmNyWEbnt40Y6ckiqhq2xVKDDt9GQw+UZwL96kZeAjpEwtq7O8vVIlSpw==
X-Received: by 2002:adf:f784:: with SMTP id q4mr11028896wrp.397.1594815815609;
        Wed, 15 Jul 2020 05:23:35 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l67sm3753409wml.13.2020.07.15.05.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 05:23:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH 1/1] doc:it_IT: process: coding-style.rst: Correct __maybe_unused compiler label
Date:   Wed, 15 Jul 2020 13:23:28 +0100
Message-Id: <20200715122328.3882187-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flag is __maybe_unused, not __maybe_used.

Cc: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: clang-built-linux@googlegroups.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/translations/it_IT/process/coding-style.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index 6f4f85832deea..a346f1f2ce21f 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -1097,7 +1097,7 @@ la direttiva condizionale su di esse.
 
 Se avete una variabile o funzione che potrebbe non essere usata in alcune
 configurazioni, e quindi il compilatore potrebbe avvisarvi circa la definizione
-inutilizzata, marcate questa definizione come __maybe_used piuttosto che
+inutilizzata, marcate questa definizione come __maybe_unused piuttosto che
 racchiuderla in una direttiva condizionale del preprocessore.  (Comunque,
 se una variabile o funzione è *sempre* inutilizzata, rimuovetela).
 
-- 
2.25.1

