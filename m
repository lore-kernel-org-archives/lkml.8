Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578D9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7B7206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="gQPTPw1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHRViM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 17:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHRViK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 17:38:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB5BC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:38:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r4so19549846wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2U86mn2kEau7t7AV/3TYAZlozd1Thks5A7onfWqZ6aA=;
        b=gQPTPw1kOMTq/0m65ziy6G1Cps9/UtYrm/rVmzZ/wUkZU4cBvpsixFB17WxZpKW4Xg
         HeyF9wmaQ1Ua+P7/c4z0gpZhsm8b21LX+/gqMgs0yX8DU/a7UwfK8xjUs6il+CGVkIAw
         LQJn5q0botLpXUK5qkqGEfGyhB+DLRnAGx3BHwQGVDDAnouRO1SheZF7P5gEQpaT+wZF
         5pNSReZ26+ZfgdS8o9nzYPa2mTRljxaqBFSxUuVc/uHGfMmTaO42qxC0AnMtykz7MoFz
         kHFcgWkMu7KjnsaUq0MU6m2zX03kIAMPWFU9nS5HszTAVrnfJ+bt6Ln7Bdj7PQ1Ppyvp
         ovrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2U86mn2kEau7t7AV/3TYAZlozd1Thks5A7onfWqZ6aA=;
        b=YbVtZmADz1p7qjBnABJssFFlrqfuGv3r7iVY7HNt3ew8GvnpN9s/+uIhTFPJ2p8GoF
         RQsUuc6F09o9d8c02TOKwpnNaGH0F5OqMoazEPgNRYDuV8TCFhGkUBf+xqBzFyZwn5K9
         N99Ene4LGuvWi2LmX11pl+8Nm+OUQqMZ1ddh5mIV2POeQA+aVBf1WceVKF93neJVFWFR
         595ZyyXXloPsbOyLRXIhhPj4ofBYzDBLyKefvHVCGFQ0rOfUxdmxvRrJZPu4B69SrMoU
         wsEZAQYML5ifHlVzoJR5JTu0C8JeRsUFMSVw119Fz5mNrHb7/PPE/bAD8imea1iJIQC9
         hWrA==
X-Gm-Message-State: AOAM532AuBUqtYpxGkkRwLTbqf967lC077SZYe1X72CM8qMz2WyIODFi
        /gZoueIhSLhBbNtDuzedq+BrwA==
X-Google-Smtp-Source: ABdhPJz5BjgpVZ8GKUjBMWJAl5KjmdW5nKSfbODZyfNl7vVKL8frQpBLGVl1sRdOgsTEuFOgKTVrZw==
X-Received: by 2002:adf:f248:: with SMTP id b8mr23195251wrp.247.1597786688706;
        Tue, 18 Aug 2020 14:38:08 -0700 (PDT)
Received: from localhost.localdomain ([88.116.83.106])
        by smtp.gmail.com with ESMTPSA id z207sm1797860wmc.2.2020.08.18.14.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 14:38:07 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v6 0/5] iio: temperature: mlx90632: Add extended calibration calculations
Date:   Tue, 18 Aug 2020 23:37:32 +0200
Message-Id: <20200818213737.140613-1-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add extended calibration calculations for the new subversion of DSP5.

V6 review comments from Andy Shevchenko <andy.shevchenko@gmail.com:
	 - Covert all while loops to regmap_read_poll_timeout or
	   read_poll_timeout even though udelay of more than 20ms is used
	   in the second. Problem was, that timeout needs to be 800ms,
	   while polling frequency could be 20ms, but we konw that that
	   will generate more noise on line than needed. Did some tests and
	   current number combination seems best. This also caused that
	   commit messages were adjusted.
V5 review comments from Andy Shevchenko <andy.shevchenko@gmail.com:
	 -  Swap order of patches to avoid re-doing the calculations
	 - Add fixed name defines for Ambient and Object RAM temperature
	   channels as per suggestion of the Jonathan Cameron <jic23@kernel.org>
V5:
	 - Add style changes patch along with current series.

V4 review comments from Andy Shevchenko <andy.shevchenko@gmail.com>:
	 - Move the function creation for Ta4 to first patch
	 - Add kernel doc patch for documenting internal struct
	 - Add patch to convert while loops to do-while loops for
	   polling

V3 review comments from Andy Shevchenko <andy.shevchenko@gmail.com>:
	 - Change commit message text to more proper English as per suggestions
	 - Drop unneeded brackets and parentheses
	 - Use defines from limits.h
	 - Remove userspace typedefs as leftovers from porting
	 - Testing of timeout loops with iopoll.h was no successful,
	   because delay between measurements is 10ms, but we need to
	   fill at least 3 channels, so final timeout should be 40ms
	   which is out of scope of usleep function
	 - Fixing some typos in comments

V2 review comments from Andy Shevchenko <andy.shevchenko@gmail.com>:
	 - Convert divison back to shifts to make it more readable

Crt Mori (5):
  iio:temperature:mlx90632: Reduce number of equal calulcations
  iio:temperature:mlx90632: Add kerneldoc to the internal struct
  iio:temperature:mlx90632: Convert polling while loop to regmap
  iio:temperature:mlx90632: Adding extended calibration option
  iio:temperature:mlx90632: Some stylefixing leftovers

 drivers/iio/temperature/mlx90632.c | 274 ++++++++++++++++++++++++++---
 1 file changed, 247 insertions(+), 27 deletions(-)

-- 
2.25.1

