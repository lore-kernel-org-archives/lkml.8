Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6F5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D0D20665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jiUck+ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgHYOLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYOLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:11:07 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681F1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=INfPDuBEQjuK5krf1yIfiQ/ZIRrfrYzboKUxI06QpW4=; b=jiUck+agvbnD0b3KBAvuaQJr7j
        YwD5yUrhIMvSvcghlJTopYjPYK5cuihbrnXWQc3uW/6fX3XGRKXlUjQc+Q6sOy3dXmv3pgbhBFN4+
        n3Xyy7g7dzYgPWg5XWN2vCZj8mfJ1nql/c0N0O2DkM3OAKT18qxr7eE0k4kVyHqsla3RrrQnv2LF1
        pAzJtfAyn7PVPGjsxLoaDUFMffcuQpTmPk92oZT0x7YxK5tSjKuz44dfjOqNDmZ5CKOfKTn8zhIVw
        6FO5SujhsBEMtX4tpNbsJD9jgxqiYjYzto1+4zKWMs543uV0nzjHw9X04QFvD9MaMTo4ew2ZKPWBg
        Ktp0b6HA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAZfA-0003FU-93; Tue, 25 Aug 2020 14:11:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00D9330280E;
        Tue, 25 Aug 2020 16:10:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AEF0629E76F4B; Tue, 25 Aug 2020 16:10:58 +0200 (CEST)
Date:   Tue, 25 Aug 2020 16:10:58 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-ID: <20200825141058.GZ1362448@hirez.programming.kicks-ass.net>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
 <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
 <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
 <20200825151538.f856d701a34f4e0561a64932@kernel.org>
 <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
 <20200825221555.a2d72c9754284feced6a8536@kernel.org>
 <20200825133005.GY1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825133005.GY1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 03:30:05PM +0200, peterz@infradead.org wrote:
> On Tue, Aug 25, 2020 at 10:15:55PM +0900, Masami Hiramatsu wrote:

> > OK, this looks good to me too.
> > I'll make a series to rewrite kretprobe based on this patch, OK?
> 
> Please, I'll send the fix along when I have it.

One approach that I think might work nicely is trying to pull
trampoline_handler() into core code (with a few arch helpers). Then we
can replace that loop once, instead of having to go fix each
architectures one by one.

They're all basically the same loop after all.
