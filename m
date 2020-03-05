Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8A9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0901B208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="sAdchzbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCEKBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:01:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42676 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCEKBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:01:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id h8so2511478pgs.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 02:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d+aqQE01oMJb6UAMOBubBoPlQDg0qTH2nDZoUSvA2Pw=;
        b=sAdchzbzWdhLon0k5KU9t969rKbfqBHE5ntd8N0XREvIVOQx75SkoByrm8ZtpBglwn
         JJwH+kZSo7V/xCdkndKCh+lFMzbfUjv2Ir9+VCbd1X+M1N1Vn6XWMdhFpdHIJ9AsBIEe
         /juGIbSFekuuNZl8IP1yGZpwpqyvTiXVpqlpYiyvf0HKPaMmi5Kppi3Oj12PyV1Bi7IH
         pishhBkEccoaWKKJF5dPSq8B3ToteJr8pHBxbflhJdhNWtETENPUr51Qvo9YbTz+D983
         G5O/+EFXyo5OYGBh9r9qucLV80RCKMyGcQa8r5LjSrNnTTsCizsY6sLSgS+HH311phvh
         mwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+aqQE01oMJb6UAMOBubBoPlQDg0qTH2nDZoUSvA2Pw=;
        b=pnt7EyjHDhjTf4XfKowj3UFv+oI79O+KKvLp20ND+/COvGRDlDAEkvHFIPacBgZI5Y
         dG0/EqouoHFZvgw0zCGp1UKKja7mJBcZb/b7YPKweTNEVf8+GeQFL4iUJGC8kToc2DU3
         z03uRhBH55qdY/BJ8rBfnJ8wwMs9oHh+uADMiPl+aTZg5+EIy0rDdYACttGEhdeeEUen
         9exKyLUPi2hIXn41U1Ai4VLkGBcikP0KKb+cudY1lvfvfSF/OJV8wrqC4d+swqRL9XnH
         DVudaQ9Lsdzx3FTT7fHjYdbuSAd80VZ689EICr58052lnIYwDDZBGt7PCEE42meFF8WS
         Q14g==
X-Gm-Message-State: ANhLgQ0L60y/CEd3p+cXTnw58sM7/bD32GR/1IpRUqzivXRDlSjOWlbd
        IuiAJ+xiwFnNfFfiIbGZkDlPmi9HAuk=
X-Google-Smtp-Source: ADFU+vshcthIRHvuvF4c67fKbNw4z5+YYa5m9qu+uE4WbbYTJtO7NJ2lNM6SgCVG0yZe2IUd7F7Ang==
X-Received: by 2002:aa7:958f:: with SMTP id z15mr7770264pfj.205.1583402474728;
        Thu, 05 Mar 2020 02:01:14 -0800 (PST)
Received: from starnight.local ([150.116.255.181])
        by smtp.googlemail.com with ESMTPSA id x4sm26340400pgi.76.2020.03.05.02.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 02:01:14 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>, linux@endlessm.com
Subject: Re: [PATCH 70/89] drm/vc4: hdmi: Remove vc4_dev hdmi pointer
Date:   Thu,  5 Mar 2020 18:00:46 +0800
Message-Id: <20200305100046.55388-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index 1e44a3a8c2b0..d5c832c99460 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -73,7 +73,6 @@  struct vc4_perfmon {
>  struct vc4_dev {
>  	struct drm_device *dev;
>  
> -	struct vc4_hdmi *hdmi;

Tested the building based on kernel v5.6-rc4 and linux-next/next-20200225.
The hdmi removed here still be used in drivers/gpu/drm/vc4/vc4_hdmi.c.
If DRM_VC4_HDMI_CEC is not disabled in building config, then it will hit
building error.

Jian-Hong Pan

>  	struct vc4_hvs *hvs;
>  	struct vc4_v3d *v3d;
>  	struct vc4_dpi *dpi;
