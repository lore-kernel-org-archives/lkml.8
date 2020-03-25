Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ADBC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84FD2074D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hpKyr6kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgCYRrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:47:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58362 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYRrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=eVNvwVJQBlEZzfJXg4Z7qLVAlQDZSb9x/PxITKasAU8=; b=hpKyr6kdav8figazrMeAdXaHl5
        3E9975mKw524ZM/z1HG8Tvk/Cs4r8DBJzkCmGld3oAMZ50l90ZEH9iungFEvRDjhWEbhgoKMV+sLw
        Q4+5zo3s1XG8fiC33NSVbRL8aGqb5zqZ8Tqa1Q8SKnnSLbCDhtJQElmpowK9ZuAlh2jWVVN6XyjHq
        32tOD8S4fTwYm9mMerFsDGJjixfGpgiwO9Fmm8k/L90uR7CDZQ2X9Cne9iKpej2deNuJ8RQBbeWkN
        XdDBDK2izHaIZdD53y3DTslCn55yYa7oY3BpYRX0UIVp9lwknXhJY+5ZRi+fZxGkX8HJHAnn6pc+n
        nJ3Zggig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHA80-0003oU-8O; Wed, 25 Mar 2020 17:47:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF9223007F2;
        Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9EF6829BD8A27; Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Message-Id: <20200325174525.772641599@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 25 Mar 2020 18:45:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: [PATCH v4 00/13] objtool: vmlinux.o and moinstr validation
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This lacks the first 17 patches of the v3 posting which are en-route to
tip/core/objtool and should show up there somewhere later this evening.

As should be familiar by now; these patches implement the noinstr
(no-instrument) validation in objtool as requested by Thomas, to ensure
critical code (entry for now, idle later) run no unexpected code.

Functions are marked with: noinstr, which implies notrace, noinline and sticks
things in the .noinstr.text section. Such functions can then use instr_begin()
and instr_end() to allow calls to code outside of this section in sanctioned
areas.




