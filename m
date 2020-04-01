Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65352C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF1E21556
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758510;
	bh=Tmn5oleCgqpuxbdTFU9DQWUHW4JqZTaDz7bSMafc/Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WUHo0SOVgCY1bOty4NrC4IW9eTenUVtLQCEfc5LJrO2m1V6IaRKv957M7JHzZby+T
	 EMfzxW2DYNHAzZMO9nYuT7G0lYDV4ga7en7cks+2RqX34KGL4cGFrG7IEMq4aAM9TY
	 GW2src+YbClBEmnl29FQiRkvAcpqENnnBUo65/os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388124AbgDAQ23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388104AbgDAQ21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:28:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32BA120857;
        Wed,  1 Apr 2020 16:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758506;
        bh=Tmn5oleCgqpuxbdTFU9DQWUHW4JqZTaDz7bSMafc/Eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hkxaCa95Bse6LViwdzY/piHRkk13DTYzbEOabeFvTKja4AWlYL5XYfdF6YUnloU3y
         1snFcgQUi+KTb789D6zs85FM9rDNuaH9YmsWi4DMez3o1/sE04pErvWn1UyWt2Xt4u
         M5VRFM4nhLYIQvcrxPJHsHyASqhG79pWEsl8h0rI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        disconnect3d <dominik.b.czarnota@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, John Keeping <john@metanate.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Lentine <mlentine@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 110/116] perf map: Fix off by one in strncpy() size argument
Date:   Wed,  1 Apr 2020 18:18:06 +0200
Message-Id: <20200401161556.222657643@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: disconnect3d <dominik.b.czarnota@gmail.com>

commit db2c549407d4a76563c579e4768f7d6d32afefba upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/map.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -85,7 +85,7 @@ static inline bool replace_android_lib(c
 		return true;
 	}
 
-	if (!strncmp(filename, "/system/lib/", 11)) {
+	if (!strncmp(filename, "/system/lib/", 12)) {
 		char *ndk, *app;
 		const char *arch;
 		size_t ndk_length;


