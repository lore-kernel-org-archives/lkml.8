Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C873C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCA120720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595321626;
	bh=fJDP3yNOl/K866uMpL/NF2K1ZrUibrxeuk4+kAdVEig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k90/m9W0q1o/Miu6789nOsQOd2Rnx/IwJQo81ahOXRdGdphLh5lf0fHcB7i0wzBSO
	 kLydJ+SDTCRazoQ/M4UEwaDHTDhvasWB1vXVJhqZnbsbYw4RDJAaomMNuambp1I/Qn
	 Ul0RnMVTwjPjPZPIwXBj3dJBuHjOyRGgoXP8aODw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgGUIxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGUIxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:53:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A62820717;
        Tue, 21 Jul 2020 08:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595321624;
        bh=fJDP3yNOl/K866uMpL/NF2K1ZrUibrxeuk4+kAdVEig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ss7FxF0BYDAQpdKWRJnTELxmW8ub3Ej1d6E9JM7JMbRi2DSwpfY3gfBhoTVkWPeSK
         EkzTh0cY9Gl/ek/TxlbWqdUBbj673P20PNY7hoewH3IAiaLbhyrkXygSu7pI+WMyuz
         I6wVq7/BqADb/6w8z6PlIcqbRa5SkvdpFiqle8fc=
Date:   Tue, 21 Jul 2020 10:53:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: modules: remove set but not used variable
 'no_warn'
Message-ID: <20200721085353.GA1664942@kroah.com>
References: <20200721084144.13545-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721084144.13545-1-zhengyongjun3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 04:41:44PM +0800, Zheng Yongjun wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/base/module.c: In function 'module_add_driver':
> drivers/base/module.c:33: warning:
> variable 'no_warn' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/base/module.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/module.c b/drivers/base/module.c
> index 46ad4d636731..d1060c504c1b 100644
> --- a/drivers/base/module.c
> +++ b/drivers/base/module.c
> @@ -33,7 +33,6 @@ static void module_create_drivers_dir(struct module_kobject *mk)
>  void module_add_driver(struct module *mod, struct device_driver *drv)
>  {
>  	char *driver_name;
> -	int no_warn;
>  	struct module_kobject *mk = NULL;
>  
>  	if (!drv)
> @@ -59,11 +58,11 @@ void module_add_driver(struct module *mod, struct device_driver *drv)
>  		return;
>  
>  	/* Don't check return codes; these calls are idempotent */
> -	no_warn = sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
> +	sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");

So you fix one warning for another one?  Did you test build this change?

