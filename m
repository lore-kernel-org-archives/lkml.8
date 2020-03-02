Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1857AC3F2D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A7E246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583140995;
	bh=WdNgLQOUJ6VX5OtVOQNN869MeH5t74rvlLLGcpdCCDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pJk/ThN7GwpL8Ah4uiJpRGoW9Uyy6E1SfglIrBmk3NHIVqhqt2slwX9rv57KYbym+
	 6zDF3VBg8WEN4mYkcrRtGEI9R+lu6VJgM4lk5tE/8kd9RU/zZ4Ucl5tj+vSw8Qazi0
	 wKF8IqTT9NAO2xfQUTk1VnkHZOo0JlSPxaAYq2R4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCBJXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:23:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgCBJXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:23:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0808624695;
        Mon,  2 Mar 2020 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583140992;
        bh=WdNgLQOUJ6VX5OtVOQNN869MeH5t74rvlLLGcpdCCDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CDpjS0YvNXYTu5tjMmr8FSYqx7dJhkBDCzuxJB5z+PTPttOR9RgNDVH/rSSr2PArj
         dwms1o7h1VMVAR/AEyUHlmDv/WzDik0r5FKQrXUo2UzRd+7qsXGpjMuFFnMiCqzOyB
         mxRGAPbZKa+zFb73Ru5MV3tFmWWD9BUnGIcnJxrM=
Date:   Mon, 2 Mar 2020 10:23:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hongbo Yao <yaohongbo@huawei.com>
Cc:     christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, chenzhou10@huawei.com, rjw@rjwysocki.net,
        pavel@ucw.cz
Subject: Re: [PATCH -next] drivers/base/power: fix build error without SYSFS
Message-ID: <20200302092308.GA1997164@kroah.com>
References: <20200302092918.40163-1-yaohongbo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302092918.40163-1-yaohongbo@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 05:29:18PM +0800, Hongbo Yao wrote:
> If CONFIG_SYSFS=n, the following error is seen while building 
> drivers/base/power/sysfs.c:
> 
> drivers/base/power/sysfs.c: In function dpm_sysfs_change_owner:
> drivers/base/power/sysfs.c:708:44: error: passing argument 2 of
> sysfs_group_change_owner from incompatible pointer type
> [-Werror=incompatible-pointer-types]
>   rc = sysfs_group_change_owner(&dev->kobj, &pm_attr_group, kuid, kgid);
>                                             ^
> In file included from ./include/linux/kobject.h:20:0,
>                  from ./include/linux/device.h:17,
>                  from drivers/base/power/sysfs.c:3:
> ./include/linux/sysfs.h:564:19: note: expected const struct
> attribute_group ** but argument is of type const struct attribute_group *
> 
> dpm_sysfs_change_owner() should only used when CONFIG_SYSFS is
> defined.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 3b52fc5d7876 ("drivers/base/power: add dpm_sysfs_change_owner()")
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> ---
>  drivers/base/power/power.h | 10 +++++++++-
>  drivers/base/power/sysfs.c |  2 ++

You shouldn't have to add #ifdefs to a .c file here, it should all be
able to be fixed in the .h file by putting proper "empty" functions.

thanks,

greg k-h
