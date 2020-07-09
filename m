Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF8BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91FF7207F9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WGkjJT2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGISLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgGISLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:11:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF80CC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:11:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k5so1137924plk.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wmEMbHFIFolpPSfOWlthVl+wISXkY/EjNqgGfbsD0h0=;
        b=WGkjJT2xNPmrDvn/WXc3lU5b8TQya9Nq4HlFfjT1+maaJ8yUWY7Z+pV7PUNQYBerfg
         DJiWGt35qxaToZJzjvaFgWBiB6mnwZtwGbn/vw33/oifHfzhtPLN0vUj7/paLtNp4NBG
         wEZvTQCOB9DfxU2oWiHoReKw8xviiNHCul2xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wmEMbHFIFolpPSfOWlthVl+wISXkY/EjNqgGfbsD0h0=;
        b=AkzR/x3PH//h73XZJkbAVHrlAiS6zAJYKUfQ3aW36aQuyiJRKnRSquS8Fxs5kg/wI4
         4GvjRil1dwejgDaaclnym6Y+po7d9lSHrRe08WgdJ3NRLY2aCFcr8Zobh9h4JzWKhHoi
         I/vBfcHR+PmImrQiOcaH6l7+fh0L1T8SBAq6Y2FMH0cZwSiXtrrWhzsRdxhJnay6YFyp
         W0JeQsbt2Ji2aDXF34vtpjgUikrco7IeR7NnTOXMS6kV2dUZAMaq+Ct4hfK84NWoYv0R
         MMnL6Ez93WFqxhOIkqyJ1taWihVON1R5+XpdtqyXQ19qS+BQmmATSaUlgroOd7SoRiMk
         w/pg==
X-Gm-Message-State: AOAM533JwxOXhzZEU2kekrQEMQQXzx3CFDTe0vd51dxgeax1kgemMOWe
        6c5sQaNpiJOdPXMatkQ7MZiW5g==
X-Google-Smtp-Source: ABdhPJyxjW1KLKFqPcsaXTLnNmo9fATtUlfY4foAlMln4gVN4WfxQeE5ABbaZarMTe0iedLF8KVRZw==
X-Received: by 2002:a17:902:6bca:: with SMTP id m10mr15048342plt.210.1594318292254;
        Thu, 09 Jul 2020 11:11:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q11sm3347977pgr.69.2020.07.09.11.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:11:31 -0700 (PDT)
Date:   Thu, 9 Jul 2020 11:11:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/security-bugs: Explain why plain text is
 preferred
Message-ID: <202007091110.205DC6A9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The security contact list gets regular reports contained in archive
attachments. This tends to add some back-and-forth delay in dealing with
security reports since we have to ask for plain text, etc.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/security-bugs.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
index dcd6c93c7aac..c32eb786201c 100644
--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -21,11 +21,18 @@ understand and fix the security vulnerability.
 
 As it is with any bug, the more information provided the easier it
 will be to diagnose and fix.  Please review the procedure outlined in
-admin-guide/reporting-bugs.rst if you are unclear about what
+:doc:`reporting-bugs` if you are unclear about what
 information is helpful.  Any exploit code is very helpful and will not
 be released without consent from the reporter unless it has already been
 made public.
 
+Please send plain text emails without attachments where possible.
+It is much harder to have a context-quoted discussion about a complex
+issue if all the details are hidden away in attachments.  Think of it like a
+:doc:`regular patch submission <../process/submitting-patches>`
+(even if you don't have a patch yet): describe the problem and impact, list
+reproduction steps, and follow it with a proposed fix, all in plain text.
+
 Disclosure and embargoed information
 ------------------------------------
 
-- 
2.25.1


-- 
Kees Cook
