Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A135C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3170A2065C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7YTg/Nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgGHMDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgGHMDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:03:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B519BC08E6DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:03:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f2so20693040wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EfL+TnTwzrxBs3OWsbVJ1u2HNp81yr5D58y8jJwfHCg=;
        b=V7YTg/NuT1ipSiphL7EvNRuTDaXv8eq0KaXXKKSKjl/mC+jCiU36KNbNpr6xipISRd
         qWZWOid3XF/HdL7CtyOkvOVNsRM4xkEX+fjQAovODTP/W0CIuJkkHlFIFykYxRI9Qvo2
         qE8RJ0nwah9EwAlJFf+GPBkJRk63xtzmgOt4P6iT0iahUYwp1gIlsl3MCWmaGO79N5bN
         y1DSQnGFHBZLQ2sIPBPi+E2ieP2vvs1eA/maPioucGFRuBDhYQtQrlppYxc8xu68qIFj
         L6IHtoeUfefWuAax+TghGhwH9LCZf0l5eps2R/cZBZljKcjvX9KvozXCeIy4iILmYgId
         Awwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EfL+TnTwzrxBs3OWsbVJ1u2HNp81yr5D58y8jJwfHCg=;
        b=PmzikLjkrwILgCl5B7i4fNJel0C5CODdDNsFjd/M+kKjKjj0MWoidPSfodVDVwyaIo
         1NlVe9AOxwCyX86CUXWnyoEmx1J3FynbBmFSJc+QFVdbOPX/MxmY/ra7F30Tl9r7CnNb
         mW3hfNtVGzTdR8yLF8FgDuA/ad9KAVnwNXqAqDJgOzcMPwdSxnasnBtiitr8mVtAx4nF
         Z8M3q8ESp5Wic/GlXcf2CjzR9/4B6ovAIB5BgcG+m7ZnHEK5y9tfkSaZpWupbotNQcN/
         1S1ulX+qciIbfjohTdu+OkTyrG+yJl4XPR79g5O3VdwKtyQbs+5pveoWAO9cAEibDlYq
         4msg==
X-Gm-Message-State: AOAM531NcV9+4tTO7NkgSoEqoElx8nki7OzZ7r6qoe/LH1H2bsYW1gGq
        8VBYIOXLKyDIuQ/TyfXVd+OH7Q==
X-Google-Smtp-Source: ABdhPJwDfd21b5LkVyddx+3HtwmIG7Pf/brq+tML6qftxXPRLFkk5Zh6X+F0E5Q2tUlt/E8YIAo/KQ==
X-Received: by 2002:a5d:5549:: with SMTP id g9mr61834625wrw.419.1594209780204;
        Wed, 08 Jul 2020 05:03:00 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m62sm3964997wmm.42.2020.07.08.05.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:02:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Subject: [PATCH 24/30] scsi: aacraid: linit: Provide suggested curly braces around empty body of if()
Date:   Wed,  8 Jul 2020 13:02:15 +0100
Message-Id: <20200708120221.3386672-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708120221.3386672-1-lee.jones@linaro.org>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aacraid/linit.c: In function ‘aac_biosparm’:
 drivers/scsi/aacraid/linit.c:368:41: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
 368 | param->heads, param->sectors, num));
 | ^

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aacraid/linit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index a308e86a97f19..734dd6e67246d 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -363,9 +363,10 @@ static int aac_biosparm(struct scsi_device *sdev, struct block_device *bdev,
 
 		param->cylinders = cap_to_cyls(capacity, param->heads * param->sectors);
 		if (num < 4 && end_sec == param->sectors) {
-			if (param->cylinders != saved_cylinders)
+			if (param->cylinders != saved_cylinders) {
 				dprintk((KERN_DEBUG "Adopting geometry: heads=%d, sectors=%d from partition table %d.\n",
 					param->heads, param->sectors, num));
+			}
 		} else if (end_head > 0 || end_sec > 0) {
 			dprintk((KERN_DEBUG "Strange geometry: heads=%d, sectors=%d in partition table %d.\n",
 				end_head + 1, end_sec, num));
-- 
2.25.1

