Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23687C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF69C20829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N1IV89Qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgG3W7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgG3W7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:59:23 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279DEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 15:59:23 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w17so15578930ply.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1tCgxzZFgBmN5BP/Gtd6Qog3rehlHJS7ze5ylUHdc1Y=;
        b=N1IV89Qms8KPVjsZz44hlQRN5Tgf3vxJBHeNKOfZpH2aHlYzXqMHGaSvFRVvbQ3Swl
         JCJ8IzVXYQHetCQPZU0guumKE9xWI/8z23YXxm0VjAh97TXEw74fpzA7BeKfy3Hr12vh
         h3Pq9LZj+vSWzog2S9mzQIASEhI+sx/gWdTHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1tCgxzZFgBmN5BP/Gtd6Qog3rehlHJS7ze5ylUHdc1Y=;
        b=UYw+ng+I9QBSxVV3PYwR8FNH3C8Zb1Khupn5hA8a4RffdTMNnSAvOLZXbpQRWRAJyP
         8OzEU0lRCI/k3KAgI0OF0Zz6nWdnXIPNI/o8ZVWHZ+RBC+GBWQw/0gK15BgWAUfdGpVQ
         SB7Pud73vLUGgy3UTa3LlXy3nK2hW0P8UV42ynjHIZAfXNXJvqXqOUn24mvvFQJ9VGJn
         v1VAfimQigeS0KdPQrcLoX+P5qGk0Nvxax75JJHqf7Xv6/w1L2fR+p9M5X9UoZa9R771
         edVw0sVUlzBdk01ooc+OZxTFufFtm9Zj21uTkbtykiqUJgg4gaiDs9CIrrmjbvzrCddR
         fMeQ==
X-Gm-Message-State: AOAM533KBdOqm2GwTNasx++QilupOSh5OgILpdEjyzuavr5uBkIfo25o
        5BateNctIHqTTn7IFclt365ReA==
X-Google-Smtp-Source: ABdhPJxQYdudZr0u5Ior4Wwl11nPhAEG5OZyk58r6rJ0DsP9/VfKp0EejMb76y4UlAbhN/KOZA/Teg==
X-Received: by 2002:a62:5443:: with SMTP id i64mr1032634pfb.313.1596149962517;
        Thu, 30 Jul 2020 15:59:22 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id c134sm7415152pfc.115.2020.07.30.15.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:59:22 -0700 (PDT)
Date:   Thu, 30 Jul 2020 15:59:21 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Azhar Shaikh <azhar.shaikh@intel.com>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        heikki.krogerus@linux.intel.com, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com, rajmohan.mani@intel.com
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Send enum values
 to usb_role_switch_set_role()
Message-ID: <20200730225921.GC3145664@google.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
 <20200730225609.7395-2-azhar.shaikh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730225609.7395-2-azhar.shaikh@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Azhar,

On Thu, Jul 30, 2020 at 03:56:08PM -0700, Azhar Shaikh wrote:
> usb_role_switch_set_role() has the second argument as enum for usb_role.
> Currently depending upon the data role i.e. UFP(0) or DFP(1) is sent.
> This eventually translates to USB_ROLE_NONE in case of UFP and
> USB_ROLE_DEVICE in case of DFP. Correct this by sending correct enum
> values as USB_ROLE_DEVICE in case of UFP and USB_ROLE_HOST in case of
> DFP.
> 
> Fixes: 7e7def15fa4b ("platform/chrome: cros_ec_typec: Add USB mux control")
> 
> Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
> Cc: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Prashant Malani <pmalani@chromium.org>
> ---

Please add the list of changes in each version after the "---" line.

>  drivers/platform/chrome/cros_ec_typec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 3eae01f4c9f7..eb4713b7ae14 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -590,7 +590,8 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>  		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
>  
>  	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
> -					!!(resp.role & PD_CTRL_RESP_ROLE_DATA));
> +				       resp.role & PD_CTRL_RESP_ROLE_DATA
> +				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
>  }
>  
>  static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
> -- 
> 2.17.1
> 
