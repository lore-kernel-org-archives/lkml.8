Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4044C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8422E20756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y3pICMW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgETM32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETM32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:29:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28674C061A0E;
        Wed, 20 May 2020 05:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q4DUpChN4qJpLF/i/QXJs3kgt+zVdTAZ3fvdiiTDP9g=; b=Y3pICMW9DsoZq58jIVqAYZN07V
        06G3u3zd2aOXPaBAnj4oW+UGfibaE/6pyHd0McCJNPFJAaARwzKLqVaQhF2eUnuSdeAprWcm/3uZ3
        KQMXHhFQEZPaoVXRAc4Hed0BZU7ojNbBQMH0UUOotAS+WotBmcVrgv8JC//cUTuIdCRH2oEsC07Ie
        F5N08WCDGyVlFBpDML5JbfBwMtgtKP4ai4jHBTyKlAkSAfnlQ2dhwO19fWybIqhgeK3BAF2jctdFo
        x6wKZ8lD/j+JBOJk2RG8UKhMzTD6FhdAFuJBakPWV6A3fBrup8x8QMNbu2aDg2rYHImVEbT9WCPcp
        LOMiLZXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbNqd-0004ER-CF; Wed, 20 May 2020 12:29:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 095CB300478;
        Wed, 20 May 2020 14:29:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F17DA25E3797A; Wed, 20 May 2020 14:29:20 +0200 (CEST)
Date:   Wed, 20 May 2020 14:29:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/29] modpost: add read_text_file() and get_line()
 helpers
Message-ID: <20200520122920.GB325280@hirez.programming.kicks-ass.net>
References: <20200517094859.2376211-1-masahiroy@kernel.org>
 <20200517094859.2376211-4-masahiroy@kernel.org>
 <20200519102133.GA279905@hirez.programming.kicks-ass.net>
 <CAK7LNARkUkdRsW0D5cc5cEtXFJfnKhiVuZvrD6T1Xg3sr9kv=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARkUkdRsW0D5cc5cEtXFJfnKhiVuZvrD6T1Xg3sr9kv=A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 09:17:45PM +0900, Masahiro Yamada wrote:

> The specification [1] says this:
> 
> "The value returned may be less than nbyte if the number of bytes
> left in the file is less than nbyte, if the read() request was
> interrupted by a signal, or if the file is a pipe or FIFO or
> special file and has fewer than nbyte bytes immediately available
> for reading."
> 
> 
> This case does not meet any of 'if ...' parts.

So nobody ever ^Z's their build? I really don't think you can assume
that you'll never get a signal. That's just asking for trouble.

Doing the right thing here is 'trivial', there is absolutely no reason
to not do it.
