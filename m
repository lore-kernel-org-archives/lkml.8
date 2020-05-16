Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2524C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 10:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DF220728
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 10:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sPB/pnH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgEPKew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 06:34:52 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:4004 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgEPKew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 06:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589625292; x=1621161292;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=gSufrPtaerKux+r8GM5T2Rp5gsHaSemAu39XANkY1D0=;
  b=sPB/pnH05ExRvx1Dg7UBnC7kgBxC38Ku29rAtm7aqYDWPehHTCOFiVpL
   EJg7UC26yIbmu4sBytTrDIhz4huNrGHqFc/Foez3oqO9/pU/hRpRxmmQq
   5fsg5vcFWTuZeBXoi2Q2PRMWyNFq0jUvaVxX59QX5F/Ws5VRU89d9/xd0
   E=;
IronPort-SDR: hBFWLGstAsao/8HTmRIypxsYOxlaw0nbibwxtRKmY/Vtm4uXhVDUwoXHFw50Wygr7JzbdyHZa6
 5H9UjOK/fpxA==
X-IronPort-AV: E=Sophos;i="5.73,398,1583193600"; 
   d="scan'208";a="35473441"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 16 May 2020 10:34:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id 47A52A1CEA;
        Sat, 16 May 2020 10:34:49 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 16 May 2020 10:34:48 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 16 May 2020 10:34:48 +0000
Received: from localhost (10.85.1.185) by mail-relay.amazon.com (10.43.61.243)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Sat, 16 May
 2020 10:34:46 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v7 0/3] Optionally flush L1D cache on context switch
Date:   Sat, 16 May 2020 20:34:27 +1000
Message-ID: <20200516103430.26527-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are the remaining patches built on top of
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/log/?h=x86/mm

for the series posted at
https://lore.kernel.org/lkml/20200510014803.12190-1-sblbir@amazon.com/

Changelog v7
- Split patch 5 from the previous series into two patches
- Reuse the prctl PR_GET/SET_SPECULATION_CTRL with PR_SPEC_L1D_FLUSH_OUT
    as the ctrl parameter
- Add the BUILD_BUG_ON that went missing that checks the placement of
    TIF_SPEC_L1D_FLUSH
- Update the documentation to reflect the changes

Balbir Singh (3):
  x86/mm: Optionally flush L1D on context switch
  prctl: Hook L1D flushing in via prctl
  Documentation: Add L1D flushing Documentation

 Documentation/admin-guide/hw-vuln/index.rst   |  1 +
 .../admin-guide/hw-vuln/l1d_flush.rst         | 51 +++++++++++++++++++
 Documentation/userspace-api/spec_ctrl.rst     |  7 +++
 arch/x86/include/asm/thread_info.h            |  9 +++-
 arch/x86/kernel/cpu/bugs.c                    | 28 ++++++++++
 arch/x86/mm/tlb.c                             | 39 ++++++++++++--
 include/uapi/linux/prctl.h                    |  1 +
 7 files changed, 131 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst

-- 
2.17.1

