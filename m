Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD80C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380FA21655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780026;
	bh=oZOl4RYqt3l5gr2MsWMgKw2f8+6/Y+INPbbuX20NNgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hTMSRdJVCdPbtCS04xbvWJ6vIcc+CLAZh6CCZP3pdE4FNEdrYmzyGnMJyM7hwdZig
	 n6plxS5KGsbxvyYTFTFeToSgPLC/lYA9Yx2P8DeQQsWj817QyXDLx2KEKurdLaUkrr
	 dijzCMkZZezwepB4XXnHJAaHvGBw89nGaxWtSc+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgCISxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:53:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbgCISxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:53:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B96222B48;
        Mon,  9 Mar 2020 18:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780022;
        bh=oZOl4RYqt3l5gr2MsWMgKw2f8+6/Y+INPbbuX20NNgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z+NBG4EQbi+cQy/FF946Rr9gjil3sX+Ad7eoiVAU1aoCFCaD63q4BzzonjujQv7Qv
         sBIWHvUiMfL8LuhS3qmW1KirxvEEIcy4kupZ16fP0a5dvkx8pDO8P7HUpimMGTQpiI
         84HY9YhryKIq9rXdugZyO5uMlAgMM3gS0nFjmIvY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        disconnect3d <dominik.b.czarnota@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, John Keeping <john@metanate.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Lentine <mlentine@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/6] perf map: Fix off by one in strncpy() size argument
Date:   Mon,  9 Mar 2020 15:53:19 -0300
Message-Id: <20200309185323.22583-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200309185323.22583-1-acme@kernel.org>
References: <20200309185323.22583-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
/system/ directory is only writable by the root user, so I don't think
this bug has much (or any) security impact.

Fixes: eca818369996 ("perf tools: Add automatic remapping of Android libraries")
Signed-off-by: disconnect3d <dominik.b.czarnota@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Keeping <john@metanate.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Lentine <mlentine@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20200309104855.3775-1-dominik.b.czarnota@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 95428511300d..b342f744b1fc 100644
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
2.21.1

