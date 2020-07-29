Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7C9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B87220672
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ72dvnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbgG2CEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgG2CEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 22:04:00 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8F1C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 19:04:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k4so11061306pld.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 19:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=opm5/07OD3J2p/0n+7i7LzhKbmftCJUmIROWDMPvtU4=;
        b=KQ72dvnDALPU5r/omXmjdtZI2XRViO+8jLujYN8p1OScazfUGU7iVn84MKvhxWdR2X
         /QlikExYwVM9nSbPHOa6/fmtXlYXXOpn69tvZE/2cng2+Yto3ke8d/yfsmlL7ZJMi7TY
         S3x7Xrj99aYdBZDGwD+hFBmGGfPoYLaNvRQLaVejUc0K7v0okGraPCGZBvbVaV/revk1
         wpCJWHjQHO2ad/cyQ8oUDVxr9x/C2PFNcf3fwuJm6pEnqaOETaa0P/zL+A09z6BdJFiG
         XS7Wl0XILYkRpZr2PkT10IPXVyjjGMN1CNKZ9Punu9fRxt5LKMbGRuM9hRBp2odHNHAG
         /NPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=opm5/07OD3J2p/0n+7i7LzhKbmftCJUmIROWDMPvtU4=;
        b=L+eUkJmth5Ehg2XqmmJYT0HFS7UpDYeDr7ttDg0dAUnCFpAiYmeMs6DrwWSDY58Ks3
         B4HAHtUu3dd4OaQiPiwaaJECW96JQxFNCfbDSJs7eliNBiGId5K9bt0u6o+OheU2g1MZ
         L4G6S+JhNPWVt4J43uDobY4kgatUMQ54mNWgJQfoid96f/UgBvMiY9sjMCoBj6P2/Gwh
         sEC/MBZxMv3NKwuICdbfHkeUxkwPRoYxPifhP+J20cvwqTQ0luYtJWjDCHm8qR1ikhEr
         h81qyINL5PwQT8a3kFHkOEGWYhf/B3dOVNrEZctffebP48AQoimK2cwpqBsZ3R2HsAck
         +qqw==
X-Gm-Message-State: AOAM533h7NPO5PatWgRDUgHwVPDa/n97StDq/q0LouRQCV/2bbeCRlLp
        JVJjGzKxtDghK83MGwPTthM=
X-Google-Smtp-Source: ABdhPJzfqV6zX0OF8YTJPMPc+QE9i+TUzyTtuShT2IGRvxssqK3wFB5dF5s6Ru/Dfve74pIFmvrHxA==
X-Received: by 2002:a17:90a:9f4a:: with SMTP id q10mr7309395pjv.139.1595988239749;
        Tue, 28 Jul 2020 19:03:59 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id lt17sm401897pjb.6.2020.07.28.19.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 19:03:56 -0700 (PDT)
Date:   Wed, 29 Jul 2020 11:03:55 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
Message-ID: <20200729020355.GA1534750@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de>
 <20200719143527.GA566@jagdpanzerIV.localdomain>
 <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
 <20200720015057.GA463@jagdpanzerIV.localdomain>
 <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
 <20200721144220.GE44523@jagdpanzerIV.localdomain>
 <87ft9kx6er.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft9kx6er.fsf@jogness.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/21 17:03), John Ogness wrote:
> On 2020-07-21, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> >> That said, we have traditionally used not just "current process", but
> >> also "last irq-level" as the context information, so I do think it
> >> would be good to continue to do that.
> >
> > OK, so basically, extending printk_caller_id() so that for IRQ/NMI
> > we will have more info than just "0x80000000 + raw_smp_processor_id()".
> 
> If bit31 is set, the upper 8 bits could specify what the lower 24 bits
> represent. That would give some freedom for the future.
> 
> For example:
> 
> 0x80 = cpu id (generic context)
> 0x81 = interrupt number
> 0x82 = cpu id (nmi context)

Looks good to me. I'd probably add in_softirq state. So the contexts
are: in_task, in_softirq, in_irq, in_nmi

For the purpose of future extensions, I would probably consider
u64 for callerid. So that we can store more "state bits" in the future,
like disabled/enabled preemption; disabled/enabled local irqs; etc.

	-ss
