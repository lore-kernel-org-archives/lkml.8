Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C4CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3617C2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7b1AFLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgHNQIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgHNQIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:08:16 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C7BC061386
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 09:08:16 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u63so8566840oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5taqwMO9fu02Eq/oSradLpdwhpBHOZ6HATVQFj48PwQ=;
        b=A7b1AFLEdYJMUBJufiROZGagwsw9MKsgAlYJ2at68KUus+KO4FnTq7s99tj3255glk
         0mcR5QfAvpui7uyg9C7uhaZRTRWWzP1vQQv4iRRk75b4Otu/Pdq5+OnTeXaus1lz3eUA
         iRE5I8oQfGQedATtZxV7S5NtrCsVbvH5Zm+xgkisSWff8iK9kpoLS6i+sNlwtIuEs/Yi
         wQIlF9cLAWCjHPOOvHI/CTKxvQmMYIMt1MvxJVbiY0z+vDPCAW7rvdU+RVeIQKkHekLv
         rrMuHK8c9xRSTKa9wE6A/lnbTAlg0ulIUQ7E+620VRrM8jnkKY0F+QsNzUzdlAJpV+mV
         sxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5taqwMO9fu02Eq/oSradLpdwhpBHOZ6HATVQFj48PwQ=;
        b=XXIyx9FC/FxthJETR57DbNHUxZGCOcWqGiIvx5duv01XAP2bau+PxscLsP9sMh0aM8
         4UQDwslv9bL8ZWgowEU0Hekv4e7qVJXbgIvkJwVmN7QR/7M0IDE0RKDu+Qx+MgTXS3DT
         zJ5tgtvIiaX09zm08pzczzEPknlm2EljLI4HURV4FeCko7fD433mIgQuAfPLYi563l0i
         A8X2pdl/efswHFC36xB4ddvgkAW2UkIkYKjytKC3FfJ78SXHH4AuS5ADuNF06bBzIpM+
         ghXNLAiOL98kLIdHd6O2GtN48LkSicSGxY0vyrUIdwSb/uXPWIkHbus6dHt0Hvap/cyn
         GZcQ==
X-Gm-Message-State: AOAM533Viq21w1yDkbmR7gcliTUlpAX2sZG/ssa14dh8AyF+CYOePASA
        HNQu3539FnHqZAyGFqR9LBQ=
X-Google-Smtp-Source: ABdhPJzaRBSFFR6TAPd4qAaVsJoeJP7a+jauGczShtyYAzEfw9qRT+nBEQGL0QsOzcn1iUPB3XGfbA==
X-Received: by 2002:aca:4996:: with SMTP id w144mr1882058oia.119.1597421295127;
        Fri, 14 Aug 2020 09:08:15 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id 143sm1900648oie.11.2020.08.14.09.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 09:08:14 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/2] dyndbg: give %3u width in pr-format, cosmetic only
Date:   Fri, 14 Aug 2020 10:08:00 -0600
Message-Id: <20200814160800.3298765-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200814160800.3298765-1-jim.cromie@gmail.com>
References: <20200814160800.3298765-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the print-width so log entries line up nicely.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1d012e597cc3..01b7d0210412 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -947,7 +947,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	v2pr_info("%u debug prints in module %s\n", n, dt->mod_name);
+	v2pr_info("%3u debug prints in module %s\n", n, dt->mod_name);
 	return 0;
 }
 
-- 
2.26.2

