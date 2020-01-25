Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D39C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 13:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E662070A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 13:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1cn2rtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgAYNqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 08:46:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35416 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAYNqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 08:46:11 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so1989280plt.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 05:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UseYwksRXy1FRsziRCEfauNXVKV66lcX0Z60Z80rcEQ=;
        b=U1cn2rtp5HaScqVpNnTPdupOhU3dc+A9D7CN+NmF6XB8+GBgYJsge3eioJoX/RISZc
         xXB+X534IILv5FfWeHnWwRC/HHNAPj4st1YgmNTsQ1K/hoy8nR6aETWo4ZUoVq6Yp0wa
         KZQdfsUXLlX18LTNZ692B4WvFiui/fWHzyhWr1tZcDMVv2fKLcfZCrV55awuLNHXCO8N
         NXzuH+oh30506BcVN5eB6jYdniiKrdBd3evxjWtJ6rPR8+z4r5jQderBYln9XYG9VdM4
         ek2qCp9EdIzUZ2DvtjN7lYP718oBqQc3zAGCa2lQTA29UThLlhm/Z2+o1e5BZnbbZ5Fk
         1ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UseYwksRXy1FRsziRCEfauNXVKV66lcX0Z60Z80rcEQ=;
        b=FhR0Ugk5dg5E+hWWv0wBKMOpH9w2Ob/1RrJRc6G5kplLmm34JBiM5mmDbHqeU9MJX6
         nCh7mGn3Q4sgAbsOCQ+qfmTnqjDLmuBbnxosb3mFXAbIlBEnO3ZlSXjJ1FtmYZJx3YFi
         FSuz9jP7bBTRtZuhQEw9VtssIkaFqmTqf0PSUCvOP2H8pUHTsyHgu0xuQRfdC+RwxlqC
         TAWX3/dD+jDOodzuDkdG+eADRmiCCHtssK64rqFXcM1v5X/kou8Fsay/5LWizxm0RdRm
         yqfKPH+r+IIXbSnqIdLMe1AZf9ieAA33P/8ZhUV5mkCADHuPLRsFVx9UZrYlGO9GvyUD
         8tWw==
X-Gm-Message-State: APjAAAUsWV/NEWF1gdsqrwul13pMWDtTk9u5G8er59yRUHhRue8h3tUs
        3Cp7/ykP9swMf4qmIEJVS+k=
X-Google-Smtp-Source: APXvYqxwVbnj0o+6EqXP1Yh0WUy1DHDxWyfbZhcRXljqz2AsHvyWSumnbARkfiuNvF5d4vXp/trYNg==
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr4764866pjt.69.1579959970417;
        Sat, 25 Jan 2020 05:46:10 -0800 (PST)
Received: from google.com ([123.201.163.7])
        by smtp.gmail.com with ESMTPSA id t187sm9959497pfd.21.2020.01.25.05.46.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 25 Jan 2020 05:46:10 -0800 (PST)
Date:   Sat, 25 Jan 2020 19:16:04 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, saurav.girepunje@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: hal: fix condition with no effect
Message-ID: <20200125134604.GA4247@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.6.2-neo (NetBSD/sparc64)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix warning reorted by coccicheck
WARNING: possible condition with no effect (if == else)

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
  drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c | 8 --------
  1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
index 02da0a8..8dfa9b9 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
@@ -1610,8 +1610,6 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
  						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(13);
  					else if (maxInterval == 2)
  						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(14);
-					else if (maxInterval == 3)
-						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
  					else
  						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
  				} else {
@@ -1619,8 +1617,6 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
  						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(9);
  					else if (maxInterval == 2)
  						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(10);
-					else if (maxInterval == 3)
-						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
  					else
  						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
  				}
@@ -1630,8 +1626,6 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
  						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(5);
  					else if (maxInterval == 2)
  						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(6);
-					else if (maxInterval == 3)
-						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
  					else
  						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
  				} else {
@@ -1639,8 +1633,6 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
  						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(1);
  					else if (maxInterval == 2)
  						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(2);
-					else if (maxInterval == 3)
-						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
  					else
  						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
  				}
-- 
1.9.1

