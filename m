Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D503CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A82D120678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lcM9twGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgFCXTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgFCXTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 19:19:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FFAC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 16:19:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j1so2318524pfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wuYknzWnAMFhtdnreVMZAlkxFgRjxzpB7CA+xwwH8qs=;
        b=lcM9twGQQwrHp5CmH/xGWch1sz6um1ZqQMlygUFW6zDLTfVVoM/25LtT/GqnF6oBsL
         pAjHOnhxYrhiyso2mZxnEv8eWNi6/WB/tIDbiF+8VzZ3Yi/2yXTeJiTZkKdWXKyumpGn
         aZhBiGmEMP6Ej7w0fhP/bKp1pUA6TxtEMrmxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wuYknzWnAMFhtdnreVMZAlkxFgRjxzpB7CA+xwwH8qs=;
        b=OiHG78R2TdLRjQbUg2e4bM1o95BRMwOOkX+3IeYzpQenv2uVRhOAB6nqXqwDQ6bsnv
         t5C3+/GOl3GViClCFpck90K58WlGLelTrF5gEt+CcpmwwEdTsXz1uLCbsXGO4P++URme
         k0JubNLfWromsh6TV+wTq/WJ4pbw8Yy8mN/Mw1TXB1YKD2B6ft0UWLk4aMRplPCaSSZi
         5d3s9z2lQZZCaGnGcVg1cE0Dnl+mW3lVIZuL31PnDR4qd9QGgqkdECxmQXzkxHwWttXL
         OM7rxmBXdV5uMM6kYJYuUuAXsv/5L+iEYOXkZvxSPMjrfKG12++WOrtnvrvEvIoPnHNN
         M+Xw==
X-Gm-Message-State: AOAM533S7s5S2D6EpFZx6FqwupggA52stKZUWFJXv5Dfg0gjL/UGL2PR
        IXp5vkG9Oxn1RUTgV0APLowuDw==
X-Google-Smtp-Source: ABdhPJzLOfCFNyLgR2EkxrOvcNu9cdVMqrUZow7jfnOHQ4vghqo8lxDdhm2TVwwKnDdQVjZKvBpr0g==
X-Received: by 2002:a63:2f43:: with SMTP id v64mr1694226pgv.232.1591226343724;
        Wed, 03 Jun 2020 16:19:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j186sm2713651pfb.220.2020.06.03.16.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 16:19:02 -0700 (PDT)
Date:   Wed, 3 Jun 2020 16:19:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: Avoid missing typo suggestions
Message-ID: <202006031618.DA25142@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My codespell dictionary has a lot of capitalized words. For example:

MSDOS->MS-DOS

Since checkpatch uses case-insensitive matching, I get an undefined
variable warning and then empty suggestions for things like this:

Use of uninitialized value $typo_fix in concatenation (.) or string at ./scripts/checkpatch.pl line 2958.

WARNING: 'msdos' may be misspelled - perhaps ''?
+       struct msdos_dir_entry *de;

This fixes the matcher to avoid the warning, but it's still a rather
silly suggestion:

WARNING: 'msdos' may be misspelled - perhaps 'MS-DOS'?
+       struct msdos_dir_entry *de;

So I'm not really sure what to do with this ... filter out bad
suggestions instead?

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e9f8146600d0..1aaf3317b6ad 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -727,7 +727,7 @@ if ($codespell) {
 
 			my ($suspect, $fix) = split(/->/, $line);
 
-			$spelling_fix{$suspect} = $fix;
+			$spelling_fix{lc($suspect)} = $fix;
 		}
 		close($spelling);
 	} else {
-- 
2.25.1


-- 
Kees Cook
