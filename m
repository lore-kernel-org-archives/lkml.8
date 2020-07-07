Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CD3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B1F20773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135282;
	bh=m3Bg9p0WjwVIantLqzPG6EBi0zosw5xGhOVnfB8M3xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yjc7FQ/stoaU5+hoQz7dwKIgmEkzeALRntFHit6FwMxWEkMDtKzelaeuxlpfO/Yu+
	 Q+hfeVmrJLgS/3tETAPLf5svPGrOM5WAsiEDWnf74NxHlxlNu4rBNvnD19NNaklyRL
	 38UIxa1FmmpsfRAkuMh4C/pGUjgm2E0UWUtVmIQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgGGPVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728333AbgGGPVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:21:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 428072065D;
        Tue,  7 Jul 2020 15:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135274;
        bh=m3Bg9p0WjwVIantLqzPG6EBi0zosw5xGhOVnfB8M3xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EjTREqHSPSkwk2dWBHReB7OffPl2ZmRy9u3O3ETDDCeiRSQnFNYYGDkYw3vFXUp5/
         aCu5U6HFbZCvbqn8cAFOPtHYaSEpM56jJZy7H9tOhWFMIpNhrPGRKEKMcpTlbS4+HK
         LNpyvTt4IW6p1awsZ+j1BbT7Kr1TB3d6pCQS+sWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 43/65] samples/vfs: avoid warning in statx override
Date:   Tue,  7 Jul 2020 17:17:22 +0200
Message-Id: <20200707145754.536471575@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145752.417212219@linuxfoundation.org>
References: <20200707145752.417212219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit c3eeaae9fd736b7f2afbda8d3cbb1cbae06decf3 ]

Something changed recently to uncover this warning:

  samples/vfs/test-statx.c:24:15: warning: `struct foo' declared inside parameter list will not be visible outside of this definition or declaration
     24 | #define statx foo
        |               ^~~

Which is due the use of "struct statx" (here, "struct foo") in a function
prototype argument list before it has been defined:

 int
 # 56 "/usr/include/x86_64-linux-gnu/bits/statx-generic.h"
    foo
 # 56 "/usr/include/x86_64-linux-gnu/bits/statx-generic.h" 3 4
          (int __dirfd, const char *__restrict __path, int __flags,
            unsigned int __mask, struct
 # 57 "/usr/include/x86_64-linux-gnu/bits/statx-generic.h"
                                       foo
 # 57 "/usr/include/x86_64-linux-gnu/bits/statx-generic.h" 3 4
                                             *__restrict __buf)
   __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 5)));

Add explicit struct before #include to avoid warning.

Fixes: f1b5618e013a ("vfs: Add a sample program for the new mount API")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>
Link: http://lkml.kernel.org/r/202006282213.C516EA6@keescook
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/vfs/test-statx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
index a3d68159fb510..507f09c38b49f 100644
--- a/samples/vfs/test-statx.c
+++ b/samples/vfs/test-statx.c
@@ -23,6 +23,8 @@
 #include <linux/fcntl.h>
 #define statx foo
 #define statx_timestamp foo_timestamp
+struct statx;
+struct statx_timestamp;
 #include <sys/stat.h>
 #undef statx
 #undef statx_timestamp
-- 
2.25.1



