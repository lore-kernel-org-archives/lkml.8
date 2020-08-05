Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C55C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F5722B40
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBycW0YI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgHEI6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEI6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:58:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9585DC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 01:58:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z188so14460028pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6z4BtSfyPhm8FSZ25vbHMUyLLqoJGugLumxHfRS+vcU=;
        b=vBycW0YI0MBJ7/ydGdDUcDOklc7CTc3aUfphBk3gy65bdHN/YsB3d+plPiLgLGNQRs
         7hfb0Q0EGuxVxKR6Vlpcpi8NLwKdbP/h9oh/E8IzjJXkbQ8TkSJp4/gj0rQUH7ddWoNB
         zuA/a+v1xU896+ZjbekFAXCJg8oSfNQf00+q4kV1hw6XUvpR85Lhfhu1DN7GQw0XvDhD
         AV//VQJdWX43bcxIXwWQjkiPPffw3fZK+/MB3SvP3YfbFKKqtAAeydWkHvHqdNkEdl8d
         QLQ/H07/kWjL0HF8iZAnSRv/57zI3MxXczMC1bxe9ZBkAp/W/EhPO9HCo3KI+McbXoZs
         dOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6z4BtSfyPhm8FSZ25vbHMUyLLqoJGugLumxHfRS+vcU=;
        b=OzOcBONO+HRmq+/1+GbcV/TFeZ0IJYKdKvabKw8rSSHncwTxEl0tuj7VSAsmodBwLG
         BkIamb3MFqUZz27lK0ifEOMMuX+8Knjc02skLNKSVMqYzNFaiSrSCzrWaB2mpXkcEl6w
         X/HvUKnTzfbeS9C91zXvmtu5wDzSVjuV9wZg/S3BsC71Hn3lKGEjZzZBCRa58m+Vn1Xt
         fQJmlGvyYaurD8Jw55KW4sKiJnFz31NW4hwr6eZc6A1YD/MDuUopVbwzfefT8Z9+PHea
         q/y/VHtmERHppLxhFMBOOEPJH4n3Rt/+MskZE9aGc1GettYTR/ubu2djj/peq7bR4RKa
         EYVg==
X-Gm-Message-State: AOAM531aCIDgaqyrbhnYRnZDOES2uajz/YokmktuBevIqqOipd149jbD
        WaVbS9wc0AoDm6e5HYZRHzE=
X-Google-Smtp-Source: ABdhPJz+qziOqDKLYQASamapIJBDEfHS/yK8/HaBDxRZ8CK+id83lz0nZysUuHIu5g63MH/VN8A/Nw==
X-Received: by 2002:aa7:8608:: with SMTP id p8mr2281174pfn.62.1596617881218;
        Wed, 05 Aug 2020 01:58:01 -0700 (PDT)
Received: from localhost.localdomain ([106.51.111.128])
        by smtp.gmail.com with ESMTPSA id i1sm2466361pfo.212.2020.08.05.01.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 01:58:00 -0700 (PDT)
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Sumera Priyadarsini <sylphrenadin@gmail.com>
Subject: [PATCH v2] scripts: coccicheck: Add chain mode to list of modes
Date:   Wed,  5 Aug 2020 14:27:40 +0530
Message-Id: <20200805085740.9263-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds chain mode to the list of available modes in coccicheck.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
Changes in v2:
	- Change coccinelle to coccicheck as suggested by Julia Lawall.
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..6e37cf36caae 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -99,7 +99,7 @@ fi
 if [ "$MODE" = "" ] ; then
     if [ "$ONLINE" = "0" ] ; then
 	echo 'You have not explicitly specified the mode to use. Using default "report" mode.'
-	echo 'Available modes are the following: patch, report, context, org'
+	echo 'Available modes are the following: patch, report, context, org, chain'
 	echo 'You can specify the mode with "make coccicheck MODE=<mode>"'
 	echo 'Note however that some modes are not implemented by some semantic patches.'
     fi
-- 
2.17.1

