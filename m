Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965E2C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA2320767
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586788151;
	bh=wCBcKibZmzQckIP611Z7JTeaw6ivaoQWmBaFnERJuf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=04jwGA+Cs55L+ngV2FX7Ju/07ppQpmwbUSm2uUjj1NGlOlN85SlyAPkWnmtGYrsKf
	 8tYCQVJeMo3TLuBJ15lUEyD56f/aVo0uaw2MjgAsfUooYxGFeMHivlgpv4wCIqkAHa
	 aqcWQSxW1m9kEeDGBJ4njUc+zLBBciVjOXFwNXfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgDMO3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:29:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbgDMO3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:29:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5E4C2073E;
        Mon, 13 Apr 2020 14:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586788149;
        bh=wCBcKibZmzQckIP611Z7JTeaw6ivaoQWmBaFnERJuf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7xmcBDqKbj3fLb/0NyLZL9NMu5wV1nVmQX50l3w78UG0qVSMq86CL9by8sxAerrs
         tK77TUcwb7KlhLNfiSUh1Mk6xPPDRPdvYVBtIAd4DHSkxdA1SXEvHdcPWCo5MzUYrS
         K+d9iSCFLOtyOwjf2Xp2Q23ISQTnCHBvwO0voBEE=
Date:   Mon, 13 Apr 2020 16:29:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Forest Bond <forest@alittletooquiet.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 1/2] staging: vt6656: Use define instead of magic
 number for tx_rate
Message-ID: <20200413142907.GA3548777@kroah.com>
References: <20200407163915.7491-1-oscar.carter@gmx.com>
 <20200407163915.7491-2-oscar.carter@gmx.com>
 <20200413125633.GB3127208@kroah.com>
 <20200413141315.GA3101@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413141315.GA3101@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 04:13:15PM +0200, Oscar Carter wrote:
> On Mon, Apr 13, 2020 at 02:56:33PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Apr 07, 2020 at 06:39:14PM +0200, Oscar Carter wrote:
> > > Use the define RATE_11M present in the file "device.h" instead of the
> > > magic number 3. So the code is more clear.
> > >
> > > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > > ---
> > >  drivers/staging/vt6656/baseband.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > This patch did not apply to my tree, please rebase and resend.
> >
> I need to rebase only this patch for this serie so, it's necessary to send all
> the serie or only this patch?

If I applied the other one, just this patch.

> If it's only this patch I need to indicate v4 in the subject or a v2 due it's
> related only with this patch?

As so many of your patches were rejected because of this, rebase them
all, and resend them all as a single patch series, so that I know what
order to apply them in and have a chance to get it right :)

thanks,

greg k-h
