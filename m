Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3E6C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6C42166E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="hqyTcqIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgCFNeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:34:13 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34988 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCFNeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:34:09 -0500
Received: by mail-pj1-f65.google.com with SMTP id s8so1103770pjq.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jwvqhmbLPpvanCf4CYPj6H756JJZayFM0Q320MsSZZo=;
        b=hqyTcqIGcYRSfxPhsTnMYXAKvfyWxWa9yNdPDtkX8UTSp8Hd5c1GqP/I9nYxLw3Ewn
         KZnKO/QRU/7DKwObIXQu8nKYZpg+Uel8JNQ+AAx3ZD/QstxlgjHhWTsIpOev+rE6q8zl
         GdmTa5OE7dkxYmC3PY9TgsD8BgAT9geSvp5+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwvqhmbLPpvanCf4CYPj6H756JJZayFM0Q320MsSZZo=;
        b=ksOgUH8vKg5SA5O1ECbLHI5P+4ke77WDJ2st0DhBW0eGrb3ZmnrIDmIfxGlrXQLCX1
         MP2tdWsQuN5DsAQN537MAf1/5dnIMznDYNFMm7mScDMuH7q50fxZ4SKQ+zoExVmCc0rQ
         MS7d/CpVNHQgGQeNZkUKW9fH2eWtJADceXMGBFGKCszMF3WYLoHI9U1Uh2//btK8Oywu
         JljfizK05jzoujmsT0TboyS52yGUw/JT/5FO4562tBX7lbuaksFCFAJDhgpoQSorFJ2c
         ey3BPahBgUzBv4q0S40c4zUIHOEXL/oG3evAXXypuwStGnLWZOgeehsLKl177qIV1z1u
         eqGw==
X-Gm-Message-State: ANhLgQ1pzFlfSzCJvOX2N+sCafuMcGrlY1OdTszzltswjiST34iUvnRs
        14LdiWsUvCygf5tbQ26srCVCIJAvSO8=
X-Google-Smtp-Source: ADFU+vv+KMS5gERf7CXGqDJLMTaerPdFTQAHXXtiRFVoMb3eP1LLQdOrxWN074muoj0uvCZ6KfuIIA==
X-Received: by 2002:a17:90b:4c4d:: with SMTP id np13mr3730802pjb.58.1583501647865;
        Fri, 06 Mar 2020 05:34:07 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-b120-f113-a8cb-35fd.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:b120:f113:a8cb:35fd])
        by smtp.gmail.com with ESMTPSA id x11sm35601211pfn.53.2020.03.06.05.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 05:34:07 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v8 3/4] powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
Date:   Sat,  7 Mar 2020 00:33:39 +1100
Message-Id: <20200306133340.9181-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306133340.9181-1-dja@axtens.net>
References: <20200306133340.9181-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan is already implied by the directory name, we don't need to
repeat it.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/mm/kasan/Makefile                       | 2 +-
 arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)

diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index 6577897673dd..36a4e1b10b2d 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -2,4 +2,4 @@
 
 KASAN_SANITIZE := n
 
-obj-$(CONFIG_PPC32)           += kasan_init_32.o
+obj-$(CONFIG_PPC32)           += init_32.o
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/init_32.c
similarity index 100%
rename from arch/powerpc/mm/kasan/kasan_init_32.c
rename to arch/powerpc/mm/kasan/init_32.c
-- 
2.20.1

