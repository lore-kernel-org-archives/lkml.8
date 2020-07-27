Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED76C4345D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1352075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek7ZqXpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgG0JHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgG0JHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:07:01 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F418C061794;
        Mon, 27 Jul 2020 02:07:01 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h13so11821401otr.0;
        Mon, 27 Jul 2020 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cnnk+R6s02N/1ZtsK3L3h80BkK4YyB9AiPTtAGsZx7Q=;
        b=ek7ZqXpnRZsKYEckxz8ADcWr6162gmxv+Wfg/VPifAgvMFGtdVjReQiHzHPLwdLcOq
         icV8Si8AMi9ik/+QgKU0oh6BDXJVHcsx2ht1PgdjsLN4v6mLEzEc6JGXfubohK4LYTKK
         DuVhqkMDbxMmNgG1M4lCCZPyS+3RR1S0CjwQgC6gkvoXsGwe5FfzEyXdhz+8YReNNPKU
         kCpxAG9Hz8eFnjsAgoImjblNx4TAjoLj2ld8OvfJa3MyY47+40tDRg2DFOZJy3SMq1+z
         HIKGGVFARyDN+Siq6aneD82dF6fbTuwzE7AS9jq49wp0WBcgHu4VaesqiZFOp5Ij1Sng
         0qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cnnk+R6s02N/1ZtsK3L3h80BkK4YyB9AiPTtAGsZx7Q=;
        b=Ilt1IXaC4S5n0qOYzfTjmRo9wcxbw08v3V7rrruMMAS/5A+mGHIB/r066Jo6+k+5GX
         /UR3ymLXCJqipSIUf9cgYnfxuBYBii5Yvz2r6GoNTjqnqUYj+tg5UesRbOfGfwYyKsH1
         bU2wOcNUCKdUUDh2iCw+A6CBevQwmrk9MEDSxapFI8mlG43o0x15K6fvwg/Xz95MPuB+
         ALr1SsTW0+bY5s2KmXJ5+MD3OyV/yP+6QG8OMTPqbdLxbYh0GCGHIR/LEjRUTu57681C
         V4hwWrEeKAPL7TdceA/G2n0UKub60WzYfkwgbGylJMH28NML1pFRxVcZ3ByaW6CcSEwP
         Vv3g==
X-Gm-Message-State: AOAM533XS4+f8JuRf/FZAln3GXL2NV2pvz19aB+Kkn0sgKhTO/a/t+xh
        NE5NxiA7ATR6Sn7g2i5KupmMyeNP
X-Google-Smtp-Source: ABdhPJyGgv3a23b5lsT5QrMXtNqJyXacnhWEZoQLb96Xh14GfhLOO6vVPujqIpXAmOR27rJ9QKngEQ==
X-Received: by 2002:a9d:63cd:: with SMTP id e13mr20224848otl.170.1595840820489;
        Mon, 27 Jul 2020 02:07:00 -0700 (PDT)
Received: from localhost.localdomain ([170.130.31.90])
        by smtp.gmail.com with ESMTPSA id q189sm1471297oic.15.2020.07.27.02.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 02:06:59 -0700 (PDT)
From:   Forest Crossman <cyrozap@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Forest Crossman <cyrozap@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Small fixes for ASMedia host controllers
Date:   Mon, 27 Jul 2020 04:06:27 -0500
Message-Id: <20200727090629.169701-1-cyrozap@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch just defines some host controller device IDs to make the
code a bit easier to read (since the controller part number is not
always the same as the DID) and to prepare for the next patch.

The second patch defines a new device ID for the ASM1142 and enables the
XHCI_NO_64BIT_SUPPORT quirk for that device, since it has the same
problem with truncating the higher bits as the ASM2142/ASM3142.


Forest Crossman (2):
  usb: xhci: define IDs for various ASMedia host controllers
  usb: xhci: Fix ASMedia ASM1142 DMA addressing

 drivers/usb/host/xhci-pci.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.20.1

