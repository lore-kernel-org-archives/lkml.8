Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA81C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077C82080C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EW5Vv5n+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgCBOzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:55:40 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35975 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBOzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:55:40 -0500
Received: by mail-qv1-f65.google.com with SMTP id r15so223439qve.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 06:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=0CpiaNQchpE16G6mANWZwg+nmZTjaWwL7tiiRnj9aPM=;
        b=EW5Vv5n+D0f0UsNthc3h71t87hgxrDN6gLEo145hhbKf1ajrmajo6rJt7kavSWyTI4
         bwFu8iNIAvoYKIEv0cktWcTI9/Q9uAh1K90YRpoh5HVSi9rTkn+38cDLnym8EYTWoj7M
         UeXwTAzvd0DPluF4XF47pUItLYvHwLRfs1xPlCszLhOBe0rfX7mMcpK9GMfZnLYqEjZ1
         YuwzI86DbYmLFUH2sf7aoUW3SOzF/xjx+R/ywSCGVKhZAETGtpnBO/wigsvwNawBBkZL
         N9XT5679xeiVdnlgYDkZ1pwIOmIc5h5TlEJVg22wnyICC3B1QnHtfIquma1hlc5/4S21
         Cszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=0CpiaNQchpE16G6mANWZwg+nmZTjaWwL7tiiRnj9aPM=;
        b=aoGnemvx9mVbdAO1KOJ0JgxvbaZ4cAH1wkTtBfqbtQp2Neuf25vDXf/PduqxyEa/bI
         v3/QtfM4VK1RZdmhfr28NeA3NwxQuE54rlktHn+xr1gtEl2eP7TR0ZnwQ3rxNFs+/zEU
         YmVsKjxPqzZWRs+4+xq/sYEqv9q/1g8ZRA8giNeIwoZ756dTZaQMmzeMSCYM87IsVPu5
         zFM9AZR2DV3ey5tsglTkwnazRnO0Sw6m8Sgxlab7FmUJGA2ZDSOft09LztfZiR8MWW92
         Br2At5N4sexgHHl7BEly5ecpckeIHh2jLBgyvn7d9R6fJUFQH3ua5hdY21G4QxOvvZ6H
         5b5Q==
X-Gm-Message-State: ANhLgQ2Yl+IRt4nNvXKAJ8lcNW9rEmOsQw6uSi4O4ZvTgUu+kwYRELAa
        QuFHuzRvfXpNZ5K3CQl+NVP3QsJYwzo=
X-Google-Smtp-Source: ADFU+vvesLUwxRNmnURWg/vjPlfWrJWFNvK8XeqM6VCnKNj4HaX0n3ghYn5mnBDLZQGi3ALvgQtHAg==
X-Received: by 2002:ad4:5288:: with SMTP id v8mr6695869qvr.120.1583160939125;
        Mon, 02 Mar 2020 06:55:39 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id i132sm10353996qke.41.2020.03.02.06.55.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 06:55:38 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C8F03403AD; Mon,  2 Mar 2020 11:55:35 -0300 (-03)
Date:   Mon, 2 Mar 2020 11:55:35 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf parse-events: Use asprintf() instead of strncpy() for
 tracepoints
Message-ID: <20200302145535.GA28183@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Noticed this with gcc 10 on fedora rawhide:

In file included from /usr/include/string.h:495,
                 from util/parse-events.h:12,
                 from util/parse-events.c:18:
In function ‘strncpy’,
    inlined from ‘tracepoint_id_to_path’ at util/parse-events.c:271:5:
/usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ offset [275, 511] from the object at ‘sys_dirent’ is out of the bounds of referenced subobject ‘d_name’ with type ‘char[256]’ at offset 19 [-Werror=array-bounds]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /usr/include/dirent.h:61,
                 from util/parse-events.c:5:
util/parse-events.c: In function ‘tracepoint_id_to_path’:
/usr/include/bits/dirent.h:33:10: note: subobject ‘d_name’ declared here
   33 |     char d_name[256];  /* We must not include limits.h! */
      |          ^~~~~~
In file included from /usr/include/string.h:495,
                 from util/parse-events.h:12,
                 from util/parse-events.c:18:
In function ‘strncpy’,
    inlined from ‘tracepoint_id_to_path’ at util/parse-events.c:273:5:
/usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ offset [275, 511] from the object at ‘evt_dirent’ is out of the bounds of referenced subobject ‘d_name’ with type ‘char[256]’ at offset 19 [-Werror=array-bounds]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /usr/include/dirent.h:61,
                 from util/parse-events.c:5:
util/parse-events.c: In function ‘tracepoint_id_to_path’:
/usr/include/bits/dirent.h:33:10: note: subobject ‘d_name’ declared here
   33 |     char d_name[256];  /* We must not include limits.h! */
      |          ^~~~~~
  CC       /tmp/build/perf/util/call-path.o

So I replaced it with asprintf to make the code shorter, use a bit less
memory and deal with the above problem, ok?

- Arnaldo

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c01ba6f8fdad..a14995835d85 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -257,21 +257,15 @@ struct tracepoint_path *tracepoint_id_to_path(u64 config)
 				path = zalloc(sizeof(*path));
 				if (!path)
 					return NULL;
-				path->system = malloc(MAX_EVENT_LENGTH);
-				if (!path->system) {
+				if (asprintf(&path->system, "%.*s", MAX_EVENT_LENGTH, sys_dirent->d_name) < 0) {
 					free(path);
 					return NULL;
 				}
-				path->name = malloc(MAX_EVENT_LENGTH);
-				if (!path->name) {
+				if (asprintf(&path->name, "%.*s", MAX_EVENT_LENGTH, evt_dirent->d_name) < 0) {
 					zfree(&path->system);
 					free(path);
 					return NULL;
 				}
-				strncpy(path->system, sys_dirent->d_name,
-					MAX_EVENT_LENGTH);
-				strncpy(path->name, evt_dirent->d_name,
-					MAX_EVENT_LENGTH);
 				return path;
 			}
 		}
