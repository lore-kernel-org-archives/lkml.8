Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DE9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC6C205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="UzgbGWYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgHKJpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:45:07 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:44674 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgHKJpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1597139105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C1C/bfcTzAjyjIEmceYjlKaTAd0vBlG0fPV+iLhjdZQ=;
  b=UzgbGWYqek2dFZbrtOupRPFD8L2vDlYfEdzHclTutngS3UojNR/e+k2m
   MPzjN5oarYrI/FLukR2BaPVjs3reZ5N/kRcrSvQyy3zfR5wXlwkvB95Hg
   Fe1xz9+YYeyyvlvyqVzfOnkNh9tWo62wLVz6FKfLzANs965ShNCPiulrI
   8=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: yCcrGj6Y7sGlIM1t377a4q/TQDwBL2wPr7/L/nPfOKNCau+nryFLlWIEk43kz2kHCEPigs6Shn
 6gcd0lLnPt++IrOYG+b7Q1BsnLxmH50uRZ0QT8tFRbwZVw75DyuaNwSBfW7K/EjP2WyoMlK/Cg
 ZItZc8Zaf9jovqJ5ToCurtpCnDN09KAQITdBNyiyHgD1BW4c0aDlsRxqeELcE7npraP/aCx3pR
 ssSzHJcpTPMZmZWLgFRQeuzY5dor0VzeYuxAIYReQJ3ez41R9oPlg5qqlGAxx+Vqa1qzezRNVL
 2us=
X-SBRS: 2.7
X-MesageID: 24569967
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,460,1589256000"; 
   d="scan'208";a="24569967"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH v4 0/2] xen/balloon: fixes for memory hotplug
Date:   Tue, 11 Aug 2020 11:44:45 +0200
Message-ID: <20200811094447.31208-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following series contain some fixes in order to split Xen
unpopulated memory handling from the ballooning driver if ZONE_DEVICE is
available, so that physical memory regions used to map foreign pages are
not tied to memory hotplug.

The main difference in this version is that MEMORY_DEVICE_DEVDAX is
renamed to MEMORY_DEVICE_GENERIC, as using DEVDAX in the Xen code to
allocate unpopulated memory felt wrong.

Thanks, Roger.

Roger Pau Monne (2):
  memremap: rename MEMORY_DEVICE_DEVDAX to MEMORY_DEVICE_GENERIC
  xen: add helpers to allocate unpopulated memory

 drivers/dax/device.c                    |   2 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.c |   9 +-
 drivers/xen/Kconfig                     |   4 +
 drivers/xen/Makefile                    |   1 +
 drivers/xen/balloon.c                   |   4 +-
 drivers/xen/grant-table.c               |   4 +-
 drivers/xen/privcmd.c                   |   4 +-
 drivers/xen/unpopulated-alloc.c         | 185 ++++++++++++++++++++++++
 drivers/xen/xenbus/xenbus_client.c      |   6 +-
 drivers/xen/xlate_mmu.c                 |   4 +-
 include/linux/memremap.h                |   9 +-
 include/xen/xen.h                       |   9 ++
 mm/memremap.c                           |   2 +-
 13 files changed, 221 insertions(+), 22 deletions(-)
 create mode 100644 drivers/xen/unpopulated-alloc.c

-- 
2.28.0

