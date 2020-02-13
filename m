Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FBCC3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2A5218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581618590;
	bh=8HBxUh0JdyAk8hq/g0A89/Dsm5mgWq9d1peP/wtuncM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JN3pERo9bDuQPlM+BE776OAQoK5aCYXHReNdIBSjMq8WdroIQd0/sCEC8CNHRzX6l
	 A6RZJ1RxCWDWZId8kLohPXY9ZGg+T0OD4zG2Ed06T/V6pnMP/VhGTs8/D2wqNGnb/l
	 VLrTsGgbLt5f9SwDKd8VbsTqmKknExRPMAOHBE04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgBMS3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:29:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMS3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:29:49 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DD1A21734;
        Thu, 13 Feb 2020 18:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581618588;
        bh=8HBxUh0JdyAk8hq/g0A89/Dsm5mgWq9d1peP/wtuncM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0P0qS0iaFPq1Kaie9QUKT6TZUtEVPao5URCdwXsVShflL6Eqk9tkoLQk0wz+/1Qb
         FtnJiOnkQc4ygLqhb1ja16NuVeOMEgVSGFQ0/fqqTUBbfw9iTz1FxHzqfQ3L7hqHiB
         d93gqPP29xH+slD2v70MT/dDwnd317f7yFxn1q5w=
Date:   Thu, 13 Feb 2020 10:29:48 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 16/52] serial: uartps: Add a timeout to the tx empty
 wait
Message-ID: <20200213182948.GA3715117@kroah.com>
References: <20200213151810.331796857@linuxfoundation.org>
 <20200213151817.584286846@linuxfoundation.org>
 <20200213182246.GA10589@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213182246.GA10589@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 07:22:46PM +0100, Pavel Machek wrote:
> Hi!
> 
> > commit 277375b864e8147975b064b513f491e2a910e66a upstream
> > 
> > In case the cable is not connected then the target gets into
> > an infinite wait for tx empty.
> > Add a timeout to the tx empty wait.
> 
> Was this tested? Because it does not work...
> 
> > Reported-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: stable <stable@vger.kernel.org> # 4.19
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> > @@ -681,16 +683,20 @@ static void cdns_uart_set_termios(struct uart_port *port,
> ...
> > +	int err;
> >  
> >  	spin_lock_irqsave(&port->lock, flags);
> >  
> >  	/* Wait for the transmit FIFO to empty before making changes */
> >  	if (!(readl(port->membase + CDNS_UART_CR) &
> >  				CDNS_UART_CR_TX_DIS)) {
> > -		while (!(readl(port->membase + CDNS_UART_SR) &
> > -				CDNS_UART_SR_TXEMPTY)) {
> > -			cpu_relax();
> > +		err = readl_poll_timeout(port->membase + CDNS_UART_SR,
> > +					 val, (val & CDNS_UART_SR_TXEMPTY),
> > +					 1000, TX_TIMEOUT);
> > +		if (err) {
> > +			dev_err(port->dev, "timed out waiting for tx empty");
> > +			return;
> >  		}
> >  	}
> >
> 
> It will return with lock held and interrupts disabled. Mainline takes
> spinlock later, so it does not have a problem.
> 
> Merging 107475685abfdee504bb0ef4824f15797f6d2d4d before this one
> should fix the problem.

Good catch, that's a mess.  I'll go queue this up now.

greg k-h
