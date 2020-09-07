Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA59C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85084206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxCG1050"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgIGRS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:18:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26222 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729734AbgIGOBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599487262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=UMW53qYbnEJqvbLmiW8HSZb8Nx6gj/HTuK4M4tdTyjM=;
        b=GxCG1050S9fwcces6OIt5u64NZyRC+daXITYsgcztWUrgLCn6S/yBS2GnBXZAmgrfeAEE+
        Vyrlttfxge9XXz989eGKYsc/pBRrpyRHYug6pa1sxTM/5I0b/1Hot5y2GvAs5RX1TbRKXc
        vVojQDHwfE2Ev6C+3aGueJMnXKoOoqs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-0oBmeZYIPBO6--lwr0lw_w-1; Mon, 07 Sep 2020 09:58:56 -0400
X-MC-Unique: 0oBmeZYIPBO6--lwr0lw_w-1
Received: by mail-qt1-f198.google.com with SMTP id e14so8986162qtm.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UMW53qYbnEJqvbLmiW8HSZb8Nx6gj/HTuK4M4tdTyjM=;
        b=VKhBgbsoGFWCh6NeNjdWAhp84u2Lz0AuRjwJIpkG/CmQZDioj7MtrxhPsU4LIHchcY
         wVoaFxUYt452jvamCYEaqugaf34Wc97l8Pv6ChBRQlKc9ei4bTblSv1YG1tp1qwrejqt
         6SQWMhe07+58+DaQVyhwKDnHAkQ23RPx6HsDKznEMa1//MW0CHPV3J0psdlvhvzJuBL8
         EG3PiL8tRqg2zwOf6fPyPI7oug9Lr+OBNcReBXRM7vRqJLMJq7iUC0JvMrzNx1V7cvtj
         AyzRhLQr7Wn6qwFaUqBp/mWke28e4EK7MtzSIf0xFDabWE8qvwR1tAALiPXmiwuyR6nP
         ouKw==
X-Gm-Message-State: AOAM5331Wow/KnGGAdyA187NXyL5UDBI2zmt+fSqY0ogLaIGbhzSgUDK
        dpujvkNST5/aHpmIRcEMmy/UOjUHiqROiyoCwXgixhqB1RF70yIZZSpMRh6nKiaD/exZEGv3sRf
        dfODO470fPSY3RcDzNiQIhE9a
X-Received: by 2002:a05:620a:145:: with SMTP id e5mr19039828qkn.479.1599487135859;
        Mon, 07 Sep 2020 06:58:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDWKcmMr1vFt4Rnb+glrvluCclhHn5iCtXltaQd+0gOGxpwp5oE+wuLyMiSrfYmeKBPhBnEw==
X-Received: by 2002:a05:620a:145:: with SMTP id e5mr19039810qkn.479.1599487135622;
        Mon, 07 Sep 2020 06:58:55 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r11sm11659852qtt.2.2020.09.07.06.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 06:58:55 -0700 (PDT)
From:   trix@redhat.com
To:     rostedt@goodmis.org, mingo@redhat.com, natechancellor@gmail.com,
        ndesaulniers@google.com, tom.zanussi@linux.intel.com,
        baohong.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] tracing: fix double free
Date:   Mon,  7 Sep 2020 06:58:45 -0700
Message-Id: <20200907135845.15804-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analyzer reports this problem

trace_events_hist.c:3824:3: warning: Attempt to free
  released memory
    kfree(hist_data->attrs->var_defs.name[i]);

In parse_var_defs() if there is a problem allocating
var_defs.expr, the earlier var_defs.name is freed.
This free is duplicated by free_var_defs() which frees
the rest of the list.

Because free_var_defs() has to run anyway, remove the
second free fom parse_var_defs().

Fixes: 30350d65ac56 ("tracing: Add variable support to hist triggers")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/trace/trace_events_hist.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0b933546142e..1b2ef6490229 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3865,7 +3865,6 @@ static int parse_var_defs(struct hist_trigger_data *hist_data)
 
 			s = kstrdup(field_str, GFP_KERNEL);
 			if (!s) {
-				kfree(hist_data->attrs->var_defs.name[n_vars]);
 				ret = -ENOMEM;
 				goto free;
 			}
-- 
2.18.1

