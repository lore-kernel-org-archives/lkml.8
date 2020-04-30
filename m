Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB03C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BCB2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+LJYXx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgD3LU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726819AbgD3LUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:20:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD29C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 04:20:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s18so2590650pgl.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=06zPWEluu9vRkSomaV4Rb19WXIxUjIgbc58HvLTjqJU=;
        b=Z+LJYXx3rAp0alVaNJJBo3hQWwH0sS8uKeb5I1WLSBoiTNtojilGp+dLt03Kv55zcI
         q1lwkyWkVOqXWka3tCAKAXq8SaJeoubFtv7pGI7xNkuM+BGr2MrtaQIRZJvP+8PU2Gpr
         aX6eU65fXjIWDpQ2wa/FqNYYKQkpfPfn2C0ict2cHFr4gVlmKaY/+2yrYF/Ycr8nyY6e
         +WTaCJdvovAsALRr739OPLGmtQhglkKs7imDR8k/QEA9nZiQmXjpqpl4xuCJTrGj59+Z
         MWVpeE7juvbf7zYP6ng30dD9cIy7Q87GsTUKjGVLpORtQbFsaXK6XeOxPTZ9z0WArdew
         643A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=06zPWEluu9vRkSomaV4Rb19WXIxUjIgbc58HvLTjqJU=;
        b=Cr8TpGL5ozkSHcyiJn8Apv0xm/DEuI3AL9z8oGQJ/3/2w+/SG17qX6ZsMyfNaX9PSp
         sKdz3c0Np7of1b+l/B7xhyDgXd84sljT2kQ65iRTqgP38TYlFm6XhDZzt6R2q05Dc/fN
         DOZU4yBvRRwbV+jw4mdhSRChYUvVz6ZNePWKXJNAU4Ta8ldFAlqy0/BspxdgedGYHxVe
         Q6RlOww9QMifCmQtHbx8kz8cnmdieeWmTTt8PRfbyWmU1S+16dj8A37IRu3O7aUcayTW
         y+/xRz9g8+j//vIjWxQ2Ajw0akmBCO68OSSNcgBSiTih34AlEuuVzJWI8HM33FRsuAtz
         SpBQ==
X-Gm-Message-State: AGi0PubP7blX/ZYmYHntxeLTAUSM+Vxp87oh0UE8dwn8ZsvaS+3+2+5X
        pQNO17oNU2Dox/zi8kaAnjU=
X-Google-Smtp-Source: APiQypLiun5y7ugnBNE5XABMc7/XzmbIqAOoqAaEuiEAHodLIlhCyVblkPUYy9GeWNC1v8BNoEX80A==
X-Received: by 2002:a62:3006:: with SMTP id w6mr2987066pfw.29.1588245655175;
        Thu, 30 Apr 2020 04:20:55 -0700 (PDT)
Received: from ubuntu.localdomain ([220.116.27.194])
        by smtp.gmail.com with ESMTPSA id q11sm3317108pfl.97.2020.04.30.04.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 04:20:54 -0700 (PDT)
From:   youngjun <her0gyugyu@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        youngjun <her0gyugyu@gmail.com>
Subject: [PATCH] fs: kernfs: fix possible null pointer dereferences
Date:   Thu, 30 Apr 2020 04:20:46 -0700
Message-Id: <20200430112046.53721-1-her0gyugyu@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernfs_path_from_node_locked checks buf is NULL.
But, two cases below are not covered.

if(!kn_to)			<--- case1 (buf can be NULL)
	return strlcpy(buf, "(null)", buflen);

if(kn_from == kn_to)		<--- case2 (buf can be NULL)
	return strlcpy(buf, "/", buflen);

if (!buf)			<--- checked here.
	return -EINVAL;

buf NULL case needs to be checked first.

Signed-off-by: youngjun <her0gyugyu@gmail.com>
---
 fs/kernfs/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 02fb5cc76e33..d802cfceddba 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -128,6 +128,9 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 	size_t depth_from, depth_to, len = 0;
 	int i, j;
 
+	if (!buf)
+		return -EINVAL;
+
 	if (!kn_to)
 		return strlcpy(buf, "(null)", buflen);
 
@@ -137,9 +140,6 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 	if (kn_from == kn_to)
 		return strlcpy(buf, "/", buflen);
 
-	if (!buf)
-		return -EINVAL;
-
 	common = kernfs_common_ancestor(kn_from, kn_to);
 	if (WARN_ON(!common))
 		return -EINVAL;
-- 
2.17.1

