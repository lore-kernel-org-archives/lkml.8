Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9518FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D59820737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkBBy5U3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390135AbgDBRlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:41:35 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:33457 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389093AbgDBRle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:41:34 -0400
Received: by mail-pf1-f202.google.com with SMTP id o5so3573444pfp.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=371o/vNhJY1GWeYnWWYQwId4nlaG8dGoisjj7qeE9aM=;
        b=qkBBy5U3CMM7MZifcMDDdewLDPNKJAomOP8csqTCRViOau1jlVdJ7cylogBTm4NSZB
         jcI0H99RSpOCgYqr7Rv9sepwzun5PqKILYEXEQKLc/H5TqUQchwp6oObnjkK2bawZVfm
         cBYGJwwx8EehsKB8RiJQXp3lHHeMaz4v0GE3B/k2mAmsMtZY8ZzTdnxbocVxYw+VlWEw
         91x7AAlfhnAL0JZxMVlqmLt7zfQRVIOYqZW4VJnMqbD5NB7MmyCabpiIkiXFcExcYCbi
         KcbbE8yiXIxrCcc1cU/4OHea0UQE7wvIMtaauz4ttnblB8kfWVp5B5HkzcOufUroOcyG
         NzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=371o/vNhJY1GWeYnWWYQwId4nlaG8dGoisjj7qeE9aM=;
        b=Z5CQQ3rgxXNlKHUSbLVJJTin1O3zwxfKtn3PljPf+VqEOR9jfkIYf/AJDxrvngLqrJ
         KCNv8suBNTK+0+4C+RQdixn/WXdfU1eaKDm43WSZyb7D7AH0JRPVW410l9kEoE96zPBQ
         knw0/g4fs9rEEfOlKQ8+dYDoSNHCH1HAsjm/QFQm1ALiMp8WcGA6iII39LsDb7jVO87I
         sabld0eow1W2sXj1cb8BtzVqjv/1nKkkD9ElB0/aIZILh2+liBQNIxYDWW5eR6Wad8wf
         +u3U2aYiPSqmURSyFXxP9XeLvlGRGSAZvDCCCLISn6syjoutdcryC3mY3ubeoAwt+mct
         M/Jg==
X-Gm-Message-State: AGi0PubQgfE9imYRc//lDDTVSo5lIQyCrAZ7FwHNDG8wnpSxiZDunaNS
        LafoZeTeYwLqnAhg5nwgkNbyRS7r8tWX
X-Google-Smtp-Source: APiQypJepdKj0PDf1373XbxO5BqkbKcEEtSv8GdcD9TG2LRknOWN3R4OthW3IhKm1jLGeqaITsZPTG0bTNVz
X-Received: by 2002:a17:90a:32c5:: with SMTP id l63mr5185816pjb.47.1585849293626;
 Thu, 02 Apr 2020 10:41:33 -0700 (PDT)
Date:   Thu,  2 Apr 2020 10:41:30 -0700
Message-Id: <20200402174130.140319-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH] perf script: add -S/--symbols documentation
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Capture both that this option exists and that symbols can be hexadecimal
addresses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-script.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 99a9853a11ba..963487e82edc 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -412,6 +412,14 @@ include::itrace.txt[]
 --xed::
 	Run xed disassembler on output. Requires installing the xed disassembler.
 
+-S::
+--symbols=symbol[,symbol...]::
+	Only consider the listed symbols. Symbols are typically a name
+	but they may also be hexadecimal address.
+
+	For example, to select the symbol noploop or the address 0x4007a0:
+	perf script --symbols=noploop,0x4007a0
+
 --call-trace::
 	Show call stream for intel_pt traces. The CPUs are interleaved, but
 	can be filtered with -C.
-- 
2.26.0.rc2.310.g2932bb562d-goog

