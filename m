Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9742C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D812217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RmilMONI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgCDRtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:49:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39463 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgCDRs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:48:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id s2so1328407pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rbVdOqdLtvL6BAjB45nh8iw0l22p38/imiSMDTNUS1g=;
        b=RmilMONIsWX5ITGHh/3Tz0BXxVTpJdfnbUH6z4TsuRn/17NBt+MvQoLd5buS1yOzUB
         nkeJ7CFPtOhoNTRVbK9hwVHktFeafsOz6QkdmS717th+puCwcPR6bqz8e/Cdst2nwVnY
         hbWoZziMH/zj7th1OSiCWAPA36t7dHUC2e/SSERdKVNmMeB8r/7HP2Ws6hnmI3f0G5ns
         SGnuMyWia11GEv4g0Fc+8FXIcE6ubkJLJnpOkZp9lJ++OJz0tPA61fuUPn79XHBtHQLE
         sVAigcD4F+628Wyct34PMr1uU5ByLCwgtoTM2QNSZKivmkGzTMJffZ6x9aVkt1a1LAKD
         mEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rbVdOqdLtvL6BAjB45nh8iw0l22p38/imiSMDTNUS1g=;
        b=SR9l4nbnPjmowJfuJ/pvrbdyiWmU0hGHuaD8NMhuqKfU0a33QBISgmccTZdl9WLqnw
         /nIm5B8N8lzUioQ/opwd/pnuZu1+i7M6WMhb4eCzEIHSGrhWG9MMYOKUKdktF4EGwvdE
         XBmX24pVhQM++FFRNfBQvSlKvZypSlqWYOOahaghTvwJ5SZWUpn8uCTnoiqvH92HfvST
         ySkzySZKrasq27+vP1aXKFkgiDSBo45XskFSpkRgXdvD7cSRpb9FI99ZldLcVZXzPitL
         9NZmifk2J+TWHIyMAjhsqpodjTo8GOuL5Crxmz8sj88Q0RClzBLtT8Qdo3UsBqupnyoi
         mGFA==
X-Gm-Message-State: ANhLgQ3UXH29Oz+1EcPFKN+rTgmGNKGNMbFQAPTF3VbUUJi2YhGgC8vF
        bgxgI2xK8ma48zQQdJ2EZc0PNA==
X-Google-Smtp-Source: ADFU+vtQk1N88Lqfci1AwA7ASz3zTHYO2ALb0KW4ABIckdRB45gMq7yc209oZ5jZ+JaAPbD9Ywz+1g==
X-Received: by 2002:a62:25c3:: with SMTP id l186mr4167416pfl.52.1583344138873;
        Wed, 04 Mar 2020 09:48:58 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k16sm2844987pfh.127.2020.03.04.09.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:48:58 -0800 (PST)
Date:   Wed, 4 Mar 2020 10:48:56 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, afd@ti.com, s-anna@ti.com,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCHv7 08/15] remoteproc/omap: Remove the platform_data header
Message-ID: <20200304174856.GG8197@xps15>
References: <20200221101936.16833-1-t-kristo@ti.com>
 <20200221101936.16833-9-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221101936.16833-9-t-kristo@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 12:19:29PM +0200, Tero Kristo wrote:
> The platform data header for OMAP remoteproc is no longer used for
> anything post ti-sysc and DT conversion, so just remove it completely.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Acked-by: Suman Anna <s-anna@ti.com>

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  include/linux/platform_data/remoteproc-omap.h | 51 -------------------
>  1 file changed, 51 deletions(-)
>  delete mode 100644 include/linux/platform_data/remoteproc-omap.h
> 
> diff --git a/include/linux/platform_data/remoteproc-omap.h b/include/linux/platform_data/remoteproc-omap.h
> deleted file mode 100644
> index 7e3a16097672..000000000000
> --- a/include/linux/platform_data/remoteproc-omap.h
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Remote Processor - omap-specific bits
> - *
> - * Copyright (C) 2011 Texas Instruments, Inc.
> - * Copyright (C) 2011 Google, Inc.
> - */
> -
> -#ifndef _PLAT_REMOTEPROC_H
> -#define _PLAT_REMOTEPROC_H
> -
> -struct rproc_ops;
> -struct platform_device;
> -
> -/*
> - * struct omap_rproc_pdata - omap remoteproc's platform data
> - * @name: the remoteproc's name
> - * @oh_name: omap hwmod device
> - * @oh_name_opt: optional, secondary omap hwmod device
> - * @firmware: name of firmware file to load
> - * @mbox_name: name of omap mailbox device to use with this rproc
> - * @ops: start/stop rproc handlers
> - * @device_enable: omap-specific handler for enabling a device
> - * @device_shutdown: omap-specific handler for shutting down a device
> - * @set_bootaddr: omap-specific handler for setting the rproc boot address
> - */
> -struct omap_rproc_pdata {
> -	const char *name;
> -	const char *oh_name;
> -	const char *oh_name_opt;
> -	const char *firmware;
> -	const char *mbox_name;
> -	const struct rproc_ops *ops;
> -	int (*device_enable)(struct platform_device *pdev);
> -	int (*device_shutdown)(struct platform_device *pdev);
> -	void (*set_bootaddr)(u32);
> -};
> -
> -#if defined(CONFIG_OMAP_REMOTEPROC) || defined(CONFIG_OMAP_REMOTEPROC_MODULE)
> -
> -void __init omap_rproc_reserve_cma(void);
> -
> -#else
> -
> -static inline void __init omap_rproc_reserve_cma(void)
> -{
> -}
> -
> -#endif
> -
> -#endif /* _PLAT_REMOTEPROC_H */
> -- 
> 2.17.1
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
