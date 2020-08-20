Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE4EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E0620702
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXTks0qC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgHTX5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgHTX4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:56:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1A1C061349
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:56:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t14so109129wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSKa4Ey8gdfGZw4O7eXF+v0TKjbgoL2h7/Rum3+7vIE=;
        b=KXTks0qCaDbUf6bPSUK7xs/HT8S55LvPXgC8K2DVaaR3efaGdhX3rHNOPE1ocnOqyX
         Lu64TfQ2jxfdtUu4eG/nhLqYSCijXr41c/h4MZx+ib0IWXeiKV8rWaTPSbNiZvwHUIi0
         LfX0BCHPrg4tK9DYHGpkocyUuAkqbO5vVyCEf6kU5VoKTOV8IZQLZzJ772H6tXWoPjSx
         De5MzZKc0RJeG+jhckjzf7zD5PLYvWYrIqyLqgXUrKZ8Yvgu5rBLNPT4QCv9HK9tNjHx
         frl3rvvz9Hk6wxrtuz9gc9vRuMSTg8JVPn2y93jWV1MqV1vS+pAeL6Ack1RYwyyXsLgR
         NN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSKa4Ey8gdfGZw4O7eXF+v0TKjbgoL2h7/Rum3+7vIE=;
        b=L+zV/O5Qe0BipTLeJ4O2uVwd9/a5Ko3VPGJBeCD9Wn83rHDAKw5D9H4DXvnB94FA8p
         /gdDTKVrMJeHd35AarjsUST1/J2g7LOJtK0XV8fR8uDocJBW6z1RSi+Dh05PSPXlw0IA
         ihQGd/FSMBUth67Xgt1nLmk2zBVa9+mj+tEH1+J6qYk2tVF/I4L9kshnxTJqYCKDh/5Q
         QT4chSJphwrusx2EFk+o4u0zSWN4t7+Mdf5t8dM15x400BQgkJO8EqZrnGN5WLS68oxA
         uNhTypXRCvRBzmMekmRs5SEpKe/6lStHc0TGmcBEt+7ig4mOaXNfpsJbmYzq5fLvI2D/
         ilIQ==
X-Gm-Message-State: AOAM530nx8+1jidkkMgK+UpW5naGNCOKOzvun2YSJ445bqx7ZQAJTGQ+
        qZAG/3IpCTg0UspvhS0xZv0=
X-Google-Smtp-Source: ABdhPJwDGeYpHJYWEawHyyzdBiI9Dk7vOO5oGyMaLBb8yJU/pvhi6QWe4Hh/d9CEuDOAQsmEiul5gw==
X-Received: by 2002:a1c:2808:: with SMTP id o8mr820101wmo.108.1597967770566;
        Thu, 20 Aug 2020 16:56:10 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id s20sm561046wmh.21.2020.08.20.16.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 16:56:09 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: add patch rule for dma_alloc_coherent
Date:   Fri, 21 Aug 2020 00:55:57 +0100
Message-Id: <20200820235600.326346-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()")
removed the definition of dma_zalloc_coherent() and also removed the
corresponding patch rule for replacing instances of dma_alloc_coherent +
memset in zalloc-simple.cocci (though left the report rule).

Add a new patch rule to remove unnecessary calls to memset after
allocating with dma_alloc_coherent. While we're at it, fix a couple of
typos.

Fixes: dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()")
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 scripts/coccinelle/api/alloc/zalloc-simple.cocci | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
index 26cda3f48f01..b3d0c3c230c1 100644
--- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
+++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
@@ -127,6 +127,16 @@ statement S;
   if ((x==NULL) || ...) S
 - memset((T2)x,0,E1);
 
+@depends on patch@
+type T, T2;
+expression x;
+expression E1,E2,E3,E4;
+statement S;
+@@
+  x = (T)dma_alloc_coherent(E1, E2, E3, E4);
+  if ((x==NULL) || ...) S
+- memset((T2)x, 0, E2);
+
 //----------------------------------------------------------
 //  For org mode
 //----------------------------------------------------------
@@ -199,9 +209,9 @@ statement S;
 position p;
 @@
 
- x = (T)dma_alloc_coherent@p(E2,E1,E3,E4);
+ x = (T)dma_alloc_coherent@p(E1,E2,E3,E4);
  if ((x==NULL) || ...) S
- memset((T2)x,0,E1);
+ memset((T2)x,0,E2);
 
 @script:python depends on org@
 p << r2.p;
@@ -217,7 +227,7 @@ p << r2.p;
 x << r2.x;
 @@
 
-msg="WARNING: dma_alloc_coherent use in %s already zeroes out memory,  so memset is not needed" % (x)
+msg="WARNING: dma_alloc_coherent used in %s already zeroes out memory, so memset is not needed" % (x)
 coccilib.report.print_report(p[0], msg)
 
 //-----------------------------------------------------------------
-- 
2.28.0

