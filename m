Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C128BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0598207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590586489;
	bh=qX8tDKwCNrMJuCf2/sY1GfVbI6T8Hbojb6verUXTvAc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rDS4kDjTfgZnuEoRvvR/jxYQ5F216ZdMeC2sG/+PzGStqsMbRYe256i5h8PyVvFYp
	 Cus+4359Yl5vVrxDQBWu8Y2aFk5cxE66G8fi/j2+WsP5hY/a/nD1JM5z+Qk4SZ5Evq
	 OA3VSo2FOlFYTSTTMkdMCXGeMIdqLk7YS/fVsEOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbgE0Net (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:34:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387664AbgE0Ner (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:34:47 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3302207CB;
        Wed, 27 May 2020 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590586487;
        bh=qX8tDKwCNrMJuCf2/sY1GfVbI6T8Hbojb6verUXTvAc=;
        h=Date:From:To:Cc:Subject:From;
        b=VlzVQ31KmSEOR/Q+pON6KQeS6zoc1wFbJtntY2RH/c7Hb8rPbOBdV4po/w42ydsYN
         TJp0hisRfSX+dGgL6TP6DYs+/nK0FJtmvAonHuXVi7qcV8g9zfRGTKbed5/JRiNbdi
         CytsjKlaI+JYiLl4nmibkmHn/OSs/MjCU/nfLvGs=
Date:   Wed, 27 May 2020 08:39:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] m68k: Use sizeof_field() helper
Message-ID: <20200527133942.GA10408@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the sizeof_field() helper instead of an open-coded version.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/m68k/kernel/signal.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index b3ff39588f36b..fc034fd19798e 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -61,25 +61,25 @@
 #define	FMT4SIZE	0
 #else
 #define	FORMAT		0
-#define	FMT4SIZE	sizeof(((struct frame *)0)->un.fmt4)
+#define	FMT4SIZE	sizeof_field(struct frame, un.fmt4)
 #endif
 
 static const int frame_size_change[16] = {
-  [1]	= -1, /* sizeof(((struct frame *)0)->un.fmt1), */
-  [2]	= sizeof(((struct frame *)0)->un.fmt2),
-  [3]	= sizeof(((struct frame *)0)->un.fmt3),
+  [1]	= -1, /* sizeof_field(struct frame, un.fmt1), */
+  [2]	= sizeof_field(struct frame, un.fmt2),
+  [3]	= sizeof_field(struct frame, un.fmt3),
   [4]	= FMT4SIZE,
-  [5]	= -1, /* sizeof(((struct frame *)0)->un.fmt5), */
-  [6]	= -1, /* sizeof(((struct frame *)0)->un.fmt6), */
-  [7]	= sizeof(((struct frame *)0)->un.fmt7),
-  [8]	= -1, /* sizeof(((struct frame *)0)->un.fmt8), */
-  [9]	= sizeof(((struct frame *)0)->un.fmt9),
-  [10]	= sizeof(((struct frame *)0)->un.fmta),
-  [11]	= sizeof(((struct frame *)0)->un.fmtb),
-  [12]	= -1, /* sizeof(((struct frame *)0)->un.fmtc), */
-  [13]	= -1, /* sizeof(((struct frame *)0)->un.fmtd), */
-  [14]	= -1, /* sizeof(((struct frame *)0)->un.fmte), */
-  [15]	= -1, /* sizeof(((struct frame *)0)->un.fmtf), */
+  [5]	= -1, /* sizeof_field(struct frame, un.fmt5), */
+  [6]	= -1, /* sizeof_field(struct frame, un.fmt6), */
+  [7]	= sizeof_field(struct frame, un.fmt7),
+  [8]	= -1, /* sizeof_field(struct frame, un.fmt8), */
+  [9]	= sizeof_field(struct frame, un.fmt9),
+  [10]	= sizeof_field(struct frame, un.fmta),
+  [11]	= sizeof_field(struct frame, un.fmtb),
+  [12]	= -1, /* sizeof_field(struct frame, un.fmtc), */
+  [13]	= -1, /* sizeof_field(struct frame, un.fmtd), */
+  [14]	= -1, /* sizeof_field(struct frame, un.fmte), */
+  [15]	= -1, /* sizeof_field(struct frame, un.fmtf), */
 };
 
 static inline int frame_extra_sizes(int f)
@@ -651,7 +651,7 @@ static int mangle_kernel_stack(struct pt_regs *regs, int formatvec,
 	} else {
 		struct switch_stack *sw = (struct switch_stack *)regs - 1;
 		/* yes, twice as much as max(sizeof(frame.un.fmt<x>)) */
-		unsigned long buf[sizeof(((struct frame *)0)->un) / 2];
+		unsigned long buf[sizeof_field(struct frame, un) / 2];
 
 		/* that'll make sure that expansion won't crap over data */
 		if (copy_from_user(buf + fsize / 4, fp, fsize))
-- 
2.26.2

