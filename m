Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9D5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5204207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592982555;
	bh=xbNqFn/9ByJOYnzc/xSSD/TofOt0SnTeW8Q4g5Pnaso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NN/0GQWRV3EI33FRvzIanUtvciQ2jhRh1hSg4i9z8/hFGNLhvWAdKaeFrvrQaZgTx
	 5FEu5unGXnWQ/JflOd4dXL5DCOw8KiGZUEVfTyOkX+0EnHJ91ki75SSFR222bcNRL3
	 +KKZKjf9fAc0wsGIF7ajZKUMA1+sey8O+dPlBxmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389606AbgFXHJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387849AbgFXHJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:09:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1148B207DD;
        Wed, 24 Jun 2020 07:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592982551;
        bh=xbNqFn/9ByJOYnzc/xSSD/TofOt0SnTeW8Q4g5Pnaso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgHtXjB0lEQ3whfnQCzMBjGSp2vdCYAJ2njn+Sdc/gMz0S+zjSQ5yIp7Lvm+vfvZ7
         eF8NmiFaUFlxeuq9cGKFlkzKMR2PRgnCiO4LS4UQDlSqSFrLG+iW1YaJxRgFc4SVX5
         k2fRhWGQcl7/m9hKGWTA3/bdCGQV+P9yNTMhjcvg=
Date:   Wed, 24 Jun 2020 09:09:10 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Phu Luu <Phu.Luu@silabs.com>
Cc:     "johan@kernel.org" <johan@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brant Merryman <Brant.Merryman@silabs.com>,
        Richard Hendricks <Richard.Hendricks@silabs.com>
Subject: Re: [PATCH v3 2/2] USB: serial: cp210x: Proper RTS control when
 buffers fill
Message-ID: <20200624070910.GA1557212@kroah.com>
References: <DM6PR11MB2857CC4B06D64F290FC42E739C950@DM6PR11MB2857.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB2857CC4B06D64F290FC42E739C950@DM6PR11MB2857.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 07:03:04AM +0000, Phu Luu wrote:
> CP210x hardware disables auto-RTS but leaves auto-CTS when
> in hardware flow control mode and UART on cp210x hardware
> is disabled. This allows data to flow out, but new data
> will not come into the port. When re-opening the port, if
> auto-CTS is enabled on the cp210x, then auto-RTS must be
> re-enabled in the driver.
> 
> Signed-off-by: Phu Luu <phu.luu@silabs.com>
> Signed-off-by: Brant Merryman <brant.merryman@silabs.com>
> ---
> 06/09/2020: Patch v3 2/2 Modified based on feedback from Johan Hovold <johan@kernel.org>
> 12/18/2019: Patch v2 Broken into two patches and modified based on feedback from Johan Hovold <johan@kernel.org>
> 12/09/2019: Initial submission of patch "Proper RTS control when buffers fill"
> 
> drivers/usb/serial/cp210x.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index bcceb4ad8be0..091441b1c5b9 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -917,6 +917,7 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
>                u32 baud;
>                u16 bits;
>                u32 ctl_hs;
> +             u32 flow_repl;
>                 cp210x_read_u32_reg(port, CP210X_GET_BAUDRATE, &baud);
> @@ -1017,6 +1018,23 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
>                ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
>                if (ctl_hs & CP210X_SERIAL_CTS_HANDSHAKE) {
>                                dev_dbg(dev, "%s - flow control = CRTSCTS\n", __func__);
> +                             /*
> +                             * When the port is closed, the CP210x hardware disables
> +                             * auto-RTS and RTS is deasserted but it leaves auto-CTS when
> +                             * in hardware flow control mode. This prevents new data from
> +                             * being received by the port. When re-opening the port, if
> +                             * auto-CTS is enabled on the cp210x, then auto-RTS must be
> +                             * re-enabled in the driver.
> +                             */
> +                             flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
> +                             flow_repl &= ~CP210X_SERIAL_RTS_MASK;
> +                             flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_FLOW_CTL);
> +                             flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
> +                             cp210x_write_reg_block(port,
> +                                                             CP210X_SET_FLOW,
> +                                                             &flow_ctl,
> +                                                             sizeof(flow_ctl));
> +
>                                cflag |= CRTSCTS;
>                } else {
>                                dev_dbg(dev, "%s - flow control = NONE\n", __func__);
> --
> 2.17.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
