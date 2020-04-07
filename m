Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA124C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946B12075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="N0TFJnCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgDGQeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:34:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53892 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgDGQeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:34:21 -0400
Received: from zn.tnic (p200300EC2F0B2700A94266E658FF3DDD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2700:a942:66e6:58ff:3ddd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 086601EC0985;
        Tue,  7 Apr 2020 18:34:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586277260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10AuisXdlkUGnV+75mnu84n04JgfotyUA5Qxp55bd6c=;
        b=N0TFJnCU3O9Ql8HiJSnsgw3cmuRn69X1L+XEegCo0x1/t2M3ppOEKxoEG1hcbakITMFSJJ
        4swSm1BVlcqt/boqtGVBF1bx5nIXeGmr5WXUIjhMBd06E6s38Wr1hI4WcMgnSJ6OwNR2QG
        s6oNO3gAjTxeYKVyh9gcnfB8dennJfo=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/9 v3] New way to track mce notifier chain actions
Date:   Tue,  7 Apr 2020 18:34:05 +0200
Message-Id: <20200407163414.18058-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200212204652.1489-1-tony.luck@intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

here's what I have. I'd like to keep mce.kflags hidden for now.

The last patch is something tglx spotted yesterday and fixing that with
the MCE flags is pretty easy - was boxing with a wrapper struct around
struct mce and that gets really ugly.

Tony, I'm open to suggestions how to test it - I probably don't have an
access to such box which can trigger read errors on nvdimms or what was
the use case?

Thx.

Borislav Petkov (2):
  x86/mce/amd, edac: Remove report_gart_errors
  x86/mce: Fixup exception only for the correct MCEs

Tony Luck (7):
  x86/mce: Rename "first" function as "early"
  x86/mce: Convert the CEC to use the MCE notifier
  x86/mce: Add a struct mce.kflags field
  x86/mce: Fix all mce notifiers to update the mce->kflags bitmask
  x86/mce: Change default MCE logger to check mce->kflags
  x86/mce: Add mce=print_all option
  EDAC: Drop the EDAC report status checks

 arch/x86/include/asm/mce.h           | 28 +++++++----
 arch/x86/include/uapi/asm/mce.h      |  1 +
 arch/x86/kernel/cpu/mce/amd.c        |  9 +++-
 arch/x86/kernel/cpu/mce/core.c       | 72 +++++++++++-----------------
 arch/x86/kernel/cpu/mce/dev-mcelog.c |  5 ++
 arch/x86/kernel/cpu/mce/internal.h   |  1 +
 arch/x86/kernel/cpu/mce/severity.c   |  6 ++-
 drivers/acpi/acpi_extlog.c           | 19 ++------
 drivers/acpi/nfit/mce.c              |  1 +
 drivers/edac/amd64_edac.c            |  8 ----
 drivers/edac/edac_mc.c               | 61 -----------------------
 drivers/edac/i7core_edac.c           |  5 +-
 drivers/edac/mce_amd.c               | 28 ++---------
 drivers/edac/mce_amd.h               |  2 -
 drivers/edac/pnd2_edac.c             |  8 ++--
 drivers/edac/sb_edac.c               |  7 ++-
 drivers/edac/skx_common.c            |  3 +-
 drivers/ras/cec.c                    | 33 ++++++++++++-
 include/linux/edac.h                 |  8 ----
 include/linux/ras.h                  |  5 --
 20 files changed, 118 insertions(+), 192 deletions(-)

-- 
2.21.0

