Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727E7C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D47020720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589227481;
	bh=n63/YfSS2BLXhpW9OHsMu3MiGnyizgEMk8AT2HW5xMs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Q7Rnj+iLKBhFdSO1Nyr4ZoRSyRE5W/z0lvkZODqaptdVgIwr7Mrdv3HMeupGwrebV
	 6OzAXr+jnY2tNBIfyemMhYbrqnNO3Qiuc8sW867v+bfciZVGMmrMOBqI7BqYvbNQ15
	 kj6nojxb5vNBqjy3zxOy6GE24cHXBe8I7Q8xHwuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbgEKUEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgEKUEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:04:40 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F2E6206F5;
        Mon, 11 May 2020 20:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589227479;
        bh=n63/YfSS2BLXhpW9OHsMu3MiGnyizgEMk8AT2HW5xMs=;
        h=Date:From:To:Cc:Subject:From;
        b=XL4ioT8pz8LypKXDgGNkR5hgGiQk1tQvV5FO7JM0T2Qm+FVPeCTcJlveImKmRYFDE
         Y+T8oqoS8IqfwI3hU9b1zXUzC5LXq1T8JJz4neAUzrj3m//BZalBJkh88x74nxGrpW
         KFi8aBMGIa+LYsnUEUu2xdwU71TeZLjAkbVF2OiI=
Date:   Mon, 11 May 2020 15:09:11 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] perf/x86: Replace zero-length array with flexible-array
Message-ID: <20200511200911.GA13149@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/x86/events/intel/bts.c    | 2 +-
 arch/x86/events/intel/uncore.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 6a3b599ee0fe..731dd8d0dbb1 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -58,7 +58,7 @@ struct bts_buffer {
 	local_t		head;
 	unsigned long	end;
 	void		**data_pages;
-	struct bts_phys	buf[0];
+	struct bts_phys	buf[];
 };
 
 static struct pmu bts_pmu;
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 0da4a4605536..b469ddd45515 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -130,7 +130,7 @@ struct intel_uncore_box {
 	struct list_head list;
 	struct list_head active_list;
 	void __iomem *io_addr;
-	struct intel_uncore_extra_reg shared_regs[0];
+	struct intel_uncore_extra_reg shared_regs[];
 };
 
 /* CFL uncore 8th cbox MSRs */
-- 
2.26.2

