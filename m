Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D97C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80092078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XcGGBpzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389314AbgDBSaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:30:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44820 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbgDBSaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+vHpnh+0rTYDAtzNZlna39evBB1KMMkLlfqwjsGL1T4=; b=XcGGBpzXgl87o1ccUDhAvZXsMw
        8m/sOy6cibb8zHhDSYk5iiZpDeTN3NzvtCwnsmIPIBJhcHPm/a1jHZlXbflXJ3pWLF5B8jXCOhmRC
        /JvGnM+PvcDp2voVTXPWfrKWK0dKP0wcWAWQibqrukLYcMpW9MX3IRlBIzLxb0/7THoeVdivmDgAr
        DXCFEpREcnTPkq4ZrReCYlulNvPLL137o35YUty8a1XpimR+5BYL1kfZAoJ452SP6dLdcuEYDiO+L
        OUmduwKkS6Y2SrXnsevpE/qS+ZlCgSWFO4vsza2O36aoFXECcWoKkFl2/JKSKxKu8f3fw3uDlvnEe
        YrOpqUJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK4bN-0001ja-Qg; Thu, 02 Apr 2020 18:30:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92F58305E45;
        Thu,  2 Apr 2020 20:30:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E1A52B120949; Thu,  2 Apr 2020 20:30:04 +0200 (CEST)
Date:   Thu, 2 Apr 2020 20:30:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        raphael.gault@arm.com
Subject: Re: [PATCH v2 00/10] Objtool updates for easier portability
Message-ID: <20200402183004.GJ20730@hirez.programming.kicks-ass.net>
References: <20200327152847.15294-1-jthierry@redhat.com>
 <20200402175827.kk7su6mo42aa6bh5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402175827.kk7su6mo42aa6bh5@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 12:58:27PM -0500, Josh Poimboeuf wrote:
> On Fri, Mar 27, 2020 at 03:28:37PM +0000, Julien Thierry wrote:
> > Hi,
> > 
> > This patchset includes some of the least controversial changes that
> > were needed as part of the arm64 port [1].
> > 
> > I'm resending these rebase on top of linux-tip/core/objtool, following
> > the addition of Peter's patches [2]
> > 
> > It consist mostly of small fixes or lifting some limitations to make it
> > easier to support a new architecture in objtool. Of course, these will
> > not be the only required changes, but these are the ones I hope make
> > enough sense to be merged separately from the rest of arm64 port series.
> > 
> > Changes since v1[3]:
> > - Really just rebased things
> > 
> > [1] https://lkml.org/lkml/2020/1/9/643
> > [2] https://lkml.org/lkml/2020/3/25/807
> > [3] https://www.spinics.net/lists/kernel/msg3453718.html
> > 
> > Thanks,
> > 
> > Julien
> 
> I'm taking everything except 5, 7, and 10.  I'll run them through
> testing and then send them along to the tip maintainers.  Thanks!

For that set:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

