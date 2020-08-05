Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA47C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797692250E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SISlafSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgHEX1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgHEX1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 19:27:04 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F60C061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 16:27:03 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 140so25154430lfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 16:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkNZOfpFr9WFrUPLACefS2Hn8u2WI1aY1JXzo3CgXzs=;
        b=SISlafSQhU73duEj6bfuucZfrBC7rL4N/S2ZgFTUMe9BRTfiPiCc9eTOQnfFkNYTNx
         WsAIwDYwfBCCaM4GtVeQsKMGW3SGgDlXGhOQk0DVy4AHmTLZNTLWlXbzeQjcsEIgTRiV
         Kiwrfj2JIbQRqfW+wh1sW08kmTTI5DmboA2tST74bItPiACQVjc1eqAb3cE+FGzUu0MU
         16qZ61W6EFd1fbxYkLOcCEtKHv2rwJf4V3kL5Ze8a2TEVEZDrPgbHNDVoS8XNr/fE9ad
         gNkO56TjmF4Jr1KFwdV/DBJ7G3BdrK6AuYGudguL2ur01rNzwIEC7KPVzTBqjn4q2s7e
         wPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkNZOfpFr9WFrUPLACefS2Hn8u2WI1aY1JXzo3CgXzs=;
        b=eGoKCNxhcLDJ+SXKMRwfqwHNRNnafMq2tXYJAPpR2bpkeaok6IWOtibwieLbmG9a2q
         WZA63KlBCDuFsLin8Tx6Fccf/9/QPnoKz8kJF8fdPJlvSsoQ5yJ1wC07Atsd7yM+Oshn
         rlrv2svBXbZsEAqdeKbvL0GfNNVQksEwJpXao+0fsM8TRxYbdio67+vfIZi1JgCKGLCN
         8mazbInwoVSW4MpVZ+l9j07CJhHlyTgBtjeSvIWQedrMPLeL5xNk+BHfQtdWuW3MMOXe
         jUMOUezKelxinVFHW5DJD75ch+DqCxRZFuHvgGaSZ6FHAPAORoRVxufYVguzbTIWNnxa
         Ps6A==
X-Gm-Message-State: AOAM532merDn+5N6WoWTFJ7YbzkVSjnMBf5VAgVvvbckBJKircS8I7BG
        rt9OnSTAl2D+WQL8OcqribU=
X-Google-Smtp-Source: ABdhPJxDDgXwjD7b3b2mHri+5bjLWhL15NDiAmS7kUCr7xPGPIz+qzUHqBhza1Sv0dO9XMmFhWxjPQ==
X-Received: by 2002:a19:7ec3:: with SMTP id z186mr2568235lfc.3.1596670019378;
        Wed, 05 Aug 2020 16:26:59 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r16sm1485603ljd.71.2020.08.05.16.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 16:26:58 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, eajames@linux.ibm.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/3] fsi: Constify fsi_device_ids
Date:   Thu,  6 Aug 2020 01:26:21 +0200
Message-Id: <20200805232624.6938-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsi_device_id is never modified (and it's a const pointer in the
fsi_driver struct), so make the static variables const to allow the
compiler to put them in read-only memory.

Rikard Falkeborn (3):
  fsi: master: Constify hub_master_ids
  fsi: sbefifo: Constify sbefifo_ids
  fsi: scom: Constify scom_ids

 drivers/fsi/fsi-master-hub.c | 2 +-
 drivers/fsi/fsi-sbefifo.c    | 2 +-
 drivers/fsi/fsi-scom.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.28.0

