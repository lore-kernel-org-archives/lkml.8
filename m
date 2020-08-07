Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCBCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C721204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CfIq8Di8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHGSUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGSUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 14:20:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C52C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 11:20:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so1445525plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=276xfBP1w7X97C9ql/giGHZq7wUWHu7gA5RsgQzdGD8=;
        b=CfIq8Di81sNR8H7lxHvtX5Wf9ujf7h2Z7Zl4RVbivy14BVenOOwEPCAOK2JLDNqRTx
         nHM/sU8R++Rl6OIie/IdyzfRA4ubxnpKdEh3KeWN3g/reUqromIvaNVBw87crAMwI7SY
         GBxKuPPM631RqGadSnzlHL+58VV1RsXfsvLIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=276xfBP1w7X97C9ql/giGHZq7wUWHu7gA5RsgQzdGD8=;
        b=E/tVxi1eljMmdtf06xT7/95t+hwd412ay1jLkL7gbHh1e2kVrBRkewDm82BCsCN6pI
         aOtGgK0NT7Tbz4dwvGJb5eRFQYzEJ6d/JgZ9SdOmbc5U/U9G/1GrB/zx3qxmz3uClFS+
         FzBERo60n10Ifg3c8zPgPvi9+h1rRNqqW+lPN6YqzOyELjFwNUyFBNtXpyDklhOK41KA
         ckgW9wTEGJR9ItcNGj2tqgpbNE8QvjZoLvKoNj/Zkbmsuoo5MBXjrUH8oZuooBec8JKe
         KfoMAiasuPZyv60WFeB+bYeSdhuLh1/658NO+19usU7meqmOszpRNttlirhgxiBe2qqA
         2MKA==
X-Gm-Message-State: AOAM532J1nuG6vW2lov3DDh619WNGnKQXl4AyhGJNbq2kJ+HXo48n+RK
        Bba74WiAZdWJGcE1ZdsuwlJoNg==
X-Google-Smtp-Source: ABdhPJxlaOVZr5zmgSA4DO08Bh2Ckp1n2h/orZUqv+YTF2gcOpQbuC/BbT12z011xfES7jhEgTJauw==
X-Received: by 2002:a17:902:b407:: with SMTP id x7mr13504740plr.244.1596824407469;
        Fri, 07 Aug 2020 11:20:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z25sm13723421pfg.150.2020.08.07.11.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 11:20:06 -0700 (PDT)
Date:   Fri, 7 Aug 2020 11:20:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Chris Palmer <palmer@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Matt Denton <mpdenton@google.com>,
        Robert Sesek <rsesek@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Will Deacon <will@kernel.org>, Will Drewry <wad@chromium.org>,
        Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] net/scm: Fix typo in SCM_RIGHTS compat refactoring
Message-ID: <202008071117.56ADE58@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When refactoring the SCM_RIGHTS code, I accidentally mis-merged my
native/compat diffs, which entirely broke using SCM_RIGHTS in compat
mode. Use the correct helper.

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Link: https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-August/216156.html
Reported-by: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Link: https://lore.kernel.org/lkml/1596812929.lz7fuo8r2w.none@localhost/
Suggested-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Fixes: c0029de50982 ("net/scm: Regularize compat handling of scm_detach_fds()")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/compat.c b/net/compat.c
index 703acb51c698..95ce707a30a3 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -294,7 +294,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
 		(struct compat_cmsghdr __user *)msg->msg_control;
 	unsigned int o_flags = (msg->msg_flags & MSG_CMSG_CLOEXEC) ? O_CLOEXEC : 0;
 	int fdmax = min_t(int, scm_max_fds_compat(msg), scm->fp->count);
-	int __user *cmsg_data = CMSG_USER_DATA(cm);
+	int __user *cmsg_data = CMSG_COMPAT_DATA(cm);
 	int err = 0, i;
 
 	for (i = 0; i < fdmax; i++) {
-- 
2.25.1


-- 
Kees Cook
