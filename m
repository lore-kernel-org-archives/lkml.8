Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFA0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D69B21927
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594706724;
	bh=bHbsEQUe++Lcee6QxGMLVV8KWlmKwrS5KtkVW9rfyeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ey4O3njsTMdXhhqaan7ACXDbq4iC1T0OaMR1v+G6UQkTdRKH6C7x17BhQpQPFF9yV
	 hEG/uhTKcx9Uw44qKUiYD9T5RZOoVtSB/b2BMHUoUqSKUJsIb5L7WdU54VQN2flaUk
	 RmoKok6RumOIZEC1IDv9dzy2p3sSYqhkY4Noh2Oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgGNGFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgGNGFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:05:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 597C520890;
        Tue, 14 Jul 2020 06:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594706721;
        bh=bHbsEQUe++Lcee6QxGMLVV8KWlmKwrS5KtkVW9rfyeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jm/Djc8vK56LTCq+jDsDw1QyMassDPWu10If0CuiGPm0/PC8lzLTMMbPDOFNnpA8l
         xoxzZnzJxfUTfZ3ADn9XomKui/y9YscOQSFMsbHd99EVRT5Hre1d3T6iQznH7bANQQ
         cZFO10EHHHvWRF/nqHybpFMZv240jmXo/r3Uex14=
Date:   Tue, 14 Jul 2020 08:05:20 +0200
From:   reg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Move to high priority workqueue for
 processing events
Message-ID: <20200714060520.GB657428@kroah.com>
References: <20200713204300.345975-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200713204300.345975-1-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 01:43:00PM -0700, Badhri Jagan Sridharan wrote:
> "tReceiverResponse 15 ms Section 6.6.2
> The receiver of a Message requiring a response Shall respond
> within tReceiverResponse in order to ensure that the
> sender’s SenderResponseTimer does not expire."
> 
> When the cpu complex is busy running other lower priority
> work items, TCPM's work queue sometimes does not get scheduled
> on time to meet the above requirement from the spec.
> Elevating the TCPM's work queue to higher priority allows
> TCPM to meet tReceiverResponse in a busy system.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 82b19ebd7838e0..088b6f1fa1ff89 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4747,7 +4747,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	mutex_init(&port->lock);
>  	mutex_init(&port->swap_lock);
>  
> -	port->wq = create_singlethread_workqueue(dev_name(dev));
> +	port->wq = alloc_ordered_workqueue("%s", WQ_HIGHPRI, dev_name(dev));

How are you "guaranteeing" that this is really going to change anything
on a highly loaded machine?

Yes, it might make things better, but if you have a hard deadline like
this, you need to do things a bit differently to always ensure that you
meet it.  I do not think this change is that fix, do you?

thanks,

greg k-h
