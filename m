Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF62C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9753B21789
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIqNiy5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgFQQ0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgFQQ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:16 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD8EC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:14 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id e8so518923ooi.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJ9r7Kj2JZ78SZKbu2ksaAjGKTUOUIiaxChKdLFlRa4=;
        b=aIqNiy5Mvn9/rd7bP4fh90AZFFHugzC1CLHYBNPgKtBEr3gvCCLc18lO5g7o/gJCUa
         1kZ5TW7O1cp8MaMbp7QVvmOMSk38NaiIfllExM6LnPoOR5kluzRRecSH54Z5oMrNharH
         7r+1fkOaM0KnXcnk89uGqy8uBob/Q+/plAat1PhX1FAH06s2RcuRHCLLaj/0X016WOUm
         nnnOKIii4xb1eoUfJzb53eMwOTecAP9GEp1/Z1+l69Q484JPFdua/no1adE+xlG3TMcp
         VAxmGqqFMqb4+xp3PP2qbTOtWcW0Ao301Pl/GaSDsxe1ybAI2bk/+RI49+u21PgzpJDZ
         yUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJ9r7Kj2JZ78SZKbu2ksaAjGKTUOUIiaxChKdLFlRa4=;
        b=KOhIPO36uZ7ICJ/I1PTD4MZgvJHOshId46DgyWMeQAZdpeQrBsSM8pqAhFZYB7gr3H
         p+lLueP+liacDtLD3OMb7AToCcOPrFa7PhNRiAJbuj1RZtg+fEoie6fwapSVSfmQe7Wa
         8/k6ZXJDJLAMBS6YTYfOx1L7HiU+WEfUQjLggpDyjms0vSk92CctO1eWdLypG8W2vdI3
         3i9odanxem9eF+rVu18PWV8hVFAUQpJcBZ5Bpyk1oneRads9cKdp0kGyKWLK9kKL0TYj
         d5ULeunItXszdxZqx0AfWERt9SxUUTwSuRcJz6SwyC7Ybw7bBHCAbi0bZDPCbAbB914r
         Wyug==
X-Gm-Message-State: AOAM531wcM59c3LVKza5WiWMajOOkQezIcmuMISWzidfRem8YCmdynw2
        WICnLZZSlG/lLVSjZBFWEoaI0l3Ho0U=
X-Google-Smtp-Source: ABdhPJxs2bpQ2kJwYaIYG7G78leaC2D5eqwUQtKrZiITvUcnau3olbCEJ3u/IUYzJWf2q3KNUaaw6g==
X-Received: by 2002:a4a:e6d2:: with SMTP id v18mr195801oot.34.1592411174350;
        Wed, 17 Jun 2020 09:26:14 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:13 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 11/21] dyndbg: use gcc ?: to reduce word count
Date:   Wed, 17 Jun 2020 10:25:24 -0600
Message-Id: <20200617162536.611386-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reduce word count via gcc ?: extension, no actual code change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e879af4e66e0..6d0159075308 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -127,10 +127,10 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 
 	vpr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
 		 msg,
-		 query->function ? query->function : "",
-		 query->filename ? query->filename : "",
-		 query->module ? query->module : "",
-		 fmtlen, query->format ? query->format : "",
+		 query->function ?: "",
+		 query->filename ?: "",
+		 query->module ?: "",
+		 fmtlen, query->format ?: "",
 		 query->first_lineno, query->last_lineno);
 }
 
-- 
2.26.2

