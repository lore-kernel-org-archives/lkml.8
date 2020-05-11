Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4E4C54E8F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD37B206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KVR/4mWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgEKG2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 02:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbgEKG23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 02:28:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9873C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 23:28:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y9so925275plk.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 23:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=24++CivPXE8fBvBos0NVNWFy2GmB83U0HnUkCj+M+o8=;
        b=KVR/4mWdqwJpQHob/TYk74A1WMBuMPqPOYFObOiTpdCy2zF3Fp1iMg87RWDKMgtKQJ
         ofd0XbRm9kl3hCuBGmLNf8XANJlcPRR6lDRcX4H4GGCRjA2VRqXxnhfbbkOCl7atusgt
         BHmiSD3YmQmiZgkoJ3RFiHcmwiDCyFzMyOCAPNvwLoooWQdCKDvNcEgAr+2Yfo1Q/3us
         NKo2SKByxk0Wibi+kaN3bRMGxAC0b0mQFqzg/Iu2q4dLI1Lq96EuIi2NFiVryqpnwTQW
         HTu48lTSI8GaNv4XBKrH6slifMP4c6KRZ4CAa4r2PPRmbueyGAaHmX+5Eo/kRWJ8Kx/X
         Ul1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=24++CivPXE8fBvBos0NVNWFy2GmB83U0HnUkCj+M+o8=;
        b=LxP4pPzD1cUEvdyU5XFYvv71agbE6rTb5l+CuM9wKAaZwjH46A9XJav/vtKTHIAJWx
         86rELYw94e/Sak4OA1ojG4y/7Mk36i8pnwmTR/ozNc+/Gr3BH/5IKaFsT8mJCmFJMSDT
         IW0xT6FncSo8qHh/z5Gh2ox1Kd2jez+tFYsxDlU57J2BFCg0KIqWsPmIOVNhPGyRYm+A
         RBVFIkrpy3X5jI3auxfog/HcLr038FrUK7oaf2towmETgmjxlyER6pu7mUs09gbsuAkb
         7qTiKBMeIFFKiTdM7+dqCY+jQpVZM999l8Mb9RIvN8EmIsd3HJXVfLllGbpYR04YUE7c
         FfOA==
X-Gm-Message-State: AGi0PuYI0IgpPb/MghHQWumkBsxmwnAPcuXmgMgt+B+dLG5w0qFdaYnf
        WO7Z46Mtm4FyfkeEuUaH4ltVYQ==
X-Google-Smtp-Source: APiQypKAox9LvCH+V2CF16w07BkS47nQx+kio2NAvZWt8LOA4/QXf/llrtpA/r5sbzWwGQbPvldPlA==
X-Received: by 2002:a17:90a:3509:: with SMTP id q9mr20591776pjb.121.1589178508479;
        Sun, 10 May 2020 23:28:28 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id j63sm5179558pge.76.2020.05.10.23.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 23:28:27 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 1/2] mm: remove the specific name of arm64
Date:   Mon, 11 May 2020 14:28:19 +0800
Message-Id: <3a6a92ecedc54e1d0fc941398e63d504c2cd5611.1589178399.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589178399.git.zong.li@sifive.com>
References: <cover.1589178399.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UXN is the name of arm64 page-table descriptors.

Signed-off-by: Zong Li <zong.li@sifive.com>
CC: Will Deacon <will@kernel.org>
---
 mm/Kconfig.debug | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index e19f94c6df90..b8cbe035247f 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -130,8 +130,6 @@ config DEBUG_WX
 
 	  This is useful for discovering cases where the kernel is leaving W+X
 	  mappings after applying NX, as such mappings are a security risk.
-	  This check also includes UXN, which should be set on all kernel
-	  mappings.
 
 	  Look for a message in dmesg output like this:
 
-- 
2.26.2

