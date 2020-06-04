Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1B3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5982E20738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJ000Iqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgFDInF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgFDInF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:43:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB500C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:43:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d6so7219809ybn.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nlkXKlWFIYxfLs04PG1x7XFTLy1mblGWjCOyvzYPXHU=;
        b=UJ000Iqf10R44YN/3kxhUlycYRN3yTnbTPlNipV0FMnYH1WGgQJvc5zN3Nk0OjO4Ld
         5T0tJ2LHLrmGgJKTROWQE9w/K78/dLjh7hli7SJKaFrvmA8b/GmXCz0362vT++gHxfom
         eRvn2BoC/u5TmF7qNpNLlfDPnIQD+kSlg1DAVCn0SsIYY4TNoFrwvvC+zV09RFUMrfQz
         ctSx5F8TwpDkyk0NVPjl42bIm3H+6Ycve7PwXopqqNChdbqTKxxlyNdlcTE4PEnz7u7W
         seTSmJSDOo+nfpqYiAFrJDtWCI8E8FnnB1hyOn9QOKoxgMCrYNFz20q/lD/PTDzmxTPK
         4jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nlkXKlWFIYxfLs04PG1x7XFTLy1mblGWjCOyvzYPXHU=;
        b=ZJMT3A6RoDYac1IgFJMmCC94lk8KNzlbhScRykfwAFKqIC4SMv2iiVatcDjtr5AmUg
         znI9z/ZEjW9V/0bDkTYGiW4AWdxgnqXt9A1Noaig+4DTQKyeC174KA7XjD+polKC2Nr8
         vi7rd+hDSx0WeFr5+eFKJaYtZDqJZlK1owjZs65WhtCKbo/VNjM5lVMfGy8vN+AEtyRi
         kqiP+i6r/LpFM8cDNRiiSlV8aZm8NQsxysuh7pTrXu85LX+8nKYU0pMkLWP/Wxs/Nh7z
         OSnwTQr+eTCNGb5xrjBYjubWw98b2MYAyJl7wvxghKkSWfiSB0un7Y6SEioGsMqpPVk/
         lVag==
X-Gm-Message-State: AOAM533N3dIhKenDp6P9gd/58CQZ6ksYIXHeIKCOwXlFMK8AWEVaEyO0
        kRI2O8Hr5UT1AIcXD+8/2VN7YXeCI2k=
X-Google-Smtp-Source: ABdhPJx/x3rTxyXVTfCzwPxpHuZZeyDbY0k/8MsEoTn1vhtNL6AF6homBmYHpgnkIBATuDvPKVRucxU6lT0=
X-Received: by 2002:a5b:512:: with SMTP id o18mr5703507ybp.419.1591260184074;
 Thu, 04 Jun 2020 01:43:04 -0700 (PDT)
Date:   Thu,  4 Jun 2020 10:42:45 +0200
Message-Id: <20200604084245.161480-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH] ovl: explicitly initialize error in ovl_copy_xattr()
From:   glider@google.com
To:     miklos@szeredi.hu, vgoyal@redhat.com
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

The uninitialized value is returned when all the xattr on the file
are ovl_is_private_xattr(), which is actually a successful case,
therefore we initialize |error| with 0.

Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Roy Yang <royyang@google.com>
Cc: <stable@vger.kernel.org> # 4.1

---

The bug seem to date back to at least v4.1 where the annotation has been
introduced (i.e. the compilers started noticing error could be used
before being initialized). I hovever didn't try to prove that the
problem is actually reproducible on such ancient kernels. We've seen it
on a real machine running v4.4 as well.

v2:
 -- Per Vivek Goyal's suggestion, changed |error| to be 0
---
 fs/overlayfs/copy_up.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 9709cf22cab3..07e0d1961e96 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -47,7 +47,7 @@ int ovl_copy_xattr(struct dentry *old, struct dentry *new)
 {
 	ssize_t list_size, size, value_size = 0;
 	char *buf, *name, *value = NULL;
-	int uninitialized_var(error);
+	int error = 0;
 	size_t slen;
 
 	if (!(old->d_inode->i_opflags & IOP_XATTR) ||
-- 
2.27.0.278.ge193c7cf3a9-goog

