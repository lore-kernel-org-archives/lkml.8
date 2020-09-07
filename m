Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DEDC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE1E21481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgIGP27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:28:59 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40373 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730137AbgIGPPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:15:45 -0400
Received: (qmail 763212 invoked by uid 1000); 7 Sep 2020 11:08:58 -0400
Date:   Mon, 7 Sep 2020 11:08:58 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        stern@rowland.harvard.ed, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 04/11] USB: core: hub.c: use usb_control_msg_send() in
 a few places
Message-ID: <20200907150858.GD762136@rowland.harvard.edu>
References: <20200907145108.3766613-1-gregkh@linuxfoundation.org>
 <20200907145108.3766613-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907145108.3766613-5-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 04:51:01PM +0200, Greg Kroah-Hartman wrote:
> There are a few calls to usb_control_msg() that can be converted to use
> usb_control_msg_send() instead, so do that in order to make the error
> checking a bit simpler and the code smaller.
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2:
>  - dropped changes to usb_req_set_sel() thanks to review from Alan

> @@ -4056,7 +4035,7 @@ static void usb_enable_link_state(struct usb_hcd *hcd, struct usb_device *udev,
>  	 * associated with the link state we're about to enable.
>  	 */
>  	ret = usb_req_set_sel(udev, state);
> -	if (ret < 0) {
> +	if (ret) {
>  		dev_warn(&udev->dev, "Set SEL for device-initiated %s failed.\n",
>  				usb3_lpm_names[state]);
>  		return;

Did this change survive by mistake?

Actually, it looks like usb_req_set_sel needs to check the value 
returned by usb_control_msg -- a perfect example of the sort of thing 
you were trying to fix in the first place!

Alan Stern
