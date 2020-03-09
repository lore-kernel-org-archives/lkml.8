Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A6EC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F2320728
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583738111;
	bh=PYnmclPjdflJx/ckSws5nLPRS3ivvG9vPlDVPu/AulY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I0t8Xi/MvtXWpsD1DKYDn6N5kz+SLzvlbYd/EH5k94Tw4M1KoY46WH9mXpCJqSW+l
	 1Q2gc26jFlt9MsOO1+DbxsDcaN5A0QN4K1ZvDycENa4zZ9xhnf+eKFOtuETsXTszKo
	 nT37pCGSuxZGSv9v9X1DreTXEjxBk1FZQEJH9iic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCIHPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCIHPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 03:15:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB2A206D5;
        Mon,  9 Mar 2020 07:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583738109;
        bh=PYnmclPjdflJx/ckSws5nLPRS3ivvG9vPlDVPu/AulY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FlXYlHa6k8OxVGvMbp1cmSjJH0RjCs+MFbG33E9Ov6fGF+ezx0GJdz1S9WwaRvd/t
         AYqJzxvRA3jRVe1zk45D0n4O8PeMA7Ns3SjVkQsz+hHyQc6g3bZwwnW8FFCZP2M1JJ
         PW/02XEa0aVkmXt9ymAyFRv0Z8rjczBd8Li1ALWs=
Date:   Mon, 9 Mar 2020 08:15:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, miguel.ojeda.sandonis@gmail.com,
        willy@haproxy.com, ksenija.stanojevic@gmail.com, arnd@arndb.de,
        mpm@selenic.com, herbert@gondor.apana.org.au,
        jonathan@buzzard.org.uk, benh@kernel.crashing.org,
        davem@davemloft.net, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH RFC 3/3] speakup: misc: Use dynamic minor numbers for
 speakup devices
Message-ID: <20200309071506.GB4095204@kroah.com>
References: <20200309021747.626-1-zhenzhong.duan@gmail.com>
 <20200309021747.626-4-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309021747.626-4-zhenzhong.duan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 10:17:47AM +0800, Zhenzhong Duan wrote:
> Arnd notes in the link:
>    | To clarify: the only numbers that I think should be changed to dynamic
>    | allocation are for drivers/staging/speakup. While this is a fairly old
>    | subsystem, I would expect that it being staging means we can be a
>    | little more progressive with the changes.
> 
> This releases misc device minor numbers 25-27 for dynamic usage.
> 
> Link: https://lore.kernel.org/lkml/20200120221323.GJ15860@mit.edu/t/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> Cc: William Hubbs <w.d.hubbs@gmail.com>
> Cc: Chris Brannon <chris@the-brannons.com>
> Cc: Kirk Reiser <kirk@reisers.ca>
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/speakup/devsynth.c     | 10 +++-------
>  drivers/staging/speakup/speakup_soft.c | 14 +++++++-------
>  2 files changed, 10 insertions(+), 14 deletions(-)

speakup, while being in staging, has been around for a very long time,
so we might break things if we change their minor numbers.

I'd need an ACK from the speakup maintainers/developers before I can
take this as I don't have any way to verify what their systems look
like.

thanks,

greg k-h
