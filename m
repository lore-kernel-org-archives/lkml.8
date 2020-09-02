Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6A8C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C5020829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgIBO5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:57:17 -0400
Received: from netrider.rowland.org ([192.131.102.5]:60707 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726406AbgIBO5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:57:02 -0400
Received: (qmail 624961 invoked by uid 1000); 2 Sep 2020 10:57:01 -0400
Date:   Wed, 2 Sep 2020 10:57:01 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        stern@rowland.harvard.ed, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 04/10] USB: core: hub.c: use usb_control_msg_send() in a
 few places
Message-ID: <20200902145701.GA624583@rowland.harvard.edu>
References: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
 <20200902110115.1994491-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902110115.1994491-5-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 01:01:06PM +0200, Greg Kroah-Hartman wrote:
> There are a few calls to usb_control_msg() that can be converted to use
> usb_control_msg_send() instead, so do that in order to make the error
> checking a bit simpler and the code smaller.
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

One problem in this patch...

> @@ -3896,27 +3875,14 @@ static int usb_req_set_sel(struct usb_device *udev, enum usb3_link_state state)
>  	if (u2_pel > USB3_LPM_MAX_U2_SEL_PEL)
>  		u2_pel = USB3_LPM_MAX_U2_SEL_PEL;
>  
> -	/*
> -	 * usb_enable_lpm() can be called as part of a failed device reset,
> -	 * which may be initiated by an error path of a mass storage driver.
> -	 * Therefore, use GFP_NOIO.
> -	 */
> -	sel_values = kmalloc(sizeof *(sel_values), GFP_NOIO);
> -	if (!sel_values)
> -		return -ENOMEM;
> -
> -	sel_values->u1_sel = u1_sel;
> -	sel_values->u1_pel = u1_pel;
> -	sel_values->u2_sel = cpu_to_le16(u2_sel);
> -	sel_values->u2_pel = cpu_to_le16(u2_pel);
> +	sel_values.u1_sel = u1_sel;
> +	sel_values.u1_pel = u1_pel;
> +	sel_values.u2_sel = cpu_to_le16(u2_sel);
> +	sel_values.u2_pel = cpu_to_le16(u2_pel);
>  
> -	ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
> -			USB_REQ_SET_SEL,
> -			USB_RECIP_DEVICE,
> -			0, 0,
> -			sel_values, sizeof *(sel_values),
> -			USB_CTRL_SET_TIMEOUT);
> -	kfree(sel_values);
> +	ret = usb_control_msg_send(udev, 0, USB_REQ_SET_SEL, USB_RECIP_DEVICE,
> +				   0, 0, &sel_values, sizeof(sel_values),
> +				   USB_CTRL_SET_TIMEOUT);

This effectively changes GFP_NOIO to GFP_KERNEL.  Probably you should
leave this particular call alone.

Alan Stern
