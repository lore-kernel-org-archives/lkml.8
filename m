Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB63CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 01:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B84DF206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 01:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF52aeqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgF2BWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 21:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgF2BWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 21:22:20 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0DEC03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 18:22:19 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id di5so2043022qvb.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 18:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Gh8U1Z9aatU+1G7l/mTh27mGH6DDhKMcWP0trx36I7Y=;
        b=nF52aeqa6XvI17VPNWfcxUO3BvWQWocUrQt4NXM5BPW4VeOXe+BAqRmkyPFsZZP7gT
         lHaIauq6Rf/gswtinjhDpyTrHlYvnaYZ2glDFrGJvjWJHlKsW0G50ypzCHQovjows77j
         1XPkqdyBN802miZ6CBrFrLHC2p+9sXrvGKbWcvewr+fqsmeby+kPDrc9b0ccbuM9vU4F
         uEDTo1caGWeRYWuiq3HiG41w6A3xY3kRnRoOwtASefv/FVSep4ByOfvV96Ba8t7jVAEw
         iq9ro33zXzxdHsldk82gfElLQR43YqGnorWgF+s+tmvJoSbxo3E1WHWkX6aCCNuNjSWM
         MF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Gh8U1Z9aatU+1G7l/mTh27mGH6DDhKMcWP0trx36I7Y=;
        b=YiEkK4Ymq4ZXaGBcZJJCE1TNoHbEfc/9B0bOgyfN3TRc19e2xsCYdb0fshTSxeV3h/
         syYdaQJFOdnX7jr4Uhh/uYx5LP0fTjAQgdjHCNucqz9JI3FmKA5SQhqOKyQfeGbu3vKz
         PZ2GdI6ci51GCsbKBj9qnPBrs/bgFwmzf/nCHaid7yL9r/ckkjmzEm13vUB/3QVz/+w4
         Qmhnoosjlk0ROc392iMnmr7c6SssuGUEJoZMrgXiPjWGqbq6KbPSGXMoIOXiZDoQz2A4
         kScMRXSSzBROyBJIruj5W0EamxvYUx2LmZwUD5/OvNPTNRil90jvtub2aVgUP/F7JCOC
         KwUg==
X-Gm-Message-State: AOAM532+DNjjvhGhSruAUKbQiooi8/tu6U2LFODeqF7OykWn3fhgZxFX
        HkBTblyGSfgmNEZywCL5opc=
X-Google-Smtp-Source: ABdhPJxp74N6P3MOVzgMLWI70QSmixkYtlP57p89PpUlEcDy6Ky5ITGxpDJdzTuOltHEmlMGxo55+g==
X-Received: by 2002:a0c:f385:: with SMTP id i5mr13474375qvk.4.1593393739128;
        Sun, 28 Jun 2020 18:22:19 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:f01c:7705:2169:19ef])
        by smtp.googlemail.com with ESMTPSA id 19sm6784157qky.72.2020.06.28.18.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 18:22:18 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] [scripts] read_file: fix memory leak
Date:   Sun, 28 Jun 2020 21:21:33 -0400
Message-Id: <20200629012149.29839-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200621165657.9814-1-gaurav1086@gmail.com>
References: <20200621165657.9814-1-gaurav1086@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free buf before returning to avoid memory leak.

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 scripts/insert-sys-cert.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index 8902836c2342..22d99a8faca9 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-sys-cert.c
@@ -250,6 +250,7 @@ static char *read_file(char *file_name, int *size)
 	}
 	if (read(fd, buf, *size) != *size) {
 		perror("File read failed");
+		free(buf);
 		close(fd);
 		return NULL;
 	}
-- 
2.17.1

