Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C9FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 21:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE8520723
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 21:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgE3VVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 17:21:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34615 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgE3VVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 17:21:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id b6so3549243ljj.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 14:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wt7DeyDhX+RpnOwE14bZ128gk/jokCi5wj4+Egs8otU=;
        b=CteddQB0Md+5T3Zwav1qNZOCgj3E7v2e647nB8PQ9pXuzVkJfJrvTcpYFNEJbdsbY+
         zJGE0Gngi6VPUlMj54nYS9vJ/rdTjEb1ZKROCAKVy7fSZuqpUPa1QxWcgghXsTcgRfF3
         ln64ckS88dLUywgyRAU0WylxlreBFpw51zlhuIAwvNyenIecvkj64+p72C2bKDePkZRT
         wpdJFLHPNNjiYCq02FijizX3pjcUkDvdHCUuBqt2k7xL48BpmkqpZWRopcjFpOlWBK52
         WjFAPM3/U1z9k4RGCuzGkcibwAV5R/7KiBU4UcCuKYhOL/f5GDL1eMK4HJPniS10NAAx
         4+sg==
X-Gm-Message-State: AOAM531dLfkasB8B78cbLknDZ5R/gNSQrGxazPsOlchD2v1R/m/o/oco
        y0ZWhKDNPGA7kFrqegdHjWg=
X-Google-Smtp-Source: ABdhPJze84fkW5KSzE/MX4yCrW7dER49HipqIDaUscsqC5h7Sybp+5LYjQtqM/bwQZYsHCmu3DOwjw==
X-Received: by 2002:a2e:b52d:: with SMTP id z13mr1335086ljm.299.1590873707038;
        Sat, 30 May 2020 14:21:47 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.196])
        by smtp.googlemail.com with ESMTPSA id u15sm3262161lfg.92.2020.05.30.14.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 14:21:46 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] checkpatch: check for trivial sizeofs
Date:   Sun, 31 May 2020 00:21:29 +0300
Message-Id: <20200530212129.7498-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sizeof(char) and its variations in most cases doesn't make code more clear.
It only makes code wordy.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index eac40f0abd56..9dd338b125d2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6045,6 +6045,13 @@ sub process {
 			}
 		}
 
+# check for trivial sizeof(char) == 1
+		if ($line =~ /\bsizeof\s*\(\s*((?:(?:un)?signed\s+)?char|(?:__)?u8|u?int8_t|[us]?byte(?:_t)?)\s*\)/) {
+			my $byte = $1;
+			CHK("SIZEOF_TRIVIAL",
+			     "redundant sizeof($byte) == 1 \n" . $herecurr);
+		}
+
 # check for struct spinlock declarations
 		if ($line =~ /^.\s*\bstruct\s+spinlock\s+\w+\s*;/) {
 			WARN("USE_SPINLOCK_T",
-- 
2.26.2

