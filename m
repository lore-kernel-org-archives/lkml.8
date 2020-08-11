Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3C7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53871206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjPUmn9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgHKGTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgHKGTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:19:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88191C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:19:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k13so6288910plk.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QbYFQHGSCXTkvfzhzlvcOi9Xb1MZRYIzSuZhAaf4ogg=;
        b=jjPUmn9Lsaby7YWOEHYVxw7NjUcc2XEAqI+KTvGwJbQ5sXeI0N7xtHBwQhgdkH9QwM
         cCW7V6UicLfBIyKXAmvO9I6eygdvPopF4k5ayaoKxvsMHhQx7+NywLzHDeDEoIwfDWHj
         +BSq5yRlsxeC37IUkWWrpFKFU8QZnzNYiTSqrpKYFRlYecG5ua3/hI0Q/FigPoFpn2zh
         9Z58I7TymrMm7j0xweui01+Ru9wVlhRLtu4YyUagwJqG5wmrpsMxTwFbrddl2YxPcjvg
         AyLxKfbY0p7pcF4CMAVCU2TiXPxhxgkmix1XbtnO2ed0oFjWx0zNE9ce9SpkzjaNaJ6z
         5Gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QbYFQHGSCXTkvfzhzlvcOi9Xb1MZRYIzSuZhAaf4ogg=;
        b=jg4F2+ZdZgE5flPEyBN6WoncfE+fhfhVLWwXl8b/zopx4kVubdjrhV0VGbE5jcUavV
         LGGySBjCHLpmYirZ9uv3ujWG/mzqhqrR70GGq19p5+rWHuSaX8LBkAOcgN3VBLO+2dqc
         u7gj8outHOnsnQrDKfhJx99uuK7U0c6LGpcN92w3lWMACvKMmWbRX0VNIqnLDrdh2ImO
         SVt/Z5OlJ/MfWokhol25dOuy49lvBUt236AZiHb685kGTQsTDXzuZsXG9Ll3qQDHJfvy
         o3Yt0vi/Z0yL4DWeKq9b8VbTuJRSdsHgrf5TiPuJIooakUyQiI3JY/rk6Ay+jbFInNaa
         Eb3A==
X-Gm-Message-State: AOAM532k1yX6HxHzDg3oNED2k7ccA8P/gm+/0S2w0K7ujXjaMmDQpT4i
        ZfHiwmv28bMK6aFIpO6h1e1f
X-Google-Smtp-Source: ABdhPJx2lcz2WImeiaWDVuA+zI4eXGDZSWy/gMYcxblM3kwTHN5s884Cxps+4YXpyVXiEjSxsjNF7A==
X-Received: by 2002:a17:90a:b386:: with SMTP id e6mr3150762pjr.57.1597126746781;
        Mon, 10 Aug 2020 23:19:06 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:699:2bc7:b9eb:9a30:bf89:3f3d])
        by smtp.gmail.com with ESMTPSA id y23sm23826436pfb.66.2020.08.10.23.19.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Aug 2020 23:19:05 -0700 (PDT)
Date:   Tue, 11 Aug 2020 11:48:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 11/11] bus: mhi: core: Introduce sysfs entries for MHI
Message-ID: <20200811061858.GB2762@Mani-XPS-13-9360>
References: <1597096865-19636-1-git-send-email-bbhatt@codeaurora.org>
 <1597096865-19636-12-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597096865-19636-12-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 03:01:05PM -0700, Bhaumik Bhatt wrote:
> Introduce sysfs entries to enable userspace clients the ability to read
> the serial number and the OEM PK Hash values obtained from BHI. OEMs
> need to read these device-specific hardware information values through
> userspace for factory testing purposes and cannot be exposed via degbufs
> as it may remain disabled for performance reasons. Also, update the
> documentation for ABI to include these entries.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  Documentation/ABI/stable/sysfs-bus-mhi | 21 ++++++++++++++
>  MAINTAINERS                            |  1 +
>  drivers/bus/mhi/core/init.c            | 53 ++++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
>  create mode 100644 Documentation/ABI/stable/sysfs-bus-mhi
> 
> diff --git a/Documentation/ABI/stable/sysfs-bus-mhi b/Documentation/ABI/stable/sysfs-bus-mhi
> new file mode 100644
> index 0000000..59da56d
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-bus-mhi
> @@ -0,0 +1,21 @@
> +What:		/sys/bus/mhi/devices/.../serialnumber
> +Date:		Aug 2020
> +KernelVersion:	5.10
> +Contact:	Bhaumik Bhatt <bbhatt@codeaurora.org>
> +Description:	The file holds the serial number of the client device obtained
> +		using a BHI (Boot Host Interface) register read after at least
> +		one attempt to power up the device has been done. If read
> +		without having the device power on at least once, the file will
> +		read all 0's.
> +Users:		Any userspace application or clients interested in device info.
> +
> +What:		/sys/bus/mhi/devices/.../oem_pk_hash
> +Date:		Aug 2020
> +KernelVersion:	5.10
> +Contact:	Bhaumik Bhatt <bbhatt@codeaurora.org>
> +Description:	The file holds the OEM PK Hash value of the endpoint device
> +		obtained using a BHI (Boot Host Interface) register read after
> +		at least one attempt to power up the device has been done. If
> +		read without having the device power on at least once, the file
> +		will read all 0's.
> +Users:		Any userspace application or clients interested in device info.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db..5e49316 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11018,6 +11018,7 @@ M:	Hemant Kumar <hemantk@codeaurora.org>
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
> +F:	Documentation/ABI/stable/sysfs-bus-mhi
>  F:	Documentation/mhi/
>  F:	drivers/bus/mhi/
>  F:	include/linux/mhi.h
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 972dbf0..c086ef2 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -76,6 +76,56 @@ const char *to_mhi_pm_state_str(enum mhi_pm_state state)
>  	return mhi_pm_state_str[index];
>  }
>  
> +static ssize_t serial_number_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct mhi_device *mhi_dev = to_mhi_device(dev);
> +	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> +
> +	return snprintf(buf, PAGE_SIZE, "Serial Number: %u\n",
> +			mhi_cntrl->serial_number);
> +}
> +static DEVICE_ATTR_RO(serial_number);
> +
> +static ssize_t oem_pk_hash_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct mhi_device *mhi_dev = to_mhi_device(dev);
> +	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> +	int i, cnt = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++)
> +		cnt += snprintf(buf + cnt, PAGE_SIZE - cnt,
> +				"OEMPKHASH[%d]: 0x%x\n", i,
> +				mhi_cntrl->oem_pk_hash[i]);
> +
> +	return cnt;
> +}
> +static DEVICE_ATTR_RO(oem_pk_hash);
> +
> +static struct attribute *mhi_sysfs_attrs[] = {
> +	&dev_attr_serial_number.attr,
> +	&dev_attr_oem_pk_hash.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group mhi_sysfs_group = {
> +	.attrs = mhi_sysfs_attrs,
> +};
> +
> +static int mhi_create_sysfs(struct mhi_controller *mhi_cntrl)
> +{
> +	return sysfs_create_group(&mhi_cntrl->mhi_dev->dev.kobj,
> +				  &mhi_sysfs_group);
> +}
> +
> +static void mhi_destroy_sysfs(struct mhi_controller *mhi_cntrl)
> +{
> +	sysfs_remove_group(&mhi_cntrl->mhi_dev->dev.kobj, &mhi_sysfs_group);
> +}
> +
>  /* MHI protocol requires the transfer ring to be aligned with ring length */
>  static int mhi_alloc_aligned_ring(struct mhi_controller *mhi_cntrl,
>  				  struct mhi_ring *ring,
> @@ -917,6 +967,8 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>  	mhi_cntrl->mhi_dev = mhi_dev;
>  
>  	mhi_create_debugfs(mhi_cntrl);
> +	if (mhi_create_sysfs(mhi_cntrl))
> +		dev_err(mhi_cntrl->cntrl_dev, "Failed to create sysfs entries\n");
>  
>  	return 0;
>  
> @@ -940,6 +992,7 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
>  	struct mhi_chan *mhi_chan = mhi_cntrl->mhi_chan;
>  	unsigned int i;
>  
> +	mhi_destroy_sysfs(mhi_cntrl);
>  	mhi_destroy_debugfs(mhi_cntrl);
>  
>  	kfree(mhi_cntrl->mhi_cmd);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
