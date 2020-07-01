Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32427C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B462083E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593620314;
	bh=+kg5n5iBRN1rz+NautQXbGnzXr0XI+MwbTAXtj/Q2no=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tKoQ1IcgyBHPN4QOW44oSEonZaJqEbHBt6KnhNELOyhwaK8ID+5yi7joP7YGQKHuk
	 nasKEJk+GDF3UYogUQ8v6t7lBNZvGA66LyZ9AutoTpl0orQkhXlFl6vr5SZRFsTg/4
	 kwa52NwtWU6xRkCqW8MAEmk74WI+tcwT2i2HqtQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbgGAQSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgGAQSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:18:31 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35BC0207BB;
        Wed,  1 Jul 2020 16:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593620311;
        bh=+kg5n5iBRN1rz+NautQXbGnzXr0XI+MwbTAXtj/Q2no=;
        h=From:To:Cc:Subject:Date:From;
        b=nNb5HwLX5irb5b+xXWqNzGCwM33f3ij2fcNA9Doyc3lMc2mSaEuzmDurDZyg5pGNw
         qtTb8ldfZipMDzZAPk2whBdPQLQf/qeTv+mAoc5hh5DlRIA2s1GSUJnenvC6iMhLrA
         XhPSaJR/kkCtf8psvGp5PYMX0C45lyv9jQnZ8Iyk=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jqfRN-0087Zf-N9; Wed, 01 Jul 2020 17:18:29 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [PATCH 0/3] arm64: Allow the compat vdso to be disabled at runtime
Date:   Wed,  1 Jul 2020 17:18:21 +0100
Message-Id: <20200701161824.1346732-1-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, daniel.lezcano@linaro.org, vincenzo.frascino@arm.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The relatively recent introduction of the compat vdso on arm64 has
overlooked its interactions with some of the interesting errata
workarounds, such as ARM64_ERRATUM_1418040 (and its older 1188873
incarnation).

This erratum requires the 64bit kernel to trap 32bit accesses to the
virtual counter and emulate it. When the workaround was introduced,
the compat vdso simply wasn't a thing. Now that the patches have
landed in mainline, we trap the CVTVCT accesses from the vdso.

This can end-up in a nasty loop in the vdso, where the sequence number
changes on each trap, never stabilising, and leaving userspace in a
bit of a funny state (which is why we disable the vdso in most similar
cases). This erratum mentionned above is a bit special in the sense
that in only requires to trap AArch32 accesses, and 64bit tasks can be
left alone. Consequently, the vdso is never disabled and AArch32 tasks
are affected.

Obviously, we really want to retain the 64bit vdso in this case. To
that effect, this series offers a way to disable the 32bit view of the
vdso without impacting its 64bit counterpart, by providing a
"no-compat" vdso clock_mode, and plugging this feature into the
1418040 detection code.

I haven't put any Cc stable for now, but I believe we need to do
something for older kernels.

Marc Zyngier (3):
  arm64: Introduce a way to disable the 32bit vdso
  arm64: arch_timer: Allow an workaround descriptor to provide
    vdso_clock_mode
  arm64: timers: Disable the compat vdso for cores affected by
    ARM64_WORKAROUND_1418040

 arch/arm64/include/asm/arch_timer.h               |  3 +++
 arch/arm64/include/asm/vdso/clocksource.h         |  7 +++++--
 arch/arm64/include/asm/vdso/compat_gettimeofday.h |  8 +++++++-
 drivers/clocksource/arm_arch_timer.c              | 11 +++++++++++
 4 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.27.0

