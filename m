Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520C8C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DB220714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XfAKdd2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgCZUgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:36:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgCZUf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2D+2vncTikC9/HnOBtgzamVlSeubBDo21bU7QpehDEU=; b=XfAKdd2ewX7eGSogzSHKnafZ19
        p2fxmxA8QoZUm/OxYsHb/MJsDTWW86X08P8qrCsbDJIUl4biIK739Uzd8U4E3GHBGklJ7cx2JsI5u
        lrszLg4ndJ6jshm1mQgZnnT9KUzGZSdDg3D0xHmsBweY3zLF9fBG7jHUpqIx1XjxgqlvQ3V1nV2t2
        dREO9moY17l75lr/MHOeeM/G4yzBLbFXCmLkWdFhy0tkGQK1SuRxyswxy1tJI2m288IoZhGSWTV+I
        FUw5GVxBzulKyjyOai3ecP/fI4OhDp2U2IAz/yFCyd8SQ7JTuwoxcOPih8FXAIRDAj1ybxVeXXle3
        xdh+TsZQ==;
Received: from [179.97.37.151] (helo=sandy.ghostprotocols.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHZEH-0004si-IE; Thu, 26 Mar 2020 20:35:53 +0000
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 57842169; Thu, 26 Mar 2020 17:35:49 -0300 (BRT)
Date:   Thu, 26 Mar 2020 17:35:49 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mingbo Zhang <whensungoes@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: perf: insn: Tweak opcode map for Intel CET
 instructions
Message-ID: <20200326203549.GD20397@redhat.com>
References: <20200303045033.6137-1-whensungoes@gmail.com>
 <20200326103153.de709903f26fee0918414bd2@kernel.org>
 <bac567dd-9810-4919-365e-b3dfb54a6c4b@intel.com>
 <20200326135547.GA20397@redhat.com>
 <363DA0ED52042842948283D2FC38E4649C72EFF3@IRSMSX106.ger.corp.intel.com>
 <20200326145726.GC6411@kernel.org>
 <20200326150137.GD6411@kernel.org>
 <4a2a3582-21a0-f3fc-102e-42ec67d0aafa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a2a3582-21a0-f3fc-102e-42ec67d0aafa@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 26, 2020 at 07:36:27PM +0200, Adrian Hunter escreveu:
> On 26/03/20 5:01 pm, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Mar 26, 2020 at 11:57:26AM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Thu, Mar 26, 2020 at 02:19:07PM +0000, Hunter, Adrian escreveu:
> >>>>> But they have not yet been applied.
> > 
> >>>>> Sorry for the confusion.
> > 
> >>>> I'll collect them, thanks for pointing this out.
> > 
> >>> The patches are in tip courtesy of Borislav Petkov thank you!
> >  
> >> Ok, thanks Borislav,
> > 
> > I didn't notice because it didn't made into tip/perf/core :-\ In what
> > branch is it btw, I couldn't find any cset with substr summary "Add
> > Control-flow Enforcement" in, tip/master also doesn't have it.
> > 
> > - Arnaldo
> > 
> 
> 
> x86/misc

Right, he told me, thanks,

- Arnaldo
