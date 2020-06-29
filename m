Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC0EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC88206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FezAnxPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390056AbgF2VCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbgF2TMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:50 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DE2C08E763
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 22:14:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so6626792plo.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 22:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=Puo6oGVYHZcL7bpuZStnbvjW4QMJ406YmIdwoEcmz2s=;
        b=FezAnxPg6kxSnBrxKsnGU68s4r8atyxN55OQYgfBgbFEE7sgO3+vCdRDiiFG6yEOK2
         jDl8EWMZOjlhwS+zz0tmgUgnZ4Ye2FqNGvPeDXceFowvoaCvmPJmBEa0s9ehTe/mjmU1
         i/PclRbXTa7cWHXIHkrsQIsLEcTLsDzSJC9mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=Puo6oGVYHZcL7bpuZStnbvjW4QMJ406YmIdwoEcmz2s=;
        b=GmDo8/I4TI+obTHZPp2RrB0fsIsC9aKPfZtOhdeJecCMTK3UavabKRrpANhnX7MKQO
         AwGQzMjQPAK9/hpMY2cIYFb27mtS9gHmzHU5Z4hu5HR+rYmGXyysQbpArvZzJ/449sPd
         EGbt+6l4V16z/znjUmf5/JB96Hsdlp+PsrCbXXkT9sT05QhTY63KjdRe4P60XAB576W6
         Z/cmS3fAKil32aG09VpLnvAUnUcfO1czeBPY/cvSX51hu8tTe3hdwmtWIskyMvDjfY1p
         l3/oq20YlxdsQhjhjDd4gNGxZCNoHCYaWKBwCuv94Gdx9ixAc0phSl9nvSYE6vNbi9Al
         mjMQ==
X-Gm-Message-State: AOAM53108OxI5qG/m2OUynIzHk7a1UXEPD7t9nP5qa9nXCwX0DZ1XWRc
        xMXUIgdjyXbxBlnZM2KSevBgSg==
X-Google-Smtp-Source: ABdhPJw0X3SUMS7q/5WaXoOuRXANudjostovb3WS0vzYoHrr8zMtespLNSVO9+YtCwnfUlKK1K/kGQ==
X-Received: by 2002:a17:90a:ac03:: with SMTP id o3mr15760654pjq.214.1593407669056;
        Sun, 28 Jun 2020 22:14:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u8sm31432022pfh.215.2020.06.28.22.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 22:14:27 -0700 (PDT)
Date:   Sun, 28 Jun 2020 22:14:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] samples/vfs: Avoid warning in statx override
Message-ID: <202006282213.C516EA6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Something changed recently to uncover this warning:

samples/vfs/test-statx.c:24:15: warning: ‘struct foo’ declared inside parameter list will not be visible outside of this definition or declaration
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
---
 samples/vfs/test-statx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
index 76c577ea4fd8..49c7a46cee07 100644
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


-- 
Kees Cook
