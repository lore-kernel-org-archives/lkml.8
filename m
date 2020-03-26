Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BA0C2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A557C20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YV/YEVuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgCZHIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:08:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36165 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbgCZHIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:08:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so6399385wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=H2TUyOy7hFlU1mihaYKviLCAQGjbqgsYp50LlzLi1G8=;
        b=YV/YEVucTc4tJe8tVRyZyeopa1bFmsBloz1o8vb0870H7+lU3KBrDXwvdLOMqy7+YH
         PE5wla7gtriZfVzj9J+HE2BVnmMQ4nOcQiOLGgQ3anptlmmGu1EQguydcMw1hd6+e2W9
         7PbMRQG5dPaHvtk9Ou+4gszYCAHp6yVusqQsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H2TUyOy7hFlU1mihaYKviLCAQGjbqgsYp50LlzLi1G8=;
        b=tHGD7U1rS6dolsD9n/HHnsBwt7/FvQgNajcEv4QWGBQIDT4BimH6nNSziX1qwA2V+M
         XTqfGY1xMWFHz5DwLDOwCTyxPwq2qoFAx9CKrN7yqdmZwg+U6aPfSosLCcivK9F181cb
         09MQs9pvLv2SzIiSZI/7I2/6vc0FoluZ8F+JOOfwLY0AdyC8VF+8eAOJJWJGBwaK1B4g
         /7A24/NTsgNIDCBRaFWifgmxNZ4Ds1yl1mFsrSDRocEmriMqXROao98YsOs3fj6wWZo7
         Vx25Z4vRZP29uXpt60Lqb+E8sqjKSvzR06Ah32Xw0pOg0VoKXwmZA8CsIR2MzJxYzZyX
         I6yw==
X-Gm-Message-State: ANhLgQ0xw6kyOwExOhGMbMeMOT+QAeR1mx/ZBjDuaVvNjH3yb/82R9l0
        LXZ6eXMpJDeB1hGLZZhAs/pd7w==
X-Google-Smtp-Source: ADFU+vtoVFnc/MkSSn13lthBxGx1jDdqQOH+rCgiBTbCYRQZtgcw9pqUOFvmC34OnQDJ702CVYW4rw==
X-Received: by 2002:a5d:6044:: with SMTP id j4mr7223851wrt.232.1585206479437;
        Thu, 26 Mar 2020 00:07:59 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id u8sm2129446wrn.69.2020.03.26.00.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Mar 2020 00:07:58 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 0/3] PCI: iproc: Add fixes to pcie iproc 
Date:   Thu, 26 Mar 2020 12:37:24 +0530
Message-Id: <1585206447-1363-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains fixes and improvements to pcie iproc driver.

This patch set is based on Linux-5.5-rc1.

Bharat Gooty (1):
  PCI: iproc: fix out of bound array access

Roman Bacik (1):
  PCI: iproc: fix invalidating PAXB address mapping

Srinath Mannam (1):
  PCI: iproc: Display PCIe Link information

 drivers/pci/controller/pcie-iproc.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

-- 
2.7.4

