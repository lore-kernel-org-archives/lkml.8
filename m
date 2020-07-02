Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C62C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3AF920748
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3CY2JNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgGBPo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgGBPo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:44:26 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F6FC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 08:44:26 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k71so9106538pje.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nRwAvhsTBMrG6ide5sNk42yeU3QRoAwYZKlWEvw6/Uc=;
        b=B3CY2JNtpz+UCWJsdts0OCVy5b5koIZyP3M4Ky+ncAnrvMf/hu7/PZXwOPzDnhY1YX
         T+lyMoU5612SnV4bW1u7R1crSQzZ/fAe/XJVmW982pVs1Y2O84dF9Q1hzBoHM8Vd0zVM
         SMTTDr1CuF6GFdUN9FqUuLF0ma65ySwyIqDUIlIiaTpaZHaWpByaZqJCgvM3Tn9jnySD
         5mAYc12Trj1qGTnGmhooIpcmyG8NljV2DD6t3cTXeayRzhl+A79394g396uIpimVzkmv
         XxakU3TJWFZrBPR6aQtLdQed3W4G8DQ1DoDxJz1PMQdKZpAcpI7SYPnfZKt0fEfp41ps
         2g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nRwAvhsTBMrG6ide5sNk42yeU3QRoAwYZKlWEvw6/Uc=;
        b=XZMD6SW4mkm3mchmdkjSmGAXTfgIy7fwQ4YjraItjAK6IgONhFjU66zB1dkIHkRCWT
         WEf/huzs4hzWmKXL/B9zV6ZNKwrlCkNXgNfJtq9L5iQijw1SyyAzAHL1rZvG86JEd51n
         2XExdLcs2taWWAp2e/w4RHTSyWT1mlkqP2TPw/IhJBFKOAJLtk0TR8+wiis1d1hh1cnM
         XcQledLUFAo0hPLiJbe8LAsXYufMFvPEK0QJ/XdtYJOwjd2//oF/5twqt6wz13yi6/Qj
         BGNiHqstpORq1nBD15CNQVa3UEh8SJEY1x3QmoISv/0qqhQRvU1a6cIQHaRt3E9/TLGI
         2vMg==
X-Gm-Message-State: AOAM532Az+y2CCGhS2xBh1aw83coTEiOB+pZ+p9oVc6hrimbr2/58TUa
        rqptXoxnlTaOsc8DjJpDtYHL5fU5
X-Google-Smtp-Source: ABdhPJxIL/dOnPZ1QkhHV5VTj4SqRISUUHvYBn/Op7GrAkGXxdWRrOenaGaA4ZdyU8eismahoMf0dQ==
X-Received: by 2002:a17:90a:ff91:: with SMTP id hf17mr33498239pjb.137.1593704665733;
        Thu, 02 Jul 2020 08:44:25 -0700 (PDT)
Received: from localhost.localdomain (n11923716050.netvigator.com. [119.237.16.50])
        by smtp.gmail.com with ESMTPSA id f15sm7166804pgr.36.2020.07.02.08.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 08:44:25 -0700 (PDT)
From:   Simon Fong <simon.fodin@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     Simon Fong <simon.fodin@gmail.com>, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Patchset of coding style fixes
Date:   Thu,  2 Jul 2020 23:44:18 +0800
Message-Id: <cover.1593703689.git.simon.fodin@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixed CHECK and WARNINGs of coding style.

Simon Fong (2):
  staging: rtl8188eu: Fix CHECK of coding style
  staging: rtl8188eu: Fix WARNINGs of Block comments

 drivers/staging/rtl8188eu/core/rtw_recv.c |  7 ++-
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 62 +++++++++++------------
 2 files changed, 34 insertions(+), 35 deletions(-)

-- 
2.17.1

