Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F43C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA4420801
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591770129;
	bh=D1SFR63cq6HdbYoMldj+B+CcxDon+vNFYZHvLNzb4QE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hUkorXyew3dhYiF1r4wZhfQMZDWVT4dV+8wsVr5J8ez84huto+6lBMptT8Y8e1g2R
	 M27E3OSsbo4WHNTouIJghXaDjvz6oE6ty/ncerzVnFlAgFILWZLoZNYfZBwdD/veRg
	 5GkfWWTmlohDSUlQHidw0zppYHZNTG8iwp9DXIv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgFJGWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgFJGWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:22:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C28D20760;
        Wed, 10 Jun 2020 06:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591770126;
        bh=D1SFR63cq6HdbYoMldj+B+CcxDon+vNFYZHvLNzb4QE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SeO+vuxaGdJAUy+ZxxqZEjcKUnpNVFFT2twB7fe/f+cS2GP7LedlGj4lNO8sWsFXj
         HKyFudyoMZHOnrMjgI5zTa24sxdHVm4H7l+ASztXjMtlE7xmrN//CPHx+IE+DFZFfs
         iCamBJgCJjFg5reJq6oUJstCEArJMQc1n552OIgU=
Date:   Wed, 10 Jun 2020 08:22:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bart Van Assche <bvanassche@acm.org>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Justin Hsieh <justinhsieh@google.com>,
        Hakieyin Hsieh <hakieyin@gmail.com>
Subject: Re: [PATCH] usb/gadget/function: introduce Built-in CDROM support
Message-ID: <20200610062204.GC1890802@kroah.com>
References: <ejh@nvidia.com>
 <mchehab+samsung@kernel.org>
 <benh@kernel.crashing.org>
 <1591756349-17865-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591756349-17865-1-git-send-email-macpaul.lin@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 10:32:29AM +0800, Macpaul Lin wrote:
> Introduce Built-In CDROM (BICR) support.
> This feature depends on USB_CONFIGFS_MASS_STORAGE option.
> 
> 1. Some settings and new function is introduced for BICR.
> 2. Some work around for adapting Android settings is intorduced as well.

If you have to list a number of things done in a single patch, you
should break this up into multiple patches, as each patch should only do
one thing.  Please make this a patch series.

Also, you added new configuration settings, where are they documented?


> 
> Signed-off-by: Justin Hsieh <justinhsieh@google.com>
> Signed-off-by: Hakieyin Hsieh <hakieyin@gmail.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  drivers/usb/gadget/Kconfig                   | 16 +++++++
>  drivers/usb/gadget/function/f_mass_storage.c | 49 +++++++++++++++++++-
>  drivers/usb/gadget/function/f_mass_storage.h |  5 +-
>  drivers/usb/gadget/function/storage_common.c | 23 +++++++++
>  4 files changed, 90 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 4dc4d48fe6a6..686ba01bedb5 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -188,6 +188,9 @@ config USB_F_RNDIS
>  config USB_F_MASS_STORAGE
>  	tristate
>  
> +config USB_F_BICR
> +	tristate
> +
>  config USB_F_FS
>  	tristate
>  
> @@ -357,6 +360,19 @@ config USB_CONFIGFS_MASS_STORAGE
>  	  device (in much the same way as the "loop" device driver),
>  	  specified as a module parameter or sysfs option.
>  
> +config USB_CONFIGFS_BICR
> +	bool "Built-In CDROM emulation"
> +	depends on USB_CONFIGFS
> +	depends on BLOCK
> +	depends on USB_CONFIGFS_MASS_STORAGE
> +	select USB_F_BICR
> +	help
> +	  The Build-In CDROM Gadget acts as a CDROM emulation disk drive.
> +	  It is based on kernel option "USB_CONFIGFS_MASS_STORAGE".
> +	  As its storage repository it can use a regular file or a block
> +	  device (in much the same way as the "loop" device driver),
> +	  specified as a module parameter or sysfs option.
> +
>  config USB_CONFIGFS_F_LB_SS
>  	bool "Loopback and sourcesink function (for testing)"
>  	depends on USB_CONFIGFS
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 33c2264a0e35..9de1cd465635 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -315,6 +315,9 @@ struct fsg_common {
>  	void			*private_data;
>  
>  	char inquiry_string[INQUIRY_STRING_LEN];
> +
> +	/* For build-in CDROM */
> +	u8 bicr;
>  };
>  
>  struct fsg_dev {
> @@ -369,6 +372,10 @@ static void set_bulk_out_req_length(struct fsg_common *common,
>  	if (rem > 0)
>  		length += common->bulk_out_maxpacket - rem;
>  	bh->outreq->length = length;
> +
> +	/* some USB 2.0 hardware requires this setting */
> +	if (IS_ENABLED(USB_CONFIGFS_BICR))
> +		bh->outreq->short_not_ok = 1;
>  }
>  
>  
> @@ -527,7 +534,16 @@ static int fsg_setup(struct usb_function *f,
>  				w_length != 1)
>  			return -EDOM;
>  		VDBG(fsg, "get max LUN\n");
> -		*(u8 *)req->buf = _fsg_common_get_max_lun(fsg->common);
> +		if (IS_ENABLED(USB_CONFIGFS_BICR) && fsg->common->bicr) {
> +			/*
> +			 * When Built-In CDROM is enabled,
> +			 * we share only one LUN.
> +			 */
> +			*(u8 *)req->buf = 0;
> +		} else {
> +			*(u8 *)req->buf = _fsg_common_get_max_lun(fsg->common);
> +		}
> +		INFO(fsg, "get max LUN = %d\n", *(u8 *)req->buf);

Why this message all the time?  Drivers should be quiet if all is good.



>  
>  		/* Respond with data/status */
>  		req->length = min((u16)1, w_length);
> @@ -1329,7 +1345,7 @@ static int do_start_stop(struct fsg_common *common)
>  	}
>  
>  	/* Are we allowed to unload the media? */
> -	if (curlun->prevent_medium_removal) {
> +	if (!curlun->nofua && curlun->prevent_medium_removal) {
>  		LDBG(curlun, "unload attempt prevented\n");
>  		curlun->sense_data = SS_MEDIUM_REMOVAL_PREVENTED;
>  		return -EINVAL;
> @@ -2692,6 +2708,7 @@ int fsg_common_set_cdev(struct fsg_common *common,
>  	common->ep0 = cdev->gadget->ep0;
>  	common->ep0req = cdev->req;
>  	common->cdev = cdev;
> +	common->bicr = 0;
>  
>  	us = usb_gstrings_attach(cdev, fsg_strings_array,
>  				 ARRAY_SIZE(fsg_strings));
> @@ -2895,6 +2912,33 @@ static void fsg_common_release(struct fsg_common *common)
>  		kfree(common);
>  }
>  
> +#ifdef USB_CONFIGFS_BICR
> +ssize_t fsg_bicr_show(struct fsg_common *common, char *buf)
> +{
> +	return sprintf(buf, "%d\n", common->bicr);
> +}
> +
> +ssize_t fsg_bicr_store(struct fsg_common *common, const char *buf, size_t size)
> +{
> +	int ret;
> +
> +	ret = kstrtou8(buf, 10, &common->bicr);
> +	if (ret)
> +		return -EINVAL;
> +
> +	/* Set Lun[0] is a CDROM when enable bicr.*/
> +	if (!strcmp(buf, "1"))
> +		common->luns[0]->cdrom = 1;
> +	else {
> +		common->luns[0]->cdrom = 0;
> +		common->luns[0]->blkbits = 0;
> +		common->luns[0]->blksize = 0;
> +		common->luns[0]->num_sectors = 0;
> +	}
> +
> +	return size;
> +}
> +#endif
>  
>  /*-------------------------------------------------------------------------*/
>  
> @@ -3463,6 +3507,7 @@ void fsg_config_from_params(struct fsg_config *cfg,
>  		lun->ro = !!params->ro[i];
>  		lun->cdrom = !!params->cdrom[i];
>  		lun->removable = !!params->removable[i];
> +		lun->nofua = !!params->nofua[i];
>  		lun->filename =
>  			params->file_count > i && params->file[i][0]
>  			? params->file[i]
> diff --git a/drivers/usb/gadget/function/f_mass_storage.h b/drivers/usb/gadget/function/f_mass_storage.h
> index 3b8c4ce2a40a..7097e2ea5cc9 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.h
> +++ b/drivers/usb/gadget/function/f_mass_storage.h
> @@ -140,5 +140,8 @@ void fsg_common_set_inquiry_string(struct fsg_common *common, const char *vn,
>  void fsg_config_from_params(struct fsg_config *cfg,
>  			    const struct fsg_module_parameters *params,
>  			    unsigned int fsg_num_buffers);
> -
> +#ifdef CONFIG_USB_CONFIGFS_BICR
> +ssize_t fsg_bicr_show(struct fsg_common *common, char *buf);
> +ssize_t fsg_bicr_store(struct fsg_common *common, const char *buf, size_t size);
> +#endif
>  #endif /* USB_F_MASS_STORAGE_H */
> diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/gadget/function/storage_common.c
> index f7e6c42558eb..8fe96eeddf35 100644
> --- a/drivers/usb/gadget/function/storage_common.c
> +++ b/drivers/usb/gadget/function/storage_common.c
> @@ -441,6 +441,29 @@ ssize_t fsg_store_file(struct fsg_lun *curlun, struct rw_semaphore *filesem,
>  		return -EBUSY;				/* "Door is locked" */
>  	}
>  
> +	pr_notice("%s file=%s, count=%d, curlun->cdrom=%d\n",
> +			__func__, buf, (int)count, curlun->cdrom);
> +
> +	/*
> +	 * WORKAROUND for Android:
> +	 *   VOLD would clean the file path after switching to bicr.
> +	 *   So when the lun is being a CD-ROM a.k.a. BICR.
> +	 *   Don't clean the file path to empty.
> +	 */
> +	if (curlun->cdrom == 1 && count == 1)
> +		return count;
> +
> +	/*
> +	 * WORKAROUND: Should be closed the fsg lun for virtual cd-rom,
> +	 * when switch to other usb functions.
> +	 * Use the special keyword "off", because the init can
> +	 * not parse the char '\n' in rc file and write into the sysfs.
> +	 */
> +	if (count == 3 &&
> +			buf[0] == 'o' && buf[1] == 'f' && buf[2] == 'f' &&
> +			fsg_lun_is_open(curlun))
> +		((char *) buf)[0] = 0;

Why not fix Android userspace?  Wouldn't that be easier?

And the indentation here is really odd...

thanks,

greg k-h
