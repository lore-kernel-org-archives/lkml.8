Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4779C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0E7208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PJXffpYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgCXQNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:13:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36914 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgCXQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=V/b/+GbUgkpoqF72DeJ/pFihwPzjLqrTR4pRp62XKN8=; b=PJXffpYx1HtEf73MgshavraNmS
        6HFp89R/TgfT5YqlKb6gNFzET3MqQJgWQmUnXX9sd5tq989iwnx/AWpYfs9z2kx0SUWYGacQzqJch
        YHgWah65DtAEopIIvZOSQgiNx9YFw/29NW7CwzV+LgbCBRz/AbhEndF18WJTe8/kVVL9PyCnV8B3J
        gzxbjeR95Y8zDCgQWWpipuSR8r+30/cvbU6dRBaB+wR+k7Hd2Kyh8YaeBL6gEwO7rMBhCynu6rgRS
        NL9sF7KM1peah9iWRMTw2SiIY8LAqH7BdZMd0tEBFrwccxlnG/VqHxPkERqa0fy5+S8CT+qyqRL71
        LXT0E6zA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9J-0006bN-Oc; Tue, 24 Mar 2020 16:11:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2CB3C300606;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 158AD29A490F0; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324153113.098167666@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 00/26] objtool: vmlinux.o and noinstr validation
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Once more, more patches... up 7 from last time.

As should be familiar by now; these patches implement the noinstr
(no-instrument) validation in objtool as requested by Thomas, to ensure
critical code (entry for now, idle later) run no unexpected code.

Functions are marked with: noinstr, which implies notrace, noinline and sticks
things in the .noinstr.text section. Such functions can then use instr_begin()
and instr_end() to allow calls to code outside of this section in sanctioned
areas.

Since a RELA does not include section information, we need to run objtool on
a vmlinux.o which includes all relevant functions; so the first 'few' patches
optimize objtool to allow running on vmlinux.o.

This all is starting to look good and barring any show-stoppers the plan is to
get this merged soonish. There's one wobbly in patch 18, Josh any
suggestions -- all I could come up with was ugleh.


