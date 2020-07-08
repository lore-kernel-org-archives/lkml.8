Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D232C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD1C20772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UVVJVhkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgGHMDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgGHMC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:02:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F9BC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:02:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so48661222wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sy/K8f8HsXXHV/Uh8PtUz+jEUwEZnfQCudyYCgnVPrY=;
        b=UVVJVhkkvXU5mQaYO7/e6LDc6Bn+WyCrxwonvgA5bXcIDKlvL9UZyftgtkF/mFygO9
         Y92+vMSrt60fiM8wodrySHgosdmXqwjvaG1WzE9xIhuct+M/8L+96nZZbbCOnULeiPeN
         ZTVXO+EZChxwre/ooWZwMBRtGz/N4IHmc4b4dzDo4XBqs5IZVDEKI/RWuz/xu4Y/nxll
         oEOYdjvrgnEqGvYKb2wvkiCLmtuI4POA5MgvjqNTPNlGUFedPELjVCNPRZUakEPFg46j
         idt6O3eIE1ZjoTHSb6RgXUs5GAOkd/qW1jc7JHesY4MaWWwu08UKU8pn5Lj+Y/aThEDi
         CgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sy/K8f8HsXXHV/Uh8PtUz+jEUwEZnfQCudyYCgnVPrY=;
        b=T3GO9qBcN/IIYo0gCBgqTHxr/O28AIvmULiUE6DwBJTfVkyeIkKCHVF9hEijirma8/
         44TfoGO0IWRDJV7kA/HX8mWsl8DtJUB2BaAxRWhcHpwLmII2NoqdY1jv50Ta5rRU9ILz
         4ArwznqntPWWWTqOG/WzpRyuvOperokY7Fvdh9NQ2Lx8/SF+l/RY5Shx5XW/ApPiMjgS
         eyt5xAon8QkfaBUIxNTOQ7aGRk67n0b31Y7wFktxTLmAvz6U4RmB1VVd6SpvtVC49FDy
         TYVg8fmNZNbIrZUftRTFXTnPmj7+H45P6tqp5O2s+0wk7pgQ8S0lOlHa5WJQ7bfDcbxU
         DELA==
X-Gm-Message-State: AOAM531RYW6722sksWOWKXGGyyLSGvuhuiziEAGdR6Wlsa75iPnmony/
        3nNjDptc9HdazMbHZ+EElKGEf/Pm6wY=
X-Google-Smtp-Source: ABdhPJwhGEqPkcJyX2dv/WqMG7iM0VhAhQCXAAfNOLSl+0U4picjbr+HsPGcLq6WylxaF+kkxtJ1Ow==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr61722445wrp.77.1594209774488;
        Wed, 08 Jul 2020 05:02:54 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m62sm3964997wmm.42.2020.07.08.05.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:02:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.com>,
        "Daniel M. Eischen" <deischen@iworks.InterWorks.org>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 20/30] scsi: aic7xxx: aic7xxx_osm: Remove unused variable 'ahc'
Date:   Wed,  8 Jul 2020 13:02:11 +0100
Message-Id: <20200708120221.3386672-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708120221.3386672-1-lee.jones@linaro.org>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks as though 'ahc' hasn't been used since 2005.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aic7xxx/aic7xxx_osm.c: In function ‘ahc_linux_slave_configure’:
 drivers/scsi/aic7xxx/aic7xxx_osm.c:674:20: warning: variable ‘ahc’ set but not used [-Wunused-but-set-variable]
 674 | struct ahc_softc *ahc;
 | ^~~

Cc: Hannes Reinecke <hare@suse.com>
Cc: "Daniel M. Eischen" <deischen@iworks.InterWorks.org>
Cc: Doug Ledford <dledford@redhat.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aic7xxx/aic7xxx_osm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index 32bfe20d79cc1..cc4c7b1781466 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -666,10 +666,6 @@ ahc_linux_slave_alloc(struct scsi_device *sdev)
 static int
 ahc_linux_slave_configure(struct scsi_device *sdev)
 {
-	struct	ahc_softc *ahc;
-
-	ahc = *((struct ahc_softc **)sdev->host->hostdata);
-
 	if (bootverbose)
 		sdev_printk(KERN_INFO, sdev, "Slave Configure\n");
 
-- 
2.25.1

