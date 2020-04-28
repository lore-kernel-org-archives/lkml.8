Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8043CC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF3E21927
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099330;
	bh=vpnBgYOMkZl24zZAF+Gw4N8jzNY5K3OYGZBkJNrDpe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vOthvFjl+A9UwC3EkAC4wvYjq0CH8OwNt4OgnQgUJYq3BOvL8X8pauXzvpLVckQ+U
	 FeyOmycJPpp8hVduAlab/v5PGt4Gb1rzqmykBley37KTR1wyN2QZT6z6Ybqy3SHvzn
	 r6kMXu2wTGZs4JMQ8bfyEk83BoB/O1ayNO5ZqaB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgD1SmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731063AbgD1SmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:42:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F078720730;
        Tue, 28 Apr 2020 18:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099322;
        bh=vpnBgYOMkZl24zZAF+Gw4N8jzNY5K3OYGZBkJNrDpe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xt8FWRCwt6aFA4n7r1jrvPA7+nFPgdWsZywDCmG5AupAWvzDMblxL1U23Gv66H0AV
         3r190TCr4tihq4tR/2IW2YIO9YlV5tqn1bxxJUK7bXGy8RhBqkdSEvZwnh5lrsGuaY
         rM+DSbDI7nQ/s0CkDDDTNG7YHDvskV7v6HXrkeiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matthew Ruffell <matthew.ruffell@canonical.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Wise <pabs3@bonedaddy.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Neil Horman <nhorman@tuxdriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 104/168] coredump: fix null pointer dereference on coredump
Date:   Tue, 28 Apr 2020 20:24:38 +0200
Message-Id: <20200428182245.549168975@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

commit db973a7289dad24e6c017dcedc6aee886579dc3a upstream.

If the core_pattern is set to "|" and any process segfaults then we get
a null pointer derefernce while trying to coredump. The call stack shows:

    RIP: do_coredump+0x628/0x11c0

When the core_pattern has only "|" there is no use of trying the
coredump and we can check that while formating the corename and exit
with an error.

After this change I get:

    format_corename failed
    Aborting core

Fixes: 315c69261dd3 ("coredump: split pipe command whitespace before expanding template")
Reported-by: Matthew Ruffell <matthew.ruffell@canonical.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Wise <pabs3@bonedaddy.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Neil Horman <nhorman@tuxdriver.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200416194612.21418-1-sudipm.mukherjee@gmail.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/coredump.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -211,6 +211,8 @@ static int format_corename(struct core_n
 			return -ENOMEM;
 		(*argv)[(*argc)++] = 0;
 		++pat_ptr;
+		if (!(*pat_ptr))
+			return -ENOMEM;
 	}
 
 	/* Repeat as long as we have more pattern to process and more output


