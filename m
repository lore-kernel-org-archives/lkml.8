Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA87C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDBC2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbgDBOZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:25:42 -0400
Received: from netrider.rowland.org ([192.131.102.5]:44551 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729166AbgDBOZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:25:41 -0400
Received: (qmail 12507 invoked by uid 500); 2 Apr 2020 10:18:58 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Apr 2020 10:18:58 -0400
Date:   Thu, 2 Apr 2020 10:18:58 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
cc:     gregkh@linuxfoundation.org, <hariprasad.kelam@gmail.com>,
        <colin.king@canonical.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ldv-project@linuxtesting.org>,
        <andrianov@ispras.ru>
Subject: Re: [PATCH] usb: host: u132-hcd: Traverse u132_static_list under
 mutex lock in u132_hcd_exit
In-Reply-To: <20200401191735.10809-1-madhuparnabhowmik10@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2004021015270.9681-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Apr 2020 madhuparnabhowmik10@gmail.com wrote:

> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> The global list u132_static_list is protected by u132_module_lock.
> Elements are added to this list in the probe function and this list is
> traversed in u132_hcd_exit() to unregister devices.
> 
> If probe and exit execute simultaneously there can be a race condition
> between writing to this list in probe and reading the list in exit as
> u132_module_lock is not held in exit function.
> 
> Even though u132_exiting variable is used in probe to detect if the module is
> exiting, it is ineffective as the probe function may read the value
> before it is updated in exit and thus leading to a race condition.
> 
> Therefore, hold u132_module_lock while traversing u132_static_list in
> exit function.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  drivers/usb/host/u132-hcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
> index e9209e3e6248..1cadc4e0c9b2 100644
> --- a/drivers/usb/host/u132-hcd.c
> +++ b/drivers/usb/host/u132-hcd.c
> @@ -3217,10 +3217,10 @@ static void __exit u132_hcd_exit(void)
>  	struct u132 *temp;
>  	mutex_lock(&u132_module_lock);
>  	u132_exiting += 1;
> -	mutex_unlock(&u132_module_lock);
>  	list_for_each_entry_safe(u132, temp, &u132_static_list, u132_list) {
>  		platform_device_unregister(u132->platform_dev);
>  	}
> +	mutex_unlock(&u132_module_lock);

How about just getting rid of this loop entirely, along with the 
u132_static_list?  As far as I can see, that list doesn't do anything.

Not to mention that this driver has no business calling 
platform_device_unregister() here, since it didn't call 
platform_device_register() in the first place.  The call to 
platform_driver_unregister() below should do all the necessary work.

Alan Stern

>  	platform_driver_unregister(&u132_platform_driver);
>  	printk(KERN_INFO "u132-hcd driver deregistered\n");
>  	wait_event(u132_hcd_wait, u132_instances == 0);

