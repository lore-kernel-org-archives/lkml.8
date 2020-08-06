Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384D2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7DD221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596743852;
	bh=+VmuM/1u7i3X4Vu/hSmGjplIMQWbQYEg7Tij33ZLEDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZaT4jCXpc/O3OPhEVy+5xtWEPbeAm/HIRO0J4TN0a3cdIgy6E1+tkCbBwtlAJkvL5
	 B929qwQiYXSmVZqqsUhZzphucpwFdo8wpaBejbJ7MxmOhQgf/2LT3v02PbExUCXkIu
	 tbegUR8t3gkvrAyyxzVc/CzFYa037O1robfHUPFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgHFT5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgHFT52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:57:28 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B897CC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:57:28 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v22so31405275qtq.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FCOZIRhvd3ECxrtGqId1ZP0YOYmVDIm1/Jxa7nxwJQE=;
        b=kmKAxtd0R5xtd5UrJA4nBn3Y3xBU0sEQNaIeK846VSdEuH/EVHCsgWQ7m8P0p2ndBq
         681i8D+ofQEmE8WtQCMQeT2uJRF13V9skph1L+7NH05h/v6EplObdgpBI7GZGEyczYdP
         OLxiHhGfszlB36ydgn2ODdwb1THR/DGSQayGdpl7Af0A+5/yiGJF6WpGa6WUeuSNcymn
         jaOILBebxiySjSPned545p1+5uEnvY/1o3qCDltq0cQG0T0GDapp+zQ0nc5lnFunMK1d
         PFNwUtsogJ5XOv+iCAuTz80DdqeBte71GAv4GXujTazfMa8vE0OLc9YdEd1loNNbWEK+
         X02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FCOZIRhvd3ECxrtGqId1ZP0YOYmVDIm1/Jxa7nxwJQE=;
        b=A2Qx/uwcx79Q76O7zB7J24O8vDGadMOVJKFGvXZym7LfEBkj2WtcOHhyolnRdWpI8m
         ziluvD7nAxFBrMQtS8GbXhX70L78zRSVg/HoWLK1fSIo4qgV1Tr7Bs+TjpHhouKiUx2p
         DfUMK+yp0EmIXZHi3Fx3Xkqbo2NjwX+y4GCUvyMWzeCgLfLoOWm/B1n41utZ7YRhMtvZ
         xQTMUAoSwyXD6pyRFjC4Ie0/7DZG1s97UT9L55z9FcuRChdUmqqlpzPBxwJotTMCX3OA
         BIJ9Xldf5sxugy1jI4YNuF7TQ4VEtbNIuYe4quZM7Scppo7u2pEdy9HABLafryu1Y5A3
         skcw==
X-Gm-Message-State: AOAM531iOT9ndZxlkB87QIadu9pvz/h5PfI6xE9nxIaxmRCfwlKwEMXY
        8pSjKFIfIs5DbnBibQFQqYE=
X-Google-Smtp-Source: ABdhPJzNtt5jxhK+32G/3aTp+8cfRJKiz84iuUBNxYQDTlyrpx/Ptr2LlUF8qSd0mlMsOw4KDquILA==
X-Received: by 2002:aed:2f02:: with SMTP id l2mr10786981qtd.48.1596743847866;
        Thu, 06 Aug 2020 12:57:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2e8b])
        by smtp.gmail.com with ESMTPSA id s30sm5693189qtc.87.2020.08.06.12.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:57:27 -0700 (PDT)
Date:   Thu, 6 Aug 2020 15:57:26 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/mm changes for v5.9
Message-ID: <20200806195726.GI4520@mtj.thefacebook.com>
References: <20200803190354.GA1293087@gmail.com>
 <20200805110348.GA108872@zx2c4.com>
 <CAHk-=wiq+7sW3Lk5iQ0-zY5XWES4rSxK505vXsgFY=za88+RZw@mail.gmail.com>
 <20200806131034.GA2067370@gmail.com>
 <20200806185723.GA24304@suse.de>
 <CAHk-=wg7PHCUMD1xY=YCCeVHspAhw0YNEhyO3CnHfRPwsf6P8A@mail.gmail.com>
 <20200806192333.GB24304@suse.de>
 <CAHk-=win5DxMK-MH57NSrA+nVxF60MYR9RyArPX5NW_0yaBpoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=win5DxMK-MH57NSrA+nVxF60MYR9RyArPX5NW_0yaBpoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 12:42:23PM -0700, Linus Torvalds wrote:
> that admittedly odd sequence is get_work_pwq(work)
> 
> And then the faulting instruction is:
> 
> >   2a:* 49 8b 46 08          mov    0x8(%r14),%rax <-- trapping instruction
> 
> and this is the "->wq" dereference.
> 
> So it's the pwq->wq that traps, with 'pwq' being the trapping base
> pointer, and clearly being in the vmalloc space.
> 
> I think pwq may a percpu allocation, so not _directly_ vmalloc().
> Adding Tejun to the cc in case he can clarify ("No, silly Linus, it's
> allocated here..").

Hey, silly Linus, yeap, they're per-cpu allocations and will be in vmalloc
address space for per-cpu workqueues. For unbound workqueues, they're
regular kmallocs. The per-cpu allocation happens in alloc_and_link_pwqs():

  static int alloc_and_link_pwqs(struct workqueue_struct *wq)
  {
          bool highpri = wq->flags & WQ_HIGHPRI;
          int cpu, ret;

          if (!(wq->flags & WQ_UNBOUND)) {
                  wq->cpu_pwqs = alloc_percpu(struct pool_workqueue);
                  if (!wq->cpu_pwqs)
                          return -ENOMEM;

Thanks.

-- 
tejun
