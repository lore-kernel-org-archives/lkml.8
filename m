Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87FEC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A801F208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F813bmeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbgBVACn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:02:43 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54390 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbgBVACn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:02:43 -0500
Received: by mail-pj1-f65.google.com with SMTP id dw13so1473169pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=mlYJKghLuJvyIb9vTdDK73ZdLUo5D/iUeEEKRshNNdU=;
        b=F813bmehcWyoOKuLB18kNU/7ag9mgf6iNgkmwDBMt+nd7w/qt4bb4Y7NfrgdZTKpMr
         vhmFYAxnKpi/Q83QSAVGa7QcTSDT7gK/MjCjhYPRmAJnlHwKkbLcmShXoDGHwMbyFVy8
         Mkc+WoOMGkd3oB1FOM5O1Clm9mkoMRmedmpPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mlYJKghLuJvyIb9vTdDK73ZdLUo5D/iUeEEKRshNNdU=;
        b=Vuc5K5ewrAv82jVGxuW05svPXggc41tuAJ7Cj85YgTlrMvpXa0qtDdV6sBYlg+8tPq
         SCu9GFGzE6qgbU+ORnU8tvgR6tqYKzQ6DBoyRgNzdUh2sYKr9o8Be7JvV5xSyOkHLLIp
         M7lQwCRifKbiWw75byNlareP7OD8yvQaCm8ToN6KkEZQ0XRH4rKGhBTm+KXkgw6bXF4C
         jj6/V2Zg7QNg3cx/wTHEsJRBEOmCzFwAeXXHSVZlPpv9GUhPVLkfnmaccXTU/2xllF8e
         x4oMOHKGB+lezrhr0gHF0sgmu6wXuXg15Fj2qXgHge0LiD0o4iWKDG9obtWHsaafr7N7
         3WsQ==
X-Gm-Message-State: APjAAAVFpmy1inF9cZjznn7Zcud6ufskN6qnfl/niA5kP07f6uOwv4oW
        EIBPHlnD7vKwC4IRwV3siZjliA==
X-Google-Smtp-Source: APXvYqxWXDVzmbnMKsqNsGng+5nphCWKQ4pTyJ3j6HWshT/R2zSiILwT7bURopmZ9Z+CNal2PtMHxA==
X-Received: by 2002:a17:90a:ba91:: with SMTP id t17mr6127308pjr.74.1582329762627;
        Fri, 21 Feb 2020 16:02:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l11sm3574354pgt.59.2020.02.21.16.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 16:02:41 -0800 (PST)
Date:   Fri, 21 Feb 2020 16:02:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] docs: Fix empty parallelism argument
Message-ID: <202002211601.322B596B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there was no parallelism (no top-level -j arg and a pre-1.7
sphinx-build), the argument passed would be empty ("") instead of just
being missing, which would (understandably) badly confuse sphinx-build.
Fix this by removing the quotes.

Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Fixes: 51e46c7a4007 ("docs, parallelism: Rearrange how jobserver reservations are made")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/sphinx/parallel-wrapper.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sphinx/parallel-wrapper.sh b/Documentation/sphinx/parallel-wrapper.sh
index 7daf5133bdd3..e54c44ce117d 100644
--- a/Documentation/sphinx/parallel-wrapper.sh
+++ b/Documentation/sphinx/parallel-wrapper.sh
@@ -30,4 +30,4 @@ if [ -n "$parallel" ] ; then
 	parallel="-j$parallel"
 fi
 
-exec "$sphinx" "$parallel" "$@"
+exec "$sphinx" $parallel "$@"
-- 
2.20.1


-- 
Kees Cook
