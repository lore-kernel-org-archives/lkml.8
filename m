Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C77CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 07:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C90820866
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 07:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fenFxDjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgHHHOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 03:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgHHHOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 03:14:39 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5D1C061A27
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 00:14:39 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f193so2340227pfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 00:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/iY0wJdFd/LaP2izN3nWs7gDWHBeHcU40NdnjPvQjqw=;
        b=fenFxDjxSiYhtsExhxVhOZoox2wo71aU1oOkVuGwZkSwpkydMhtVPMpdrOsV9BIOjW
         MYjkJo02PSss2uB9xY1IGtWSlyzWJL7GR1nJHY2ihKa2yYVD97ibdAsagn5mlcbIM/q+
         nlV0cCNqFvf6G1JSTk8iPzpNAUejpOqA72mXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/iY0wJdFd/LaP2izN3nWs7gDWHBeHcU40NdnjPvQjqw=;
        b=PW+TnSagDYLty+CuXtQzPDL16EZ01v6+ZzHoOWSjHsZQETL/9hS+0iAYfBiUgMF9uV
         XJXSpXdv+z7IFcvxayOrPRfQWMjpPH0Pt0lAtPH1lpxTxtKsHh4tdHbYXVRV80qHBle6
         2oeJq67N/4WXWkHSXihr0R3+iWg8nel7FcrPBcouhbsS5Hox5j9/n9iM2GfI244Q5D9y
         QvnRtPNRRSeotAQ2F1Azdd/LgOQDri/MrTlK23paE04g30dDal9iGHKIgEkTpZYulHdh
         ZNmvrDXDd90mZOiloGrYNX4ca31KwGSfaRz0gsdmOECnEbWxz9pdojtkkTcavYaP21JZ
         T/Iw==
X-Gm-Message-State: AOAM530wwgylI7lU8zUkVzfonNRJ1+ADMRshaV86qJfaLSKeM6/MzMgm
        DHp/LUbbf1ulWsisCFhNBlvcCQ==
X-Google-Smtp-Source: ABdhPJzHvvGY5OHb5elxRyMlzTtWJhlbcwvsTyiWcSXg1OAjcx3r4fLCXFEgEvqh8QIS/ZEiIG0o8A==
X-Received: by 2002:a63:e258:: with SMTP id y24mr13991392pgj.434.1596870878446;
        Sat, 08 Aug 2020 00:14:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l9sm13388529pjf.46.2020.08.08.00.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 00:14:37 -0700 (PDT)
Date:   Sat, 8 Aug 2020 00:14:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] mailmap: Update comments for with format and more detalis
Message-ID: <202008080013.58EBD83@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without having first read the git-shortlog man-page first, the format
of .mailmap may not be immediately obvious. Add comments with pointers
to the man-page, along with other details.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
I'm adding this to my earlier .mailmap update series:
https://lore.kernel.org/lkml/20200730183702.702552-1-keescook@chromium.org/
---
 .mailmap | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 6c1c04a63b18..3a991e19928c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -2,11 +2,16 @@
 # This list is used by git-shortlog to fix a few botched name translations
 # in the git archive, either because the author's full name was messed up
 # and/or not always written the same way, making contributions from the
-# same person appearing not to be so or badly displayed.
+# same person appearing not to be so or badly displayed. Also allows for
+# old email addresses to map to new email addresses.
 #
+# For format details, see "MAPPING AUTHORS" in "man git-shortlog".
+#
+# Please keep this list dictionary sorted.
+#
+# This comment is parsed by git-shortlog:
 # repo-abbrev: /pub/scm/linux/kernel/git/
 #
-
 Aaron Durbin <adurbin@google.com>
 Adam Oldham <oldhamca@gmail.com>
 Adam Radford <aradford@gmail.com>
-- 
2.25.1


-- 
Kees Cook
