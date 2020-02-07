Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EACC04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB4B20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="GQkJS9PR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgBGO1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:27:09 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:3173 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBGO1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 09:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1581085628;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=VeOKgsLHbFVyDx7PMdA5REjoA1i7oADMZ0tHH54ICDk=;
  b=GQkJS9PRJ7DGwJYQOsle7B0Ej+vb46h4taFvk3wZH3I/EKD17qZenwQd
   GK46ZYSj+vM6+XSCwvMxbuQKmS5zVEQK7hCXJRxUdIAmc/u8mLhzGfta+
   lO18BhlNgPRN6roQNHUyWxr8JBc/zge4O3c4CVoFUVheAubysW29sQgeE
   8=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=sergey.dyasli@citrix.com; spf=Pass smtp.mailfrom=sergey.dyasli@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  sergey.dyasli@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  sergey.dyasli@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: cA4RYOaIu0S9s9ta9/oYmLKI0oPWh8qI67vWbWeID51CDJsqQPd92KqbQrXTSHxA52oIpyOEin
 mjHe3Ta8qJaLx6bWxbhkPfPX//GfH+LroBSmBFGi0coygnCqe3s209HCh5UBZXXmyCzAXVuB4O
 PGUH9uKK98jiE79sIwKNB4nDDtzDQBnEmUwfWuGxwwWQ35uDItVmyc/u6tx2xPf8HNSoFkXGUx
 LpxcLAHAu0+2zobEKKVhvS7bVrz3xR0/Fu2/Jn5GwUKtqlfFilhnqbj3ZzAl+TvbJrHpp+Ujfc
 aFo=
X-SBRS: 2.7
X-MesageID: 12106635
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,413,1574139600"; 
   d="scan'208";a="12106635"
From:   Sergey Dyasli <sergey.dyasli@citrix.com>
To:     <xen-devel@lists.xen.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Dyasli <sergey.dyasli@citrix.com>
Subject: [PATCH v3 0/4] basic KASAN support for Xen PV domains
Date:   Fri, 7 Feb 2020 14:26:48 +0000
Message-ID: <20200207142652.670-1-sergey.dyasli@citrix.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series allows to boot and run Xen PV kernels (Dom0 and DomU) with
CONFIG_KASAN=y. It has been used internally for some time now with good
results for finding memory corruption issues in Dom0 kernel.

Only Outline instrumentation is supported at the moment.

Sergey Dyasli (2):
  kasan: introduce set_pmd_early_shadow()
  x86/xen: add basic KASAN support for PV kernel

Ross Lagerwall (2):
  xen: teach KASAN about grant tables
  xen/netback: fix grant copy across page boundary

 arch/x86/mm/kasan_init_64.c       | 10 +++++-
 arch/x86/xen/Makefile             |  7 ++++
 arch/x86/xen/enlighten_pv.c       |  3 ++
 arch/x86/xen/mmu_pv.c             | 43 ++++++++++++++++++++++
 drivers/net/xen-netback/common.h  |  2 +-
 drivers/net/xen-netback/netback.c | 60 +++++++++++++++++++++++++------
 drivers/xen/Makefile              |  2 ++
 drivers/xen/grant-table.c         |  5 ++-
 include/linux/kasan.h             |  2 ++
 include/xen/xen-ops.h             | 10 ++++++
 lib/Kconfig.kasan                 |  3 +-
 mm/kasan/init.c                   | 32 ++++++++++++-----
 12 files changed, 156 insertions(+), 23 deletions(-)

-- 
2.17.1

