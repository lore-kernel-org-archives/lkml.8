Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E09C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C4121702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCCBYJPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgGUQmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbgGUQmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:42:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0953CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so3549295wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJbT5rEsiVLxEFDN8OpDH7HBLl7n1iObA52KTrCeYDY=;
        b=kCCBYJPuIw2RTNpkxwYUbE8P2MEny9ibyPD6vBVTTIscxOh3f0chTfi8Kwz7l8XqY9
         DHzPtcmsTtMjwMVmOvU5qzwk8INAXKz0HpYoGWY6aoorODiuSpvJN/O/cI03i9ej0gqh
         SYX7WJAudU97m1NOh5ghldIiE4+XM1kApRC687v16Vc2Wjl8AsMKOLU4pR5c1iN4uZhK
         iuDzIeruL7/XWiEnjoU5yk6BVH/H74bK2OQ15iQZwUxmgVxALeXQMw96H4brLqFPRdn+
         7ccF1K1oB7ZCEhwyswRjMUQPjylbwbLiP06WrK1Ws1+MDscN7uHdm15krEWOTzBDZIKj
         I+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJbT5rEsiVLxEFDN8OpDH7HBLl7n1iObA52KTrCeYDY=;
        b=Q7sXWZGgJX85DnjBH2QOidlEdMZ3bLHofnWvR3bWqoA1vqJK8hNJF1UtKkTl7rk/Vc
         sGnevNKoebo62iCGQ7b9ux81rIEnIvUb/GdnyGT42cbUwdxprLjLU/o0UaPCQcqXPgDm
         6Bnw/lKUXVTNuWcrkJav6Fh3AmBW/CucMWn1FZO2bY/14XhNiUF3lQw8Y1FIFIAYmSbz
         RygBMvGQ58szmscayCaYEmQoIpNRy4QL1sD578QtoA12qp5PdB5oHpevAWttbfD80O2E
         jn4JP4z7PjS/P50yXJXOFBuinfKDUEVRFQBtvhMgx70zemeNjQKI0T6NNKOQ5hXh3hP1
         FvpA==
X-Gm-Message-State: AOAM5305dCOor+N238zIA2nEt7kOoz4waeOXD6cw0DdXEY8FL1rAeobw
        TrJB9/4yeaz77lVOkd17AMLj0q9Tgxw=
X-Google-Smtp-Source: ABdhPJxUWjM8jLwPu2ydGiVIw/1pkm6bL1TdQY46EvjGab7xHZigolf34Caq7Ro+oPKz+z50b9eaiA==
X-Received: by 2002:a1c:2392:: with SMTP id j140mr4748659wmj.6.1595349719707;
        Tue, 21 Jul 2020 09:41:59 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id m4sm3933524wmi.48.2020.07.21.09.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:41:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Subject: [PATCH 05/40] scsi: aacraid: nark: Add missing description for 'dev'
Date:   Tue, 21 Jul 2020 17:41:13 +0100
Message-Id: <20200721164148.2617584-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200721164148.2617584-1-lee.jones@linaro.org>
References: <20200721164148.2617584-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aacraid/nark.c:31: warning: Function parameter or member 'dev' not described in 'aac_nark_ioremap'

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aacraid/nark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/aacraid/nark.c b/drivers/scsi/aacraid/nark.c
index b5d6b24d6dbda..4745a99fba8ce 100644
--- a/drivers/scsi/aacraid/nark.c
+++ b/drivers/scsi/aacraid/nark.c
@@ -24,6 +24,7 @@
 
 /**
  *	aac_nark_ioremap
+ *	@dev: device to ioremap
  *	@size: mapping resize request
  *
  */
-- 
2.25.1

