Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA1DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBCFD20720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594282038;
	bh=uuIItKbVy/ksvMT/I7W0t4Mekqy5bWcYvM2MBH5LKig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hGLbRP2ywzP6NKDF5qujHAjaZpbXa+AyS+3BbY6rr9GA2vRkclHV6r7EUZWYA5O0V
	 8mYE29RHswVgv6d5dRdAmM1ttYFaoK+kB6wCFALksxMPyMtb0qr2O8WlqOblCYOtK9
	 hcI9SW+TIL1UROQAN36+OSkqC5Kt4OzDh4lzY5gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgGIIHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgGIIHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:07:17 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96C8720720;
        Thu,  9 Jul 2020 08:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594282036;
        bh=uuIItKbVy/ksvMT/I7W0t4Mekqy5bWcYvM2MBH5LKig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhL9QPACO1f/+mRvgP5tGHS6fQfp1FickFwiz01aQaiuLz0CNwr4rGVEEWMTR5lTx
         v/sj4pgBae4mPAoATIZhy8oiB4Us6mYUBS9gCQyk0SBLoeJe0czvOxLsS+kDeexm1O
         juMD6vxhNw9XVyusGQSYHMfv7REgtiRR91/HdbUM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/4] perf-probe: Fix wrong variable warning when the probe point is not found
Date:   Thu,  9 Jul 2020 17:07:12 +0900
Message-Id: <159428203219.56570.8289435784233418736.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159428201109.56570.3802208017109058146.stgit@devnote2>
References: <159428201109.56570.3802208017109058146.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a wrong "variable not found" warning when the probe point is
not found in the debuginfo.
Since the debuginfo__find_probes() can return 0 even if it does not
find given probe point in the debuginfo, fill_empty_trace_arg() can
be called with tf.ntevs == 0 and it can warn a wrong warning.
To fix this, reject ntevs == 0 in fill_empty_trace_arg().

E.g. without this patch;

  # perf probe -x /lib64/libc-2.30.so -a "memcpy arg1=%di"
  Failed to find the location of the '%di' variable at this address.
   Perhaps it has been optimized out.
   Use -V with the --range option to show '%di' location range.
  Added new events:
    probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)
    probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)

  You can now use it in all perf tools, such as:

  	perf record -e probe_libc:memcpy -aR sleep 1

With this;

  # perf probe -x /lib64/libc-2.30.so -a "memcpy arg1=%di"
  Added new events:
    probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)
    probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)

  You can now use it in all perf tools, such as:

  	perf record -e probe_libc:memcpy -aR sleep 1


Reported-by: Andi Kleen <andi@firstfloor.org>
Fixes: cb4027308570 ("perf probe: Trace a magic number if variable is not found")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-finder.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 55924255c535..9963e4e8ea20 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1408,6 +1408,9 @@ static int fill_empty_trace_arg(struct perf_probe_event *pev,
 	char *type;
 	int i, j, ret;
 
+	if (!ntevs)
+		return -ENOENT;
+
 	for (i = 0; i < pev->nargs; i++) {
 		type = NULL;
 		for (j = 0; j < ntevs; j++) {

