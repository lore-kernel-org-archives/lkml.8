Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A231FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A5324655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="DJF3Jr9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAUX2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:28:30 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:34020 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgAUX2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:28:30 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 482PqK4bk0z9vZ8j
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 23:28:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zAB7f17VEORm for <linux-kernel@vger.kernel.org>;
        Tue, 21 Jan 2020 17:28:29 -0600 (CST)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 482PqK3Xmrz9vY9t
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 17:28:29 -0600 (CST)
Received: by mail-yw1-f69.google.com with SMTP id y188so3804439ywa.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 15:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QDSoCgRn2awPXZIHPqZUcbJK/YN9MXXwLcpipylIxRc=;
        b=DJF3Jr9OAWSaXREE+ECGzJQ5H8j/Jkoj8rXQIpqijNt8TCHZSHdERIn73pa9hMPS/x
         tQGZa5WSYDCgkyZe3xlHX3B3/43tfSLcYkb1bbADEz7wvM/WzQHTHwbT6WIox9rHC35E
         MjWBDfezMfGjiFMhWlc2m+HVCFqT78YPAARiqOZEVCSgS013htZ8zsgV2JYSDByYszs/
         7FmTdfL8BGNkoUuE8GXnnfoo6viEbZ0wPgElhBhlVhFZKwsXb5brVQBLO/04xf//Od4s
         cidUon7N+snecewRd3Y7FMtBqPVs9aCtx7qGOy3HcAil8WVb1BiE7K/V9c7HthWpytq1
         MfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QDSoCgRn2awPXZIHPqZUcbJK/YN9MXXwLcpipylIxRc=;
        b=MK0EyMVczoUg54PK+qB2igLgsaHgyZdQKzUpq3WLP623EvymHzJmiryKwghU1to6Vm
         wRoM0pfgy7m5A7SmiQ1Ac4tHhSEvE0Ni9NkfEi4a5Z9a+HrvmJtHaI+aJMYsRZQYH0X8
         Q/3niN9Dd0XxFXTwYExJ53r2hTjcmCZsxqxBje+7oTPlKLoqkdD7xAK607BrNuwLZXfz
         EQOuzVf/CBEK3N47txVQzXt7Kts0WNK3cy4fuIlFrjemohacLzlJM/mBD4TxgMGOIVz1
         9pAMK07U18WGQeXlCIsB/Vdcy0p64bdjt3M8WbX7VRkUHgx4D9CFxo0xqEoSSCjVGM5W
         ggPA==
X-Gm-Message-State: APjAAAXORvDsgSmrSDsZNtQkdnAYLFy+HEw4G6JW6mcaphO/9g2rNnSX
        gRzTUIpCnO0QyNRqUoMWVJJQ69Xd03PpWK4g30xX7Wci7ZnTiF1aL6qzTizd8CHIWmDL8PxNh9n
        jP5rl8JfY3WUKYyCs/DGnb5uY/ZjF
X-Received: by 2002:a81:b645:: with SMTP id h5mr5497653ywk.350.1579649308880;
        Tue, 21 Jan 2020 15:28:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIsms8HwlBlMjPYZ9klO4Ont2Y1e8CBZEjaa8VIBUstS21NtE1l/1pwdtycPZcQfR4MgjCMg==
X-Received: by 2002:a81:b645:: with SMTP id h5mr5497642ywk.350.1579649308608;
        Tue, 21 Jan 2020 15:28:28 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id g190sm17580313ywf.41.2020.01.21.15.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 15:28:28 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Allison Randal <allison@lohutok.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/platform/olpc: Fix the error handling of memblock_alloc failure
Date:   Tue, 21 Jan 2020 17:28:16 -0600
Message-Id: <20200121232818.28018-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of an error in memblock_alloc, the code calls both panic and
BUG_ON. Revert the error handling to BUG_ON.

Fixes: 8a7f97b902f4 (add checks for the return value of memblock_alloc*())
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 arch/x86/platform/olpc/olpc_dt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/olpc_dt.c
index 26d1f6693789..92d5ce1232ab 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -137,9 +137,6 @@ void * __init prom_early_alloc(unsigned long size)
 		 * wasted bootmem) and hand off chunks of it to callers.
 		 */
 		res = memblock_alloc(chunk_size, SMP_CACHE_BYTES);
-		if (!res)
-			panic("%s: Failed to allocate %zu bytes\n", __func__,
-			      chunk_size);
 		BUG_ON(!res);
 		prom_early_allocated += chunk_size;
 		memset(res, 0, chunk_size);
-- 
2.20.1

