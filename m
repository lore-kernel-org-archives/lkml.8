Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA5FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C766422B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOyAfpar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGTINa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgGTIN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:13:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC93C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:13:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so16896926wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CkY+pR8nEvvyoGCzwyetoIvFB+8wf85iBL4BwWdb0QY=;
        b=QOyAfparPK4/pswN9TyLt4wo+ECAHBz1qejQHZnyNbTMxa+R1EMI5FavIgDFKwwaXZ
         3o6K7vmjlkEE0WO71DvkaXSrKF8r2UaPvmCGaGcMlJ7uKbMDG7Y6NVsUJGrSjWNTWPTo
         stsWstq+531ICwKMgnJyFTB6hRdTFo9M2wJxt12S2Zx7+Ti+J1Y949iRy4zbcP0D8F/I
         YuPGN3WnmJyw6qdSZF/ixNYuhakoF2Etl3dsJDB4scpsORnnni5NckGUPOO/cyWeVz4S
         nctS/x2b9yvECWajFqNvt4GDCMxd2IAqk0fl7g4bE4kGmdy/gAkTuDCZSvu++s1MymcW
         0r2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CkY+pR8nEvvyoGCzwyetoIvFB+8wf85iBL4BwWdb0QY=;
        b=O39Ho/ejmb+DFqc/IwAIQ1Lb/RpYm+1SGMPegkCIjagDeXYpJBAyUx1TKpJXAZVyqv
         hraIzy8+4eROrMbVdNxaaEXNcih2PvoSLBtcdrE9bJUOPFdAv5mUcy2lXCkqUQo1ic0B
         /ONM6xcaU/KCikDjkgMgEO5xtQM3Z5JABVWj1AL8ry7hJDKGJPCVTehos4byeBjf1kGf
         Fe2d/ScJdKgvSjAsTkkVvqjGVnxw8qfoB6WFUhvLFdbJ+psdUx0boSEmeiGu3pEdnKPh
         Z1c7YMJ48eFUdX9dvh5wJn4dHZh8yEBuxf0Yfl+47kwjh7aaVVxNVIcLoyijKHl8CtUQ
         yDsg==
X-Gm-Message-State: AOAM531bcKBHh2TkRnFtPhwftQpNpfdD2rYzwZqoax+eOAQpKNFVQ29X
        oQyPzIoO3PjdUnjHU8DQUENjmA==
X-Google-Smtp-Source: ABdhPJzEcEIHyVwVAFXwN4wddaaeejW5ihXMCoeMsXMuylUnDNPpIrFhlHpgTJyAVNNrlB3nS6ByvA==
X-Received: by 2002:adf:bc54:: with SMTP id a20mr2575534wrh.227.1595232807971;
        Mon, 20 Jul 2020 01:13:27 -0700 (PDT)
Received: from holly.lan (82-132-214-103.dab.02.net. [82.132.214.103])
        by smtp.gmail.com with ESMTPSA id i14sm372585wrc.19.2020.07.20.01.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 01:13:27 -0700 (PDT)
Date:   Mon, 20 Jul 2020 09:13:23 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Subject: Re: [PATCH v2 3/3] kgdb: Add NOKPROBE labels on the trap handler
 functions
Message-ID: <20200720081323.5f3xojhu6v23jgqi@holly.lan>
References: <20200716151943.2167652-1-daniel.thompson@linaro.org>
 <20200716151943.2167652-4-daniel.thompson@linaro.org>
 <CAD=FV=UBMa4pt7Xg2sKXHdjo6tVaQWBQFtT_aoDJ+Xt1HrPD+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UBMa4pt7Xg2sKXHdjo6tVaQWBQFtT_aoDJ+Xt1HrPD+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 03:39:58PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jul 16, 2020 at 8:20 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > Currently kgdb honours the kprobe blocklist but doesn't place its own
> > trap handling code on the list. Add labels to discourage attempting to
> > use kgdb to debug itself.
> >
> > These changes do not make it impossible to provoke recursive trapping
> > since they do not cover all the calls that can be made on kgdb's entry
> > logic. However going much further whilst we are sharing the kprobe
> > blocklist risks reducing the capabilities of kprobe and this would be a
> > bad trade off (especially so given kgdb's users are currently conditioned
> > to avoid recursive traps).
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  kernel/debug/debug_core.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> 
> I could just be missing something, but...
> 
> I understand not adding "NOKPROBE_SYMBOL" to generic kernel functions
> that kgdb happens to call, but I'm not quite sure I understand why all
> of the kdb / kgdb code itself shouldn't be in the blocklist.  I
> certainly don't object to the functions you added to the blocklist, I
> guess I'm must trying to understand why it's a bad idea to add more or
> how you came up with the list of functions that you did.

Relatively early in the trap handler execution (just after we bring the
other CPUs to a halt) all breakpoints are replaced with the original
opcodes. Therefore I only marked up functions that run between the trap
firing and the breakpoints being removed (and also between the
breakpoints being reinstated and trap exit).


Daniel.
