Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DC2C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13B72076B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="z3j+Mugv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgC0RGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:06:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37528 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgC0RGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:06:06 -0400
Received: by mail-lf1-f66.google.com with SMTP id j11so8474915lfg.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uEmPFiw3NMkf3IfRIxWgnKIkN+OrB/j1csttn5Htb5E=;
        b=z3j+MugvIOEV5ZTNeV8Y5iSCTsByA3McfeDK2HMga5j30TJGS1jCU2mARtvWuwgHZT
         wBwryyzEC9XH8i28e+3+RHU3jD6Q86e2Y7N/2LASbsk4xhgGhE/LKp0YxH614uxCaLm2
         Uxb43/hP9GUS78Cz+RGLCxlp/k0xwNjWmpLM/AY1ydd0ToWnqmkTAkioJShsGdnUnmIq
         KDHOOiJRSvG43K61Vm4lBM4R+aHhWi5VCLrVpWl0+Xy9KMLWv5aei3nbPj/r3QC5WhNR
         oOxCPsb+UmkK4aAszIDPTddUV08oDFX+pDtf6D7W6u5qb88ypahuJSlTJ0irMeO6isQL
         UEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEmPFiw3NMkf3IfRIxWgnKIkN+OrB/j1csttn5Htb5E=;
        b=RGD37FKFppKM58uk931ABI+6RZOQyrnxEdKjwO1og9jZLJWrHRQe30HMPsH4BiMExt
         R36BXZueczgTrEUP9NYWULFnpGQutV93+aUbRjmeJVfX7uXNL+iZ5U54uapLVEaFtKpq
         N8FbrzFPQ41/5dRl8+vqsLeIWXk3PEMKt8JOTEwATxRAju6yepYtDHuMs2jFWcLm4QET
         g5AQuFDbLmDDI+R0vD0A8vYW4qSCr3bq4W6quGKqrT0rfIja3tnWLq3FUAt78UrCDhEE
         jY1RchnPI8tW2jOWI/gMhlwVihnKeKybUJvUObRG7eaD0e31gu5gQRWeGiiaRibc7PpM
         cNDw==
X-Gm-Message-State: AGi0PuZ6iVpua2nMKCV5SoJ0W+QvPES9vrxDyghB/P3kOdFYGW30F2Ac
        iB2J9/AXfUpLJaEgOLFxJ2NPMw==
X-Google-Smtp-Source: APiQypI3S8W00hxoDxa3oFcnVq3mUYLKs3IlsAXA0vKYmfajc3bCUm9dNAKtZxa0tJ1SdtOMPJlmlg==
X-Received: by 2002:a19:4f01:: with SMTP id d1mr184636lfb.182.1585328764571;
        Fri, 27 Mar 2020 10:06:04 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c5sm3225046lfg.82.2020.03.27.10.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 10:06:03 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 699D3100D28; Fri, 27 Mar 2020 20:06:07 +0300 (+03)
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 3/7] khugepaged: Drain LRU add pagevec to get rid of extra pins
Date:   Fri, 27 Mar 2020 20:05:57 +0300
Message-Id: <20200327170601.18563-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__collapse_huge_page_isolate() may fail due to extra pin in the LRU add
pagevec. It's petty common for swapin case: we swap in pages just to
fail due to the extra pin.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/khugepaged.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 14d7afc90786..39e0994abeb8 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -585,11 +585,19 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		 * The page must only be referenced by the scanned process
 		 * and page swap cache.
 		 */
+		if (page_count(page) != 1 + PageSwapCache(page)) {
+			/*
+			 * Drain pagevec and retry just in case we can get rid
+			 * of the extra pin, like in swapin case.
+			 */
+			lru_add_drain();
+		}
 		if (page_count(page) != 1 + PageSwapCache(page)) {
 			unlock_page(page);
 			result = SCAN_PAGE_COUNT;
 			goto out;
 		}
+
 		if (pte_write(pteval)) {
 			writable = true;
 		} else {
-- 
2.26.0

