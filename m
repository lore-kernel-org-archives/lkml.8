Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A4CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D342070A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VNwvzhjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbgEYIgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgEYIgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:36:43 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7760DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RTpKspGxVJJJi40+OUi0+PfMkju25wl6tiprFTvOugk=; b=VNwvzhjBBZXZ2K2tL7OAJ5w6oz
        ax0hT+LSYqqSAmwOkTkkfqSESGiRuf8XMC9qd7lSg2frS2RrrEW2GiSLeOCfaiFhpPIfFngr1medj
        oYaxzNhOJd0KIRhVPNdWKBSBdiInxW/QbkEsSwgmDIO3ahbfcUuVj/YbxwhBFzFGv7L8TkgOLbFgK
        inS01PxZV0sIzL5o1bdLN8zWkVBChNR+XRwkDI1Mra6jHEKGiSuzgxjY4EXaEhWTT/HvEalOCKfq0
        UeliyZYl2fMcLHPoMt1bZvilzCGaYzcoXg7t+/9s6DhrNvEApFN/gIb4d7ZSi9FY2sjd0RRTHokLL
        rkeDP5qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jd8ad-0001w8-Kw; Mon, 25 May 2020 08:36:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 277353011E6;
        Mon, 25 May 2020 10:36:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D13721462C5D; Mon, 25 May 2020 10:36:05 +0200 (CEST)
Date:   Mon, 25 May 2020 10:36:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     daniel.thompson@linaro.org, x86@kernel.org
Cc:     sumit.garg@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, will@kernel.org
Subject: x86/entry vs kgdb
Message-ID: <20200525083605.GB317569@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Since you seem to care about kgdb, I figured you might want to fix this
before I mark it broken on x86 (we've been considering doing that for a
while).

AFAICT the whole debugreg usage of kgdb-x86_64 is completely hosed; it
doesn't respsect the normal exclusion zones as per arch_build_bp_info().

That is, breakpoints must never be in:

  - in the cpu_entry_area
  - in .entry.text
  - in .noinstr.text
  - in anything else marked NOKPROBE

by not respecting these constraints it is trivial to completely and
utterly hose the machine. The entry rework that is current underway will
explicitly not deal with #DB triggering in any of those places.

