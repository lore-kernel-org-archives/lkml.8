Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA3EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1422E206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jwy2W0tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgFJHzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgFJHza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:55:30 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF161C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:55:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u13so885347wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=EnIrIGj03Y4Bw7tljoWmg+qr0vZ8tq42skzZqInftnc=;
        b=jwy2W0tb37SqP+WwCJTfsgps4wsHjgbA1/9/PhiM1buumDf/rLO0m3mEcOlp6aStgk
         m6E5PDh3ObL/D5EmvOP9cLJNkMeQY4RTyYpBSY4BJmFquRZxnWK52rzPA2OlpCDuqVLx
         MZY8EVyUH8aW8Ppn8g7xR+PzwdGolsyOU4rgt8F9WREHAXxgHB6JScKugxpfEhmMjgJe
         cJaTaavF4oCH+CCiNtSLD+4UE0PRchlbHNwtTS7T9poiKReJs396mn9TWqu4wo8oCYpT
         OuqUGWMW0a0PmYzn/7xD4otdO3qu95HUaOExLZ9l94fmXM87Un1VXq5pcwk2qgvMjvB2
         c6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EnIrIGj03Y4Bw7tljoWmg+qr0vZ8tq42skzZqInftnc=;
        b=OPz2M2+tMvY4IfiEtvWRaH6Ot781vPwnVbTk0GUteCZaNlRB800LGfPT96JEbiVpVO
         C2LJ+2K0VI9NBIZ/Ya/D6lBTzs99+9TrphIv7cn5bKP+TxfEkScWUf+EvAOLxK3p9OK1
         WwUj5TFfX7WMxhqiwWerE66sb96nXBrMypnTht/97SLKn6GY9wNuOV0FGYRylj0WiaBv
         7bniiBhuAI0cwhyLA8eOheT7oSzf8c6SLNaLN3nhqsY6UflIYZ+jMGIRkELavG1oE0YL
         ulJNr0iJmqCnK6c69Y0iUlMC6cJ4LN3f/nflhKoeAzcjkaSv8as/oeP1cFfpjOhubVuF
         3fnQ==
X-Gm-Message-State: AOAM532MceIcsm/2QuRm3hzzOVR+5hAPOlizPCmDBszTxl0/Z9ctzEe6
        1lxOTLhtDMRZjbaW2WttNkQnSOXw1mo=
X-Google-Smtp-Source: ABdhPJzT49tgR9+60rfN4830eLLMnTGAHQQvKlJEI8DFusTTWcDAw3O1Rr7NzXEWdzQdZL/5s+h6KA==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr1841091wmj.35.1591775728269;
        Wed, 10 Jun 2020 00:55:28 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k14sm6849615wrq.97.2020.06.10.00.55.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 00:55:27 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] sparc: piggyback: handle invalid image
Date:   Wed, 10 Jun 2020 07:55:19 +0000
Message-Id: <1591775719-28390-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With an old elftoaout, the generation of tftpboot.img fail with "lseek:
invalid argument".
This is due to offset being negative.

Instead of printing this error message, let's print a better one.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/sparc/boot/piggyback.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/boot/piggyback.c b/arch/sparc/boot/piggyback.c
index a7a38fb4ece0..613e23a1016e 100644
--- a/arch/sparc/boot/piggyback.c
+++ b/arch/sparc/boot/piggyback.c
@@ -154,6 +154,10 @@ static off_t get_hdrs_offset(int kernelfd, const char *filename)
 		offset -= LOOKBACK;
 		/* skip a.out header */
 		offset += AOUT_TEXT_OFFSET;
+		if (offset < 0) {
+			errno = -EINVAL;
+			die("Calculated a negative offset, probably elftoaout generated an invalid image. Did you use a recent elftoaout ?");
+		}
 		if (lseek(kernelfd, offset, SEEK_SET) < 0)
 			die("lseek");
 		if (read(kernelfd, buffer, BUFSIZE) != BUFSIZE)
-- 
2.26.2

