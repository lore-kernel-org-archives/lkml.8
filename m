Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D846C761A6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C3420801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBuGYG/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgBTF1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:27:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41678 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgBTF1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:27:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id j9so1313057pfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=04ICLSFyPaRkKgXzzfZdAF/oV0zsl6uwE0WtmH6Mcdk=;
        b=XBuGYG/b/9V8P+Q5lKDVG7wXvYKlEE6c8cg8kwnqOuN1rLtDOxIuvziGuSpFXf428B
         Md65FKssJ7DVWF/1boKuLxXRK+pAeD4Gstm2vncKFJpOcwXWXW6N+j/cPC6SsHN7Wolg
         fu7uFesC6aiJxSUGCUWrUe0MDIkxvcrVavo51Ye1D1P3fDWuoWF0f638ONp9Mp84Ol0B
         KlPAHJqd5JAdY1od2z0riU6LsZcvehTAI3cgijXhCUGP0uDN0xOdjCZadGSz8k1aZrU7
         Ko+vIloXARoW8UpxcOd+54MLmgbK+/5WKryR9jh8zOqpeHCun3NzyppX/mHZsOd2smgY
         V2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=04ICLSFyPaRkKgXzzfZdAF/oV0zsl6uwE0WtmH6Mcdk=;
        b=Y68qtlciDAtl2h1wu23CBcbxhDqTKLfBUsTF9084EG6o24bTRrHKOvt+pyutb2ezPT
         g+4Jh3Q36pqOATx3iWSAeea0XbmMz0gjuxkKiLQUZHRVhZmzvguBgta7C047eBLzhH6m
         yadz7ETS+liZ4vSXw9Nyvsme9yWzeMBIJleCo+Hfai+8OVNP9C8Y96llFwDfrBhnXJg3
         ntqJ2jqKPR8wB8qlySA3+dGf9UwNsDN/3plqezx9V/qBumx+5vgvcMVjFGhsxroJFh//
         YJcFkfiNmuEORwtJqBifsri5ouRck2KB8juNC1uE/2pI0W0LKbZOacoGQ5MAJVgOO2HS
         TfMA==
X-Gm-Message-State: APjAAAWrEPX0DEteqBAGKmZF0uFdD894ThdXLG690vptlbi/jEz3QgXr
        rImRsWikHhp0jC4F+1EQ7Tswww==
X-Google-Smtp-Source: APXvYqzqmDBl4j3Oyt5qjuzO7eOBzDrZWQBt45Gm39QD7zP+z5EiXPHSpNwIEibYPIkhhHERZo6Kjw==
X-Received: by 2002:a63:8c18:: with SMTP id m24mr32332005pgd.70.1582176465460;
        Wed, 19 Feb 2020 21:27:45 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id l69sm1535663pgd.1.2020.02.19.21.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:27:44 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 0/9] perf cs-etm: Support thread stack and callchain
Date:   Thu, 20 Feb 2020 13:26:52 +0800
Message-Id: <20200220052701.7754-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for thread stack and callchain; this patch
set depends on the instruction sample fix patch set [1].

This patch set get more complex, so before divide into small groups, I'd
like to use this patch set version to include all relevant patches, hope
this can give whole context for related code change.

Briefly, this patch can be divided into three parts, which also can be
reviewed separately for every part:

Patches 01, 02 are used to fix samples for one corner case is for
accessing the branch's target address and trigger an exception.
Essentially, an extra branch sample is added to reflect this
mediate branch between the previous branch and exception entry.

Patches 03, 04, 05, 06 are coming from patch v4, which are used to
support thread stack and callchain.

Patches 07, 08, 09 are used to fixup for exception entry and exit.  This
is mainly used to fix two cases, one part is to fixup the thread stack
and callchain for the case when access branch target address and trigger
exception; another part is to fixup the thread stack for instruction
emulation (and other single step cases).

This patch set has been tested on Juno-r2 after applied on perf/core
branch with latest commit 85fc95d75970 ("perf maps: Add missing unlock
to maps__insert() error case"), and this patch set is also applied on
top of instruction sample fix patch set [1].


Test for option '-F,+callindent':

  # perf script -F,+callindent
            main  3258          1          branches:         main                                                         ffffad684d20 __libc_start_main+0xe0 (/usr/lib/aarch64-linux-gnu/libc-2.28.so)
            main  3258          1          branches:             lib_loop_test@plt                                        aaaae2c4d78c main+0x18 (/root/coresight_test/main)
            main  3258          1          branches:                 _dl_fixup                                            ffffad811b4c _dl_runtime_resolve+0x40 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main  3258          1          branches:                     _dl_lookup_symbol_x                              ffffad80c078 _dl_fixup+0xb8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main  3258          1          branches:                         do_lookup_x                                  ffffad80849c _dl_lookup_symbol_x+0x104 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main  3258          1          branches:                             check_match                              ffffad807bf0 do_lookup_x+0x238 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main  3258          1          branches:                                 strcmp                               ffffad807888 check_match+0x70 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main  3258          1          branches:             lib_loop_test@plt                                        aaaae2c4d78c main+0x18 (/root/coresight_test/main)
            main  3258          1          branches:             lib_loop_test@plt                                        aaaae2c4d78c main+0x18 (/root/coresight_test/main)
            main  3258          1          branches:             lib_loop_test@plt                                        aaaae2c4d78c main+0x18 (/root/coresight_test/main)
            main  3258          1          branches:             lib_loop_test@plt                                        aaaae2c4d78c main+0x18 (/root/coresight_test/main)

  [...]


Test for option '--itrace=g':

  # perf script --itrace=g16l64i100

main  3258        100      instructions: 
	    ffffad816a80 memcpy+0x70 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad809468 _dl_new_object+0xa8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad801840 dl_main+0x778 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad81384c _dl_sysdep_start+0x36c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad800884 _dl_start_final+0xac (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad800b00 _dl_start+0x200 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad800048 _start+0x8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

main  3258        100      instructions: 
	    ffffad80952c _dl_new_object+0x16c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad801840 dl_main+0x778 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad81384c _dl_sysdep_start+0x36c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad800884 _dl_start_final+0xac (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad800b00 _dl_start+0x200 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad800048 _start+0x8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

main  3258        100      instructions: 
	    ffffad8018dc dl_main+0x814 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad81384c _dl_sysdep_start+0x36c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad800884 _dl_start_final+0xac (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad800b00 _dl_start+0x200 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad800048 _start+0x8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

main  3258        100      instructions: 
	ffff8000100878d0 el0_sync_handler+0x168 ([kernel.kallsyms])
	ffff800010082d00 el0_sync+0x140 ([kernel.kallsyms])
	    ffffad801910 dl_main+0x848 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad81384c _dl_sysdep_start+0x36c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad800884 _dl_start_final+0xac (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad800b00 _dl_start+0x200 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
	    ffffad800048 _start+0x8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

  [...]

Changes from v4:
* Addressed Mike's suggestion for performance improvement for function
  cs_etm__instr_addr() for quick calculation for non T32;
* Removed the patch 'perf cs-etm: Synchronize instruction sample with
  the thread stack' (Mike);
* Fixed the issue for exception is taken for branch target address
  accessing, for the branch sample and stack thread handling, the
  related patches are 01, 02, 07;
* Fixed the stack thread handling for instruction emulation and single
  step with patches 08, 09.

Changes from v3:
* Split out separate patch set for instruction samples fixing.
* Rebased on latest perf/core branch.

Changes from v2:
* Added patch 01 to fix the unsigned variable comparison to zero
  (Suzuki).
* Refined commit logs.

Changes from v1:
* Added comments for task thread handling (Mathieu).
* Split patch 02 into two patches, one is for support thread stack and
  another is for callchain support (Mathieu).
* Added a new patch to support branch filter.

[1] https://lkml.org/lkml/2020/2/18/1406


Leo Yan (9):
  perf cs-etm: Defer to assign exception sample flag
  perf cs-etm: Reflect branch prior to exception
  perf cs-etm: Refactor instruction size handling
  perf cs-etm: Support thread stack
  perf cs-etm: Support branch filter
  perf cs-etm: Support callchain for instruction sample
  perf cs-etm: Fixup exception entry for thread stack
  perf thread: Add helper to get top return address
  perf cs-etm: Fixup exception exit for thread stack

 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   1 +
 tools/perf/util/cs-etm.c                      | 290 ++++++++++++++++--
 tools/perf/util/thread-stack.c                |  10 +
 tools/perf/util/thread-stack.h                |   1 +
 4 files changed, 268 insertions(+), 34 deletions(-)

-- 
2.17.1

