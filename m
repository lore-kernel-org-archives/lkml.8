Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CAFC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF6920409
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dLIg8xxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgCUPOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:14:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55368 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgCUPOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IXI6gjSBhjEOorXVnv0nFFyqDbDrL/5AwtHbgiSQ0Cw=; b=dLIg8xxlkvvwwHzp+GbfWiqht0
        3QnDvpsrRdOZ5mnQNENVknrlHnOoydabiFuuPsYZMG7c8u47a8DyMx4nyEkUSJ50cRJIdbfD4rPnT
        HIC7wYOnTWtnFP17+xfM6j3o2R2aeEXpJe9eoxm8CY2l4/JhCgcyjiuePtFyfuIbtD4aGAM/T/G8L
        Nm7RPLab8lw992GmtbgI8h9ZrL9CqkNz0TkbrK2wOxEOePqrMxiCtoQXrd6M95OdVP0RtO06FI1Ff
        ew0iEn85hmyVFVbskMLTrS6U98+R18puflqOdmXmeTPypnfjyMo+/MC3t4KgLCocaBJFVpfA/8gUk
        n94y96qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFfpQ-00039q-Dd; Sat, 21 Mar 2020 15:14:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C186983502; Sat, 21 Mar 2020 16:14:21 +0100 (CET)
Date:   Sat, 21 Mar 2020 16:14:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        brgerst@gmail.com
Subject: Re: [PATCH v2 17/19] objtool: Optimize !vmlinux.o again
Message-ID: <20200321151421.GD2452@worktop.programming.kicks-ass.net>
References: <20200317170234.897520633@infradead.org>
 <20200317170910.819744197@infradead.org>
 <20200318132025.GH20730@hirez.programming.kicks-ass.net>
 <alpine.LSU.2.21.2003201719200.21240@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2003201719200.21240@pobox.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 05:20:47PM +0100, Miroslav Benes wrote:

> I think there is one more missing in create_orc_entry().

I'm thikning you're quite right about that.... lemme see what to do
about that.
