Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8184C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF822207DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597743379;
	bh=jf7Mx1Ot8arfUuf6gg/Wk5ylCL0JP7drPzwJqzU4itw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ajVyo40zbGoEaGjXkx3cpiuX8S4ElN6/UGaw3b0qngQmjy8LxvzOS7Zj8MA/Rs/t3
	 BH3ZaTI/DsevQcNWk4MbNKNt4jyLdlc38P5aCQx232YpFrRrh5RUXuzoI6dvlW3vja
	 mo0BbKDB21nHPSGeH2jS68PN8jbqBVeBgdTaFIfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHRJgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgHRJgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:36:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F1A72078B;
        Tue, 18 Aug 2020 09:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597743376;
        bh=jf7Mx1Ot8arfUuf6gg/Wk5ylCL0JP7drPzwJqzU4itw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kncx4qd2AeaHd89DpmQpPvAWG2MJRYJkGWXg7bKYSHDqCKc3NXVxtfyxGvaKapyL7
         OOmMHwYltbvwO8xVLm4X924GpUWRtTwD6omZKLuFCTWymoLruGjkXM4KV/Q323bOPz
         +8BbwgbRO1Z7qEgQblVXZ5XIaL9o9UzrTS9NLlsw=
Date:   Tue, 18 Aug 2020 11:36:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergey Korolev <s.korolev@ndmsystems.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Rob Gill <rrobgill@protonmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: core: remove polling for
 /sys/kernel/debug/usb/devices
Message-ID: <20200818093640.GC34785@kroah.com>
References: <20200809161233.13135-1-s.korolev@ndmsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809161233.13135-1-s.korolev@ndmsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 07:12:30PM +0300, Sergey Korolev wrote:
> The latest reference to usbfs_conn_disc_event() removed in
> commit fb28d58b72aa ("USB: remove CONFIG_USB_DEVICEFS")
> in 2012 and now a user poll() waits infinitely for content changes.
> 
> Signed-off-by: Sergey Korolev <s.korolev@ndmsystems.com>
> ---
>  drivers/usb/core/devices.c | 41 --------------------------------------
>  drivers/usb/core/usb.h     |  1 -
>  2 files changed, 42 deletions(-)
> 
> diff --git a/drivers/usb/core/devices.c b/drivers/usb/core/devices.c
> index 696b2b692b83..1ef2de6e375a 100644
> --- a/drivers/usb/core/devices.c
> +++ b/drivers/usb/core/devices.c
> @@ -39,7 +39,6 @@
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/gfp.h>
> -#include <linux/poll.h>
>  #include <linux/usb.h>
>  #include <linux/usbdevice_fs.h>
>  #include <linux/usb/hcd.h>
> @@ -97,22 +96,6 @@ static const char format_endpt[] =
>  /* E:  Ad=xx(s) Atr=xx(ssss) MxPS=dddd Ivl=D?s */
>    "E:  Ad=%02x(%c) Atr=%02x(%-4s) MxPS=%4d Ivl=%d%cs\n";
>  
> -/*
> - * Wait for an connect/disconnect event to happen. We initialize
> - * the event counter with an odd number, and each event will increment
> - * the event counter by two, so it will always _stay_ odd. That means
> - * that it will never be zero, so "event 0" will never match a current
> - * event, and thus 'poll' will always trigger as readable for the first
> - * time it gets called.
> - */
> -static struct device_connect_event {
> -	atomic_t count;
> -	wait_queue_head_t wait;
> -} device_event = {
> -	.count = ATOMIC_INIT(1),
> -	.wait = __WAIT_QUEUE_HEAD_INITIALIZER(device_event.wait)
> -};
> -
>  struct class_info {
>  	int class;
>  	char *class_name;
> @@ -146,12 +129,6 @@ static const struct class_info clas_info[] = {
>  
>  /*****************************************************************/
>  
> -void usbfs_conn_disc_event(void)
> -{
> -	atomic_add(2, &device_event.count);
> -	wake_up(&device_event.wait);
> -}
> -
>  static const char *class_decode(const int class)
>  {
>  	int ix;
> @@ -623,25 +600,7 @@ static ssize_t usb_device_read(struct file *file, char __user *buf,
>  	return total_written;
>  }
>  
> -/* Kernel lock for "lastev" protection */
> -static __poll_t usb_device_poll(struct file *file,
> -				    struct poll_table_struct *wait)
> -{
> -	unsigned int event_count;
> -
> -	poll_wait(file, &device_event.wait, wait);
> -
> -	event_count = atomic_read(&device_event.count);
> -	if (file->f_version != event_count) {
> -		file->f_version = event_count;
> -		return EPOLLIN | EPOLLRDNORM;
> -	}
> -
> -	return 0;
> -}
> -
>  const struct file_operations usbfs_devices_fops = {
>  	.llseek =	no_seek_end_llseek,
>  	.read =		usb_device_read,
> -	.poll =		usb_device_poll,
>  };
> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> index 98e7d1ee63dc..c893f54a3420 100644
> --- a/drivers/usb/core/usb.h
> +++ b/drivers/usb/core/usb.h
> @@ -191,7 +191,6 @@ extern const struct attribute_group *usb_interface_groups[];
>  extern struct usb_driver usbfs_driver;
>  extern const struct file_operations usbfs_devices_fops;
>  extern const struct file_operations usbdev_file_operations;
> -extern void usbfs_conn_disc_event(void);
>  
>  extern int usb_devio_init(void);
>  extern void usb_devio_cleanup(void);

Why not fix this up instead?  The debugfs file can be polled and this
should be fixed to accurately handle that.

It's kind of proof though that no one really cares about this option in
that no one has noticed it being gone for so long, so if you don't want
to fix it, I will just take this patch for now.

Let me know.

thanks,

greg k-h
