Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE15C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C7D206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393767AbgFWVfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388793AbgFWVfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:35:50 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5639AC061573;
        Tue, 23 Jun 2020 14:35:50 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E5E4E129428AF;
        Tue, 23 Jun 2020 14:35:47 -0700 (PDT)
Date:   Tue, 23 Jun 2020 14:35:47 -0700 (PDT)
Message-Id: <20200623.143547.611766403397972374.davem@davemloft.net>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, sparclinux@vger.kernel.org,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org,
        linux@armlinux.org.uk
Subject: Re: [PATCH v4 3/8] sparc64: Fix asm/percpu.h build error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200623083721.277992771@infradead.org>
References: <20200623083645.277342609@infradead.org>
        <20200623083721.277992771@infradead.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Jun 2020 14:35:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 23 Jun 2020 10:36:48 +0200

> In order to break a header dependency between lockdep and task_struct,
> I need per-cpu stuff from lockdep.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: David S. Miller <davem@davemloft.net>
