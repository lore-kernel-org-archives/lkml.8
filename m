Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BD7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC90206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594053524;
	bh=J0tnNdqUZ7QjofrvX1xWm6KVrgy7mDZI9PpGcRQ8v7Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=13DM+YeXPRpcZ0RTk6kuPOIukAEi4y1XAH3q15Xroz6yLLaBnoEpojUMUWP/DFDvx
	 khQHlCdsC3zXXprAnSKQgdhYY8SWmVsbipq0ELp2z7uTjqfHa1V0LydWAgOL79S48z
	 GqGGX4ol9zi0LxhvB/jrjWjKTKuW0PDztnSsFYy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgGFQin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729560AbgGFQiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:38:22 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95CE9206CD;
        Mon,  6 Jul 2020 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594053501;
        bh=J0tnNdqUZ7QjofrvX1xWm6KVrgy7mDZI9PpGcRQ8v7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=aWffKB9EUs/nEo1VFU1pYUPJaj6v7ckxGDTREDAzQPxN8kSnPk3CX4TcK6FOZGA8I
         TBS8AO33K/ARHJZMmv+W2AAPQ70y3AEe6K4MqdtKYkiHPLPE8nCoesom3LDPqKDOji
         M6kDlRUoP1PJnGwmKWFoIvZdRa+HMSgTqYsxylzo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jsU8K-009VkI-3W; Mon, 06 Jul 2020 17:38:20 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [PATCH v2 0/4] arm64: Allow the compat vdso to be disabled at runtime
Date:   Mon,  6 Jul 2020 17:37:58 +0100
Message-Id: <20200706163802.1836732-1-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, catalin.marinas@arm.com, daniel.lezcano@linaro.org, vincenzo.frascino@arm.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
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

Lastly, I've tagged a rework of the 1414080 workaround (which had been
posted separately) at the end of the series so that it limits its
effect to 32bit tasks exclusively (so far, it forces the userspace
access bit on 64bit tasks, and we may need to leave it disabled in the
future...).

* From v1:
  - Reworked following Mark's feedback (patches #2 and #3)
  - Reworked patch #4 after Will's comments
  - patches #1 to #3 are now cc stable
  - Applied Mark's AB to patch #1

Marc Zyngier (4):
  arm64: Introduce a way to disable the 32bit vdso
  arm64: arch_timer: Allow an workaround descriptor to disable compat
    vdso
  arm64: arch_timer: Disable the compat vdso for cores affected by
    ARM64_WORKAROUND_1418040
  arm64: Rework ARM_ERRATUM_1414080 handling

 arch/arm64/include/asm/arch_timer.h           |  1 +
 arch/arm64/include/asm/vdso/clocksource.h     |  7 +++-
 .../include/asm/vdso/compat_gettimeofday.h    |  8 +++-
 arch/arm64/kernel/entry.S                     | 40 +++++++++++--------
 drivers/clocksource/arm_arch_timer.c          | 11 +++++
 5 files changed, 48 insertions(+), 19 deletions(-)

-- 
2.27.0
