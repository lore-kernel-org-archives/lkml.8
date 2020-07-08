Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE11C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E6120656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RXcG+j8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgGHM5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgGHM5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:57:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26040C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:57:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so2991097wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HCXouCpBwn5aKxXLmZziTNcn40q7bwGlY51qWre9tKM=;
        b=RXcG+j8di8o2WKg7eCuTShT6gSdOMe7krcZVZi1XaLDXZSUZAFX/m2SL/vrazw9Gvt
         z/Pomw2dg3foNoEj0m5ie4vGNstg77Bjq+MMBrHHMIU3l32qZgir+6troEJHStWUt4WH
         xzI3o6Y9JafzwuC6F2HRd4NzB8IkOMtcEMVmoTHyy/DDfH/V0d3rZWEw9gTIrXBP3LGd
         V15XhNUmotKGRVNckI6WolC/xvzRPlNGRX3O9vBa253NoWa/MVz7JouVpms1qhsS/N7o
         Cwl8lELbB75EiVYSWpje+nkmRPUghnu+ko6YsgPR4yrikRNdHWRqtj9DALtMf8WKbH7i
         RyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HCXouCpBwn5aKxXLmZziTNcn40q7bwGlY51qWre9tKM=;
        b=JKc1RDDsANLVeAcRfspwAtxbWjomVj17A7g4NjdqRvVI2NduTn2KxoAA238CjdTs26
         Smju8U72yFYFnZ7m2F6JG7SQCx12VDRKlL0jMEE91cOq4VQvHWKyOAFnEI2S8JYBu7oi
         aFyvWJqcJC9iZST5MFfOwx6FmgtYMPJZ5LvgnWusMsOq4Dnp+8yWtVTMsbMZJJdYJ+Ds
         w3GhyljC22UklJttLh+K7w74GW9lnQLBepigClTkvtUUiSWoF/8A/aumdwT6JYayJfiZ
         QvmVzxZXxYOL8RyOyHiLcqpBtlKWOfVSVQ2kaArFPlGZETIwGGakUgsfbMWRrjazsihc
         +LxA==
X-Gm-Message-State: AOAM531g8SjwdPE/dlzcf/6PpRbclG4H4X+iUkehZl5QRosS7Wht7jFL
        ptF2p7Je4asNAOlpAPNJhOmKVgpIBk4=
X-Google-Smtp-Source: ABdhPJycsx5kBofdewff+3CqjkmQmda5YRRyOw4U6MIhhaAs0FlABNM1eKmZ27baXPdBsmO/7d3HVA==
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr9694539wma.66.1594213033890;
        Wed, 08 Jul 2020 05:57:13 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v9sm6993885wri.3.2020.07.08.05.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:57:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/3] Mop-up last remaining patches for Misc
Date:   Wed,  8 Jul 2020 13:57:08 +0100
Message-Id: <20200708125711.3443569-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These required fix-ups or were waiting on review.

Lee Jones (3):
  misc: vmw_vmci_defs: Mark 'struct vmci_handle VMCI_ANON_SRC_HANDLE' as
    __maybe_unused
  misc: eeprom: at24: Tell the compiler that ACPI functions may not be
    used
  misc: cxl: flash: Remove unused variable 'drc_index'

 drivers/misc/cxl/flash.c      | 4 ++--
 drivers/misc/eeprom/at24.c    | 2 +-
 include/linux/vmw_vmci_defs.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1

