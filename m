Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BDBC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBA4207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="D4h9ACDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404167AbgDCQTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:19:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49254 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgDCQTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:19:50 -0400
Received: from zn.tnic (p200300EC2F0D8900BDBBB37D18611998.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8900:bdbb:b37d:1861:1998])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B0AB1EC036E;
        Fri,  3 Apr 2020 18:19:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585930789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=VQU1p/q5r74OW+D8Oi0oU2c2wyQ1nx16AqdcdAFF4lI=;
        b=D4h9ACDzlmghOo1esejIDP+eJtGsvfivZ0GsxOQ6Due2KeKn7FAXxaS1bZ44chupvcKJsb
        p2q/J2DJq9Qq1Gy9AqLneBi8HokyWE9CSg1RISv6GD8Yc7y2dmil2rRPsqJNtZLqyqGgKB
        +aglmTKUwDYcbS7f9YybkRSCsaybyCQ=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] x86/mce/amd: Fix some CPU hotplug insanity
Date:   Fri,  3 Apr 2020 18:19:36 +0200
Message-Id: <20200403161943.1458-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

so tglx found a couple of issues while we were talking about something
else and threw a couple of fixes over the wall, my way. Here's the
productized and tested result.

Thx.

Thomas Gleixner (7):
  x86/mce/amd: Do proper cleanup on error paths
  x86/mce/amd: Init thresholding machinery only on relevant vendors
  x86/mce/amd: Protect a not-fully initialized bank from the
    thresholding interrupt
  x86/mce/amd: Sanitize thresholding device creation hotplug path
  x86/mce/amd: Straighten CPU hotplug path
  x86/mce/amd: Cleanup threshold device remove path
  x86/mce/amd: Make threshold bank setting hotplug robust

 arch/x86/include/asm/amd_nb.h      |   1 +
 arch/x86/kernel/cpu/mce/amd.c      | 224 ++++++++++++++---------------
 arch/x86/kernel/cpu/mce/core.c     |  12 ++
 arch/x86/kernel/cpu/mce/internal.h |   9 +-
 4 files changed, 131 insertions(+), 115 deletions(-)

-- 
2.21.0

