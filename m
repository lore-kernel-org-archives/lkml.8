Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A1BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015EB2415E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtyYD6Go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgFTSIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:08:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34667 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbgFTSIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so9873945otj.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJ9r7Kj2JZ78SZKbu2ksaAjGKTUOUIiaxChKdLFlRa4=;
        b=GtyYD6GoeEicv99hjQyT+uO5yuqQTWZdZJkEgMtnvjDaXThtAohiGjHri5YqTf20kL
         I0bPbYnwDzVt3//oFSDs0eQvpFCgcPrvl8eq905pUvwP7lK/kZVkSUwhBh0QL8hhd1qW
         aMmyNlwSUhjDKXj/QMQdEauYfC8zDioHlK7AEY6AuPpHSu5LSnzvcB1kF5QkFtdz7jhe
         ZeJMSELoBWRo/vc/6miY5JZJVtkv/0YmR7okPgFvUt5/JAW/H3bkO7DPe9GwnFYNm0dZ
         xp8fgroA21yriKwSGs7leBJaHOogAULpJR8Sv7c386COEB1hYBLgTpbluy4NcBTtbslb
         OdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJ9r7Kj2JZ78SZKbu2ksaAjGKTUOUIiaxChKdLFlRa4=;
        b=UkNAAh9XPa168koK6GDJiHsYry7nfsQYwz1C102wWXBMbbRuHwe/cpGpxqAGsw8VVU
         dIA4eYi8/ZfL7M8tpu9q0QG810XqUyXq++Z+BCNqkmPNVCkVMxb6aVSI8DOvnIe+xClr
         qVlEwX1Dh3mpit3V+cWXO6au++2Y77iOFq78FVnt+H4zmCar1LtIpfe2NMFiw2EGjcVA
         vU6zpDovBvXj5AB/Flzcfu4rLEQ14qQ6yH1YSgppb0eddrYZnvV9cee7+qxGpYibTfiZ
         fx33qOB7jv16jm/boW1zyKMdeTfdRh1Ze+Sf5RUsXmAHTnmCe0ophZHB2ZjTHKqQm1Kh
         vuXg==
X-Gm-Message-State: AOAM532inp/WMKWO9PKY1cze+ruW1SrHeF4uUyMxpfgS0eC18v0wWQIl
        PuSF8/JRSULfu3MO3o6RA0U=
X-Google-Smtp-Source: ABdhPJxRAZQWn1D9IqENU9cHqUiT+YFEhKOY7c9IhLmFtr2dRN91ugTwiLs7eGikvZXi3pCWm+gGyA==
X-Received: by 2002:a05:6830:60d:: with SMTP id w13mr7930485oti.243.1592676434481;
        Sat, 20 Jun 2020 11:07:14 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:07:14 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 11/17] dyndbg: use gcc ?: to reduce word count
Date:   Sat, 20 Jun 2020 12:06:37 -0600
Message-Id: <20200620180643.887546-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
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

