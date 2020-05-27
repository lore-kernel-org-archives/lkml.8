Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F87AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05EB12088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY23dNqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgE0Uyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgE0Uyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:54:40 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA46C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:54:40 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x18so9515497pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0PiLFUHjJ3TV2xcfUTcBbUSBMI/CnZK15s/joy4TG+Y=;
        b=gY23dNqiZtCL+lz80go6c7oVIXjBIhyhcV2JSOZV4pqRf79boVoadZBc4SIKj2+Xu1
         k1Ns6Qh3ueAFxQuC4HWqhwfJ57/Qnx78BDrFrwFdXQZg/uC14VrdMJ5bfoLlXq4lc4BV
         CjAvdb2YYuf9B7aArvsqJE2RQBEQTwx2WMbWx2Gc64mnUFfirkcnl6sR8T/Udl08Xpo7
         yz03yC4GNLHTD1/+l4dcQNRXyGHw79LAHLoLCMxtFjDfq/kJD16FL3skM2ujZtZLKMOT
         GV0DKUO6KtSTxzNts1+hVNYkeijJDhV9/a0t+v1iL3rFILT4FiEdxTkpfezgnJNO5ANv
         wn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0PiLFUHjJ3TV2xcfUTcBbUSBMI/CnZK15s/joy4TG+Y=;
        b=R65usBxuJKiHCwEy5y2npK3bD/hGaH+B+DYKa2etPdVAK2LPK4mV3S9EocnRRWYvF9
         r1vbawiSQ1HYr4R9ZMS3G9xy0R7G0hbryCcPyMj/I6DqJ1VdUE/9XYTJm09+pfqqSr0x
         Af7iVrrhUdckLuFzasDNDs8/VVEpL2Nky3LmIe2TgyyjQtv4EpHXAp69gE9Zvb7ASz0W
         PLpPbgtlOi8vMLtZJSF8zWBHY31hA6kPzfOYkwVhyo1DDKjYmd+SS6P+2SyW2SM51tzW
         V/gqv0ls2bMHuZWz8Sw4AqbkyRMOzwXSafq8JWqDWlralB+NvVzQNZLdRuZxpgZnhtwy
         BdBg==
X-Gm-Message-State: AOAM530buuGoP1Iyuj4C08vSJ7UCzs+6w7g+wAEiBKcN6YFEuhKlbkYL
        asU5vucngZ9SSz/HedokA3g=
X-Google-Smtp-Source: ABdhPJwV8OJTbrEJlcXxHa5WpihgHyU1h/uvcIml2IOtVxTmnKMbONosMFdkhG4t36EX7+JYvOXFWA==
X-Received: by 2002:a17:902:b203:: with SMTP id t3mr213803plr.129.1590612879611;
        Wed, 27 May 2020 13:54:39 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.201.5])
        by smtp.gmail.com with ESMTPSA id x12sm2895477pfo.72.2020.05.27.13.54.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 13:54:38 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] staging: gasket: Convert get_user_pages*() --> pin_user_pages*()
Date:   Thu, 28 May 2020 02:32:42 +0530
Message-Id: <1590613362-27495-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code was using get_user_pages_fast(), in a "Case 2" scenario
(DMA/RDMA), using the categorization from [1]. That means that it's
time to convert the get_user_pages_fast() + put_page() calls to
pin_user_pages_fast() + unpin_user_page() calls.

There is some helpful background in [2]: basically, this is a small
part of fixing a long-standing disconnect between pinning pages, and
file systems' use of those pages.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
	https://lwn.net/Articles/807108/

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>

Hi,

I'm compile tested this, but unable to run-time test, so any testing
help is much appriciated.
---
 drivers/staging/gasket/gasket_page_table.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index f6d7157..d712ad4 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -449,7 +449,7 @@ static bool gasket_release_page(struct page *page)
 
 	if (!PageReserved(page))
 		SetPageDirty(page);
-	put_page(page);
+	unpin_user_page(page);
 
 	return true;
 }
@@ -486,12 +486,12 @@ static int gasket_perform_mapping(struct gasket_page_table *pg_tbl,
 			ptes[i].dma_addr = pg_tbl->coherent_pages[0].paddr +
 					   off + i * PAGE_SIZE;
 		} else {
-			ret = get_user_pages_fast(page_addr - offset, 1,
+			ret = pin_user_pages_fast(page_addr - offset, 1,
 						  FOLL_WRITE, &page);
 
 			if (ret <= 0) {
 				dev_err(pg_tbl->device,
-					"get user pages failed for addr=0x%lx, offset=0x%lx [ret=%d]\n",
+					"pin user pages failed for addr=0x%lx, offset=0x%lx [ret=%d]\n",
 					page_addr, offset, ret);
 				return ret ? ret : -ENOMEM;
 			}
-- 
1.9.1

