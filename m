Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA05C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 407B720775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzW94luz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgG0FzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgG0FzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:55:09 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15278C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 22:55:09 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k71so8494820pje.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 22:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UGWIuwdMtZTOoSuQVQNMVyQoWTT0FqCbci1iZWDfg0M=;
        b=UzW94luzogN6pC/WqmPCe6pTi0gXeDLxDYtbOREVgfv2qU1vZXgrym3s0gQCgP7RiU
         WQOgk8TygKmMOeume2UzuyCpgZU9POlW7yBv3uI8iyADDySGs/Ud2d0NRSrJZDbCrSfA
         cOovf7gnz1OUJdm/VD9lNBbLYev0xReMlGEBJIPFQmxMSXtdMwVErxUuS7aswEYRGL8P
         L6SoLMzmGGEjSSSmwm0AmmFvvwIfsQ8TgCNHmods9nP8upC/xpxPwyT0MLhkcVECH4+i
         gZw06lNQuDgbhMyddIlcP0EPDip8prlTGoXJxgv9WqJ29OdYi6EAzNase+t3dNQ21V3i
         xvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UGWIuwdMtZTOoSuQVQNMVyQoWTT0FqCbci1iZWDfg0M=;
        b=Fp6A5bQx9NgGGh8qg1kxSlvA24j09aZpZG7D/Y5Q63V/4Qut4FJfPILun0OIoeN2so
         PSAil/Pm3kH/nv5VYzzY70ksPFNzcqL9fsb9a4brovhG6sH/Rd2rtzbAuvG+1uQDIjnZ
         vVbnzFe6Yy03FwfHD/Ek0Rdl7Mb7PdK4xcE08j67lxRLkHqMwokWXApNLCNUgCfDCvI0
         rqQ2Bgoq7C3Ew3U9mVFroqKaW+sjlF+S+XXnDdq0K5NEGouOHmJt19kUrzJHa0omrCTj
         roVX2uqXpRD7ZTrKt65DkcplW+xQSj2CIVBgHxDVjQuD7Io8EFtAWb9VL5q2DZVoTgLI
         5Z8Q==
X-Gm-Message-State: AOAM533hw5IJKJRADlIetJfQZvhTwhrkAl3xovU/vY3dSY1f5iaU6qum
        I5kSdv1QN4omBusm4NSMnHw=
X-Google-Smtp-Source: ABdhPJzpFgyP85X6QUFCCcMPTOfE1m7wfVo50jr6xHpIfgrEzvpcD9QbbHK0XoP/ebdGWCda0uo3uA==
X-Received: by 2002:a17:902:c38b:: with SMTP id g11mr17252373plg.340.1595829308671;
        Sun, 26 Jul 2020 22:55:08 -0700 (PDT)
Received: from endurance.iB-W4G311N.setup.in ([59.95.38.168])
        by smtp.googlemail.com with ESMTPSA id y68sm920158pfy.185.2020.07.26.22.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 22:55:07 -0700 (PDT)
From:   Nachiket Naganure <nachiketun8@gmail.com>
To:     apw@canonical.com, joe@perches.com, lukas.bulwahn@gmail.com,
        skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        nachiketun8@gmail.com
Subject: [PATCH] checkpatch: disable commit log length check warning for signature tag
Date:   Mon, 27 Jul 2020 11:24:58 +0530
Message-Id: <20200727055458.559558-1-nachiketun8@gmail.com>
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
index 197436b20288..46237e9e0550 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2806,6 +2806,8 @@ sub process {
 					# filename then :
 		      $line =~ /^\s*(?:Fixes:|Link:)/i ||
 					# A Fixes: or Link: line
+		      $line =~ /$signature_tags/ ||
+					# Check for signature_tags
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
 			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
-- 
2.25.1

