Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63851C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35269206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="axyEP3Qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgGHXVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgGHXVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:21:38 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBD5C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 16:21:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id i14so136675pfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 16:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aWbEsQ54hjjSOfJj7PQhDsC6GNOyST30pEElPtE2K0Q=;
        b=axyEP3QxBfqQyEv9X2FCuSp03HkD7jBoS5PeshAW+/HPgWeJyf70rB3+wl+gNsvL4z
         OFhXfmS9p2HHWFWbT6keuWPM581K76MKzFcl5aZm9ncPSpKj9nOmfqzNPgZqoe9kikWg
         ZH1SeW27U4goZRxSItFv5LyG711am+m7a3hd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aWbEsQ54hjjSOfJj7PQhDsC6GNOyST30pEElPtE2K0Q=;
        b=JlM4ecpmJqbOGuc3OyZZI6/TPy7k0dWJPFYFUavYw5wJGhUma8fLyA8QAHnvcoUDIX
         sT3kpn53yTosmEiD6PgPl8BpS2LZaPIis8NVpKZKjyHROImQ7TH3UMCRKdenz4PA8Svx
         skjMmybD2TdCFSwm4Xfax89eUUT/+YACIHuWqOoIUFF4nXzpKY08KhuEtvwhwOrzE79I
         mUpJQXtP3J0ojOF/XLDiyVZtLQg8Wc4MErXL9AjqIaMoxuwE+RT98sHmMCLOiN3jdqux
         T1N/I7X4Yw/T+QlbG1+tSImac+zNQFg4M1xCCoiDzAMA3c52979+mLJU8T0TBT8yh4Dp
         q8WQ==
X-Gm-Message-State: AOAM530VDmFNf91URIiiyIMx2d95nHu+GxEtYfZdzLAx13Y7eaPBJJUR
        XNAPjA5euu9N7+IQ+fTpC1mAaw==
X-Google-Smtp-Source: ABdhPJwvMUAhxUfcwwUAmLp0XxTDFXEUcQ7x0gVaGJAbtyOUVE5rAUl6MbmzKSY9U6JBjKNN4941iQ==
X-Received: by 2002:aa7:8283:: with SMTP id s3mr56731226pfm.90.1594250497690;
        Wed, 08 Jul 2020 16:21:37 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id 64sm782880pgb.63.2020.07.08.16.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:21:37 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:21:36 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: USB4 support
Message-ID: <20200708232136.GB68629@google.com>
References: <20200703081703.87720-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703081703.87720-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 03, 2020 at 11:17:03AM +0300, Heikki Krogerus wrote:
> +static int cros_typec_enable_usb4(struct cros_typec_data *typec,
> +				  int port_num,
> +				  struct ec_response_usb_pd_control_v2 *pd_ctrl)
> +{
> +	struct cros_typec_port *port = typec->ports[port_num];
> +	struct enter_usb_data data;
> +
> +
> +	/* REVISIT: Cable Current? */

Since we don't pull this data out of the EC currently, I think we can just drop
this for now (the "Mux" drivers aren't using this data at the moment
either).

> +
> +	/* REVISIT: Claiming unconditionally that all tunnels are supported. */
> +	data.eudo |= EUDO_PCIE_SUPPORT;
> +	data.eudo |= EUDO_DP_SUPPORT;
> +
> +	data.eudo |= EUDO_TBT_SUPPORT;
> +	data.eudo |= EUDO_HOST_PRESENT;

I think it's fine to drop this block altogether. I don't think any of
the current "Mux" drivers parse this information, and we aren't surfacing
it from the Chrome EC.

> +
>  	} else if (mux_flags & USB_PD_MUX_DP_ENABLED) {
>  		ret = cros_typec_enable_dp(typec, port_num, pd_ctrl);
> -- 
> 2.27.0
> 

I'll wait for a day for any comments for the maintainers, and if not,
I'll upload v2 of this patch with the "REVISIT" comments omitted.

Thanks,

-Prashant
