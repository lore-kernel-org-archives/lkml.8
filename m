Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1619C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8431206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent-com.20150623.gappssmtp.com header.i=@isovalent-com.20150623.gappssmtp.com header.b="EEH5gsyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389038AbgF3Ofy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731427AbgF3Ofv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:35:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920C9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:35:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so9175829wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ehSuH0Ppvr3SarHPimFMKCcDFvWk7d98TWdLgtUAdk=;
        b=EEH5gsyRve5CqoVSk9842wt6lCZaD9pqW/LmrXByhYGDb7lv2/0AB1uRi8n9uZrgnl
         zbRJ3gPUiiszSXRu4zBUFqoQ7ZKqWf07Rvy1dvUDsOtJwcVhCROYD3Gi/mS4J1qp8cZm
         O7Ngg/PDJPUoU+wNFXqad0N+bR9LJzVdE9c1ZM1674YTjLKD+VAtUeSgNVD07yKdCbNK
         OmGdTamj+OtzMshlITGU4dYjOmQaTaRjGDvzWIq3A38ZSegGUjJMK6lPzjnpoRakFmB3
         k8+NgjPmiBgALA+4PkjQ3ASBNovCRcdpSrsRF4WNQyHQ5KPqKYUlrtKk+ENfIXa2BGPs
         oUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ehSuH0Ppvr3SarHPimFMKCcDFvWk7d98TWdLgtUAdk=;
        b=DW9S2IccnoF+/kW4+F+hATd9U4wUUna9v3/Ce4CUZKE1MAbjkXkh/VtQJDZ96Gdeb8
         +JaLbOTFRAgkn0b2TPkESGGFXWHT+J1qCDrhjSqv/4tknb1oGr3083USF0iaMH8bQVT6
         NrLr6ZWHuciJZC7xctcRI9/09ZctINgoJchLtlD36PAeT8B0MsiPsjoIABJBqXrpdwag
         uzwpLwKsN/qaLAOkMeK5HwhWy8eYTqA7vKA+9pEufS2ywyMIav7VOngm073eJH7KFl59
         it8IYfSDzI75xmUCGa+hF5a9DT4bo6PqurOIT4H8cwbuAj8jjArKAjppHCKlK4MKF4wJ
         NYiQ==
X-Gm-Message-State: AOAM533w18ml51cIkK12vWMWZqLBmX5T4cb8ex6baJIavEJ65T39eWMY
        DOYeNRhCacUo+sel6Bx9Sn4Syg==
X-Google-Smtp-Source: ABdhPJxfreHHCSgkoRRa5/FN8jXyQ3dmNAYhdiaG0ZWp6lK21+Bv13m6PRC1LeUucj5OreEAxBU7ow==
X-Received: by 2002:a5d:55c9:: with SMTP id i9mr21721835wrw.404.1593527749296;
        Tue, 30 Jun 2020 07:35:49 -0700 (PDT)
Received: from localhost.localdomain ([194.35.116.93])
        by smtp.gmail.com with ESMTPSA id g16sm4317837wrh.91.2020.06.30.07.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 07:35:48 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH] checkpatch: prevent reporting C99_COMMENTS error for SPDX tag in .c file
Date:   Tue, 30 Jun 2020 15:35:25 +0100
Message-Id: <20200630143525.13869-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checkpatch.pl is invoked with "--ignore C99_COMMENT_TOLERANCE", it
reports C99-style comments found in the code, by matching on the
double-slash pattern "//". This includes the leading slashes before the
SPDX tags that are now used in a majority of C files.

Such tags are commented with the double-slash on purpose, and should not
trigger errors from checkpatch. Let's ignore them when searching for
C99-style comments to report.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 scripts/checkpatch.pl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3cacc122c528..67f350c580ea 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3983,7 +3983,10 @@ sub process {
 		}
 
 # no C99 // comments
-		if ($line =~ m{//}) {
+		if ($line =~ m{//} &&
+		    !($rawline =~ m{// SPDX-License-Identifier:} &&
+		      $realfile =~ /\.c$/ &&
+		      $realline == $checklicenseline)) {
 			if (ERROR("C99_COMMENTS",
 				  "do not use C99 // comments\n" . $herecurr) &&
 			    $fix) {
-- 
2.20.1

