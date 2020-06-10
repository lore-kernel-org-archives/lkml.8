Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260B4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E799C20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WAs0ZPp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgFJMcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 08:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgFJMcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:32:50 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3285AC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5o09axm2r9rIH7znUCDLHPlwkpxXzMT5u+8PhF6S94w=; b=WAs0ZPp1V1hryQHcMpUOPKNOqq
        N2jUhScQ2Bd0WBjja1RX0xCTAIUbA5CkG9y3sDLiqKWSp9tfm2wzsgRmhS6XObhIZqylaLxe4wprB
        CJobSB6ZREMQZS/EZE0sutrqzRMd32g8umnb5ctNyN0SHdBX16hgtFpde/A95PImUee+Uj3UmHunQ
        goOpOinXXh1e1nPwu6PcIFaypdmh8C0D3wgy4lyGbS7owrs2J1TJlDzsp89NJ0qvfi+FLkeU+etrt
        VanhLR//hrYd9ALTDsPFf4YB/QpwHbh4sf9CNwj+QPCA2uQscAco4dck7PbyCvmJhGFBu3gRVJqIu
        qXLno40g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jizu9-0005Wl-L6; Wed, 10 Jun 2020 12:32:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB7C83012C3;
        Wed, 10 Jun 2020 14:32:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C1E6203EE225; Wed, 10 Jun 2020 14:32:26 +0200 (CEST)
Date:   Wed, 10 Jun 2020 14:32:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Morton <Eric.Morton@amd.com>
Subject: Re: [PATCH 3/3] x86/msr: Add an MSR write callback
Message-ID: <20200610123226.GC2497@hirez.programming.kicks-ass.net>
References: <20200610110037.11853-1-bp@alien8.de>
 <20200610110037.11853-4-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610110037.11853-4-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:00:37PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Add a callback which gets executed after a MSR is written from
> userspace. This is needed because in the case of AMD's MSR_AMD64_LS_CFG
> MSR which gets cached in the kernel, the cached value needs to be
> updated after the write, otherwise latter doesn't stick.

We cache a whole bunch of MSRs in kernel. Why is this one special?

If you write using the stupid msr device, you get to keep all pieces.
