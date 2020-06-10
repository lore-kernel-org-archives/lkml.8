Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BBEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1C6207C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XVuMF96i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgFJLAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgFJLAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:00:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D940FC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:00:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c190029f750dc462a5b02.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1900:29f7:50dc:462a:5b02])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3BBD31EC0288;
        Wed, 10 Jun 2020 13:00:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591786847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=u+yseAhSTuL9WNs4t9gjGaAfWzuvxDaGplm92riYglo=;
        b=XVuMF96ivnB/pJ0ZbhkJtJWrrdjumCWI0947ZFo2Xlzk2DMBIuLXWV287++m23gyMVUHsg
        deVOziwCEEsYbY8p0W0/8PMHTIVKeK+AuXmu8xI36hF1PNbzfXxdtEyk0KBzPdbBNJicME
        DG6ianVVbqqs3NmXp/7EiJCxOncMiFY=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] x86/MSR: Add a MSR write callback
Date:   Wed, 10 Jun 2020 13:00:34 +0200
Message-Id: <20200610110037.11853-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

here's a small set which adds a callback to execute when a MSR is
written. Patch 3 explains the need for it.

Thx.

Borislav Petkov (3):
  x86/msr: Pass a single MSR value to __rwmsr_on_cpus() too
  x86/msr: Add wrmsrl_val_on_cpus()
  x86/msr: Add an MSR write callback

 arch/x86/include/asm/msr.h   | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c   |  2 +-
 arch/x86/kernel/cpu/common.c | 31 +++++++++++++++++++++++++++++++
 arch/x86/kernel/msr.c        |  3 +++
 arch/x86/lib/msr-smp.c       | 26 +++++++++++++++++++++++---
 5 files changed, 68 insertions(+), 4 deletions(-)

-- 
2.21.0

