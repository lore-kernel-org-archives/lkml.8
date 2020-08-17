Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8069EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481B8206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=forissier-org.20150623.gappssmtp.com header.i=@forissier-org.20150623.gappssmtp.com header.b="lDEWpA8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHQJvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgHQJvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:51:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733F1C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:51:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so14319620wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7PtTaJXigA3cBZlJ0btbEz9RHph+qTS8qn+gx/LZdvk=;
        b=lDEWpA8IYNzqqo7+mQ1sClkTnMYYMbc4HROnDOeQOnHTMRODRHFaupcdOlUjHJQpmz
         qu5rYvh6ihEgXSCDDx5IRucJZFlJ5zBV357PjFkyWi/nAGGyUFC01KsatOJ4wt3r0s8l
         DA5mh1Erx9wclZrkQ1QQA8VcQIx+lEZzCosZLgxydhGa8xAWCB6xDw4Q8s5leyXZC3D9
         l9W+hvEZ9xpviTRRxXO2BNwBMT8fZVpBNtwHKiTxKdeqCoffpvXGPebpYhOLbZS6AYvc
         CXlH3RS7Clh/S2Vu4x5bLg6f9F750ww3bDuZZIAYcRuK22IvFG2mBBAyrf379kAxfopN
         OViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7PtTaJXigA3cBZlJ0btbEz9RHph+qTS8qn+gx/LZdvk=;
        b=Y8VYKeyD258d7FLV/BBECcrCTZ1iAnaRkbrmyvadlTzcKdEHeXSmejjaNTjjn2WdS+
         JaVWbQtAShzExz4Jy3BPMr5WO8IPKsTmKfHyWwRRtFGZFH0My1QDDoD5Vxez/ypQPWUf
         urzB8pMmbU3VPiCDuuTHQyl1CdfvW4QCfJqsapiYKHUfwYoqyKHvt/k0JnbWROYRMioZ
         hE1cEWA1JQt+4Eh0jlhDrsxrQaFavdU+z2OH9hpN8wWu4MfL/2o74w3tsFrvP1vJ8/8W
         H47duszB4Z1Rsd3cNlhgkR6bnWPyNqX1+R08qKtjdofh5igotuap1Va4hVCoRXTkCBcn
         z5tQ==
X-Gm-Message-State: AOAM530Y2gLc3mUaoc96gJ+uo0kE7wtQcrj2ky2yAFOn6Jk3fXKtE7Xl
        atcgrlF5+6D7JHRiTpv9Zgxg78YTxgBC2L9f9mfn/Q==
X-Google-Smtp-Source: ABdhPJw/rVTGCvE6htxYMIk9PMDj4c5QydIhZd8YpKwzPv0RNTmyZWt0vYcELijzk4eWRxGz2mBK0A==
X-Received: by 2002:adf:bc54:: with SMTP id a20mr14390119wrh.227.1597657905783;
        Mon, 17 Aug 2020 02:51:45 -0700 (PDT)
Received: from matebook.home ([2a01:e0a:3cb:7bb0:3009:af69:3d13:4910])
        by smtp.gmail.com with ESMTPSA id b142sm29802277wmd.19.2020.08.17.02.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:51:45 -0700 (PDT)
From:   Jerome Forissier <jerome@forissier.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>
Subject: [PATCH] checkpatch: get CONFIG_ prefix from the environment
Date:   Mon, 17 Aug 2020 11:50:56 +0200
Message-Id: <20200817095056.31001-1-jerome@forissier.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig allows to customize the CONFIG_ prefix via the $CONFIG_
environment variable. Out-of-tree projects may therefore use Kconfig
with a different prefix, or they may use a custom configuration tool
which does not use the CONFIG_ prefix at all. Such projects may still
want to adhere to the Linux kernel coding style and run checkpatch.pl.
To make this possible, update checkpatch to use the value of $CONFIG_
if defined or "CONFIG_" otherwise.

Signed-off-by: Jerome Forissier <jerome@forissier.org>
---
 scripts/checkpatch.pl | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2cbeae6d9aee..2cf750175a71 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -65,6 +65,7 @@ my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANC
 # git output parsing needs US English output, so first set backtick child process LANGUAGE
 my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 my $tabsize = 8;
+my $CONFIG_ = $ENV{"CONFIG_"} || "CONFIG_";
 
 sub help {
 	my ($exitcode) = @_;
@@ -6528,16 +6529,16 @@ sub process {
 		}
 
 # check for IS_ENABLED() without CONFIG_<FOO> ($rawline for comments too)
-		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^CONFIG_/) {
+		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^$CONFIG_/) {
 			WARN("IS_ENABLED_CONFIG",
-			     "IS_ENABLED($1) is normally used as IS_ENABLED(CONFIG_$1)\n" . $herecurr);
+			     "IS_ENABLED($1) is normally used as IS_ENABLED($CONFIG_$1)\n" . $herecurr);
 		}
 
 # check for #if defined CONFIG_<FOO> || defined CONFIG_<FOO>_MODULE
-		if ($line =~ /^\+\s*#\s*if\s+defined(?:\s*\(?\s*|\s+)(CONFIG_[A-Z_]+)\s*\)?\s*\|\|\s*defined(?:\s*\(?\s*|\s+)\1_MODULE\s*\)?\s*$/) {
+		if ($line =~ /^\+\s*#\s*if\s+defined(?:\s*\(?\s*|\s+)($CONFIG_[A-Z_]+)\s*\)?\s*\|\|\s*defined(?:\s*\(?\s*|\s+)\1_MODULE\s*\)?\s*$/) {
 			my $config = $1;
 			if (WARN("PREFER_IS_ENABLED",
-				 "Prefer IS_ENABLED(<FOO>) to CONFIG_<FOO> || CONFIG_<FOO>_MODULE\n" . $herecurr) &&
+				 "Prefer IS_ENABLED(<FOO>) to $CONFIG_<FOO> || $CONFIG_<FOO>_MODULE\n" . $herecurr) &&
 			    $fix) {
 				$fixed[$fixlinenr] = "\+#if IS_ENABLED($config)";
 			}
-- 
2.25.1

