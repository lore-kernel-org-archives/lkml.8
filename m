Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE853C11D24
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B380E208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582250036;
	bh=Z3Io93RMyZjx9er7hNSV+YXVieGSX4hDxd7jJRnuQwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eLtz41KkHiH25HEBJwpeEdt425nzENNbYB6wOgW75uGiKu6VqFkIwl3gpm5UIun8v
	 dzDymwlR46cSZHu47+4DD2jxCSKu6MzIM7hOPD1IeLyaW3WVnsLP8qzRhrLzr4J4N4
	 dQG1F2HtU3zb1ahn+B4BLdUJzB/ul8/dtAmT+/bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgBUBxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:53:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbgBUBxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:53:53 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C90EC206E2;
        Fri, 21 Feb 2020 01:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582250032;
        bh=Z3Io93RMyZjx9er7hNSV+YXVieGSX4hDxd7jJRnuQwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vVBVmLLaWHTcffiGGAkFQ0aL1CbXn8fDBwBJLlvD9fZJGsuURNQH+qtEQl4qNhfNL
         LI7/bE3Ymzo218bIHMDHaGCKeT2MS51FYaVMiokOvlpmpD8jruSrP4J0fHSuwTzJvZ
         +5DbhmAu98NDmp3ZDfQUZBQp/FGclMhUz63PLs8k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>
Subject: [PATCH 8/8] perf arch powerpc: Sync powerpc syscall.tbl with the kernel sources
Date:   Thu, 20 Feb 2020 22:53:10 -0300
Message-Id: <20200221015310.16914-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200221015310.16914-1-acme@kernel.org>
References: <20200221015310.16914-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Copy over powerpc syscall.tbl to grab changes from the below commits

  fddb5d430ad9 ("open: introduce openat2(2) syscall")
  9a2cef09c801 ("arch: wire up pidfd_getfd syscall")

Now 'perf trace' on powerpc will be able to map from those syscall
strings to the right syscall numbers, i.e.

  perf trace -e pidfd*

Will include 'pidfd_getfd' as well as:

  perf trace open*

Will cover all 'open' variants.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 43f736ed47f2..35b61bfc1b1a 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -517,3 +517,5 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	nospu	clone3				ppc_clone3
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
-- 
2.21.1

