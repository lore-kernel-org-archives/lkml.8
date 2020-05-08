Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1454DC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF12E24969
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgEHNIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730552AbgEHNFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:42 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F24C05BD43;
        Fri,  8 May 2020 06:05:41 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gz-0007qq-4Z; Fri, 08 May 2020 15:05:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D3D621C0853;
        Fri,  8 May 2020 15:05:10 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:10 -0000
From:   "tip-bot2 for Zou Wei" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libtraceevent: Remove unneeded semicolon
Cc:     Hulk Robot <hulkci@huawei.com>, Zou Wei <zou_wei@huawei.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1588065121-71236-1-git-send-email-zou_wei@huawei.com>
References: <1588065121-71236-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Message-ID: <158894311079.8414.15750026350936900649.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     eebe80c982546ce1041b7dcf3c461406f1e7e88f
Gitweb:        https://git.kernel.org/tip/eebe80c982546ce1041b7dcf3c461406f1e7e88f
Author:        Zou Wei <zou_wei@huawei.com>
AuthorDate:    Tue, 28 Apr 2020 17:12:01 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 30 Apr 2020 10:48:32 -03:00

libtraceevent: Remove unneeded semicolon

Fixes coccicheck warning:

 tools/lib/traceevent/kbuffer-parse.c:441:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: http://lore.kernel.org/lkml/1588065121-71236-1-git-send-email-zou_wei@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/kbuffer-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/kbuffer-parse.c b/tools/lib/traceevent/kbuffer-parse.c
index b887e74..27f3b07 100644
--- a/tools/lib/traceevent/kbuffer-parse.c
+++ b/tools/lib/traceevent/kbuffer-parse.c
@@ -438,7 +438,7 @@ void *kbuffer_translate_data(int swap, void *data, unsigned int *size)
 	case KBUFFER_TYPE_TIME_EXTEND:
 	case KBUFFER_TYPE_TIME_STAMP:
 		return NULL;
-	};
+	}
 
 	*size = length;
 
