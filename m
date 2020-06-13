Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA28BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85345207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlmW/SJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgFMP6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgFMP6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:10 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB96C08C5C2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:09 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id x17so2540963oog.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MAJLBB76V35KN8WSxLx5UypUGcFlDfUX4c3HkYKsVKk=;
        b=hlmW/SJ+8i/eymv3aZoazZdpr9N9pDDLZofY166K5jaOsVMMPSGHxISU1yDSxc3Jeq
         2UZuNw7VdTdMIWeCahupQ8/Mg591SZwsMbbNDXTbgLM+Q56ykLiuClbJIK1XMn53yNYg
         NVupBxmLKwiA/OHBlKHI/WVAuFq3qrn0lu5bMBq+8A1ioDhRL6jznwg4R+6LDkdXhn7c
         rlr1T4ujNybGUgv26vKLueQxu8EsdqW5q0Y4arUOwGcBJStBHaVb95ZKcRPUJyw0p2mT
         yOuwQFCYT7XadmRP/zBC/JyD7qTsQAqErlLLXdyWtTwI/jBCfrH69sf1UBmVUt4zbloU
         nK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MAJLBB76V35KN8WSxLx5UypUGcFlDfUX4c3HkYKsVKk=;
        b=m/ykdv6HN2zk6uY2/mR78kjG5a2Tlocm+fkaZNq4RL31Tw722R+naCRgtoXR9dSIrD
         g05mhVG1zu4ftydj9VAjWremdbWHfodN4CDlKA334Zycu2e1/jSsMXLGS6wkZk7S5JQA
         j9lT6hg4n5ysJurFcpTlbBmaVbxOErX67eVDzFzfntl8pzapKfn9leimAYDDWuU7l09j
         I9384QODvswYgXcN40vsDlwYVkBuIMEXZ2+oDZAk1p0uvLGb+PhHW6k+dr6pYYIHymLE
         Jjp+iaUc1Uj4eH5biysegK0Iw+IQxNiMYfI9mXC/12bDmdDCyZ8U9d5kopGEP8Jr15kY
         SbrQ==
X-Gm-Message-State: AOAM533Jo9jOOFSXX9heeptf6kYx6Jrfdr9B+YxvZ3xaHZqJL1eY/sKa
        qkIWUB5okYQLDQmLHY78AbZsXUwyV4o=
X-Google-Smtp-Source: ABdhPJwu9MA4hmthKjq7g7tYznqSrZB5mQ9EICm8VR1Du+5LXgY/D80bOKQAihfKK7BogUdOk+hhDg==
X-Received: by 2002:a4a:d41:: with SMTP id 62mr15271998oob.10.1592063889168;
        Sat, 13 Jun 2020 08:58:09 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:08 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 09/24] dyndbg: add maybe(str,"") macro to reduce code
Date:   Sat, 13 Jun 2020 09:57:23 -0600
Message-Id: <20200613155738.2249399-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reduce word count via macro, no actual object change.

OTOH, maybe() could be scrubbed if printk's default printing (iirc) of
"(null)" pointers is deemed appropriate for the log-msg.
---
 lib/dynamic_debug.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 31d3be30776e..20b712652ee4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -114,6 +114,7 @@ do {								\
 #define vpr_info(fmt, ...)	vnpr_info(1, fmt, ##__VA_ARGS__)
 #define v2pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
 
+#define maybe(str, empty)	( str ? str : empty )
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
 	/* trim any trailing newlines */
@@ -127,10 +128,10 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 
 	vpr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
 		 msg,
-		 query->function ? query->function : "",
-		 query->filename ? query->filename : "",
-		 query->module ? query->module : "",
-		 fmtlen, query->format ? query->format : "",
+		 maybe(query->function, ""),
+		 maybe(query->filename, ""),
+		 maybe(query->module, ""),
+		 fmtlen, maybe(query->format, ""),
 		 query->first_lineno, query->last_lineno);
 }
 
-- 
2.26.2

