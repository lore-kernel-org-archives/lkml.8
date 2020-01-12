Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C885C33CAC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 18:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F12B21556
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 18:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXMVpie4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733247AbgALR76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 12:59:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37616 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733203AbgALR7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 12:59:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so6401250wru.4;
        Sun, 12 Jan 2020 09:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2z5jKKd1kP0MGK92fjPfQhagxUNB4WYrYfTGQCeaJaI=;
        b=rXMVpie4I6835JSVbDI3sQTxOTKQBd4BFGhjhKZrbphGEySSZzqRSr0qnd2eIKPPo8
         vdvgA7v/itexM++eH+lQ1NpYal+yPaIg3u7nvqBVXSwIAHraetE+pj0VG571Gd1ofU4T
         lQ4OnuIdr0s0UjvdY2QwqFNLFQM/L/nOGg+0OUu2+NwqxbNNT0Lj0VRa/y682ZwvHLXW
         ul72ef0RkEjARu+VTWER4uOHcsqDgoZaCpf3htgZhd/Y86waa6n4Wh18RjCLljM4BiFB
         CYcVOizz3KjADECUewAdUh8eJgBkdoTnr1ZgD1pFsD2K9jdWnmuQNL4QXal/E9o9apje
         7Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2z5jKKd1kP0MGK92fjPfQhagxUNB4WYrYfTGQCeaJaI=;
        b=hL8POZuczpWDDAddz/SKEF8H75kj+zqRHmZUvo24JDyMrNwCuvKWSoVBb+K7KKZ/8g
         CS8sJjj1nPrCP3B8RuyVSk6X87PDw8lpw62OPhX6xXGPHBCKfgUeceZfayQsmteG2TjM
         2dhi8ayMeM4qX7wcuddLSL2vphhOS2r2ssl463h8VO5yh4Vrzagzst3QyESnAU6AWJJM
         Omx4mnhNIdxgQ33EkPdbDHrTEhQLKOj0yQ5M5a7GUCLLeXyl9QA3dn99kTELe3ykiqnK
         4csGqNhwZcL8Ywpk66VDhn2cJhXX9NZNFZmIGVjmm2EvDY4ehTrUmZtdC87k1umMHyKL
         XnCw==
X-Gm-Message-State: APjAAAWChXJnTT7KLn81ioe1dwYZK5MtBwxw3cP5tj4P8R5x5HSjID2v
        CtzBlq1NsCNE1lfv9DVDa6xWZ+C8
X-Google-Smtp-Source: APXvYqzgINU2cjDfDKUuG7UoPCMbyduVF4vZdkmSesEde07NJ1C2f9Pfn0IOeksN6sakxsL/wGRVyA==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr14775327wrp.182.1578851991201;
        Sun, 12 Jan 2020 09:59:51 -0800 (PST)
Received: from Pali-Latitude.lan (ip-89-103-160-142.net.upcbroadband.cz. [89.103.160.142])
        by smtp.gmail.com with ESMTPSA id t25sm11076522wmj.19.2020.01.12.09.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:59:50 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [WIP PATCH 4/4] udf: Allow to read UDF 2.60 discs
Date:   Sun, 12 Jan 2020 18:59:33 +0100
Message-Id: <20200112175933.5259-5-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200112175933.5259-1-pali.rohar@gmail.com>
References: <20200112175933.5259-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current udf implementation now should be able to properly mount and read
images with UDF 2.60 revision in R/O mode without any problem.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 fs/udf/udf_sb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
index baac0357b..be8cb9f3b 100644
--- a/fs/udf/udf_sb.h
+++ b/fs/udf/udf_sb.h
@@ -6,7 +6,7 @@
 #include <linux/bitops.h>
 #include <linux/magic.h>
 
-#define UDF_MAX_READ_VERSION		0x0250
+#define UDF_MAX_READ_VERSION		0x0260
 #define UDF_MAX_WRITE_VERSION		0x0201
 
 #define UDF_FLAG_USE_EXTENDED_FE	0
-- 
2.20.1

