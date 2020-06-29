Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BEDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9CB2076C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1jI6aqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388293AbgF2VDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730459AbgF2TMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89800C014A4A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:17:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p3so7961709pgh.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tgDUE0GKIkXmW6aX8lSR4NBOqlcCjZE7PQjmXBJ/lhQ=;
        b=Z1jI6aqnyUAm3q07oAb5HCKKw4uCkN9ddj5DoN/Sg5VrboJwevPNrx5jLcmZc9Dl8O
         ZRcimyRboN1Mw60EMnIE6sg0WqQspyGB1f47XUPbzFnvcL28gzVoEypDV9PSA492B4qB
         LMY0EoGnFUAttLxvYWDvZy+U616IqcnR3Wgrjq3C7ebwO/PSzhVk5D6D61MlfjqhrPcH
         MGdFVCtnMLP+C03SvJiWfyOZSmg78HZ/2Tv10F1tHbg1RZaJEWFtWk5xGCeQHKhIE4Sn
         eUiAQCmCxLZX4NKVOwTXMuZrMaya1tu3C78hwonMTqzMaIKTD5KAdAxDuVuHJLmmfiP3
         7NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tgDUE0GKIkXmW6aX8lSR4NBOqlcCjZE7PQjmXBJ/lhQ=;
        b=hJ4ygH8oTk4CWTjQa/w5axW3ojbPZh3J2j/aq8pxt6+GW9SsMyLVW2p1MsyOTOfzKE
         SXdFcEvX4HA2eddKyFtrE894UwbkGOv6wDAEDefiMn9Dc+6pi2tKjtwfko9nP6YH12wk
         vli156ayo2++CAG6TPO5Ic6uhwbqr8aKHh5RHRIf+mHiO6iVc9dwLnXByN+MK9+4KyaS
         Gg37DKIQQ52pQ/NyFzlkV24Hix1LhVHnrCC1Spy9OCGUClepmPIm4WL4jo0t8kMMYBlG
         iZWqbgelyq6hQC7iVNqfFn/6Tt5P3eoOOzAxYAbsgJU/fD/GnXEZMDHQ6oTgdCO0AFyR
         uGTw==
X-Gm-Message-State: AOAM530icLzeX9pNWY4a9QBvzUxr2vgMRPuft3t1WpTLK636FiPQXrpy
        TcIEkI2Fdm21tuAARCuRctc=
X-Google-Smtp-Source: ABdhPJzM28IRQ1wZ9naK+e4ccSXlhOR9bkSkq6Iyv0YsLSn5bOc6DAlXFR5zm+eZRxkTJOETv4SPtA==
X-Received: by 2002:a63:6643:: with SMTP id a64mr9557397pgc.246.1593418633762;
        Mon, 29 Jun 2020 01:17:13 -0700 (PDT)
Received: from varodek.localdomain ([106.210.40.90])
        by smtp.gmail.com with ESMTPSA id co1sm3345154pjb.34.2020.06.29.01.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 01:17:13 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@gmail.com>, Alex Dubov <oakad@yahoo.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v1 0/5] misc: use generic power management
Date:   Mon, 29 Jun 2020 13:45:26 +0530
Message-Id: <20200629081531.214734-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mentee: Remove Legacy Power Management.

The purpose of this patch series is to remove legacy power management callbacks
from amd ethernet drivers.

The callbacks performing suspend() and resume() operations are still calling
pci_save_state(), pci_set_power_state(), etc. and handling the power management
themselves, which is not recommended.

The conversion requires the removal of the those function calls and change the
callback definition accordingly and make use of dev_pm_ops structure.

All patches are compile-tested only.

Vaibhav Gupta (5):
  cb710/core.c: use generic power management
  cardreader/rtsx_pcr.c: use generic power management
  misc/tifm_7xx1.c: use generic power management
  misc/phantom.c: use generic power management
  misc/pch_phub.c: use generic power management

 drivers/misc/cardreader/rtsx_pcr.c | 27 +++++++----------
 drivers/misc/cb710/core.c          | 28 +++++------------
 drivers/misc/pch_phub.c            | 48 ++++++------------------------
 drivers/misc/phantom.c             | 20 +++++--------
 drivers/misc/tifm_7xx1.c           | 30 +++++--------------
 5 files changed, 42 insertions(+), 111 deletions(-)

-- 
2.27.0

