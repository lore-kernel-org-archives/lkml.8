Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29979C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC302070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=students-iitmandi-ac-in.20150623.gappssmtp.com header.i=@students-iitmandi-ac-in.20150623.gappssmtp.com header.b="PiK/1LIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgG2IMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2IMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:12:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D062EC0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:12:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j20so12548346pfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iitmandi-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S46xE3v5DrbbnFv9e5puvYo4jscSSSdvbX89O6S8DDQ=;
        b=PiK/1LIl8E/ZxiNOPlZOco9DGDkPa8InSq+tT3BBXy/JusYHitRQcDlma6dXh8ftfj
         AuJf5HzZMpsifHvouWzlUvFmSf9eV0+u32GHTv5nNoI3LT2PWK7u4L7XcnOjc5q55oMx
         VmKjk5ZpzVaIBk8VuoVF15/rlJFfgsjJCvFPh/HVrogN9lJ+7NOekYius/EzvM4b2nwi
         I9r/advsb8QODpGxlZJZNCw1ZfhwAU2z3vwVodmAdzL9UhBOmF0ebnmURz41vhYBzO+5
         mNTDS8uGUV4V6um2lOoPViqL93dqxUdQSn7SFCNivJ85WrEFy+J1kmDNg9AMMyXXOltL
         Lccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S46xE3v5DrbbnFv9e5puvYo4jscSSSdvbX89O6S8DDQ=;
        b=JKOS2gDx/Z8II+JSwW0sxT73E5edlF6n8HDRBhry1Z5qz4vSPNG+yjvh0MokJEttNe
         MsybAus5dfZQJgSSFJcTC78QewMq4ls7CKw8rY06M0+Kta/dFCarlvLk8+nQpbVosZfb
         yaEwUH0005CYX6nKBm+dojJXCY26A1eu8U5wUqWJaGSjjHuuCGQDuKJxwNbn13p+Uml+
         zpsBtECZbxOHDgFVZtZydyzV5VOmMxD+GKUoWSaNQq7B6i1QhdPHz4qgVXbnDQGFopqQ
         QLv03DWfRe6sBn2natuR22KCgFGajgfQBiUbPP5bvHFQztmTYTc+EHqa+7OgTS8rY7bu
         MCFA==
X-Gm-Message-State: AOAM531mm/6/Zl4hDCu+15z0a8QwduJN8+0utib7BGQ548EQG5RBRAer
        UKRhXEQniuN400vCTa3iZcT/QA==
X-Google-Smtp-Source: ABdhPJyDQEJ/JkWYuadFiwHxJB1gNPr4kQTXQ5jj2him+TlG+sTNSnHWHZofs9Eb9EhwLTAzDULJow==
X-Received: by 2002:a62:5284:: with SMTP id g126mr2422012pfb.139.1596010338199;
        Wed, 29 Jul 2020 01:12:18 -0700 (PDT)
Received: from devil-VirtualBox.www.tendawifi.com ([103.198.174.215])
        by smtp.gmail.com with ESMTPSA id s6sm1377206pfd.20.2020.07.29.01.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 01:12:17 -0700 (PDT)
From:   Ankit Baluni <b18007@students.iitmandi.ac.in>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Ankit Baluni <b18007@students.iitmandi.ac.in>
Subject: [PATCH -v2] Staging: iio: Fixed a punctuation and a spelling mistake.
Date:   Wed, 29 Jul 2020 13:41:55 +0530
Message-Id: <20200729081155.3228-1-b18007@students.iitmandi.ac.in>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHp75VcmMf5dt7mu9N0C=6Rej-WzZ0EpzntHYCQkgNLVZkPbgg@mail.gmail.com>
References: <CAHp75VcmMf5dt7mu9N0C=6Rej-WzZ0EpzntHYCQkgNLVZkPbgg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a missing comma and changed 'it it useful' to 'it is useful'.

Signed-off-by: Ankit Baluni <b18007@students.iitmandi.ac.in>
---
Changes in -v2:
	-Remove space before ':' in subject line.

 drivers/staging/iio/Documentation/overview.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/Documentation/overview.txt b/drivers/staging/iio/Documentation/overview.txt
index ebdc64f451d7..00409d5dab4e 100644
--- a/drivers/staging/iio/Documentation/overview.txt
+++ b/drivers/staging/iio/Documentation/overview.txt
@@ -9,7 +9,7 @@ The aim is to fill the gap between the somewhat similar hwmon and
 input subsystems.  Hwmon is very much directed at low sample rate
 sensors used in applications such as fan speed control and temperature
 measurement.  Input is, as its name suggests focused on input
-devices. In some cases there is considerable overlap between these and
+devices. In some cases, there is considerable overlap between these and
 IIO.
 
 A typical device falling into this category would be connected via SPI
@@ -38,7 +38,7 @@ series and Analog Devices ADXL345 accelerometers.  Each buffer supports
 polling to establish when data is available.
 
 * Trigger and software buffer support. In many data analysis
-applications it it useful to be able to capture data based on some
+applications it is useful to be able to capture data based on some
 external signal (trigger).  These triggers might be a data ready
 signal, a gpio line connected to some external system or an on
 processor periodic interrupt.  A single trigger may initialize data
-- 
2.25.1

