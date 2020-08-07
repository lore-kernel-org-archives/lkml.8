Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57F2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BCC220866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596787492;
	bh=PE3k/C4w0OpdhoKq/qH5cL2MHvqVFxiNXKGphsCSR3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kwkSkehfrXq2MNcZdAQ7mls8fkPzNTw0Z8rG2GkcmsSIK92Qj4USBukK6bpCWFoQr
	 5Mme9aKJnkzS/GUKs3tClrNrgOrp4cAZ+ayDw5jYLRn+pOwVsJc411xz9wBvAioaXQ
	 dSj34uE0Cm+aktKDSecmfpHHvJN0jrRZcEcaT+vE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHGIEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHGIEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:04:50 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF2E920866;
        Fri,  7 Aug 2020 08:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596787490;
        bh=PE3k/C4w0OpdhoKq/qH5cL2MHvqVFxiNXKGphsCSR3I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GMWiDkuPkCo8gphXIDxriyWGWPFKzP6ZFxOHSo9w0dCBmJ/iPiH1ORwkrR7eTfmPg
         AyqSC3JL9VczcfAZVjiM1+/XdE4V3vPvLO3yfXRtHaq9F8FXkDqsRxn1s4JKc4cziW
         +nanfhdS9TzT1SDzIZ8ITkinchr2WHybb1tI4NFM=
Date:   Fri, 7 Aug 2020 10:04:44 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [RESEND PATCH] media: atomisp: Replace trace_printk by pr_info
Message-ID: <20200807100444.0f2d3c94@coco.lan>
In-Reply-To: <CANMq1KD_hJ_ST3du7dcSd8GBtdL4d-C1pWbxXz8Wu8w79-2fUg@mail.gmail.com>
References: <20200710144520.RESEND.1.Id0f52f486e277b5af30babac8ba6b09589962a68@changeid>
        <20200710070332.GA1175842@kroah.com>
        <CANMq1KDcKWgyYYP_m0-WV7602g7zUbU0PPkvwXxbSTF5vFfKGQ@mail.gmail.com>
        <CANMq1KC7CgUT+neoOUZbnr8MbDgqEikqt2vn8dxAS1rpX=C2aA@mail.gmail.com>
        <20200807062809.GB979264@kroah.com>
        <CANMq1KD_hJ_ST3du7dcSd8GBtdL4d-C1pWbxXz8Wu8w79-2fUg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 7 Aug 2020 14:51:12 +0800
Nicolas Boichat <drinkcat@chromium.org> escreveu:

> On Fri, Aug 7, 2020 at 2:28 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Aug 07, 2020 at 09:50:23AM +0800, Nicolas Boichat wrote:  
> > > On Fri, Jul 24, 2020 at 8:41 PM Nicolas Boichat <drinkcat@chromium.org> wrote:  
> > > >
> > > > On Fri, Jul 10, 2020 at 3:03 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:  
> > > > >
> > > > > On Fri, Jul 10, 2020 at 02:45:29PM +0800, Nicolas Boichat wrote:  
> > > > > > trace_printk should not be used in production code, replace it
> > > > > > call with pr_info.
> > > > > >
> > > > > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > > > > ---
> > > > > > Sent this before as part of a series (whose 4th patch was a
> > > > > > change that allows to detect such trace_printk), but maybe it's
> > > > > > easier to get individual maintainer attention by splitting it.  
> > > > >
> > > > > Mauro should take this soon:
> > > > >
> > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>  
> > > >
> > > > Mauro: did you get a chance to look at this? (and the other similar
> > > > patch "media: camss: vfe: Use trace_printk for debugging only")  
> > >
> > > Mauro: Another gentle ping. Thanks.  
> >
> > It's the middle of the merge window, maintainers can't do anything until
> > after 5.9-rc1 is out, sorry.  
> 
> Huh, wait, looks like Mauro _did_ pick it (found it in this email
> "[GIT PULL for v5.8-rc7] media fixes").
> 
> My bad then, I was expecting an ack ,-)

Never expect acks. Kernel maintainers usually don't send them.

Yet, in the case of media, you should probably have received
an automatic e-mail from our patchwork instance.

Thanks,
Mauro
