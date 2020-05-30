Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAF8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD812075A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M908Kpub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgE3IUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgE3IUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:20:38 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06D9C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 01:20:37 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d2so5146419qtw.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 01:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rUynu7wHkaD5M9a1OIoajT2/mS+pyvyBnkF6EWXrYFA=;
        b=M908KpubgjzN+UifxWiv9y9xGUGRrrhjTHuR6/Hmqz/sy75ks9hJDa9h6oLkFSNOJZ
         YfIOUZFYQkaIyD+TK/H5srYpDOZdDEBHMvQcdDJ7C38Rv9No7vwSzPbSCwj1NfFe37ug
         3Bd3W5yb2oBTFKN3knKXJnXhQRAZug9ZxH+vytCzucRaICpGFojHoUWmks2nEDXVTfj3
         fhzfFfrjD6bPuICSa1r3zE9cGYuNkUjULPcc9JcXo7XENLY/0678AnZgBz9g3YRqsMCA
         HnmtkgTPh7zAXT+lwsOm7aufm2ash7RSw2oXL+rBOIEDpFyqL3NqtyEDs+9e88APhHQO
         /2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rUynu7wHkaD5M9a1OIoajT2/mS+pyvyBnkF6EWXrYFA=;
        b=jNSw6xEbDdhiREJ0YfoB8CzeECVIiM9nzUazZw0s3GmY8SyTFacl334GsryMQQbvFI
         ywI1CBELxSZSLzisebqrJxZ9Rzu26rGzbvKKhF083jK0QNWbGChq2iTqbPVz/CzqUpvZ
         UAqZDx7NqkKS9bKjdMRORAfpW5WLu/KACLP37OAquWGjWc7y87OTuOkQFD5mIYqmN3jH
         qDeQOik0oo9JipeHZLaJyWqaS4jz+Zqa7mHCTSROa1aS/lQ9yO0vdI5j7f4Rur4Ngkgq
         DTzn4j4PtFzKglUUIb/uNfFahQnXxWEPmYtw3I9XNFR6KS743vkgu1EzbBDrZa0/DR8h
         FPtA==
X-Gm-Message-State: AOAM533ORJTc3lABqcemOUvXcJBmOf7aj+wCSeFvvo+0duH75u8vuRVh
        XLRRAo7SU1xNgKnOjChizL0KXyQi2RLV
X-Google-Smtp-Source: ABdhPJw/idJvDDusDhU5iLJPOhK8xyEOZeTUU7DTeJ4npG9rt02vVN4l7rNOGcV5rP1V6lyshpjtOGHRUZLx
X-Received: by 2002:a0c:dd88:: with SMTP id v8mr108967qvk.73.1590826835580;
 Sat, 30 May 2020 01:20:35 -0700 (PDT)
Date:   Sat, 30 May 2020 01:20:12 -0700
Message-Id: <20200530082015.39162-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH 0/3] perf test: Unwind fixes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix stack frame count and memory sanitizer issues when running the
dwarf unwinding test with the elfutils/libdw unwinder (libunwind
disabled).

Ian Rogers (3):
  tools compiler.h: Add attribute to disable tail calls
  perf tests: Don't tail call optimize in unwind test
  perf test: Initialize memory in dwarf-unwind

 tools/include/linux/compiler-gcc.h       |  8 ++++++++
 tools/include/linux/compiler.h           |  3 +++
 tools/perf/arch/x86/tests/dwarf-unwind.c |  8 ++++++++
 tools/perf/tests/dwarf-unwind.c          | 11 ++++++-----
 4 files changed, 25 insertions(+), 5 deletions(-)

-- 
2.27.0.rc2.251.g90737beb825-goog

