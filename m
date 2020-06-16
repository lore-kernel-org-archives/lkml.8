Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A330AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E022078E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592301894;
	bh=UfD+imUkHRiYhthA7qqt1Fht5Eqoz0lTSxvovqL5LjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Slrfjah4y34UM6zs/AQHcfatvq3WSjLc6J44MOzdfNRc3IBJ7aWaB0CXGqULu0tXP
	 wM6QqRbmZaRGaqZgHRUfwrQqBbZ/EHapUgz43oK+wpX6Dhxn9Rcvg2r3/c5V/Uf0Qe
	 WTwJox1VANwPTF1x1s3Wcsic2QspB+78R5WsuRhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgFPKEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgFPKEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:04:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63AB420767;
        Tue, 16 Jun 2020 10:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592301892;
        bh=UfD+imUkHRiYhthA7qqt1Fht5Eqoz0lTSxvovqL5LjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPHr3jgTgfXwk3vV4kudTO30e6D48erY2BmdmRZmL4f1t29BIpGn/EQM34Gtf4JQh
         m3KRPjM/jr1WmwfOQmKfhAj/ghCfEwns5w6uOrCobBvGltrxoyfyVDENpLIzTPqN3R
         sXjfEYY/98ClTEadd7bprtkpXuC9OPKfVUFA3JxM=
Date:   Tue, 16 Jun 2020 12:04:46 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Gao, Nian" <nian.gao@siemens.com>
Cc:     "Johan@kernel.org" <Johan@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [PATCH] drivers: fix the hardware flow function of cp2102
Message-ID: <20200616100446.GB2614426@kroah.com>
References: <ac7175e5e02d4bc6ac5d30d396d6c100@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac7175e5e02d4bc6ac5d30d396d6c100@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 08:37:39AM +0000, Gao, Nian wrote:
> >From 97278cc3d00d22e8fc1edecce1f08772823a50dd Mon Sep 17 00:00:00 2001
> From: Gao Nian <nian.gao@siemens.com>
> Date: Tue, 16 Jun 2020 16:29:42 +0800
> Subject: [PATCH] drivers: fix the hardware flow function of cp2102

Why is this all in the body of your email?

Please just use git send-email to send patches out so that they come in
the proper format.

As it is, your patch has all of the tabs changed to spaces, making it
impossible to apply.  Please fix your email client up to not do this.


> 
> When the recieve buffer is full in hardware flow mode,
> cp2102 will not activate the RTS signal to notify
> the sender to stop sending data.
> 
> Signed-off-by: Gao Nian <nian.gao@siemens.com>
> ---
> drivers/usb/serial/cp210x.c | 17 ++++++++++++++++-
> 1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index f5143eedbc48..c3e05e135d2d 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -272,6 +272,8 @@ static struct usb_serial_driver cp210x_device = {
>            .break_ctl                     = cp210x_break_ctl,
>            .set_termios                 = cp210x_set_termios,
>            .tx_empty                     = cp210x_tx_empty,
> +          .throttle                         = usb_serial_generic_throttle,
> +          .unthrottle                     = usb_serial_generic_unthrottle,
>            .tiocmget                      = cp210x_tiocmget,
>            .tiocmset                      = cp210x_tiocmset,
>            .attach                          = cp210x_attach,
> @@ -915,6 +917,7 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
>            u32 baud;
>            u16 bits;
>            u32 ctl_hs;
> +          u32 flow_repl;
>             cp210x_read_u32_reg(port, CP210X_GET_BAUDRATE, &baud);
> @@ -1013,8 +1016,20 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
>            cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
>                                    sizeof(flow_ctl));
>            ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
> +          flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
> +          /*
> +          * CP210x hardware disables RTS but leaves CTS when in hardware flow
> +          * control mode and port is closed.
> +          * This allows data to flow out, but new data will not come into the port.
> +          * When re-opening the port, if CTS is enabled, then RTS must manually be
> +          * re-enabled.
> +          */
>            if (ctl_hs & CP210X_SERIAL_CTS_HANDSHAKE) {
> -                       dev_dbg(dev, "%s - flow control = CRTSCTS\n", __func__);

Why remove this debugging line?

thanks,

greg k-h
