Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708C4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A60F2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7ccvhUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgG1L3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbgG1L3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:29:19 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00E1C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:29:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m22so11712494pgv.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPsJ77H+Gr6KJwODk9E/fy3Cd6Kd23KE/I6e+cqO0VA=;
        b=t7ccvhUSx9eqG/qZIbcxQO4p9eWxukMyS1jxVQaDXgEaMnschPle3EkPBk057Qze2G
         zqO9BzVRhzvK9rYbI4EVPBUXhKUFdW2rDpBodWTFrgbBr7C81Dn2lj/NAcM38dFxPdZy
         gIaifr7Uf3puPbWfRwaG1RfcQ+HV8iYAmCoMGzLFsoXsVoS5LGzOkfh+ycVioIk/21wV
         Q1VwTYX6ke+r4hf96nMTULfaK/we5MC35eoNzgkEoavdwfnvYnRpcGxZnw1IrJgMDcce
         Jdxc+Gp/85IU35043++AfYrjLvPharAQOfTBYBXgtan6+hfAKm/Si5HE10kipukrTkKh
         Ussw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPsJ77H+Gr6KJwODk9E/fy3Cd6Kd23KE/I6e+cqO0VA=;
        b=GkBb02yyfVs61MtHUsfjkpiQGRlIaQaoJAuWE1cSC059qmZoMj/1g/KRbdY6/hF3lq
         9IepfU1ahgcYZBwwPld74U4ShhHD18+PdvZOgimbzpuBSRO0ebaU3l99n7moZK0OKMKn
         d/YHwt+ljAY5kTGiQ7FUVnjNxUB8eUlzE+2USY3vvP5lnIOHtVakKRbqGyA3sgJSN6OJ
         pdUfuN0cSOseBPNXlbtt7mv2e9lJkAl7UY5ycWMucrw3eO/HkoQHkhekHhL30glmKHEr
         y4o2xacPFzKZGEik5uuwqeFe/qJd3h4uHz5jAvDRX3/P3w9gHsAlJ1UzYwAqiWsprUJp
         onBw==
X-Gm-Message-State: AOAM531qOEA9I4nVnvvSTD1Xo4McVhqLC/pKWCZJB6GjtvmkzRvalUSA
        QNSEmFOsqWvfGqcMjiOm8oM=
X-Google-Smtp-Source: ABdhPJy1YSU+V/ePEmbu+3a9/kbPk6xNv9BKU/2wJnCs7pa6BWY4SSre3l24Ot5UdHC3WhhbOMpN4w==
X-Received: by 2002:a62:1494:: with SMTP id 142mr23138641pfu.216.1595935758467;
        Tue, 28 Jul 2020 04:29:18 -0700 (PDT)
Received: from endurance.iB-W4G311N.setup.in ([59.95.235.115])
        by smtp.googlemail.com with ESMTPSA id b18sm2877600pju.10.2020.07.28.04.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 04:29:17 -0700 (PDT)
From:   Nachiket Naganure <nachiketun8@gmail.com>
To:     apw@canonical.com, joe@perches.com, lukas.bulwahn@gmail.com,
        skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        nachiketun8@gmail.com
Subject: [PATCH v2] checkpatch: disable commit log length check warning for signature tag
Date:   Tue, 28 Jul 2020 16:59:00 +0530
Message-Id: <20200728112900.703186-1-nachiketun8@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable commit log length check in case of signature tag. If the commit
log line has valid signature tags such as "Reported-and-tested-by" with
more than 75 characters, suppress the long length warning.

For instance in commit ac854131d984 ("USB: core: Fix misleading driver bug
report"), the corresponding patch contains a "Reported by" tag line which
exceeds 75 chars. And there is no valid way to shorten the length.

Signed-off-by: Nachiket Naganure <nachiketun8@gmail.com>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 197436b20288..ef603f2d9dbf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2806,6 +2806,8 @@ sub process {
 					# filename then :
 		      $line =~ /^\s*(?:Fixes:|Link:)/i ||
 					# A Fixes: or Link: line
+		      $line =~ /^\s*$signature_tags/ ||
+					# Check for signature tag
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
 			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
-- 
2.25.1


