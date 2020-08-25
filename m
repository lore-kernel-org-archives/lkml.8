Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5181C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707AD20738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHYSA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:00:28 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35865 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726158AbgHYSA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:00:27 -0400
Received: (qmail 375693 invoked by uid 1000); 25 Aug 2020 14:00:26 -0400
Date:   Tue, 25 Aug 2020 14:00:26 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     yanfei.xu@windriver.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: core: limit access to rawdescriptors which were not
 allocated
Message-ID: <20200825180026.GA375466@rowland.harvard.edu>
References: <20200825161659.19008-1-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825161659.19008-1-yanfei.xu@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:16:59AM +0800, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> When using systemcall to read the rawdescriptors, make sure we won't
> access to the rawdescriptors never allocated, which are number
> exceed the USB_MAXCONFIG.
> 
> Reported-by: syzbot+256e56ddde8b8957eabd@syzkaller.appspotmail.com
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
>  drivers/usb/core/sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
> index a2ca38e25e0c..1a7a625e5f55 100644
> --- a/drivers/usb/core/sysfs.c
> +++ b/drivers/usb/core/sysfs.c
> @@ -895,7 +895,8 @@ read_descriptors(struct file *filp, struct kobject *kobj,
>  	 * configurations (config plus subsidiary descriptors).
>  	 */
>  	for (cfgno = -1; cfgno < udev->descriptor.bNumConfigurations &&
> -			nleft > 0; ++cfgno) {
> +			nleft > 0 &&
> +			cfgno < USB_MAXCONFIG; ++cfgno) {
>  		if (cfgno < 0) {
>  			src = &udev->descriptor;
>  			srclen = sizeof(struct usb_device_descriptor);

This is not the right way to fix the problem.

Instead, we should make sure that udev->descriptor.bNumConfigurations is 
always <= USB_MAXCONFIG.  That's what this code in 
usb_get_configuration() is supposed to do:

	int ncfg = dev->descriptor.bNumConfigurations;
	...

	if (ncfg > USB_MAXCONFIG) {
		dev_warn(ddev, "too many configurations: %d, "
		    "using maximum allowed: %d\n", ncfg, USB_MAXCONFIG);
		dev->descriptor.bNumConfigurations = ncfg = USB_MAXCONFIG;
	}

If you want to fix the bug, you need to figure out why this isn't 
working.

Alan Stern
