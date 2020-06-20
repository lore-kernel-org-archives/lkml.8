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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED04C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE0224125
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fES8RKOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgFTSIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:08:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37350 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbgFTSIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id a3so11646415oid.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tTzMdBwq+C8/w0jNkBXGzxyfHf7JC4tZwdc4uX+IGGQ=;
        b=fES8RKOlm3MoKwpelaJutOmnpbwrNyUaDJGmFGVVhilxjje++OLgnWzGzP3k/JmwfL
         lirmd7aUGuzy9BRVjfVKmy4kGIoiMPJyLuQt68lfmdd3b/EYs9QEqHXDu3lcmiYoCsR5
         CuhkQf7f5kbqKz9CkbQpkpKwwMH4c25pBidYNdxnIlfKbstA+cQVTENCPEfeYUcdil2v
         y/EeghcLth/QW+jBygLj/5EnRWdJ22gOaUyIMFnBaQ+6vEjjB3mWNJjANDcIYCSrkjsB
         nZ8kfEtL0KJ5fjeZQ5aSKeWQnB59SD3DH2/5x5ehnDNUNf3aDCldho6L00VPqavJGW25
         tLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tTzMdBwq+C8/w0jNkBXGzxyfHf7JC4tZwdc4uX+IGGQ=;
        b=F4zKTEaLrNiejXahMglPCdS0JHfrs5n+aiET0PeYwvLB6Vc7XHCYEhgTiaa9YN8LgW
         p9zJA2OELzc4pXdhyvSXg7e7mp2ZxmZIm98zH5hKL7ytmtUaioARHNpx0hvIsdJTyWrD
         ACFxYZkKuMICJRUwYeJu3OCPHOGtlJYcw/AYPfLduwftjufkZAICgUtJoLASHc7Vh1nk
         5XHa0E6hn+tQLrleYIF15evshiLUtFO/zTFxHSU0GAMrX1JHfALQT5xZS4ZzjZHvDciT
         zR1UyV/z/TkldGx7Deug0AIVIjZrFSj364bbQgmvtuCy11eUaogXR8cn3l/40XKdbuJ/
         mIxw==
X-Gm-Message-State: AOAM530zG1SQKELfhG/AyU24JU3b5+Yj84vYATRzto8cjs8CmkdT1fqd
        c6VgCV3x4m0k40STDkb62aI=
X-Google-Smtp-Source: ABdhPJxhkczl4mgTO6PEfbw9m87LBI+co1dMpgimDk+YyNUg3phHT30kKW96YW32AmhNiZZ4ddhIEg==
X-Received: by 2002:aca:d510:: with SMTP id m16mr7487858oig.13.1592676443390;
        Sat, 20 Jun 2020 11:07:23 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:07:22 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 15/17] dyndbg: export ddebug_exec_queries
Date:   Sat, 20 Jun 2020 12:06:41 -0600
Message-Id: <20200620180643.887546-16-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export ddebug_exec_queries() for use by modules.

This will allow module authors to control all their *pr_debug*s
dynamically.  And since ddebug_exec_queries() is what implements
"echo $query >control", it gives the same complete control.

Virtues of this:
- simplicity. just an export.
- full control over any/all subsets of callsites.
- same "query/command-string" in code and console
- full callsite selectivity with module file line format

Format in particular deserves special attention; it is where
low-hanging fruit will be found.

Consider: drivers/gpu/drm/amd/display/include/logger_types.h:

  #define DC_LOG_SURFACE(...)          pr_debug("[SURFACE]:"__VA_ARGS__)
  #define DC_LOG_HW_LINK_TRAINING(...) pr_debug("[HW_LINK_TRAINING]:"__VA_ARGS__)
  .. 9 more ..

Thats 11 string prefixes, used in 804 callsites across the module.
Clearly a systematized classification of those callsites.  And one Id
expect to see repeated often.

Using ddebug_exec_queries(), authors can operate on those
classifications as a unitary set:

    echo format="[SURFACE]:" +p >control

Trivially, those sets can be subsected with the other query terms too,
should the author see fit.

Using ddebug_exec_queries() from a callback, authors can change
*pr_debug* callstates when drm.debug is updated from userspace.  They
can map bits, or strings, or whatever they want.

They could even alter [fmlt] flags, though I dont foresee why they would.

Is it safe ?

ddebug_exec_queries() is currently 'exposed' to user space in
several limited ways;

1 it is called from module-load callback, where it implements the
  $modname.dyndbg=+p "fake" parameter provided to all modules.

2 it handles query input from >control directly

IOW, it is "fully" exposed to local root user; exposing the same
functionality to other kernel modules is no additional risk.

The other big issue to check is locking:

dyndbg has a single mutex, taken by ddebug_change to handle >control,
and by ddebug_proc_(start|stop) to span `cat control`.  Queries
submitted via export will have module specified, which dramatically
cuts matching work done by ddebug_change vs "module=* +p".
ISTM this proposed export presents no locking problems.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 65c224301509..b00f536d6d12 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -546,6 +546,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		return exitcode;
 	return nfound;
 }
+EXPORT_SYMBOL_GPL(ddebug_exec_queries);
 
 #define PREFIX_SIZE 64
 
-- 
2.26.2

