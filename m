Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A68CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B13214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDf86eTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbgCCTuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:50:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36925 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727604AbgCCTuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583265012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vf4h5E8IkOQ4lygsPliUgjFr5XtylcraEA/u77n/sos=;
        b=LDf86eTyZN5wa4esE33NT9Ibayu2gYGGQW1hw1SY9qsavOG7sVdN/xwbuLredk9NoJB18d
        8oqGQ4IPDAKjuXAbFJnWahbI1Wm96HgLLMIz2mRTUC1oKaRkBBxFqDArdyt1PH8kSA4Fcf
        AMPSWmfM/+QrxcAbsGqidLRw1d9k4I0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-ZxgUchyKM1WCIoLQf5S6hw-1; Tue, 03 Mar 2020 14:50:07 -0500
X-MC-Unique: ZxgUchyKM1WCIoLQf5S6hw-1
Received: by mail-qt1-f197.google.com with SMTP id j35so3001021qte.19
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 11:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vf4h5E8IkOQ4lygsPliUgjFr5XtylcraEA/u77n/sos=;
        b=qbLFDpSA2QD52q7niKAV14a3UhDPzGBY4YqwdxILpwf4RjsQjO1IQWmXYe3PB8rn1V
         zzOduqW/lwRQrqB5vlMq5H/Ryef+OI8rAiTel/RqPbCo2e27ZM6tTfnthzeojNhdGSxo
         eSqX+CEv25c7BXPvg5hhkfKBASGoDF/NpefnSKwro8XCVGP31u/TWwybYU0BGwas8a81
         7S5UE8kvYpsBfEKjx5GHU50E1UOoVyLAsUrBOGFUTLS6+Jcr0EnejJIEFQmxvaoI7bNz
         lm2OlPxPa5sQHoQNcBpfUTUBCf8IygHdmbAezniS2e+RgqIZpzTlIT23FlCjGGo+avTd
         WM7w==
X-Gm-Message-State: ANhLgQ22T0bVoqSE2bQ8xu16JEG4aOgyFFqQjTya2ifWX52GuP8Ws2/P
        gcWLH6utOb8Tf3gGRTwJd4NE+LfBSdgd5zE4bCWd9JmKR16Eeaa+bKZJY/cmyxOcdp++RFV8QXa
        F7AwgLCNIfhTFLnjTnRx+RnH7
X-Received: by 2002:ac8:357b:: with SMTP id z56mr6087792qtb.226.1583265007029;
        Tue, 03 Mar 2020 11:50:07 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuoqlsF5Q/fYco3ByAB69bUva9hDSW7kKRqW116dyUw2Moz1OhiY2NeJtVZGwucZU1EvvG+kQ==
X-Received: by 2002:ac8:357b:: with SMTP id z56mr6087777qtb.226.1583265006801;
        Tue, 03 Mar 2020 11:50:06 -0800 (PST)
Received: from desoxy ([2600:380:8e4d:1b16:f190:533c:5a8b:4a57])
        by smtp.gmail.com with ESMTPSA id f13sm8159246qkm.42.2020.03.03.11.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 11:50:06 -0800 (PST)
Message-ID: <8560ac83111aed7b4cf74b96ae578682a764f5c8.camel@redhat.com>
Subject: Re: [v2,2/3] drm/i915: Force DPCD backlight mode on X1 Extreme 2nd
 Gen 4K AMOLED panel
From:   Adam Jackson <ajax@redhat.com>
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@intel.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>
Date:   Tue, 03 Mar 2020 14:50:02 -0500
In-Reply-To: <20200211183358.157448-3-lyude@redhat.com>
References: <20200211183358.157448-3-lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.0 (3.34.0-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-11 at 13:33 -0500, Lyude Paul wrote:

> -	if (!intel_dp_aux_display_control_capable(intel_connector))
> +	/*
> +	 * There are a lot of machines that don't advertise the backlight
> +	 * control interface to use properly in their VBIOS, :\
> +	 */
> +	if (dev_priv->vbt.backlight.type !=
> +	    INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE &&
> +	    !drm_dp_has_quirk(&intel_dp->desc, intel_dp->edid_quirks,
> +			      DP_QUIRK_FORCE_DPCD_BACKLIGHT)) {
> +		DRM_DEV_INFO(dev->dev,
> +			     "Panel advertises DPCD backlight support, but "
> +			     "VBT disagrees. If your backlight controls "
> +			     "don't work try booting with "
> +			     "i915.enable_dpcd_backlight=1. If your machine "
> +			     "needs this, please file a _new_ bug report on "
> +			     "bugs.freedesktop.org against DRI -> "
> +			     "DRM/Intel\n");

Bugzilla's been put out of our misery, probably this should point to
gitlab instead.

- ajax

