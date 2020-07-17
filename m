Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92FBC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E3CE20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M06rkvxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgGQHvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgGQHvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:51:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB43C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 00:51:17 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b9so5114936plx.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 00:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nQMEtakU6xS8LBnA2yMRjtPGhopel0Omr+ZNCJgv3hU=;
        b=M06rkvxqty8dn8IXzeesiv6KfkaAFIVggP51R9rAl8zPEtCRnkT+scKW4YTcilLGZX
         /JZA+UUB/EqcnenwrIW8OeLn5QQtZk21VoSTL233t/D1lktszA69GRaJuwReqckn7FBF
         5VssdRukZwyh2IVo+pR84jmH7uCEHqugT61PPrgzDWj7MPy9BrAMbFq8KpJcG+zOoz8c
         vGBr2sQG2IxRTcFD/IhZrU8N+5PyoFSkjM9VXYNoJOLZ23hgZtk5vk9WHcT3vzggaXLM
         KAc+Rso01VAjwlVkairTfNxO6gn2LxW384A2B/RQbcrzf61FHHNHJE66aMI8IdreSUnC
         fsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nQMEtakU6xS8LBnA2yMRjtPGhopel0Omr+ZNCJgv3hU=;
        b=Kp39Ge04XsEzhNQI15RV1uYWdbixHLcC9dYL0PuKZmGtHJo+HDbxW8bMbDDaB8dVk9
         5yHfXw0AtayFkz9QFuruvono+kbLsOoROy/kLdSmVhyHik/T3OuClnbRXjkRMPgYvkE/
         XtrnkfOf7mNtHTOcp47pdlQtsVub5qyL7DiTJsI2E1SIaMhDoYujOLA/1d+I0kHfj5fX
         zoU7prhWJ/QOV4Cumx8a1Y/PuRD75JT2/irF4Hi+MGwaoZBgpngSo96Z7b/hXd4IS8Nu
         mlzdhABBbgye5YtA2TGoTjevgP0YWmu/YT1fvPYRil1/5V/QOT8cpGflkL44UDehajvz
         WD8g==
X-Gm-Message-State: AOAM531XwnrAmx8GklpuaBdc8zVvQcxDw6M7chnl3UU24H6IO4rVZd9/
        BmHF7jbb83FyRZlzqtNm9YI=
X-Google-Smtp-Source: ABdhPJy3FJKJvWW6pKyEqr3V2z6yNkYiEEfQX+1qxqgCABkkYLm6lyEyStcfQko+OoysKi3fGgdXKg==
X-Received: by 2002:a17:90a:ac14:: with SMTP id o20mr8782433pjq.185.1594972277266;
        Fri, 17 Jul 2020 00:51:17 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id s68sm1924332pjb.38.2020.07.17.00.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 00:51:16 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v1 0/3] char: use generic power management
Date:   Fri, 17 Jul 2020 13:19:34 +0530
Message-Id: <20200717074937.296192-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mentee: Remove Legacy Power Management.

The purpose of this patch series is to upgrade power management in char
drivers. This has been done by upgrading .suspend() and .resume() callbacks.

The upgrade makes sure that the involvement of PCI Core does not change the
order of operations executed in a driver. Thus, does not change its behavior.

In general, drivers with legacy PM, .suspend() and .resume() make use of PCI
helper functions like pci_enable/disable_device_mem(), pci_set_power_state(),
pci_save/restore_state(), pci_enable/disable_device(), etc. to complete
their job.

The conversion requires the removal of those function calls, change the
callbacks' definition accordingly and make use of dev_pm_ops structure.

All patches are compile-tested only.

Test tools:
    - Compiler: gcc (GCC) 10.1.0
    - allmodconfig build: make -j$(nproc) W=1 all

Vaibhav Gupta (3):
  amd64-agp: use generic power management
  sis-agp: use generic power management
  via-agp: use generic power management

 drivers/char/agp/amd64-agp.c | 24 ++++++------------------
 drivers/char/agp/sis-agp.c   | 25 ++++++-------------------
 drivers/char/agp/via-agp.c   | 25 +++++--------------------
 3 files changed, 17 insertions(+), 57 deletions(-)

-- 
2.27.0

