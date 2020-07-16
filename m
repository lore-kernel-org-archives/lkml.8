Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369C9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0569420760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ut5wyw/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgGPME5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGPME5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:04:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CE5C061755;
        Thu, 16 Jul 2020 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0BuPnT5dIJUwk1DzOp3WUgWJceui+ELcaKdkqG2qoDA=; b=Ut5wyw/K9yBsEEGWD4S/s/0YNv
        f3/wbkjCTGcvWnsQ2/8Gt+PHIE48ZQMNuBsWpr69M914EaYQ84ysiywzQ832wgf1j24F5UhhXZ5Mu
        hZtIe/fiVssausGAd13wVdch6tWODcyUsxhQAkSMGjWK5ho5+Nvjfis40JmskjZr23r4N49qFfOaj
        bk0SJ7KuIHvL0c/zEfc+MiCwXWl+lOmdMvzMchpWKPBXeIl7u/lbd8uwRxklzL+nQoSBwLr3hhF22
        3LPIEGhuEX78VldfDQiJ2XVguAAzVnUkWUF6+yQC8gWAyD2fj2yjlqlH9ITCQMby94iC6IdPfEryt
        nKcu3iVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw2d0-0008Bg-9x; Thu, 16 Jul 2020 12:04:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8BCD0300446;
        Thu, 16 Jul 2020 14:04:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C5F02361DC80; Thu, 16 Jul 2020 14:04:40 +0200 (CEST)
Date:   Thu, 16 Jul 2020 14:04:40 +0200
From:   peterz@infradead.org
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-ID: <20200716120440.GD43129@hirez.programming.kicks-ass.net>
References: <b5cd845f-7b5e-af8e-a15d-3ede7e61ced4@physik.fu-berlin.de>
 <0322def7-fc16-c805-8f2b-c88fffce2f1e@physik.fu-berlin.de>
 <2df7ca7f-7e26-c916-b6ac-4ec1913fb8d7@physik.fu-berlin.de>
 <CAMuHMdXjfq=RjJ2doR7XyQMnZUA8ccxKc7_tyUzTX29tpyZojw@mail.gmail.com>
 <20200716094039.GQ10769@hirez.programming.kicks-ass.net>
 <20200716102934.GC43129@hirez.programming.kicks-ass.net>
 <f4fcb2e7-eca3-9a70-8e32-e3bf341b62eb@physik.fu-berlin.de>
 <20200716110146.GB119549@hirez.programming.kicks-ass.net>
 <008b06d4-1edd-1610-2ee1-6ea402d06114@physik.fu-berlin.de>
 <20200716113720.GC119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716113720.GC119549@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 01:37:20PM +0200, peterz@infradead.org wrote:
> $ /opt/cross/bin/sh4-linux-gcc --version
> sh4-linux-gcc (GCC) 10.1.0

$ git checkout origin/master # linus' tree
$ mkdir sh-defconfig
$ make O=sh-defconfig/ ARCH=sh CROSS_COMPILE=/opt/cross/bin/sh4-linux- defconfig # shx3_defconfig
$ make O=sh-defconfig/ ARCH=sh CROSS_COMPILE=/opt/cross/bin/sh4-linux- -j80

insane stream of errors


Help?
