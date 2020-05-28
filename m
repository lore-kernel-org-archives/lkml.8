Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0981C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DC22088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEmL/qEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgE1I5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgE1I5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:57:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3056EC05BD1E;
        Thu, 28 May 2020 01:57:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z64so8733082pfb.1;
        Thu, 28 May 2020 01:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/K44NmJwHDbcFH7pvNpnKvedEgUw2/S/KvNbnvol89M=;
        b=UEmL/qEwh/utJX+gTL52cQFQ9WB8HRll599QVDw+oULxQYN1S02+mQmP1graq5Mljx
         Qusqm42W1w6cKGDuTGssvMOtc1y8HDaqo7WOC4XDDe1ehmZNhUraN2Dh8QOtKHOae4qA
         5vZELWJAM9YX74RnaDT4dW5igfCCofezisVqKyuNYugcScjfqD276V8E92fugPN4yqrm
         WNWHoj3i174mDyIA7pKXaad0iJhP8ny4Of6b1e0kkHI1EOOrd/O772RdaqmEMp2UK7Uz
         wqBC1rp9Ub5NuBLLq3ji6eISCyAByX6OF7Gl9FLoHJXlv2kSy+38sOw25W19EmLaXDtm
         Af6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=/K44NmJwHDbcFH7pvNpnKvedEgUw2/S/KvNbnvol89M=;
        b=EIxvGGfqlavaqDB3XBUFrGngv9sEjdgJYYdWglpRlEl/yBZflLgoqvLAlZneI70F93
         bhwBeY05n31T2x2gpmzvgCHTVTWVq3zxTNy3bXnMSIgn9HFY+5UmNU23wbV5rRO/vmV3
         0QVIPPH+yrwdBY70wvvNSiwEgZZfl7noLE3QIKdjIPId5ltTncXObAZfQ3h9ofizvLW2
         QDgs9Br4RJh5y+mVE5gG1LIEn+PQcMZ8i0B85VgNFuzAQLusI4jKZeQEnJNPFBYY/7DI
         a9ZRnsMHPeIJoxe3Z14UI3JOnwFosJdcWF9baPYO4uF8DWYUSFuKJGSKndEMdwWCEWKG
         DC3g==
X-Gm-Message-State: AOAM531igCoTu0WgkVDO8jjQB+PETlv/SY5+CoPzO/7snaFSB08ou6le
        3oeaKZF2mEheb3PuX1djdBraDhEf
X-Google-Smtp-Source: ABdhPJyefE2zcIE4dLfdJCvsHgvgIrDWiWMvZH5nkgA0Dw5LbTXpoJZU9OWa9qon/F+x3Ac0Sa+atQ==
X-Received: by 2002:a63:30c2:: with SMTP id w185mr1850624pgw.353.1590656220141;
        Thu, 28 May 2020 01:57:00 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id b4sm4066413pfo.140.2020.05.28.01.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 01:56:59 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     devicetree-compiler@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 0/2] dtc: Improve checks for i2c reg properties
Date:   Thu, 28 May 2020 18:26:48 +0930
Message-Id: <20200528085650.1417942-1-joel@jms.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to fix a build warning in the Linux kernel caused by dtc
incorrectly warning about I2C_OWN_SLAVE_ADDRESS.

v3 fixes the 10 bit size check
v2 contains a second patch to check for 10 bit vs 7 bit addresses.

Joel Stanley (2):
  checks: Remove warning for I2C_OWN_SLAVE_ADDRESS
  checks: Improve i2c reg property checking

 checks.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.26.2

