Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60532C433E8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42DE820809
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ONvhuYhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGSSIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSSIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:08:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CFAC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 11:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=CgRnudM818Ox8zC1i9FgSDhyBLgDa+Y/onXsjyLCw/4=; b=ONvhuYhkvPXUZtwXkc8K1Bgs2+
        b3mzjeyg1SYos7MJnaIYaBiY55AO0nlgoSim0uDcgk4MINinffOUPNfiOxJNs4CWHvRtKS3+vcJZ+
        OAhuyIheCZ0VaUNFvt2yj9s7QCVJfnrtHUotUV2ZIo6DSPFf3rBLS/hxE5z546buKutFasDM73jQ+
        +n9U/Avp0cMEqfwo4glfL8DNO9ajTzMbXAId1PB8pFOSD7FShgVGQoQ9Z3VP2Gf5rcjMs6j0aB+1w
        9paEKqwZDVN7VtXWgpJLr0iYoUlBUURoNXOLoVIFMHf8GoCbSiiCDYxhwNSP85BKIu0W8EUdFCjXS
        5P6ncZ+Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxDjq-0006CP-49; Sun, 19 Jul 2020 18:08:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        John Johansen <john.johansen@canonical.com>,
        apparmor@lists.ubuntu.com
Subject: [PATCH] security: apparmor: file.h: delete duplicated word
Date:   Sun, 19 Jul 2020 11:08:35 -0700
Message-Id: <20200719180835.24658-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the doubled word "then" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: apparmor@lists.ubuntu.com
---
 security/apparmor/include/file.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/security/apparmor/include/file.h
+++ linux-next-20200717/security/apparmor/include/file.h
@@ -167,7 +167,7 @@ int aa_audit_file(struct aa_profile *pro
  * @perms: permission table indexed by the matched state accept entry of @dfa
  * @trans: transition table for indexed by named x transitions
  *
- * File permission are determined by matching a path against @dfa and then
+ * File permission are determined by matching a path against @dfa and
  * then using the value of the accept entry for the matching state as
  * an index into @perms.  If a named exec transition is required it is
  * looked up in the transition table.
