Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C04C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73DE120885
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIk2bIct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGBRDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgGBRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:03:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE62DC08C5C1;
        Thu,  2 Jul 2020 10:03:05 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a14so8219229pfi.2;
        Thu, 02 Jul 2020 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sdX4HaTp9icl96MrCuNrfjEqzJvThTeDSS/Lnbk9eSI=;
        b=qIk2bIctJuCw/nX0bYoysOksrp7u5CkoSzEjixR3X+RCXSGs7q5D1/l6rUJdVlSgSI
         TKQZE6MLK9wmKW5WLX0W+Zyn+ZIqbr3KB0Aw44bz0u7qbT++5115Uc9A4zByiAd2GKve
         3t/P4oa/c8FUJJCqE3KiD7eegicbFbRUSTl77earMKh33vDPuq/nj9dPSvfp/Jr0WnqJ
         sKWcFckkLmmJ0TstROceDpwp8n4xfjLL2b1vfBRdWDiF0Bxmag5t0C/icsv40WKdV084
         OxXGWUiA4bkbv3mPmQ7dRO817I87lhgLzIFoFMOzpmNjc6oqR9ZZfCHQhNxforOJdj1a
         Pz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sdX4HaTp9icl96MrCuNrfjEqzJvThTeDSS/Lnbk9eSI=;
        b=ucZkh+oClaA7iWIsLaPNfMJ6UCuckJYqoDmwK7FfkdKRkTDMJZQRktjD+DAlkjPMHB
         60Dy2dDJT2R2xnOYMirVJOa2WwKLJZffzZDLFSJeyN7XqcPrZyY1r7KWKq4xFic1+T1V
         S/WjDnIdCYvYkoH8NPxyW060mR6+xByb89bVHFIF+WN6K9yI7Edd+5z+x//XY4YwTSFV
         R4b66x3JQtonU8jxWdUTf5hcqTZ39PWoFiHlx5ZuDjbQURBDI2b2ESLI+k1vIeCvJiGB
         Fp0nsVDmizu8hIl4/1f3zi9HVnYHr8+Oz6sxYKjoY/fME//0eBYakpHwjuqMlZSExXnp
         P6Kg==
X-Gm-Message-State: AOAM532O8cia7ShEyXumvLm6h5vUqzHgsnsz8y/4VG588AQv9V9Rzp+K
        svIxWiLlYuFf8vShtBeC6sk=
X-Google-Smtp-Source: ABdhPJzsKs1R5yuKZm5NZySSEZZHZPlNsiGXwAR+dvp1/5lvQkYtz7GeTgWdeKqHCK0mCo0ZRiOznQ==
X-Received: by 2002:a65:43cb:: with SMTP id n11mr24992540pgp.160.1593709385187;
        Thu, 02 Jul 2020 10:03:05 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.57])
        by smtp.gmail.com with ESMTPSA id j21sm9230429pfa.133.2020.07.02.10.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 10:03:04 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Manish Chopra <manishc@marvell.com>,
        Rahul Verma <rahulv@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Shahed Shaikh <shshaikh@marvell.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 0/2] qlogic: use generic power management
Date:   Thu,  2 Jul 2020 22:31:41 +0530
Message-Id: <20200702170143.27201-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mentee: Remove Legacy Power Management.

The purpose of this patch series is to remove legacy power management callbacks
from qlogic ethernet drivers.

The callbacks performing suspend() and resume() operations are still calling
pci_save_state(), pci_set_power_state(), etc. and handling the power management
themselves, which is not recommended.

The conversion requires the removal of the those function calls and change the
callback definition accordingly and make use of dev_pm_ops structure.

All patches are compile-tested only.

V2: Fix unused variable warning in v1.

Vaibhav Gupta (2):
  netxen_nic: use generic power management
  qlcninc: use generic power management

 .../ethernet/qlogic/netxen/netxen_nic_main.c  | 59 +++++++++----------
 .../net/ethernet/qlogic/qlcnic/qlcnic_hw.c    | 11 +---
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  | 33 +++--------
 3 files changed, 37 insertions(+), 66 deletions(-)

-- 
2.27.0

