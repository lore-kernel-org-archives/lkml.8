Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF25C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F159620717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PWgmiW8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgGQXhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGQXhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:37:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E3DC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=6IWmov7G5qc5CmJ+va5vHgs+koh+xBl3K8e8j7Jhf5U=; b=PWgmiW8BBXAEu9GVQROtdlkqXu
        +PLXaGM0wbABs5jIvyr7g6X9hTfdchj9N0oiJuygXk8ycZJKWUmDpagkMj8C8IOGF6oZUVdr3+SwO
        wkJNNkUI8ocV1Zj6LqFOYM4j+Y7knquYL3DlFZwwwm3x410Lui7e1lG+gbQ8QhX6bpQa61ZCLQej9
        3tRRtL1dFgwHvTymIW6HR3s2QpXq7dCIepjxYdQvs1Zp7Udb1CvKjp2fa7zN0dA6ykyyLL24csJLs
        E0FSwn2tkcd+TQQU0vWmJoMd0bp/u5fAoOTaxHSnzMeXKtYqRGI+VC0tWqODdhs8pndsKkiASkvCM
        cA5gyB2Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwZuc-0006ZG-DX; Fri, 17 Jul 2020 23:37:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ptrace: linux/ptrace.h: drop duplicated word in a comment
To:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <a05d29c0-3371-9fb7-ed13-9505828c2708@infradead.org>
Date:   Fri, 17 Jul 2020 16:37:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/ptrace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/ptrace.h
+++ linux-next-20200714/include/linux/ptrace.h
@@ -171,7 +171,7 @@ static inline void ptrace_event(int even
  *
  * Check whether @event is enabled and, if so, report @event and @pid
  * to the ptrace parent.  @pid is reported as the pid_t seen from the
- * the ptrace parent's pid namespace.
+ * ptrace parent's pid namespace.
  *
  * Called without locks.
  */

