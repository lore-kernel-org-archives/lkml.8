Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC24C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921D020823
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591693821;
	bh=jg4Sceh5hpjDtXW97go+X5pjTXtCfIonvB5PlysaFmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zBGKGZ9x5qrc3o+nOdeg1jq/HYU40Xq0S7OpSAHeYBkY29Vx7PMcr3Lt39J/rfdY7
	 Lw8bok3GfDdy8CFHVa9CQZNSsXA+E5btPW+hTyOhMTDCJXrkZzzf1JvrCvfj2adPuI
	 PgNmfxjKufPJ6F8JJO6RcXwcAH3a21S4utnmwh8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgFIJKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 05:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbgFIJKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:10:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56FE6207ED;
        Tue,  9 Jun 2020 09:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591693817;
        bh=jg4Sceh5hpjDtXW97go+X5pjTXtCfIonvB5PlysaFmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yF68NvEoUOLFG10VEqoVlctNb2zPaHIS3uYK9qOs32HdE9TumoEuZfMOGe6elJ5g6
         EvnGGXULdPaDJZDBb31m2cNI9nqsRONsJcb/Uu1vF9dHUBcuHA6WQQ4D6+HSTYD+oE
         i00blYKiJ3NCDEfpRkHaxBDWmI4bzOgbv5t234BE=
Date:   Tue, 9 Jun 2020 11:10:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>
Subject: Re: [PATCH] exfat: Fix use after free in exfat_load_upcase_table()
Message-ID: <20200609091014.GA529192@kroah.com>
References: <9b9272fb-b265-010b-0696-4c0579abd841@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b9272fb-b265-010b-0696-4c0579abd841@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 05:07:33PM +0200, Markus Elfring wrote:
> > This code calls brelse(bh) and then dereferences "bh" on the next line
> > resulting in a possible use after free.
> 
> There is an unfortunate function call sequence.
> 
> 
> > The brelse() should just be moved down a line.
> 
> How do you think about a wording variant like the following?
> 
>    Thus move a call of the function “brelse” one line down.
> 
> 
> Would you like to omit a word from the patch subject so that
> a typo will be avoided there?

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
