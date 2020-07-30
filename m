Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C63C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CCF20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dw+MzClg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgG3MjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgG3Mi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:38:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48411C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 05:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rtBCsPrEsVh8rA1lJq/04e41kh42/hAxdrTwyG0IX2k=; b=dw+MzClgW/9WsOcOO/xqUGSIEO
        LJysEImn/wx0nddU4E9yw4TXtlEYjP/MS4bJamJ8ujMutGD3bABtEdG6UMip9K4p0jSAZTpDcP1uY
        WQu5XvvkTmpht3AVQ32gES2Vy0scZfRdVuIIZsZtlXBAvDwugoAepGtiUepcomAgMzbyga3vU2Ac6
        P8kE9O5FLk510zevBjK1/sd6YU0T9y86SLU5gzN1p3KqFC9W3Xqsd9BNRUra1KckaRcW8psVNQu0t
        wmJtOYPnXCtaDNpk9i5T1fviPdKeu3Tz+Md8nem3bCVNZO1teiUfZEnniEZVHRtAAlxR3K+E8yfiu
        HrOyG4Ug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k17pj-0004mh-Jr; Thu, 30 Jul 2020 12:38:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3EA2230411F;
        Thu, 30 Jul 2020 14:38:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BC42203D5619; Thu, 30 Jul 2020 14:38:50 +0200 (CEST)
Date:   Thu, 30 Jul 2020 14:38:50 +0200
From:   peterz@infradead.org
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH v2 0/9] Make check implementation arch agnostic
Message-ID: <20200730123850.GK2655@hirez.programming.kicks-ass.net>
References: <20200730094652.28297-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730094652.28297-1-jthierry@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 10:46:43AM +0100, Julien Thierry wrote:

> Julien Thierry (8):
>   objtool: Group headers to check in a single list
>   objtool: Make sync-check consider the target architecture
>   objtool: Move macros describing structures to arch-dependent code
>   objtool: Abstract alternative special case handling
>   objtool: Make relocation in alternative handling arch dependent
>   frame: Only include valid definitions depending on source file type
>   frame: Make unwind hints definitions available to other architectures
>   objtool: Abstract unwind hint reading
> 
> Raphael Gault (1):
>   objtool: Refactor switch-tables code to support other architectures

These look OK to me, Josh?
