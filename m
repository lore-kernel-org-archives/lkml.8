Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83049C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01786206B1
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgCKOpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbgCKOpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:45:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC42020650;
        Wed, 11 Mar 2020 14:45:36 +0000 (UTC)
Date:   Wed, 11 Mar 2020 10:45:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Artem Savkov <asavkov@redhat.com>
Subject: [GIT PULL] ftrace: Return the first found result in lookup_rec()
Message-ID: <20200311104536.59de3c5a@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Have ftrace lookup_rec() return a consistent record otherwise it
can break live patching.


Please pull the latest trace-v5.6-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.6-rc4

Tag SHA1: 3bedd0c3802cdffacf9fd6a4cac9f3fa6a4da477
Head SHA1: d9815bff6b379ff46981bea9dfeb146081eab314


Artem Savkov (1):
      ftrace: Return the first found result in lookup_rec()

----
 kernel/trace/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)
---------------------------
commit d9815bff6b379ff46981bea9dfeb146081eab314
Author: Artem Savkov <asavkov@redhat.com>
Date:   Fri Mar 6 18:43:17 2020 +0100

    ftrace: Return the first found result in lookup_rec()
    
    It appears that ip ranges can overlap so. In that case lookup_rec()
    returns whatever results it got last even if it found nothing in last
    searched page.
    
    This breaks an obscure livepatch late module patching usecase:
      - load livepatch
      - load the patched module
      - unload livepatch
      - try to load livepatch again
    
    To fix this return from lookup_rec() as soon as it found the record
    containing searched-for ip. This used to be this way prior lookup_rec()
    introduction.
    
    Link: http://lkml.kernel.org/r/20200306174317.21699-1-asavkov@redhat.com
    
    Cc: stable@vger.kernel.org
    Fixes: 7e16f581a817 ("ftrace: Separate out functionality from ftrace_location_range()")
    Signed-off-by: Artem Savkov <asavkov@redhat.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3f7ee102868a..fd81c7de77a7 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1547,6 +1547,8 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
 		rec = bsearch(&key, pg->records, pg->index,
 			      sizeof(struct dyn_ftrace),
 			      ftrace_cmp_recs);
+		if (rec)
+			break;
 	}
 	return rec;
 }
