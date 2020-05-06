Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F27C47258
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC9520663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bqaQNWHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgEFHP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726897AbgEFHPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:15:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3211C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 00:15:25 -0700 (PDT)
Received: from zn.tnic (p200300EC2F069600BCEB9C28D5742179.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9600:bceb:9c28:d574:2179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 221A31EC0333;
        Wed,  6 May 2020 09:15:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588749323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=xdijj7UHafvzhpvXPwoBBmDJG5jKdDlBhacVRhZFQzk=;
        b=bqaQNWHCtwuCVSZlEoZX2RRHRNeJZSXwDMADFFycJlTz+TZz7ZtHLRSQsLphDRospAIDm3
        le70w1lRnwMe9mu1Kjw+ZHqVnkPi4mt2nLXkWM3dNevg0iF6hHo55nUa11VfosXE5WRGoe
        4ViK9mz5EIDqf8tdYyoryTejqIvpZ6I=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] x86/cpu: More macros cleanup
Date:   Wed,  6 May 2020 09:15:13 +0200
Message-Id: <20200506071516.25445-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

here are some more cleanups ontop of tglx's x86 CPU macros cleanup
series.

Thx.

Borislav Petkov (2):
  x86/cpu: Add a X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS() macro
  x86/apic: Convert the TSC deadline timer matching to steppings macro

Mark Gross (1):
  x86/cpu: Add a steppings field to struct x86_cpu_id

 arch/x86/include/asm/cpu_device_id.h | 31 +++++++++++++--
 arch/x86/kernel/apic/apic.c          | 57 ++++++----------------------
 arch/x86/kernel/cpu/match.c          |  7 +++-
 include/linux/mod_devicetable.h      |  2 +
 4 files changed, 48 insertions(+), 49 deletions(-)

-- 
2.21.0

