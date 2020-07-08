Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5A1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A165E206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fhWKxJO8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+TUlVf4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgGHTxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:53:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53396 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgGHTxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:53:39 -0400
Message-Id: <20200708195153.746357686@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594238017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=bNyLQ2pLAkRr83wZdq7rI6euSlnFR18flvxonxI4IPc=;
        b=fhWKxJO8AJQIGkBtx+zEZWMkxgE/gBzC2xEQWs1RGdbiGYNp8jTuTPdpwriTNdrii0praZ
        v6n/lTO2qEoXA/Camh+240xiDe/KsNE6bu27ldaCBDkY+Dfa7yHNYtouca5ujyAxbnM8gn
        dpaBNkwsWsnh3n75n0iCr8OIIUGOLvz8oN2XS42rmuJ5oTb65rLqUz9DLHwwSXqK1ooQLS
        Tl4KAi48kLeWWIIqV1ntRez1wboFVHWKTlEPAubbiDtTk6sjwhPvhX4/ysTV6RB9tfQOgA
        eCjuyKIeFQbIXpLKggzIEe7Gj8njkYeRjWf9dg3Ds6DybIJIlKKP3V/rS/rB4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594238017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=bNyLQ2pLAkRr83wZdq7rI6euSlnFR18flvxonxI4IPc=;
        b=+TUlVf4VktQeA7sSpjob2JKU4jDcApGvCeiZy1Ij6W47C62fLXBTy38rkYesfBN67HIqC7
        q7VvxLowuX7asaAg==
Date:   Wed, 08 Jul 2020 21:51:53 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        kvm@vger.kernel.org,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>
Subject: [patch V2 0/7] x86/kvm: RCU/context tracking and instrumentation protections
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

this is a rebased and adopted version of the original series which is
available here:

     https://lore.kernel.org/r/20200519203128.773151484@linutronix.de
 
It deals with the RCU and context tracking state and the protection against
instrumentation in sensitive places:

  - Placing the guest_enter/exit() calls at the correct place

  - Moving the sensitive VMENTER/EXIT code into the non-instrumentable code
    section.

  - Fixup the tracing code to comply with the non-instrumentation rules

  - Use native functions to access CR2 and the GS base MSR in the critical
    code pathes to prevent them from being instrumented.

Thanks,

	tglx
