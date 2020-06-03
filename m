Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F50C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968482053B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOQkwCJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgFCRrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgFCRrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:47:20 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5837C08C5C2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 10:47:19 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id m29so2257064qkm.17
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fLjSsW/NTgyWecVWnnneUC+9Bt4TjOTIssgnySdQoyA=;
        b=jOQkwCJS99WcGmfd51kk60wxPiOKILfRB8GusbTg7LPsTQIDAsWczAhDblVosu5+ml
         BjGBUcc6n42Xpx9Lf/bPp7JK+HLXnXqC0UhtijIJwUGnsm6X0vdAfS+6e5MZXS5aL95G
         ttRSyfpzUVK7JqHpjbfUEM8wAnZx5tHIMMfwuwAps1p+b4rYU/Ww6oYxjv/A24uwRJqx
         jM3XJ3bU/MW1Jeijd6r22MH6RUEyN7c7GdyoaE1yZnm6B4xmVKaWlMUdjdZ7LWvFd7kO
         SEQccx0DItI3fmXi7zdty6heTWV5avdhJg7yDPQi8eD1neYsoU00QTiO24rsPDkbsnmf
         /n9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fLjSsW/NTgyWecVWnnneUC+9Bt4TjOTIssgnySdQoyA=;
        b=sunI046keZ6je5gFy3ZebyOo8KDy9zGFFWeAPMKRxUpfHuyMZoPwFYaSr68J+ncsxB
         zbpQP+2un+/r+VvFxmbTo/5Xef/iDMvS7/Sd4QB2Bd+PyL+7Qgz7Pk9Q/LkrzNsL1mud
         Z+tvMQm8VGycS2d4HXVXnx2Fi7UUvlve1VKRBmDpNHmsPk8j7GPTmabgkDGZOOryKy/X
         UF7Ura40YfRFRQRaTISJMFbhGe9Qw2r5nfQzC3bAXORkpQn38KNZCvHE2LyNSE9PEsHg
         PwEG7B4+ZpQgGaFW/pujJc1ZAr5GNy+PX6N5VRYagHfjvLlGXnyQ0wH9Ql0Lu4zB+vx6
         XhXw==
X-Gm-Message-State: AOAM533mA99Vr6TjF7LgSK+vigpA5YEISN+SKJjo5Uz7+8hqObGGYjyP
        v7KHmsjYwPCRCBeC9zGOI8wR4OtNQng=
X-Google-Smtp-Source: ABdhPJyTlHSzgJRLnJN7g81F8X0Rocv8raZHSS9nwnnwyEOSikK0OcS11Aw0N94+Ac4/qqujAbRMGPV8W90=
X-Received: by 2002:ad4:4e86:: with SMTP id dy6mr1006686qvb.106.1591206438886;
 Wed, 03 Jun 2020 10:47:18 -0700 (PDT)
Date:   Wed,  3 Jun 2020 19:47:14 +0200
Message-Id: <20200603174714.192027-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH] ovl: explicitly initialize error in ovl_copy_xattr()
From:   glider@google.com
To:     miklos@szeredi.hu
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, royyang@google.com, stable@vger.kernel.org,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under certain circumstances (we found this out running Docker on a
Clang-built kernel with CONFIG_INIT_STACK_ALL) ovl_copy_xattr() may
return uninitialized value of |error| from ovl_copy_xattr().
It is then returned by ovl_create() to lookup_open(), which casts it to
an invalid dentry pointer, that can be further read or written by the
lookup_open() callers.

Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Roy Yang <royyang@google.com>
Cc: <stable@vger.kernel.org> # 4.1

---

It's unclear to me whether error should be initially 0 or some error
code (both seem to work), but I thought returning an error makes sense,
as the situation wasn't anticipated by the code authors.

The bug seem to date back to at least v4.1 where the annotation has been
introduced (i.e. the compilers started noticing error could be used
before being initialized). I hovever didn't try to prove that the
problem is actually reproducible on such ancient kernels. We've seen it
on a real machine running v4.4 as well.
---
 fs/overlayfs/copy_up.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 9709cf22cab3..428d43e2d016 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -47,7 +47,7 @@ int ovl_copy_xattr(struct dentry *old, struct dentry *new)
 {
 	ssize_t list_size, size, value_size = 0;
 	char *buf, *name, *value = NULL;
-	int uninitialized_var(error);
+	int error = -EINVAL;
 	size_t slen;
 
 	if (!(old->d_inode->i_opflags & IOP_XATTR) ||
-- 
2.27.0.rc2.251.g90737beb825-goog

