Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8B4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFADD2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596011754;
	bh=Qa/mUg1r63Osuladkh+ZhPXg7XvkuQp3LIxZHU411us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ROkY2OJzUM+XbdUWCwl24oFZFGou8kfMVIvz5rAE3wdUmvA+3uaZULsB9KnAGi9sT
	 gD1XrwzgL3jQkwSg0KAmDV410zLYBs/FNooV7lWrBKQoJleLovTkNoTZolKjpRA0aK
	 4j4lmpBEv2SMWBcwkC0yU9HZaP6weDHePE2OVeIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgG2Ifx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2Ifx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:35:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F36F2076E;
        Wed, 29 Jul 2020 08:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596011752;
        bh=Qa/mUg1r63Osuladkh+ZhPXg7XvkuQp3LIxZHU411us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gp6DPJcPrsgDnpx3gD2rLVdnULNLsFahGYcbtMpGnFAriq5HEN2f2+4EsKQd1MPa/
         9Cx9J1ulhnul4d+nfxic4P4zkZ7Je59ngVjs4G4G/826+MyZ4cLkoSjR+4i3jIdAFQ
         GTYAXamL0BpfReLI5WH81nIHHnh1GqSiRROwDrDU=
Date:   Wed, 29 Jul 2020 10:35:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH kernel] panic: Dump registers on panic_on_warn
Message-ID: <20200729083543.GA718807@kroah.com>
References: <20200630093846.100531-1-aik@ozlabs.ru>
 <a7d3459b-77f5-a65a-c407-e332d1b921ab@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7d3459b-77f5-a65a-c407-e332d1b921ab@ozlabs.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 06:24:26PM +1000, Alexey Kardashevskiy wrote:
> Ping?
> 
> 
> On 30/06/2020 19:38, Alexey Kardashevskiy wrote:
> > Currently we print stack and registers for ordinary warnings but
> > we do not for panic_on_warn which looks as oversight - panic()
> > will reboot the machine but won't print registers.
> > 
> > This moves printing of registers and modules earlier.
> > 
> > This does not move the stack dumping as panic() dumps it.
> > 
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  kernel/panic.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)

Why did you pick me and Nick as the people to get this patch?

Always use scripts/get_maintainer.pl please, that's what it is there
for...

thanks,

greg k-h
