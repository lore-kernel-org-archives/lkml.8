Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B634BC2D0E5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3EB2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgC3OuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:50:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59023 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbgC3OuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:50:01 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jIvjj-0006uq-5Z; Mon, 30 Mar 2020 16:49:59 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id BC3CA1040EC;
        Mon, 30 Mar 2020 16:49:58 +0200 (CEST)
Date:   Mon, 30 Mar 2020 14:47:16 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/timers for v5.7
References: <158557962955.22376.9136086165862170511.tglx@nanos.tec.linutronix.de>
Message-ID: <158557963678.22376.17697748296819329736.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/timers branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-2020-03-30

up to:  fac01d11722c: x86/tsc_msr: Make MSR derived TSC frequency more accurate


x86 timer updates:

  - A series of commits to make the MSR derived CPU and TSC frequency more
    accurate.

    It turned out that the frequency tables which have been taken from the
    SDM are inaccurate because the SDM provides truncated and rounded
    values, e.g. 83.3Mhz (83.3333...) or 116.7Mhz (116.6666...).

    This causes time drift in the range of ~1 second per hour
    (20-30 seconds per day). On some of these SoCs it's not possible to
    recalibrate the TSC because there is no reference (PIT, HPET) available.

    With some reverse engineering it was established that the possible
    frequencies are derived from the base clock with fixed multiplier /
    divider pairs.

    For the CPU models which have a known crystal frequency the kernel now
    uses multiplier / divider pairs which bring the frequencies closer to
    reality and fix the observed time drift issues.

Thanks,

	tglx

------------------>
Hans de Goede (3):
      x86/tsc_msr: Use named struct initializers
      x86/tsc_msr: Fix MSR_FSB_FREQ mask for Cherry Trail devices
      x86/tsc_msr: Make MSR derived TSC frequency more accurate


 arch/x86/kernel/tsc_msr.c | 128 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 112 insertions(+), 16 deletions(-)


