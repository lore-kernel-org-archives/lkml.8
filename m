Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44E8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B1D206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CO/02akx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbgF2TXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732286AbgF2TWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:22:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72A6C030F36
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:55:10 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d6so8274385pjs.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kUM1mXfELRgjA6MU4WdEpzrQgsH/2ddDYAafM5iYb98=;
        b=CO/02akxkxQng0CJuEdRFe2rtSJ3/+36BM6oHqD5HnhzJq+/eOJXQebW54nQRoMXJY
         S2UUisZLvJTeHOcazoj4qyBOIbZQgglQ4KLfNtSXV7be48ppsaYdoI53xtB2G4NbBzHh
         dI+YIT+29QW1ts5DOH8edepKGvnFUFKWUtm+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kUM1mXfELRgjA6MU4WdEpzrQgsH/2ddDYAafM5iYb98=;
        b=dXPVqXU1MtfiPuCuw/Mq/QDfzNmyB9CaL9H0+7WWG14134bugAedYQdZ/H3tx55voF
         GvcH4IiqzEdkZ2HkAjue7AULc9RZhIhraJ5DuAnn6sNUad6qmOV5OrQn+x18D7yvjZRi
         HjDdOqzP6oPHki3HH3u/XdqLuU5sygFZDn2iaGtZ0/0lCie/0dPp23pWEyOnobM/Qx/H
         YxWd3MtvLWJr9UVMNSeJj4q5FDhhtRCVCe559ZwAizfrYnhzO8Q1LsBG9kxw1wMMdZHG
         zCV+zosdttPsWDGSMMI+PmgnERvJB3wfsBNA6EXzGw8WRAqoFjXKNIk706+qdclHzJ29
         7Mkw==
X-Gm-Message-State: AOAM531Wv7H9HRO60uVbs3p47Obs7dMlVMDJjABwSPjoIDz/B8fDKvJR
        FFWYbzoqHBTTlPYB6QWGxIbnUsq9LfM=
X-Google-Smtp-Source: ABdhPJwQIloKsHboa7XMiYHtizUYgjYAhD3hgbBpp2T3c+4Gg5ML1N5lbKJMVIf0O1QXYsvZ7Int9w==
X-Received: by 2002:a17:90a:fe10:: with SMTP id ck16mr19197658pjb.147.1593449710318;
        Mon, 29 Jun 2020 09:55:10 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id t19sm308886pgg.19.2020.06.29.09.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:55:09 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:55:09 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, kernel test robot <lkp@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Add a dependency on
 USB_ROLE_SWITCH
Message-ID: <20200629165509.GB235106@google.com>
References: <20200629103223.1284442-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629103223.1284442-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thanks for the patch.

On Mon, Jun 29, 2020 at 12:32:23PM +0200, Enric Balletbo i Serra wrote:
> As reported by the kernel test robot the cros_ec_typec driver fails to
> build if the USB_ROLE_SWITCH is not selected, to fix that, add a
> dependency on that symbol. This fixes the following build error:
> 
>    drivers/platform/chrome/cros_ec_typec.c:133: undefined reference to `usb_role_switch_put'
>    ld: drivers/platform/chrome/cros_ec_typec.o: in function `cros_typec_get_switch_handles':
>    drivers/platform/chrome/cros_ec_typec.c:108: undefined reference to `fwnode_usb_role_switch_get'
>    ld: drivers/platform/chrome/cros_ec_typec.c:117: undefined reference to `usb_role_switch_put'
> 
> Fixes: 7e7def15fa4b ("platform/chrome: cros_ec_typec: Add USB mux control")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Prashant Malani <pmalani@chromium.org>

> ---
> 
>  drivers/platform/chrome/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index cf072153bdc5..a056031dee81 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -218,6 +218,7 @@ config CROS_EC_TYPEC
>  	tristate "ChromeOS EC Type-C Connector Control"
>  	depends on MFD_CROS_EC_DEV && TYPEC
>  	depends on CROS_USBPD_NOTIFY
> +	depends on USB_ROLE_SWITCH
>  	default MFD_CROS_EC_DEV
>  	help
>  	  If you say Y here, you get support for accessing Type C connector
> -- 
> 2.27.0
> 
