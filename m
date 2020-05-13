Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD60CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3C520753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589358134;
	bh=Y6RN6s3W5uU8DDXTwJozRpTFSVs0kM3pNSPxAB90TRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NxpRmrzB03IBH75Qkz9C/P/FK2BTjHFoTNE7GOK/0AoNhG7HpvNHo87NsQmKLhN6+
	 bszMiOmmnMD9lPUM4HwMBpZsXvykx/5092pTArLcz0CgkmnNSj6+NLbzuia3U/9ZgB
	 OklytTJLaAbZX6TmEII952yLdG74AuXl73eq947Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbgEMIWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgEMIWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:22:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22360205C9;
        Wed, 13 May 2020 08:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589358131;
        bh=Y6RN6s3W5uU8DDXTwJozRpTFSVs0kM3pNSPxAB90TRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AWwUT4o2KXyNrkLLTid53u+t+0+lb3OrXDVJUGZtld+En4CDedo2q1EJhOWdNHeWY
         UXfwunDxy/LESnewb0g+PjF7XEAX3mDpl6aM7jXP5snsS6l+fN8H5T0AIq5QRo+Gqc
         ztn/VCNR3kpzE3ofUVe6fyKroYL+h1RavSx/bL74=
Date:   Wed, 13 May 2020 10:22:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver core: Add state_synced sysfs file for devices
 that support it
Message-ID: <20200513082209.GB770255@kroah.com>
References: <20200513013415.148858-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513013415.148858-1-saravanak@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 06:34:15PM -0700, Saravana Kannan wrote:
> This can be used to check if a device supports sync_state() callbacks
> and therefore keeps resources left on by the bootloader enabled till all
> its consumers have probed.
> 
> This can also be used to check if sync_state() has been called for a
> device or whether it is still trying to keep resources enabled because
> they were left enabled by the bootloader and all its consumers haven't
> probed yet.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  .../ABI/testing/sysfs-devices-state_synced    | 24 +++++++++++++++++++
>  drivers/base/dd.c                             | 16 +++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-state_synced
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-state_synced b/Documentation/ABI/testing/sysfs-devices-state_synced
> new file mode 100644
> index 000000000000..0c922d7d02fc
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-state_synced
> @@ -0,0 +1,24 @@
> +What:		/sys/devices/.../state_synced
> +Date:		May 2020
> +Contact:	Saravana Kannan <saravanak@google.com>
> +Description:
> +		The /sys/devices/.../state_synced attribute is only present for
> +		devices whose bus types or driver provides the .sync_state()
> +		callback. The number read from it (0 or 1) reflects the value
> +		of the device's 'state_synced' field. A value of 0 means the
> +		.sync_state() callback hasn't been called yet. A value of 1
> +		means the .sync_state() callback has been called.
> +
> +		Generally, if a device has sync_state() support and has some of
> +		the resources it provides enabled at the time the kernel starts
> +		(Eg: enabled by hardware reset or bootloader or anything that
> +		run before the kernel starts), then it'll keep those resources
> +		enabled and in a state that's compatible with the state they
> +		were in at the start of the kernel. The device will stop doing
> +		this only when the sync_state() callback has been called --
> +		which happens only when all its consumer devices are registered
> +		and have probed successfully. Resources that were left disabled
> +		at the time the kernel starts are not affected or limited in
> +		any way by sync_state() callbacks.
> +
> +
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 48ca81cb8ebc..72599436ae84 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -458,6 +458,13 @@ static void driver_deferred_probe_add_trigger(struct device *dev,
>  		driver_deferred_probe_trigger();
>  }
>  
> +static ssize_t state_synced_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%u\n", dev->state_synced);
> +}
> +static DEVICE_ATTR_RO(state_synced);
> +
>  static int really_probe(struct device *dev, struct device_driver *drv)
>  {
>  	int ret = -EPROBE_DEFER;
> @@ -531,9 +538,16 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  		goto dev_groups_failed;
>  	}
>  
> +	if (dev_has_sync_state(dev) &&
> +	    device_create_file(dev, &dev_attr_state_synced)) {
> +		dev_err(dev, "state_synced sysfs add failed\n");
> +		goto dev_sysfs_state_synced_failed;
> +	}

Why not add this to the groups above this and only enable it if needed
at runtime?

The is_visible() callback should be what you need to use here.  That
will save you lots of housekeeping as well as properly remove the
attribute when the device is removed from the system (which you didn't
explicitly do in this patch...)

thanks,

greg k-h
