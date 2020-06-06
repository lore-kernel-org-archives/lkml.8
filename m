Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AC7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 09:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F34820663
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 09:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgFGJgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 05:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgFGJgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 05:36:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06D5C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 02:36:06 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jhrie-0000K4-Ui; Sun, 07 Jun 2020 11:35:57 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id F02F5FF805;
        Sun,  7 Jun 2020 11:35:55 +0200 (CEST)
Message-Id: <20200606215114.380723277@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 06 Jun 2020 23:51:14 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, x86@kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [patch 0/3] vdso: Unbreak VDSO with PV and HyperV clocksources
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos reported [1] that the recent VDSO changes broke paravirt clocksource
based VDSO in the case that the clocksource is invalidated by the
hypervisor which happens after a suspend/resume cycle of the host.

The result is a stale clocksource which is about 2200 seconds ahead of the
actual time and jumps forward by 2200 seconds once 2200 seconds have
elapsed.

The reason for this is the core code change which optimized the VDSO
clocksource validation by checking for the clocksource mode instead of
using the rather subtle check for the clocksource read return value whether
it has bit 63 set.

For some reason my brain blanked when doing that change, even if I should
have known better.

The following series restores the previous behaviour but preserves the
initially intended optimization for architectures which don't need that PV
handling.

Thanks,

	tglx

[1] https://lore.kernel.org/r/CAJfpegstNYeseo_C4KOF9Y74qRxr78x2tK-9rTgmYM4CK30nRQ@mail.gmail.com

8<-----------------
 arch/x86/include/asm/vdso/gettimeofday.h |   18 ++++++++++++++++++
 kernel/time/clocksource.c                |    2 --
 lib/vdso/gettimeofday.c                  |   19 +++++++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)
