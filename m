Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F446C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1062083B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgHJS3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgHJS3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:29:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 590A920866;
        Mon, 10 Aug 2020 18:29:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1k5CXd-0071X5-9S; Mon, 10 Aug 2020 14:29:01 -0400
Message-ID: <20200810182901.161930781@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 10 Aug 2020 14:28:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: [for-linus][PATCH 2/2] ktest.pl: Fix spelling mistake "Cant" -> "Cant"
References: <20200810182836.746909615@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in an error message. Fix it.

Link: https://lkml.kernel.org/r/20200810100750.61475-1-colin.king@canonical.com

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 9363a5b27339..cb16d2aac51c 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1543,7 +1543,7 @@ sub create_pty {
     my $TIOCGPTN = 0x80045430;
 
     sysopen($ptm, "/dev/ptmx", O_RDWR | O_NONBLOCK) or
-	dodie "Cant open /dev/ptmx";
+	dodie "Can't open /dev/ptmx";
 
     # unlockpt()
     $tmp = pack("i", 0);
-- 
2.28.0


