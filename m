Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E3CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFF6206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcJmCxzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgHERMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:12:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30250 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728207AbgHERIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=NXrvFSV+dNzT7Ew4OtdZ4sl3Tp8McXO1LQ3a/45Cy2g=;
        b=EcJmCxzcZ7bIjzT8p2fD9r9DFXN5PtMFJjemYihJHR4uAtiKoWvBjwWqOk9kSn9ggH+S59
        HiABS3ToP9hSmwJ272U6SN7hSZ4lurUNFMkW9KmlzWvPenZJeHiyBvLIaA/NGv5CWCKSsk
        pFmFSBkgEdzaSe724K3ITd1F4hkxE6g=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-YnIaVJ4UOaeY2oKgOv63Dg-1; Wed, 05 Aug 2020 10:52:19 -0400
X-MC-Unique: YnIaVJ4UOaeY2oKgOv63Dg-1
Received: by mail-qt1-f197.google.com with SMTP id f59so18863326qtb.22
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 07:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NXrvFSV+dNzT7Ew4OtdZ4sl3Tp8McXO1LQ3a/45Cy2g=;
        b=KbveZxnjwaOimAORUVbBJqkvDq0bBZBRaFdrC5CgeoUYULUSvAHd3hgZIgCOzj1i73
         pPu8YquJkoUFowNBuFB0+Z6LbZEIOt7mN+CkfHakfwzonSQ7UUeBrsfEwHfrZj4pqcXc
         VFkJteZtEypHeg6TFDWuDEoiG9orKNyE2FJqpTGKyueyYJH5t+Hunn3lVlOsAMmCdoGa
         wJUtpWIxlf2PxInSQi9aTpWckyvTzDvIGJ1tFWSQ9KTPbv94T7Y348eF/dAFWeKQxo/l
         5XZr8Sg1Aam1AEmgA4H/IJDI/SgScIykr2ie2ZNKEyQh2dIhcvf25OPOlYA07N5viU+M
         x0dw==
X-Gm-Message-State: AOAM530shyjmOvNZ4U72fG4ZbjwYBSNuecxdEEImw3sA3c5IrGVl5YK3
        IT+WtmQyvgxs39kaEs/iIxKNs2OgeuYfJbqPAhZVzbYbuUlZpzlGBUVg75g6OvcqpNMpTZhRp42
        Tfrei6T03JXQtjg/hKayC2Lls
X-Received: by 2002:ac8:4a99:: with SMTP id l25mr3768025qtq.132.1596639139243;
        Wed, 05 Aug 2020 07:52:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp5tU+SNu4wENz/P1igk4DE3nEE4fftblfRV1X1lQLG3yUmxqeZIDzwczARUE/HJu8apixFA==
X-Received: by 2002:ac8:4a99:: with SMTP id l25mr3768003qtq.132.1596639138881;
        Wed, 05 Aug 2020 07:52:18 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 22sm1868301qkd.64.2020.08.05.07.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 07:52:17 -0700 (PDT)
From:   trix@redhat.com
To:     thomas@winischhofer.net, b.zolnierkie@samsung.com, akpm@osdl.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] video: fbdev: sis: fix null ptr dereference
Date:   Wed,  5 Aug 2020 07:52:08 -0700
Message-Id: <20200805145208.17727-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this representative error

init.c:2501:18: warning: Array access (from variable 'queuedata') results
  in a null pointer dereference
      templ |= ((queuedata[i] & 0xc0) << 3);

This is the problem block of code

   if(ModeNo > 0x13) {
      ...
      if(SiS_Pr->ChipType == SIS_730) {
	 queuedata = &FQBQData730[0];
      } else {
	 queuedata = &FQBQData[0];
      }
   } else {

   }

queuedata is not set in the else block

Reviewing the old code, the arrays FQBQData730 and FQBQData were
used directly.

So hoist the setting of queuedata out of the if-else block.

Fixes: 544393fe584d ("[PATCH] sisfb update")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/video/fbdev/sis/init.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/init.c
index dfe3eb769638..fde27feae5d0 100644
--- a/drivers/video/fbdev/sis/init.c
+++ b/drivers/video/fbdev/sis/init.c
@@ -2428,6 +2428,11 @@ SiS_SetCRT1FIFO_630(struct SiS_Private *SiS_Pr, unsigned short ModeNo,
 
    i = 0;
 
+	if (SiS_Pr->ChipType == SIS_730)
+		queuedata = &FQBQData730[0];
+	else
+		queuedata = &FQBQData[0];
+
    if(ModeNo > 0x13) {
 
       /* Get VCLK  */
@@ -2445,12 +2450,6 @@ SiS_SetCRT1FIFO_630(struct SiS_Private *SiS_Pr, unsigned short ModeNo,
       /* Get half colordepth */
       colorth = colortharray[(SiS_Pr->SiS_ModeType - ModeEGA)];
 
-      if(SiS_Pr->ChipType == SIS_730) {
-	 queuedata = &FQBQData730[0];
-      } else {
-	 queuedata = &FQBQData[0];
-      }
-
       do {
 	 templ = SiS_CalcDelay2(SiS_Pr, queuedata[i]) * VCLK * colorth;
 
-- 
2.18.1

