Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210A4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 09:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8AB4206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 09:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGabIp/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgHAJJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 05:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHAJJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 05:09:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5732AC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 02:09:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p8so1144576pgn.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 02:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UN/Dvz3hyrHMgSmeNmiv4tJktuZkgJkdeT4j8TORBL0=;
        b=iGabIp/kfW/rp6Hdvg5DxXklaquJZhtr7cvsmuxiOGGMYu22baXQ2d9ML+a6w3cz8z
         lHv4XmCp8ypBv7nd7paFUBpaVtoCLPUpyQQMt9TROdPnwJYtGbyG4PMegdeZh8nMK3Rt
         qBpvZ16qFzpJ6O1dQOW7fgiPvtcFKWyE/9MjM9W+fNmm/qtWsUYKTU/5jCrvejaNYKMW
         zUxcCZzqMm1UN4efHJvmfdr65EDt8fu5BNWzUF6Xs78QsK/NLdZHU+E5WUleaQoKUjND
         dQPGX3Rp2WqXNlmBo4av8RNsrhcf8e9bs6WFCXXQW3nmfjgkqWBdcNDolqwLwuVqzJX7
         Kk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UN/Dvz3hyrHMgSmeNmiv4tJktuZkgJkdeT4j8TORBL0=;
        b=uDXICyLXtoU+iEmOlAVCCxnbFPP83sRqkzU2SAdkh9jyP75zMqTY4jjHc3FyoSUUR0
         WMSjx3p7Q3vCdWJQ93fss8mmq36MkMdTyj2q8KkG5xff8iZkJ7Ug2SAjUCTAsI9XzySK
         tlbaMvni7uU3PfGiqs1n5ct9dtwuXLVzH7Ea5xkqyCr1bntmlduRFwJQhpwdaIiech/k
         llzfuNaKDekeO2m87mSRQUUnyF8/AQymZZYahdLqT+wld66OuzXtT/+ImI60BPkTziMy
         raTbXeekB7LhmH+/5HsoI3L9ccfbhs2zKSeIDdlXTvdkFqWHrE/oLkLRtPVVwh8VsjDL
         p9Qg==
X-Gm-Message-State: AOAM531SWSeJWM4luntou3Tw3cL8LpQYSHGCBeWgy+2VdFCl0/IoVdfs
        cxFduULnIoPw03D+1h8X08yvNSJU+xU=
X-Google-Smtp-Source: ABdhPJx7HHXvadR3lbkPf9OdwKon3d8m8/5wxdSGns9KnUvl6/9nBW9gQsnkygYyDPQYcRviT3TPVQ==
X-Received: by 2002:a63:ce15:: with SMTP id y21mr7297655pgf.163.1596272946000;
        Sat, 01 Aug 2020 02:09:06 -0700 (PDT)
Received: from localhost.localdomain ([122.96.73.106])
        by smtp.gmail.com with ESMTPSA id a193sm13491945pfa.105.2020.08.01.02.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 02:09:05 -0700 (PDT)
From:   Wenchao Hao <haowenchao22@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wenchao Hao <haowenchao22@gmail.com>
Subject: [PATCH] mm, mempolicy: Check parameters first in kernel_get_mempolicy
Date:   Sat,  1 Aug 2020 17:08:26 +0800
Message-Id: <20200801090825.5597-1-haowenchao22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous implement called untagged_addr before error check, while
if the error check failed and return EINVAL, the untagged_addr is
just useless work.

Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
---
 mm/mempolicy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 381320671677..dac0cd0df3e1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1632,11 +1632,11 @@ static int kernel_get_mempolicy(int __user *policy,
 	int uninitialized_var(pval);
 	nodemask_t nodes;
 
-	addr = untagged_addr(addr);
-
 	if (nmask != NULL && maxnode < nr_node_ids)
 		return -EINVAL;
 
+	addr = untagged_addr(addr);
+
 	err = do_get_mempolicy(&pval, &nodes, addr, flags);
 
 	if (err)
-- 
2.25.1

