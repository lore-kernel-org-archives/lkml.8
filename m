Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FD2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C237C20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gAD0zWOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbgFWIj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbgFWIjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:39:24 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FF8C061796;
        Tue, 23 Jun 2020 01:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=FUcYaPjVDKdvDgNAWCH0VBlsZbePqhZn2SLAs+XhAu0=; b=gAD0zWOYV1+jt4nVM7z3Ipgm51
        8evIRze1W8EJ84Zziy4r0WwCuxroavZRpy3Og/W1UjErOpi6RCmIobX3Tzp0kzffSS92hZ8WR7Zg4
        ERPvMDZqZNAAL5Oz52cyutYWBqvlQAyf06hrFtjEQkNtFHKd7gb9jAQdwhR8GY4DlfIO6apmajpsq
        VpoFUEZ4Ub0Po92gBI3L0eKUBXEin+WKsQww5Yk9FWCyVIkpVZ8BtzVNu7yFhsLGCwf3Pqj7rZfme
        8dB7efJJJ4z0/Oa9PxCrzyQNoAtVgmATijrl+3obs5f9ulPN4QuvT38m7AyeP8w6Jbg2JLgnZxXkQ
        US5MHr1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jneS5-0005Rk-Dn; Tue, 23 Jun 2020 08:38:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13B29306E5C;
        Tue, 23 Jun 2020 10:38:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DB18B237095F8; Tue, 23 Jun 2020 10:38:39 +0200 (CEST)
Message-ID: <20200623083645.277342609@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 23 Jun 2020 10:36:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: [PATCH v4 0/8] lockdep: Change IRQ state tracking to use per-cpu variables
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahmed and Sebastian wanted additional lockdep_assert*() macros and ran into
header hell. I figured using per-cpu variables would cure that, and also
ran into header hell, still tracktable though.

By moving the IRQ state into per-cpu variables we remove the dependency on
task_struct.

Patches go on top of anything recent I think, an actual git tree with them
in is (for now) here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/irqstate

Which 0day blessed with 0 build fails.


