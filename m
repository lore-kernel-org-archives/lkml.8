Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137DFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E26DC206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="blC/DwwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgFEOaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgFEOaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:30:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65F0C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dQozpauM+B1HUAZG/afzEGekuT2pBrCyXAH6b1RYzE4=; b=blC/DwwD+vyB/QngYMRyJPdJ8C
        V/5m7Ky94t+nyRbIDIUeFa8RemAN6Mv0NKXuzcOm12jCNeumPX6PkLdSHeSP/NPKSPbnFV9EX1baf
        I72TSiScqkQ9b9vjFRdJpJT6f5YNVARLIhUOBFxffwVktD3uuTWKh5RuI1Q38xM4adem6gu3oR5h7
        RhlAwEXeObcvsurFcBwrW//vfTvnYtor7Ynf0pPc+WpHe7WXyZ5RCIQMIN+HnMVPDIfHEoUCRvMNA
        qikHKMuyXY6kzMnKyvtPZpClw+6YTt2EkljoptEuZtzZ0FyxFx2aUJSHprjZMfl+pus1CxJ7FR7En
        9CQA/zgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhDM2-0001lD-Vx; Fri, 05 Jun 2020 14:29:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E14E304BDF;
        Fri,  5 Jun 2020 16:29:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0FD4621A74B3C; Fri,  5 Jun 2020 16:29:53 +0200 (CEST)
Date:   Fri, 5 Jun 2020 16:29:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        sumit.garg@linaro.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, will@kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 0/4] kgdb: Honour the kprobe blacklist when setting
 breakpoints
Message-ID: <20200605142953.GP2750@hirez.programming.kicks-ass.net>
References: <20200605132130.1411255-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605132130.1411255-1-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 02:21:26PM +0100, Daniel Thompson wrote:
> kgdb has traditionally adopted a no safety rails approach to breakpoint
> placement. If the debugger is commanded to place a breakpoint at an
> address then it will do so even if that breakpoint results in kgdb
> becoming inoperable.
> 
> A stop-the-world debugger with memory peek/poke does intrinsically
> provide its operator with the means to hose their system in all manner
> of exciting ways (not least because stopping-the-world is already a DoS
> attack ;-) ) but the current no safety rail approach is not easy to
> defend, especially given kprobes provides us with plenty of machinery to
> mark parts of the kernel where breakpointing is discouraged.
> 
> This patchset introduces some safety rails by using the existing
> kprobes infrastructure. It does not cover all locations where
> breakpoints can cause trouble but it will definitely block off several
> avenues, including the architecture specific parts that are handled by
> arch_within_kprobe_blacklist().
> 
> This patch is an RFC because:
> 
> 1. My workstation is still chugging through the compile testing.
> 
> 2. Patch 4 needs more runtime testing.
> 
> 3. The code to extract the kprobe blacklist code (patch 4 again) needs
>    more review especially for its impact on arch specific code.
> 
> To be clear I do plan to do the detailed review of the kprobe blacklist
> stuff but would like to check the direction of travel first since the
> change is already surprisingly big and maybe there's a better way to
> organise things.

Thanks for doing these patches, esp 1-3 look very good to me.

I've taken the liberty to bounce the entire set to Masami-San, who is
the kprobes maintainer for comments as well.
