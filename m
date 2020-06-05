Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0050BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E50206F0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="QTElvvtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgFEOXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgFEOXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:23:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F318C08C5C4
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 07:23:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n24so10330985ejd.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XgY4I2DT6NHuEBJVBWH5xaWHKtAb7Acjuq8xM3DNBZs=;
        b=QTElvvtJbPz7O4l0N2vXVv9mj1TLExtC0raNDMa24L8UfKR1yYUuYHL9CxjaruDrjh
         aefJM28+QoU0J+hH7LcJY9hLj2TeIZpO1d1afTdHbgITtKVt276YnRSIFQtqPC3dyyfI
         ovRyDY8g9W4NZLaLUUq/4fqdIhDWT8EwOvTWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XgY4I2DT6NHuEBJVBWH5xaWHKtAb7Acjuq8xM3DNBZs=;
        b=m7TSc3xTwUNsJQs3vy2oMRaeLmotV1ZeIdkWDdk5JKu73xGm+8+E85+drjbIAS/PB1
         57wKa6UPhK9ut66RiDtAoUZEqe8/bV9H1PA+cd8wLaRvtbkJwiXGy1LCjCNBkGkQwOih
         +HUEFPE1HjOqjE9bGy9p1590OnHXYcFdO7bdTZHz7g4diWsket9W/drugkFDTDoHz29h
         6CJTjFCdSthzX/CLKjTROojXSjhifvDOrx66jOpVQmLMmAr8pvjgmL4IHTFbe3BxLJdf
         PG3vle+B5m8Vg70txjJCMBIsMqM6nFLtKcvpX+cIXsmcj2Azr0KxwX7C052ErZ3cB8Be
         pGCw==
X-Gm-Message-State: AOAM531ci+LhelwJgyrb+VH/d3OcKALbRLnpKfyERX8yki0WZFET6kF7
        0iT+nb6R1sIeEN7s395RhpGHKQ==
X-Google-Smtp-Source: ABdhPJx6dbhFdXcLh9Fw1Irene3+drPlsNF3oWeBEhsMBqDdvPnhWWVIhBS0bvJAttcjyHDwhAkrGQ==
X-Received: by 2002:a17:906:cb97:: with SMTP id mf23mr4356134ejb.468.1591367011198;
        Fri, 05 Jun 2020 07:23:31 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-116-45.cgn.fibianet.dk. [5.186.116.45])
        by smtp.gmail.com with ESMTPSA id qp16sm4421833ejb.64.2020.06.05.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 07:23:30 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH resend] fs/namei.c: micro-optimize acl_permission_check
Date:   Fri,  5 Jun 2020 16:23:00 +0200
Message-Id: <20200605142300.14591-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just something like open(/usr/include/sys/stat.h) causes five calls of
generic_permission -> acl_permission_check -> in_group_p; if the
compiler first tried /usr/local/include/..., that would be a few
more.

Altogether, on a bog-standard Ubuntu 20.04 install, a workload
consisting of compiling lots of userspace programs (i.e., calling lots
of short-lived programs that all need to get their shared libs mapped
in, and the compilers poking around looking for system headers - lots
of /usr/lib, /usr/bin, /usr/include/ accesses) puts in_group_p around
0.1% according to perf top. With an artificial load such as

  while true ; do find /usr/ -print0 | xargs -0 stat > /dev/null ; done

that jumps to over 0.4%.

System-installed files are almost always 0755 (directories and
binaries) or 0644, so in most cases, we can avoid the binary search
and the cost of pulling the cred->groups array and in_group_p() .text
into the cpu cache.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index d81f73ff1a8b..c6f0c6643db5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -303,7 +303,12 @@ static int acl_permission_check(struct inode *inode, int mask)
 				return error;
 		}
 
-		if (in_group_p(inode->i_gid))
+		/*
+		 * If the "group" and "other" permissions are the same,
+		 * there's no point calling in_group_p() to decide which
+		 * set to use.
+		 */
+		if ((((mode >> 3) ^ mode) & 7) && in_group_p(inode->i_gid))
 			mode >>= 3;
 	}
 
-- 
2.23.0

