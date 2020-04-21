Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAE6C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCEE2064C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YmAVZL7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgDUPte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725613AbgDUPtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:49:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1596C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tc+1Zvhrc5E4ZPKMO44IV3/GyemQ8Vq5kd2mLOwPuk8=; b=YmAVZL7z1B0USTQ9rkdZflBidj
        9gNrLJEdntrMNmPYPTXFBWx68c7USeYULkYqWakoYi8FVPYiOAD6Kr/pGHAYjyubm2q+a5P34WUtc
        Ab65g4IZTEKpZ3614Je56Kex933tVUa1bk69dy2H0hjNEPWV0b5nLcuuSao/QGmlNegiPAn2bHKdH
        g5/K6m9H1HGvxob4/F9YX7yJc3nu6Po5B2O+dzlGO0CSJhPlObWR9kwn3TdVp7TKkZ4UGrZOhi8Ro
        negdu8cWu3iS+H7f4XKW/VqE32GBvoM6CcljHSOkbkfJI0xD1AqEZmrrWLaOz8TjY8j2diUFuQS5i
        ECtT5smg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQv9O-0003a8-HF; Tue, 21 Apr 2020 15:49:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 362F3300739;
        Tue, 21 Apr 2020 17:49:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2819E2BAC8472; Tue, 21 Apr 2020 17:49:28 +0200 (CEST)
Date:   Tue, 21 Apr 2020 17:49:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     youling257 <youling257@gmail.com>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 14/26] objtool: Optimize read_sections()
Message-ID: <20200421154928.GU20730@hirez.programming.kicks-ass.net>
References: <20200324160924.739153726@infradead.org>
 <20200421144714.12479-1-youling257@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421144714.12479-1-youling257@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 10:47:14PM +0800, youling257 wrote:
> this patch cause 64bit kernel build failed on 32bit userspace, please fix.

You've now spend more time and effort complaining about this than it
would've been to fix it yourself. The fix is absolutely trivial.

Anyway, I have a fix, it'll get there eventually. Excuse me for not
considering 32bit a priority.
