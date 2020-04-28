Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FBBC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673E820575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kXsV8HlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgD1Wk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgD1Wk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:40:58 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDCEC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HJdjM6hc/E5y5M8zC0wbxXTzzjSAkyAfUmtMmm1JBag=; b=kXsV8HlThp4SOvMMpYcmP6AX5C
        zTAH51K8oM31QfgjDT8lmDNLisqNBFuBaRx0EvcJbMRaxG21sK+7rKiNYonYNUBBuydXvocRMLrOk
        s8kXHbdGnnkqFgJpH30ENQ6cDBnPvLsrLAuUKkJD2kw0G0Re6TOoN2XvbMvbMESPT/At5grFKCRDn
        WFSSiI/vc+eopDVjtj+c/BBDXWOXsqgDeKMdulei64KHijZB4Bbt5ChyugGU+3q7dP7HXotg9pH04
        2K5GI6apWbE/Pqt78uDJYZMe1HLgAN/1BeG6nw2EUEY8nqfqu25w7Z+XbTzZxaCqgxPcjLb1T6GE3
        g1P/O6Mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTYu5-00046l-Bc; Tue, 28 Apr 2020 22:40:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 285CD300739;
        Wed, 29 Apr 2020 00:40:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 115BA286F1E25; Wed, 29 Apr 2020 00:40:36 +0200 (CEST)
Date:   Wed, 29 Apr 2020 00:40:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] objtool: Fix infinite loop in find_jump_table()
Message-ID: <20200428224035.GD16027@hirez.programming.kicks-ass.net>
References: <378b51c9d9c894dc3294bc460b4b0869e950b7c5.1588110291.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <378b51c9d9c894dc3294bc460b4b0869e950b7c5.1588110291.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 04:45:16PM -0500, Josh Poimboeuf wrote:
> Kristen found a hang in objtool when building with -ffunction-sections.
> 
> It was caused by evergreen_pcie_gen2_enable.cold() being laid out
> immediately before evergreen_pcie_gen2_enable().  Since their "pfunc" is
> always the same, find_jump_table() got into an infinite loop because it
> didn't recognize the boundary between the two functions.
> 
> Fix that with a new prev_insn_same_sym() helper, which doesn't cross
> subfunction boundaries.
> 
> Reported-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
