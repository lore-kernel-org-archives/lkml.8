Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489A8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124002073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URj6Gz7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgFVPrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbgFVPrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:47:23 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2103DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:47:22 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p18so14032498eds.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8T5mZjCR5K6UE+9mip6AsTcYlxfqPfxEDZRXo68qXg=;
        b=URj6Gz7DCNjVsfGxAkO2DOJQ4lhP8RnWB1oBTpMB1v+b9ngI15iZSGpciCEHPwhRtm
         THavvnAHUL50ZpFzgz1EVT2okwJ6BeeZsAmcopLJMf5WZSkYA/QwaRG7z7H3s1k+eaJt
         EF3a5YtgqK/aV1lCOq+EjGrCWYUgoTtReCeLcXg7FKh05Qp1sNZubqrc5zQ2ZDlWfUTu
         AdbdhbrQpkW4BdEe8NFtAz6Y5DShUyx3KystsWglITp/okRj/QzsaCpNqC7cX1zVoc2L
         wiT0IjoCZxuJsPhLG88KnO5MoJdfND8u4agst1e7U+g4Tcv381/zETGmFcbfvKl3zUm0
         NAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8T5mZjCR5K6UE+9mip6AsTcYlxfqPfxEDZRXo68qXg=;
        b=Z5sAu0lCRHBoQXA8Nbj5f1rcQpmPUvx10dI1aAnl49bbdcpxikcI5af8baxy8/btyw
         hDjh7hOLxj+5iWJphE3Qo9a+tbftErWLV5bCOuWRaeWxknmuW66ccjytXrfIslwO0c0p
         ILmJNjR6GTvjOJyd1dXemAoVBoAK4pJDypxV1ZruOttzS0L03T7Vf2ICscWm3uecqNZP
         bfH8Q/X6dul8UBAdxbYQINtJ35gv2zTdQpAJHCeLap6Ev2UeyWt9M0/e0tnu/gAqLYLP
         k9EUWbxYfuAS1/JN0G0XLza87WWSgAws2vKAd8MiBB8sYaPEClm2d6WzIddv5h+fkIlL
         maXA==
X-Gm-Message-State: AOAM531kiZehrj7kp0qVaunYP6bmzsbFqAvHo5zX49m0nymR+akTcytZ
        08d/LbeyfRZ5YplmD/x9jbVK5Ac/
X-Google-Smtp-Source: ABdhPJxIEqQRDELoOstYIbkWotcJMHSYonzFQNZ+f6Fma7p8nFax+whEYuQyCld/TtQgaxDNa/YB8A==
X-Received: by 2002:aa7:c790:: with SMTP id n16mr18225197eds.54.1592840840867;
        Mon, 22 Jun 2020 08:47:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:74f4:a0e9:488b:65c7])
        by smtp.gmail.com with ESMTPSA id s14sm4015599edq.36.2020.06.22.08.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 08:47:20 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] kbuild: run the checker after the compiler
Date:   Mon, 22 Jun 2020 17:45:12 +0200
Message-Id: <20200622154512.82758-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the pre-git time the checker is run first, before the compiler.
But if the source file contains some syntax error, the warnings from
the compiler are more useful than those from sparse (and other
checker most probably too).

So move the 'check' command to run after the compiler.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 scripts/Makefile.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2e8810b7e5ed..7ba6a752d5bd 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -252,9 +252,9 @@ cmd_gen_ksymdeps = \
 endif
 
 define rule_cc_o_c
-	$(call cmd,checksrc)
 	$(call cmd_and_fixdep,cc_o_c)
 	$(call cmd,gen_ksymdeps)
+	$(call cmd,checksrc)
 	$(call cmd,checkdoc)
 	$(call cmd,objtool)
 	$(call cmd,modversions_c)
@@ -277,8 +277,8 @@ endif
 
 # Built-in and composite module parts
 $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
-	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
+	$(call cmd,force_checksrc)
 
 cmd_mod = { \
 	echo $(if $($*-objs)$($*-y)$($*-m), $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)), $(@:.mod=.o)); \

base-commit: 48778464bb7d346b47157d21ffde2af6b2d39110
-- 
2.27.0

