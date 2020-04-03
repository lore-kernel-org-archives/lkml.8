Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182B0C2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25B420787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585899582;
	bh=aLQIBx+ng0U+IFAcYJUVtiKAtHm3e+Qra/NBhpDE9d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ftiZeGCd06h7xWYfcDW+KJHyik85Kbw4945fMawWfY42CWXe3GfWmkpSzU/eZvLuo
	 HtzMoRkwSX0Q17fbUJajk8HMYfgbXg4Du1Wz7wA70eB9kAcbQyzx4zcVu5zuvW20PZ
	 PGphjPaKBQLjJdVccRNu8k5p7GnjnCNHe8NRLfB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390419AbgDCHjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:39:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388121AbgDCHjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:39:41 -0400
Received: from localhost (unknown [49.207.63.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6546120721;
        Fri,  3 Apr 2020 07:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585899580;
        bh=aLQIBx+ng0U+IFAcYJUVtiKAtHm3e+Qra/NBhpDE9d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g1rPiW9VjVGgamlTo7r3W5DVHvvvRSN0obXez0VoHJbLk07Q/8lvJvDA3wZOItehz
         OwU0HXoUIG3j6+F12qjrTGnJeevl4YOk0Pd2XufKEbc+uIwFxz8F4koQNByUPe/wSD
         LTn4YhlETApyk8MVuNbASspD+Sg/Rb02QKvh5fGg=
Date:   Fri, 3 Apr 2020 13:09:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: dmaengine updates for v5.7-rc1
Message-ID: <20200403073931.GO72691@vkoul-mobl>
References: <20200402112500.GJ72691@vkoul-mobl>
 <CAHk-=wi81+9roQMgf7n0YRxJ0rqK3W0ghB3tS3kngSikC7cOig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi81+9roQMgf7n0YRxJ0rqK3W0ghB3tS3kngSikC7cOig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-04-20, 16:28, Linus Torvalds wrote:
> On Thu, Apr 2, 2020 at 4:25 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > Here are the changes for this cycle. SFR has told me that you might see
> > a merge conflict, but I am sure you would be okay with it :)
> 
> It looked trivial enough. That said, it's in the TI_K3_UDMA driver,
> which I can't build. The driver is marked as COMPILE_TEST, but it also
> has
> 
>         depends on TI_SCI_PROTOCOL
>         depends on TI_SCI_INTA_IRQCHIP
> 
> which means that it depends on TI_MESSAGE_MANAGER, which in turn has a
> 
>         depends on ARCH_KEYSTONE || ARCH_K3
> 
> so it may be *marked* for build testing, but it doesn't actually get
> any outside of those builds.
> 
> So I did the resolution that looked trivial, but mistakes happen, and
> I can't even build-test that driver..
> 
> Just a heads-up. It does look like it was _meant_ to be build-tested,
> but that intent didn't work out.
> 
> Adding a COMPILE_TEST option to TI_MESSAGE_MANAGER gets things a bit
> further, but even then it doesn't actually build that driver because
> that TI_SCI_INTA_IRQCHIP dependency needs to be enabled too.
> 
> And that one doesn't even have a question, it's just a plain bool, and
> expects to be selected. Which the arm64 platform does.
> 
> Anyway, to make a long story short: "the COMPILE_TEST marker is a lie".

Well I do agree to your analysis and would request Peter to fix this.

> So somebody should actually test my merge.

Said that, I have aarch64 tool chain and was able to conclude that merge
looks just fine. I have compile tested the ti-udma driver as well whole
of the subsystem

Thanks
-- 
~Vinod
