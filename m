Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AFDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C399F20786
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=students-iitmandi-ac-in.20150623.gappssmtp.com header.i=@students-iitmandi-ac-in.20150623.gappssmtp.com header.b="mESkiXFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgG2HeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgG2HeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:34:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D286C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:34:06 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s26so12496304pfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iitmandi-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S46xE3v5DrbbnFv9e5puvYo4jscSSSdvbX89O6S8DDQ=;
        b=mESkiXFMivLhqN+hGYqTZVr3mN/jt1bqIxIHckD0DfO/9C3R9bmGRkrhHMyVhOQcoy
         GdkeVscfEWP1leXKC1bGouS5MufyBHXD5G5lsuoKmX3lXpZqtPrmTctMcCcKQFsY/sSG
         sijp+8fAUc11tD7KTGeRK3cdLk2PIFzkpAE04fe1OdyKz0q7s8EbN05DXiKW7xSWlvX/
         XHSxZtXofboZkPxVM2HGgyONOsMxH3TPe1/nxjEnpXp/zn5tSrb5ofRvpbIleIsRkckt
         SnpxHOdzLaI501flwHQyzGsdvrZVd/bS7XRo3Rfmjn0TC4DH3482nNrC0bAHIupJeaXT
         BGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S46xE3v5DrbbnFv9e5puvYo4jscSSSdvbX89O6S8DDQ=;
        b=MBkgYzXiG0zxHMXXkitZ+yfMVMZKFo84x3GMzf3yULWNdgL88Op7fUoIIXT1ZcHU0j
         ud1EBq9pwTAiA+bjYohHu4GqdEMu7LUE0ElR4X10pUYHt1eqtNrOYZeYlawJfFHnbbba
         YqTBAeP/ynt26dcV8cjkAV+fhDnjJqXIGda641iQUI51dFrrK39joe3jFQ9Hq0K06Ydh
         WsrmD9uHg5n0kEmnB+F7s21nypdNX9I8Z35Pwebbsua0KBCnaFsyRy5Re/7eWqvwM1vm
         AX9XRu4wPnzzk+PBSD12WXRMFQFA4YhuxCWmziDggUjAAqhbWN9WAPMpoBUbUzh5XDvl
         bctQ==
X-Gm-Message-State: AOAM533C+MTwnPubLnmVhwJ6y3U/xlntNhLXZIgkKChdVOAj3hh3oaWH
        QJH3pRPrwu8UmC4BiG0/mno0ag==
X-Google-Smtp-Source: ABdhPJwEFJVQwnTn+RUWmMfKUkxfJ2XNy5pVytSLsFeiPOx7vgLfLVmhBW1T+huugVjy9C5qeKhquA==
X-Received: by 2002:a63:6fcd:: with SMTP id k196mr29332268pgc.251.1596008045763;
        Wed, 29 Jul 2020 00:34:05 -0700 (PDT)
Received: from devil-VirtualBox.www.tendawifi.com ([103.198.174.215])
        by smtp.gmail.com with ESMTPSA id bv17sm1210956pjb.0.2020.07.29.00.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 00:34:04 -0700 (PDT)
From:   Ankit Baluni <b18007@students.iitmandi.ac.in>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Ankit Baluni <b18007@students.iitmandi.ac.in>
Subject: [PATCH] Staging: iio: Fixed a punctuation and a spelling mistake.
Date:   Wed, 29 Jul 2020 13:03:52 +0530
Message-Id: <20200729073352.1586-1-b18007@students.iitmandi.ac.in>
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

