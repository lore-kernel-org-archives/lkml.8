Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF062C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA552067D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nazpyURC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgG2ODP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgG2OCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:02:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ED3C0619D6;
        Wed, 29 Jul 2020 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PCFNxvadraoI0RmHIkyYHsdFlz3OMuw119AU7TLq6ls=; b=nazpyURCkksK//s2jFqftAaUd5
        kxb55UbjiOc7L/q1ZRu6rGXfdXly63bJzrjmt+BsGrc19eRQSb1rUqzhm/AQLd+LCnEqLoa111AkK
        zgrweqRnRFIq/VRLr7b3DaMA0ncoWS/BROlCmkshF29mIicJxXMnnP1kisYXWTieVNaQW0FQnONTF
        BVRiT4QNz2OhE9CtCMnP4llBbjVknprGy9aP6gu98mj3LrC1WFPa1B5moCwVDvKhxN19AH+uPD1Ep
        7deZw5QxqmnADW/kPjTkS5Pi5eSkDLmxiKIHE4xx7l2cZ3LTYGFCKPep0lGTtIWPX4Cbqn5bvfoMK
        RvOlXNdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0mfC-0001Dl-VE; Wed, 29 Jul 2020 14:02:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38CF2304D58;
        Wed, 29 Jul 2020 16:02:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DE45F29C0D29F; Wed, 29 Jul 2020 16:02:31 +0200 (CEST)
Message-ID: <20200729135249.567415950@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Jul 2020 15:52:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org, will@kernel.org,
        a.darwish@linutronix.de
Cc:     tglx@linutronix.de, paulmck@kernel.org, bigeasy@linutronix.de,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] seqlock: Cleanups
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These are some minor cleanups that go on top of darwi's seqlock patches:

  https://lkml.kernel.org/r/20200720155530.1173732-1-a.darwish@linutronix.de

It's mostly trimming excessive manual repetition and a few naming niggles.

The series has been exposed to 0-day for a while now, so I'm going to push the
lot out to tip/locking/core.

[ 0day found a Sparse bug in it's _Generic() implementation that has since been
  fixed by Luc ]

---
 seqlock.h |  292 +++++++++++++++++---------------------------------------------
 1 file changed, 84 insertions(+), 208 deletions(-)



