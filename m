Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47B2C83006
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8404C21775
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588228063;
	bh=j4ttnyeGzBs7nNtUbRDDvUX7Acb/T8MsX3gTMTw+5mQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BdoXC6DiJB0ZB7uBkc3ieyAEEYMXhcVsJS9+5RqW3E27VIC+LYOVWsn+gOmCVljZW
	 CWLN0V4GPx8rmJ9OF1tO20N64D34GRHhQsdeZ02D4S5m251Fl9Z1z0QlMDDwP6kB2l
	 ykrk5BmoWol8+KA1RdPydyVIHCnFu5dZ4K5jzbog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgD3G1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbgD3G1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:27:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40FDA2082E;
        Thu, 30 Apr 2020 06:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588228060;
        bh=j4ttnyeGzBs7nNtUbRDDvUX7Acb/T8MsX3gTMTw+5mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKVceOXm99TxvVsQjM7UcswlKQjnrTD8MbHZrpCmSm8Ma5+peqcgJpRKXPt+YnMJN
         Ad+t5lDCgu5vFsoNSa9OAypwqMpb7WfuYKi56Slw1yMlYxEmypS/kT9Gk/l4wypG8Y
         6jeO8r2ZBpxByhd3UURjp968yFsVKK/Lm+3tVFtk=
Date:   Thu, 30 Apr 2020 08:27:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mani@kernel.org
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, patong.mxl@gmail.com
Subject: Re: [PATCH v2 1/2] usb: serial: Add MaxLinear/Exar USB to Serial
 driver
Message-ID: <20200430062737.GA2376664@kroah.com>
References: <20200430043636.8468-1-mani@kernel.org>
 <20200430043636.8468-2-mani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430043636.8468-2-mani@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 10:06:35AM +0530, mani@kernel.org wrote:
> +	port_priv->idProduct = le16_to_cpu(serial->dev->descriptor.idProduct);
> +
> +	/* XR21V141X specific settings */
> +	if (port_priv->idProduct == XR21V141X_ID) {
> +		port_priv->regs = &xr21v141x_regs;
> +		port_priv->reg_width = 1;
> +	}

Shouldn't you abort here if idProduct does not have this value, as
that's all you test for everywhere else.  Do you even need to have this
test and save the value everywhere at all?

thanks,

greg k-h
