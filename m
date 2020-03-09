Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320BEC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05EE620674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abXdx6cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgCIKtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:49:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44108 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCIKtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:49:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id l18so334829wru.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 03:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zdAdi1VeNLIMn/A850IorBcZfUSi7qWyqIy5L4PClVw=;
        b=abXdx6cvcA4yeqRcBtnL9g/EKmNKGfEKb04pLm7JH/zpP8f8ZaLP44dQgFJ0qTbFt/
         W/C9bdYKsgYxjfJL9FVIHiNt5tqrL9BHDaUbtUaiVzIE9yQmpzXb53YziHt+EqcwVAz4
         zJ1qNyrH+uVuv3vkmmutFcD/qgSYyp1c7svUZm0/XCl/F4z4nKaXXA4p8UtmfFbsE3sx
         rlQ4/35mlusFkYFJ14iSTAPyFUBxny37nI15qBtS0HKvHzuIC/NHMDAure+WHv+2U1Ao
         B0Xmjzi4Csxa7tV1Wd3ARGtJ+ObblaPNmSbZWZBxjACg5jznHIaX/IhGQ6RQkbC6czIk
         4Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zdAdi1VeNLIMn/A850IorBcZfUSi7qWyqIy5L4PClVw=;
        b=A1rsX5VVyU4P6PPT5mtVM6QHFg5AzYY8dz/RvHVLViLtCHwMEPxPlH2lVTDESIXbg1
         /eWpueVsy70FDz/nnszhqyDiAdJOgGxk2bBdGBWD5SSelRQ1mlntAaoMBa9kBo3YGBcV
         gT+3wHZuge/M52u1JCDT1s/J4M/zzuULzH6/BeHWKtRGzl0iCmXXD6Ul/RQtMufrgbmZ
         UvfAO/eyLJ8P3qmx0/ppES1TS07pgAX1EX1FgwOOx4B5xrF5vYoA8yfpKRAYcY2BeQr1
         a60by5cDoTT0NWmfm6KGXpu/eBsSnqjnYT70xGn8S4VRr6rGhFUNX6bGBPAKVtUb7Wwb
         157A==
X-Gm-Message-State: ANhLgQ3dZbCUwiBG7qDEe4JgLMh+KJ8vGK7St9WZNDfaCuzAUjYSnoUs
        Nq+EZtoc7DAwSfq1fvjyenU=
X-Google-Smtp-Source: ADFU+vvVa/qBP+WQ4M2iYjgkyxvia3H7Zm4DIox9lMqNwCCV2rU2rAIhUA0mauTp3q4zAJn0T8UM/w==
X-Received: by 2002:adf:ed09:: with SMTP id a9mr4332790wro.307.1583750953094;
        Mon, 09 Mar 2020 03:49:13 -0700 (PDT)
Received: from localhost.localdomain (178.43.54.24.ipv4.supernova.orange.pl. [178.43.54.24])
        by smtp.gmail.com with ESMTPSA id r3sm22580520wmg.19.2020.03.09.03.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 03:49:12 -0700 (PDT)
From:   Dominik 'disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Cc:     dominik.b.czarnota@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        John Keeping <john@metanate.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix off by one in tools/perf strncpy size argument
Date:   Mon,  9 Mar 2020 11:48:53 +0100
Message-Id: <20200309104855.3775-1-dominik.b.czarnota@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: disconnect3d <dominik.b.czarnota@gmail.com>

This patch fixes an off-by-one error in strncpy size argument in
tools/perf/util/map.c. The issue is that in:

        strncmp(filename, "/system/lib/", 11)

the passed string literal: "/system/lib/" has 12 bytes (without the NULL
byte) and the passed size argument is 11. As a result, the logic won't
match the ending "/" byte and will pass filepaths that are stored in
other directories e.g. "/system/libmalicious/bin" or just
"/system/libmalicious".

This functionality seems to be present only on Android. I assume the
/system/ directory is only writable by the root user, so I don't
think this bug has much (or any) security impact.

Signed-off-by: disconnect3d <dominik.b.czarnota@gmail.com>
---

Notes:
    I can't test this patch, so if someone can, please, do so.
    
    The bug could also be fixed by changing the size argument to `sizeof("string literal")-1` but I am not proposing this change as that would have to be changed in other places.
    
    There are also more cases like this in kernel sources which I am going to report soon.
    
    Also please note that other path comparisons in this file lack the "/" at the end and it seems they may imply similar issue. I haven't analysed the code deeply to see if that is a real issue.
    
    This bug has been found by running a massive grep-like search using Google's BigQuery on GitHub repositories data. I am also going to work on a CodeQL/Semmle query to be able to find more sophisticated cases like this that can't be found via grepping.

 tools/perf/util/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index a08ca276098e..addd7edb0486 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -89,7 +89,7 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 		return true;
 	}
 
-	if (!strncmp(filename, "/system/lib/", 11)) {
+	if (!strncmp(filename, "/system/lib/", 12)) {
 		char *ndk, *app;
 		const char *arch;
 		size_t ndk_length;
-- 
2.25.1

