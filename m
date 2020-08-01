Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55184C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 19:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8E0206D4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 19:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596308810;
	bh=JkhHR/fUIESIOC8f9K4/uYsBtd9K8nxoVSQU50WWlOE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ef+oIDyF4oAI6EB9ao6x39aleUS1JlMEjF4LcyFO3NpAVMPTutmklUmXgYKfav1qq
	 mGeMPCDui99lV7OCKcQIm2gvkEG8OK9j5vBmAaJIo1Wfz2kkyT6tA0/Rn4BB0+X/4T
	 OP8uZNbU9inQ8JYnyYgu+DFWxi3Rwdmkftw3B3pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgHATG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 15:06:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgHATG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 15:06:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86F0E206D4;
        Sat,  1 Aug 2020 19:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596308787;
        bh=JkhHR/fUIESIOC8f9K4/uYsBtd9K8nxoVSQU50WWlOE=;
        h=From:To:Cc:Subject:Date:From;
        b=fgAiIKL1aV+8NtUiCOnIUNcJJXyDDUZxJzB4qQeW/A4LZ5NN+Weezqx690/NhpNlT
         dncemUauu6JNtoyPYUsdSteSncNOH09NpbuqKKexEkzDjH8NYCe0ov6anXgENJ2OWr
         TDfe66KGRigvZ0JGJOZYpcIDk+Zbvr0gqI77044Q=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Philippe Duplessis-Guindon <pduplessis@efficios.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] Fourth batch of perf tooling fixes for v5.8
Date:   Sat,  1 Aug 2020 16:06:18 -0300
Message-Id: <20200801190618.3311731-1-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit d8b9faec54ae4bc2fff68bcd0befa93ace8256ce:

  Merge tag 'drm-fixes-2020-07-31' of git://anongit.freedesktop.org/drm/drm (2020-07-30 21:26:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2020-08-01

for you to fetch changes up to 39efdd94e314336f4acbac4c07e0f37bdc3bef71:

  libtraceevent: Fix build with binutils 2.35 (2020-07-31 09:31:55 -0300)

----------------------------------------------------------------
Fourth batch of perf tooling fixes for v5.8:

- Fix libtraceevent build with binutils 2.35.

- Fix memory leak in process_dynamic_array_len in libtraceevent.

- Fix 'perf test 68' zstd compression for s390.

- Fix record failure when mixed with ARM SPE event.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Ben Hutchings (1):
      libtraceevent: Fix build with binutils 2.35

Philippe Duplessis-Guindon (1):
      tools lib traceevent: Fix memory leak in process_dynamic_array_len

Thomas Richter (1):
      perf tests: Fix test 68 zstd compression for s390

Wei Li (1):
      perf tools: Fix record failure when mixed with ARM SPE event

 tools/lib/traceevent/event-parse.c                | 1 +
 tools/lib/traceevent/plugins/Makefile             | 2 +-
 tools/perf/arch/arm/util/auxtrace.c               | 8 ++++----
 tools/perf/tests/shell/record+zstd_comp_decomp.sh | 3 ++-
 4 files changed, 8 insertions(+), 6 deletions(-)
