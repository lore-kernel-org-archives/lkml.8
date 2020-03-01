Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04377C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 15:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD220214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583075391;
	bh=L1d+AItbkkBXszkIwnSetgpZqP66VqdmSi0YX0Mk4EY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fq/WNq9KwpXVa7IinvC3qAHXiMhB52Zw5RKekXvyOSvXVkGDFzlZYULG43FiuXJTl
	 grOHiL8zyCr0In91TcafN0JAc+3TiXckixNVUkiNibFbDPOnjhQ4eXl4gLVsswo6z9
	 x1Y1FCxGBl3D0eIyDXgyI64CDpMbui8L4h975hd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgCAPJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 10:09:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCAPJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 10:09:25 -0500
Received: from localhost (unknown [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00582214DB;
        Sun,  1 Mar 2020 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583075364;
        bh=L1d+AItbkkBXszkIwnSetgpZqP66VqdmSi0YX0Mk4EY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZ59e6zO12/gehlMba0wC1AqoYskJYZ31aUz4qLL0ZrKxlDM8sc/4RI3soeWvuW6p
         8e7qZxnQ0j/KSyqYcHl131c+J+qPMNcBVi9Rmf00PcoQCIc6z4VBPdhRk3Yv0deJBj
         z7JsJOlgYSYYeEDeSQVfhNcc3svn+CQ9EoEtivds=
Date:   Sun, 1 Mar 2020 16:09:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Forest Bond <forest@alittletooquiet.net>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] staging: vt6656: Declare a few variables as __read_mostly
Message-ID: <20200301150913.GA1470815@kroah.com>
References: <20200301112620.7892-1-oscar.carter@gmx.com>
 <20200301122514.GA1461917@kroah.com>
 <20200301131701.GA7487@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301131701.GA7487@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 02:17:01PM +0100, Oscar Carter wrote:
> On Sun, Mar 01, 2020 at 01:25:14PM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Mar 01, 2020 at 12:26:20PM +0100, Oscar Carter wrote:
> > > These include module parameters.
> > >
> > > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > > ---
> > >  drivers/staging/vt6656/main_usb.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
> > > index 5e48b3ddb94c..701300202b21 100644
> > > --- a/drivers/staging/vt6656/main_usb.c
> > > +++ b/drivers/staging/vt6656/main_usb.c
> > > @@ -49,12 +49,12 @@ MODULE_LICENSE("GPL");
> > >  MODULE_DESCRIPTION(DEVICE_FULL_DRV_NAM);
> > >
> > >  #define RX_DESC_DEF0 64
> > > -static int vnt_rx_buffers = RX_DESC_DEF0;
> > > +static int __read_mostly vnt_rx_buffers = RX_DESC_DEF0;
> > >  module_param_named(rx_buffers, vnt_rx_buffers, int, 0644);
> > >  MODULE_PARM_DESC(rx_buffers, "Number of receive usb rx buffers");
> > >
> > >  #define TX_DESC_DEF0 64
> > > -static int vnt_tx_buffers = TX_DESC_DEF0;
> > > +static int __read_mostly vnt_tx_buffers = TX_DESC_DEF0;
> > >  module_param_named(tx_buffers, vnt_tx_buffers, int, 0644);
> > >  MODULE_PARM_DESC(tx_buffers, "Number of receive usb tx buffers");
> > >
> >
> > Why?  What does this help with?
> 
> If we declare these variables __read_mostly we can improve the performance. If
> these variables are read many more times than written, each core of a multicore
> system can maintain a copy in a local cache and the time to access is less than
> if they use the shared-cache.

This is a USB driver, performance is always limited to the hardware, not
the CPU location of variables.

Please always benchmark things to see if it actually makes sense to make
changes like this, before proposing them.

thanks,

greg k-h
