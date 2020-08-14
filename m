Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0A1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29D32078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="syYAFcAT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tAiOO4KL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgHNQAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgHNQAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:00:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00921C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 09:00:38 -0700 (PDT)
Date:   Fri, 14 Aug 2020 15:58:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597420837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZturQnO5r45yYaNu05eOFwVnvexI0hXi+cix/LrA4lM=;
        b=syYAFcATrfD1zYdwUKnEI2etFbHxGZ9JCecVVswJgCiaGeN95di6jv/IC3Xq9RY2YeCqMp
        lCo6beJ4wnqmKMXscH4YrieJnG/dprMwzcUlQsOLO/FuyjI8PoZqcsUvRU5mkAqsx9m+y3
        oTk0y9EyZrWWrJxLoLhqgTPqay5EYLOIMjouWACZMZptUILypv1kLyL77RLflhLdojCzUJ
        qRuQelqSusANjB5bvPYbrJEqBfi8GhjNieQDiOmGOz2QwFujD1zPjqMIYhTS8QgxyDY1wG
        kNdeMmoHQrf+ZiHDl2vmvwPTrVGsQh+6lWMz657JrQNeeeTocxX00MVnALEeXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597420837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZturQnO5r45yYaNu05eOFwVnvexI0hXi+cix/LrA4lM=;
        b=tAiOO4KLM1VnpFXG1sVru4brEkoWh9qD92VFTzmVyrBIhhPDhUSppylnmtRgTB0ZjfwViX
        9FI0vwj0WBBWqUCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v5.9-rc1
References: <159742071192.30851.2328227964586183297.tglx@nanos>
Message-ID: <159742071432.30851.8730414087382693550.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-08-14

up to:  b0294f30256b: time: Delete repeated words in comments

A set oftimekeeping/VDSO updates:

 - Preparatory work to allow S390 to switch over to the generic VDSO
   implementation.

   S390 requires that the VDSO data pointer is handed in to the counter
   read function when time namespace support is enabled. Adding the pointer
   is a NOOP for all other architectures because the compiler is supposed
   to optimize that out when it is unused in the architecture specific
   inline. The change also solved a similar problem for MIPS which
   fortunately has time namespaces not yet enabled.

   S390 needs to update clock related VDSO data independent of the
   timekeeping updates. This was solved so far with yet another sequence
   counter in the S390 implementation. A better solution is to utilize the
   already existing VDSO sequence count for this. The core code now exposes
   helper functions which allow to serialize against the timekeeper code
   and against concurrent readers.

   S390 needs extra data for their clock readout function. The initial
   common VDSO data structure did not provide a way to add that. It now has
   an embedded architecture specific struct embedded which defaults to an
   empty struct.

   Doing this now avoids tree dependencies and conflicts post rc1 and
   allows all other architectures which work on generic VDSO support to
   work from a common upstream base.

 - A trivial comment fix.  

Thanks,

	tglx

------------------>
Randy Dunlap (1):
      time: Delete repeated words in comments

Sven Schnelle (1):
      lib/vdso: Allow to add architecture-specific vdso data

Thomas Gleixner (2):
      vdso/treewide: Add vdso_data pointer argument to __arch_get_hw_counter()
      timekeeping/vsyscall: Provide vdso_update_begin/end()



