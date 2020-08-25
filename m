Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C55C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8672076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598365202;
	bh=nPGL9xYuqaBBb6/X96T+G2iHHQlcXKOgwQl9Zw4KiiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NWkmCOjKf/RzPDONH+Hd1O0q+FxvhzyHAsViAugKaRkhA4lfHTjdZMcg/QhH2YJp/
	 Z7ft/wAm2aV1tzyr182s3AUwLj6YGbh2GFIUUC7wdMxvuQ69KxMvbos2NjCjg2nrKX
	 C0ZjWdKk5zVn3FtJICLbxsXn+24oU76YUE8V61iI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgHYOUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgHYOTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:19:53 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8E5A20665;
        Tue, 25 Aug 2020 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598365193;
        bh=nPGL9xYuqaBBb6/X96T+G2iHHQlcXKOgwQl9Zw4KiiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iaGyhMfeaypRkkg78x/TqeTLlP7Ug9P/6t0HcUF9cfvYzoBP7dlbN66BlJsE72aQB
         gFO926LG+A8j/n10vj3d0q/2v1qBwP4BUaEmAskeXMfYxMKbrzxuSfchirsFuq6tlR
         gCF5x45zyVZZ/smvKsF3jkxon6a5fGyDqd50Z6Hw=
Date:   Tue, 25 Aug 2020 23:19:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-Id: <20200825231950.cd193c13ecf7dcf60232b897@kernel.org>
In-Reply-To: <20200825141058.GZ1362448@hirez.programming.kicks-ass.net>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
        <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
        <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
        <20200825151538.f856d701a34f4e0561a64932@kernel.org>
        <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
        <20200825221555.a2d72c9754284feced6a8536@kernel.org>
        <20200825133005.GY1362448@hirez.programming.kicks-ass.net>
        <20200825141058.GZ1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 16:10:58 +0200
peterz@infradead.org wrote:

> On Tue, Aug 25, 2020 at 03:30:05PM +0200, peterz@infradead.org wrote:
> > On Tue, Aug 25, 2020 at 10:15:55PM +0900, Masami Hiramatsu wrote:
> 
> > > OK, this looks good to me too.
> > > I'll make a series to rewrite kretprobe based on this patch, OK?
> > 
> > Please, I'll send the fix along when I have it.
> 
> One approach that I think might work nicely is trying to pull
> trampoline_handler() into core code (with a few arch helpers). Then we
> can replace that loop once, instead of having to go fix each
> architectures one by one.

Yes, that is what I'm trying (I had done it, but lost the code... let's do it again)

Thank you,

> 
> They're all basically the same loop after all.


-- 
Masami Hiramatsu <mhiramat@kernel.org>
