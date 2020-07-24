Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE48C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2582074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="BZqXe6it"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgGXMmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:42:50 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:20842 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgGXMmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1595594570;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lKXqW8/3YOwTJyFQghmaI+GKNMTKpRONfG96XJL/WMA=;
  b=BZqXe6itPshhw5SvxqtgahrVQsUNc1iTrY5Xcuplaj7eMxM7TAc4ZpuE
   MpL6BOJ6TLOJ2tZC6qEGeLof34rnVGeGiXyFcpY/Wq5lwahTIC1LHLTLG
   sCDHLNZYTUj77Rupkcg14VRXD3zXxSb+gr+zPbQkv+B/+OCUmBtpX7qDa
   U=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: K2iI69Y6OCtQDD19Hf1T4acInpaZV4ysI4avOab6HMISqvB1o3gpzLiKS0FhxgkjERb9XUjbTM
 F5Fk3T9f8PoaJiidx88PglziYhudJ7iwbIzk0laWncsGIwz8mbbcVgIIfzCz86by8Hxvqzx5BR
 qbK8blo8XCtPs2i+LqVGnWdLRWcLB7az7C3KN4ylPsbPouPFyCxfn6homOcHD6A5C8ZGVk1Wyy
 ZBFJQbjsCo8HjxyTMtMXjYDlwSF1IkT6vaIvqsJ6hPCQ6AHZnn0CgbbMk0UmWe/uB4BCMSNSr1
 L3s=
X-SBRS: 2.7
X-MesageID: 23118831
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,390,1589256000"; 
   d="scan'208";a="23118831"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH v2 0/4] xen/balloon: fixes for memory hotplug
Date:   Fri, 24 Jul 2020 14:42:37 +0200
Message-ID: <20200724124241.48208-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.27.0
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

Fix two patches are bugfixes that IMO should be backported to stable
branches, third patch is a revert of a workaround applied to the balloon
driver and last patch introduces an interface based on ZONE_DEVICE in
order to manage regions to use for foreign mappings.

Thanks, Roger.

Roger Pau Monne (4):
  xen/balloon: fix accounting in alloc_xenballooned_pages error path
  xen/balloon: make the balloon wait interruptible
  Revert "xen/balloon: Fix crash when ballooning on x86 32 bit PAE"
  xen: add helpers to allocate unpopulated memory

 drivers/gpu/drm/xen/xen_drm_front_gem.c |   8 +-
 drivers/xen/Makefile                    |   1 +
 drivers/xen/balloon.c                   |  30 ++--
 drivers/xen/grant-table.c               |   4 +-
 drivers/xen/privcmd.c                   |   4 +-
 drivers/xen/unpopulated-alloc.c         | 222 ++++++++++++++++++++++++
 drivers/xen/xenbus/xenbus_client.c      |   6 +-
 drivers/xen/xlate_mmu.c                 |   4 +-
 include/xen/xen.h                       |   8 +
 9 files changed, 256 insertions(+), 31 deletions(-)
 create mode 100644 drivers/xen/unpopulated-alloc.c

-- 
2.27.0

