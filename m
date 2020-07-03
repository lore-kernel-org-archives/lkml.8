Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE64C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C7320782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KU+PncGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGCVZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgGCVZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:25:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84E2C061794;
        Fri,  3 Jul 2020 14:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kDCKem1NSB8gGB4AzX45lZ5StxZJZHAvaHl9ZXibLmU=; b=KU+PncGqxo32dmAF+XWPlMoanA
        bUQ9+wTte0Jz2NdNg0NhdSeSMJ6FkBhDrMcYWlmIk93sJyvImS6aU+ddN2qOU79WLI4QJ3DpG/Ctq
        yT2H3uNnOvqQn7j3dqiuymGe6BuGqxEXhVMC4oejqRSbu8Xzzv3/WYRoJujKmX/A8ALjdPz7lJ/sr
        f3pTiWIWbDkj0hlNqzBecEpZ4BadUe+FVkEYc9lqTWlx1TKEg3lZ9Pe9muPGRisKShmvHLQzLUHbu
        +gTN6W8YrNUNaErtkro/5zmTC31MP10XWRDLCNImKHzx8xCF+mIGbww6wvX4LlKzOVM+VSzSg4OPR
        x1ygS2HQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTB9-0006Bh-Al; Fri, 03 Jul 2020 21:25:03 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 2/3] Documentation: trace/histogram-design: drop doubled words
Date:   Fri,  3 Jul 2020 14:24:52 -0700
Message-Id: <20200703212453.30553-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703212453.30553-1-rdunlap@infradead.org>
References: <20200703212453.30553-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled words "to" and "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 Documentation/trace/histogram-design.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200701.orig/Documentation/trace/histogram-design.rst
+++ linux-next-20200701/Documentation/trace/histogram-design.rst
@@ -780,7 +780,7 @@ same part of the hist_data->fields[] arr
 Moving on to the sched_switch trigger hist_debug output, in addition
 to the unused wakeup_lat variable, we see a new section displaying
 variable references.  Variable references are displayed in a separate
-section because in addition to to being logically separate from
+section because in addition to being logically separate from
 variables and values, they actually live in a separate hist_data
 array, var_refs[].
 
@@ -863,7 +863,7 @@ event.
 The onmatch() action below basically says that whenever we have a
 sched_switch event, if we have a matching sched_waking event, in this
 case if we have a pid in the sched_waking histogram that matches the
-the next_pid field on this sched_switch event, we retrieve the
+next_pid field on this sched_switch event, we retrieve the
 variables specified in the wakeup_latency() trace action, and use
 them to generate a new wakeup_latency event into the trace stream.
 
