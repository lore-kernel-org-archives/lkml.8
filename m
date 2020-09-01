Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4636C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF31321527
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlO5fZKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgIAWRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIAWR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:17:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D65CC061246;
        Tue,  1 Sep 2020 15:17:24 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so1270791plr.0;
        Tue, 01 Sep 2020 15:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8oVSt+XXgts9V9hBX8ORH+AS6m2J43vGA4wo7bjMGSw=;
        b=qlO5fZKXWIaweztfSZt5lscCfMeb95G8MhWsQ/lSaJ+FDb1SNokcNpp+7z3DLE4rF3
         2dysm9rS4OSd3k64RrCb2iDLfTihhQIBsWHIM4pO3zun/ZZiHw5M0ZYz7xotRRp0Vl6H
         gVuKb6zzb+/D4Aziqs+kgokfp0Tdgx+wAi7EGpiAZ/wFNGynAtvTJuP+UbdooYJgbhjP
         o7AepCWbCypJyziUVIcTQr08TEiIxGgWthqCZQfDFV+gKNvojJajEcK9KwneuTuD6th6
         msoaUb3F3Quj/oIp2iNYcujpjaBrVxAyuvNikmWWuoEg7qjTdOjx5lIdZ2jVaiaUQPfR
         XRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8oVSt+XXgts9V9hBX8ORH+AS6m2J43vGA4wo7bjMGSw=;
        b=ALIO8OW2BRqHXGaYnyIl/Br/NpqTSmuVlnURkFmOfol4rrjvPy28qBySBvtCU0Xw4a
         nOp5ziw1gVD11xhNMXKyuoOONB3ah0FmHOQsc1o22xchaM1466JGjb+nvHuKUE7H5FIN
         GAmoJFJ64QoXygxNEeYAKf+i3iqwnGz8Qk1oq0p91tBicYNKOkIN0299/JcNMUUcaAPw
         Y8ZJ8Ka6Gz5CqJiWBeqW/TChjoOLE4Ke3CsvU18jwutVYAL2nkEzx+vPXEVIHMk4U/Qd
         4bBlNGHSSut061V9KmU4mtKvvsi29x2A5dyxTpRXCmRYTNyCFwZmktWdjekqfNc8Ox+r
         5qyw==
X-Gm-Message-State: AOAM530wSMOLbikDFwlzmeAvrJKnn23hzuTcFSeCnOj03FMhTRU3JHSB
        SZsVqRujl3KuXy48mV21kMs=
X-Google-Smtp-Source: ABdhPJzdJq9eyRVuKNEYyNWukVThnPxVvwkVZFW01G6oPEDkIuTUBku5fZJKBabSN7o4EGbI7+mmXA==
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr3270568plt.71.1598998644148;
        Tue, 01 Sep 2020 15:17:24 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id w203sm3201356pfc.97.2020.09.01.15.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 15:17:23 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de
Cc:     sfr@canb.auug.org.au, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, tony.luck@intel.com,
        fenghua.yu@intel.com, linux-ia64@vger.kernel.org,
        schnelle@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org
Subject: [PATCH 2/2] dma-mapping: set default segment_boundary_mask to ULONG_MAX
Date:   Tue,  1 Sep 2020 15:16:46 -0700
Message-Id: <20200901221646.26491-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901221646.26491-1-nicoleotsuka@gmail.com>
References: <20200901221646.26491-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default segment_boundary_mask was set to DMA_BIT_MAKS(32)
a decade ago by referencing SCSI/block subsystem, as a 32-bit
mask was good enough for most of the devices.

Now more and more drivers set dma_masks above DMA_BIT_MAKS(32)
while only a handful of them call dma_set_seg_boundary(). This
means that most drivers have a 4GB segmention boundary because
DMA API returns a 32-bit default value, though they might not
really have such a limit.

The default segment_boundary_mask should mean "no limit" since
the device doesn't explicitly set the mask. But a 32-bit mask
certainly limits those devices capable of 32+ bits addressing.

So this patch sets default segment_boundary_mask to ULONG_MAX.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index faab0a8210b9..df0bff2ea750 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -629,7 +629,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
 {
 	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
 		return dev->dma_parms->segment_boundary_mask;
-	return DMA_BIT_MASK(32);
+	return ULONG_MAX;
 }
 
 /**
-- 
2.17.1

