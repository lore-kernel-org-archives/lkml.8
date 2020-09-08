Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66664C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CD920578
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="Mr9PlJQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbgIHTnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbgIHPwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:52:47 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ED3C0612B2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:11:32 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n18so11832976qtw.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=234lHPOkmRtRf38tY/dBUtuiJiCNT+A1HGusExETXW8=;
        b=Mr9PlJQE8npLe+p4mJ2C+cdVwblHUugaVSN0/1HpRNKDtU2yAgDDTRwo31DxGctwUT
         olHRgrKSDFjj7TvrvMkScApWdYiLUEko63sQQvNnR72Ko7jxmlBVe/qlpcADv3rpJCJc
         /x1XGudl2dNlAK5wMVg63lvoO4CKTr1zSXLdQ1vp1mqThpBX4k9XcBdyn2Y6JzM6m2qT
         b0yxgO+pavHTR05Fn7jlVEmxIs4NSgQ3oiVpbF2IknhHKK6n6TBjDEbQIsYuPgKL2KHH
         nXCJxmGj2PYyduIFg67o7M1b8J+e1v3aUQYhJ0MHWDCGyxy7mJ20Uhx6lHrUEgZzOR7N
         44WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=234lHPOkmRtRf38tY/dBUtuiJiCNT+A1HGusExETXW8=;
        b=tvph+4MzpimUYFsZoieekHwjZRTeJl9ffkWz4f+CVw1FGxGXoorQBXirMFiDr+0hpz
         WgRpZIjdZ7lyhs+Ix7K0wXz99LyzesaJEinjiVcLuZGRWF1aF0P1od++pHntfM1j8wYv
         xn2oWe0abs3YAFKSym7xgRc1i0zigl21oO21YeBqK8vXB5D0p11S2pXUMIotW/OjOMSc
         zwH0ddlqy3d1DJA54E4gBiKjky6/c6+GkjXVK9EZer1U4GDl7bCzA/vaQ61caoooGUFF
         MGXlxZp14I7smEGz0/gfdIUxKrQrhMxEKNuRp0R8X/iyPRAnRaZNQ+qs+EuPZ8E6L9Aw
         qYcA==
X-Gm-Message-State: AOAM533RHGEY4QAjtI1vVBpOlOODh9cvH3tMvXac/HB0/ghrVhuj/Fvd
        r8dS+8qqjE7AgKj+k0AHKA090s65oJQ0+paP2f8=
X-Google-Smtp-Source: ABdhPJxOq4dOIR8XqBJjvM4awnVR21mm14rvL4wSXqdtAGU3DDotuiXdbCGUT+4KfYnvHEJ+gOu8qA==
X-Received: by 2002:ac8:498d:: with SMTP id f13mr11909985qtq.35.1599570691197;
        Tue, 08 Sep 2020 06:11:31 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id m196sm13394069qke.87.2020.09.08.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:11:30 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] misc: fastrpc: define names for protection domain ids
Date:   Tue,  8 Sep 2020 09:10:10 -0400
Message-Id: <20200908131013.19630-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200908131013.19630-1-jonathan@marek.ca>
References: <20200908131013.19630-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define SENSORS_PD for the next patch, to void using magic values for these.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/misc/fastrpc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 7939c55daceb..07b381c042cd 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -73,6 +73,11 @@
 #define FASTRPC_RMID_INIT_CREATE_ATTR	7
 #define FASTRPC_RMID_INIT_CREATE_STATIC	8
 
+/* Protection Domain(PD) ids */
+#define AUDIO_PD	(0) /* also GUEST_OS PD? */
+#define USER_PD		(1)
+#define SENSORS_PD	(2)
+
 #define miscdev_to_cctx(d) container_of(d, struct fastrpc_channel_ctx, miscdev)
 
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
@@ -1037,7 +1042,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	inbuf.pageslen = 1;
 	inbuf.attrs = init.attrs;
 	inbuf.siglen = init.siglen;
-	fl->pd = 1;
+	fl->pd = USER_PD;
 
 	if (init.filelen && init.filefd) {
 		err = fastrpc_map_create(fl, init.filefd, init.filelen, &map);
@@ -1287,7 +1292,7 @@ static int fastrpc_init_attach(struct fastrpc_user *fl)
 	args[0].fd = -1;
 	args[0].reserved = 0;
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
-	fl->pd = 0;
+	fl->pd = AUDIO_PD;
 
 	return fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
 				       sc, &args[0]);
-- 
2.26.1

