Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2029C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B718824685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdMmd6p5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgBZLEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:04:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33235 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgBZLEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:04:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id m10so4298886wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 03:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qxSMSy0KeSHSnmfmzxCA8fCZhL5WkJv642hS2+p/iXs=;
        b=jdMmd6p57s9T9BTkdnRuKCzYlX8V/mp9wKLj+xSR4sQ85knTGnynU+J+MWkInqs2G3
         TuOxOkfik5PXGlBUnFPzJEE4FZQUtrvS1kQari9lhsZEx33vjY57Pv2TWD3gnunzn1uK
         2lGKdc9aIHSaZghpF//01eQMTusQNhrQfGFDfMiQzr9u/E5eGkm+twh6I6jhMXdSnmFQ
         UCY4tiRHf7WgClGpkoMbI9BS9fGDhLY7gU8P+9dTKlKg9FI8GPqR7SmJ+p2aq+FQtgcR
         XqIaCN80VtwFWXsvx59xJIHqf5SQe+Kk5FmWfgddnqMWpkOy5wwrDF054l771/6qjUkc
         XthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qxSMSy0KeSHSnmfmzxCA8fCZhL5WkJv642hS2+p/iXs=;
        b=IGIeREJyU2asFZ89RPT1ym8nFhmZZUIjAXucHbsO5/BJB2r3YPoq+f0AwrajqIZH8B
         DW2GEguwwis+85DQ1Gin/0SMGjcejnBwiGJNbJKDmWYvfC1t8fB1yrhCAcTJwf7NS/Ab
         FresPoXSCCK3Hfh2N+35+QZkFdCP+paiQb2pZVNeKX12XGUnDWsYwIs1a83iIx3aZhF3
         DBMC3iqFNhx0ECYLYJ90e6Nj9kJbG8uXl8F8+EkDzbK3iNZNfotEPsdomLkGcLzOrRyd
         OvA6qxm8+6awfdQV93N8Gv2h0IKUWfhm4X/XWHRQuUu2SRGR6QwZDHdg4f8a5IMIj/Fp
         3RJg==
X-Gm-Message-State: APjAAAVqLMBzlwZK4RA2HYB2Id5pPm5cUeNrGi1ZCYrxsZyuf1x3pc/R
        HbPVo/8pFMU2SQgeDPcHYK3P5A==
X-Google-Smtp-Source: APXvYqzo1GIu2NTEmeUo+9/xgeAhx5xgSq3jnjXari1yIps6iOhQfLG8Hjj/EVYP231cndzzGUg9rQ==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr5070418wmb.126.1582715061914;
        Wed, 26 Feb 2020 03:04:21 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h205sm2448176wmf.25.2020.02.26.03.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2020 03:04:21 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 0/1] interconnect fix for 5.6
Date:   Wed, 26 Feb 2020 13:04:19 +0200
Message-Id: <20200226110420.5357-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
This is a fix for the current release. Please apply it to char-misc-linus
when you get a chance.

Thanks,
Georgi

Georgi Djakov (1):
  interconnect: Handle memory allocation errors

 drivers/interconnect/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

