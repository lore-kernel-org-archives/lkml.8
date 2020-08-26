Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09E0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A768C207DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598430166;
	bh=tMISGZM36b6tDxevjrHPUUnvWJiWBP+nHFBD81rP+qY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=S+7Vg2aOTv51vqka01EDKiuf521TPxJTr0kIxYFTEItnM2+vfIZzLgjgWu1nvi8jC
	 vHHdn7EqGkPiCwS9LBlk237Cok4yGwDrL6PjSh/UYtqrAIWWaATYACLNE7czH4LDOE
	 puu7+NIEV1nKYYv/mEtfQaHbcTRV+QG7IHdKvnWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgHZIWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgHZIWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:22:43 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA3D0206FA;
        Wed, 26 Aug 2020 08:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598430163;
        bh=tMISGZM36b6tDxevjrHPUUnvWJiWBP+nHFBD81rP+qY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G79Fe12Y89Eu3aNxs4J3/GULNRuXsKglnE8fSDjN3IrjhnQUuJjR4JJho0h3s9WOt
         mAhRz6Mi/YAjsu6LT3pUiKGdV2oQpe8bZYYMBIx7BfBGebMK9D/qjhzxLzFMag3PhZ
         +0co3rdCfUrk/BmOTOAg5NCQXjxnAIxrSVGZN7zc=
Date:   Wed, 26 Aug 2020 17:22:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-Id: <20200826172239.ff175be78ee5f3a4380579c3@kernel.org>
In-Reply-To: <d3027772a6834f89a1ddc07c0fefaa0a@trendmicro.com>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
        <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
        <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
        <20200825151538.f856d701a34f4e0561a64932@kernel.org>
        <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
        <d3027772a6834f89a1ddc07c0fefaa0a@trendmicro.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 07:07:09 +0000
"Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com> wrote:

> 
> > -----Original Message-----
> > From: peterz@infradead.org <peterz@infradead.org>
> > Sent: Tuesday, August 25, 2020 8:09 PM
> > To: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Eddy Wu (RD-TW) <Eddy_Wu@trendmicro.com>; linux-kernel@vger.kernel.org; x86@kernel.org; David S. Miller
> > <davem@davemloft.net>
> > Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function entry is not optimized (trigger by int3 breakpoint)
> >
> > Surely we can do a lockless list for this. We have llist_add() and
> > llist_del_first() to make a lockless LIFO/stack.
> >
> 
> llist operations require atomic cmpxchg, for some arch doesn't have CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG, in_nmi() check might still needed.
> (HAVE_KRETPROBES && !CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG): arc, arm, csky, mips

Good catch. In those cases, we can add in_nmi() check at arch dependent code.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
