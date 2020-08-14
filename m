Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8234EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7192078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kab2i3ZZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kUo8DolQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHNQAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:00:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37642 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:00:36 -0400
Date:   Fri, 14 Aug 2020 15:58:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597420834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6t+jR2il3zVScXYH6J6JnpEfxWy4p58re3TI107BQ4E=;
        b=Kab2i3ZZDb/n3DxfaZIiUh81P4xGk6yGTnDPb3S++DKpSFkbKWwDknCsxcQhXaEj9GOpP7
        OCOWPjUBsYtKDWQfVU2wBSDe30aL34bpyrkHunEdzSkmRDHTNWj1xngdgIP2uz+ynE4bmt
        s8zlg5N22xckkhPgd6k1oIOGRCp9IkM0EGSTqFvwf6YYWOCi8uNsYa6tWlTjUNRIq6SQXJ
        mzFk6tqrQPGIdFik506VzgqPme1OplIPv2vDyfl0dfEGHXbFAP9HTApZrSciVzTlOT6VQl
        KQ35aWe8dDedJ/aUrvifztO+3nEpga75koLtazmhOhYeYl4i3tOs/otUQeellQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597420834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6t+jR2il3zVScXYH6J6JnpEfxWy4p58re3TI107BQ4E=;
        b=kUo8DolQGhidRgrxaiwwr8ZF1lzGU3sFpUZti+NBQhZm/YfJ5jeMXCivuaIknGnLvH2VXm
        OIA2TkkscTEPYoDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.9-rc1
Message-ID: <159742071192.30851.2328227964586183297.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-08-14

up to:  f107cee94ba4: genirq: Unlock irq descriptor after errors

Two fixes in the core interrupt code which ensure that all error exits
unlock the descriptor lock.

Thanks,

	tglx

------------------>
Guenter Roeck (2):
      genirq/PM: Always unlock IRQ descriptor in rearm_wake_irq()
      genirq: Unlock irq descriptor after errors



