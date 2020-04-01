Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78EFC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F0720784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sh8B2DiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbgDAQU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:20:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34058 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732905AbgDAQUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:20:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id 65so813773wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qJoVQBaRHJQYbVT1GJGTHlpTo29YQGbRt1FnJ8Q12S8=;
        b=sh8B2DiXOiWdTC/QlWSo5qJq5PlO04nPxzc5xPhwqU0fqQY8HW7uaoPnEZFA6lAqPg
         ZMaaMUPGE2T6Y+hRWrkIqWUXep1l5SmH9O6KfhlS+iqbje7hSj4qh1IxzEnmQZLU48a8
         rO9/WiUH6b7WNeZ8MsCj0HRUeuvJT1w+MAF9NiKGKlwkNBytTNtRobTiGx6uf0Au8elq
         ztGVxx3us1OW9tFYn3C9AhUunrXUxsn967RZeV5aMLpxmwn/k8a8vzJLmx/w5PP9HOYL
         ongIMp0xVXong+l/M/4jX46dIlFbb2d4YxzLNfF4C5ba2spvOOydscrC6KL1P0eaVynz
         Gmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qJoVQBaRHJQYbVT1GJGTHlpTo29YQGbRt1FnJ8Q12S8=;
        b=VAnsefP/44aohK7wzZNQ8w7fpM8p3iB0lJ0VGsDbk/pZfZYzgMyF1OLn5qKILRT6Gy
         VI2yQAW4uRTczm/aOFq6vyfDzIU7MNl1JCJhzjH1dLneRQBwcGrHY75BGHWBqvpPhPVm
         xXoPhvbhVeGnc3HGroQLlvDPldQ1YR8Axs4jqq5nF/ZgPKZV2U920gcWcDj/IQ7KT0xt
         MfW/7S1pf9yNuIeuwoZeVza/vRJ8BnMRCF/gUWzH86Rm9zrCo2u8BdQQdTf8a22LMoqD
         O8hsxNG2u3Ye3OBPPgvnmajGnou4A5/nwQyQPef0uZ210DeMAzrvzfrmR7EM2N1f1vH3
         tJ+g==
X-Gm-Message-State: ANhLgQ3mYejQ+496YQi+BGJxgCcI9TB+nPnI/Vm+nXd7R+X2tTszjcVa
        2mM4Vukw5zMpYc9qJCXSyAQ=
X-Google-Smtp-Source: ADFU+vv4V0fyp0xmIa06RHGv+1mqQNSwKoo8SzC6ChqvoD/UnqpyMnlCM/3PalLUrlCNEolzghMMgw==
X-Received: by 2002:a05:6000:1c4:: with SMTP id t4mr25772479wrx.89.1585758023215;
        Wed, 01 Apr 2020 09:20:23 -0700 (PDT)
Received: from localhost.localdomain ([213.137.85.32])
        by smtp.googlemail.com with ESMTPSA id q9sm3871009wrp.84.2020.04.01.09.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 09:20:22 -0700 (PDT)
From:   Daniel Shaulov <daniel.shaulov@gmail.com>
X-Google-Original-From: Daniel Shaulov <daniel.shaulov@granulate.io>
Cc:     Daniel Shaulov <daniel.shaulov@granulate.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf probe: Add support for DW_OP_call_frame_cfa vars
Date:   Wed,  1 Apr 2020 19:19:52 +0300
Message-Id: <20200401161954.44640-1-daniel.shaulov@granulate.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probes on variables with DW_OP_call_frame_cfa
as the dwarf operation in the debug info.

Some compilers (specifically Golang compiler) output
DW_OP_call_frame_cfa instead of DW_OP_fbreg for variables
on the stack. If DW_OP_call_frame_cfa is the only expression
than it is the same as DW_OP_fbreg with an offset of zero.
In the case of the Golang compiler, DW_OP_call_frame_cfa may
be followed by DW_OP_consts, with a number and than DW_OP_plus.
This trio is the same as DW_OP_fbreg with the number from
DW_OP_consts as the offset.

With this change, probing on functions in Golang with variables works.

Signed-off-by: Daniel Shaulov <daniel.shaulov@granulate.io>
---
 tools/perf/util/probe-finder.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index e4cff49384f4..866b17aea263 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -240,11 +240,23 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 	}
 
 	/* If this is based on frame buffer, set the offset */
-	if (op->atom == DW_OP_fbreg) {
+	if (op->atom == DW_OP_fbreg || op->atom == DW_OP_call_frame_cfa) {
 		if (fb_ops == NULL)
 			return -ENOTSUP;
 		ref = true;
-		offs = op->number;
+		if (op->atom == DW_OP_fbreg) {
+			offs = op->number;
+		} else if (nops == 3) {
+			/*
+			 * In the case of DW_OP_call_frame_cfa, we either have
+			 * an offset of 0 or we have two more expressions that
+			 * add a const
+			 */
+			if ((op + 1)->atom != DW_OP_consts ||
+			    (op + 2)->atom != DW_OP_plus)
+				return -ENOTSUP;
+			offs = (op + 1)->number;
+		}
 		op = &fb_ops[0];
 	}
 
-- 
2.22.0

