Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54410C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D561207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="slqjhI49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgFDGol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 02:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgFDGol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 02:44:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE61BC03E96D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 23:44:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q11so4804543wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 23:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+gzwZ+GVL/HnJJ2Ggtgyw16DZMXF2l13HXz40MqkfTs=;
        b=slqjhI4951CeoWRsLAz8FNwjYQV+eB7IDNz0IfLAOTIYqUARCzY5Kn0H/3SdvPkQE2
         Bagq6mR1TiEEIWO/2JLEnPxpCgMF7iuWBGfZjZipcOyyBRJodUXNOFkiGUAPqn0LS9il
         O2/kDBMiRrrYkYzibwc/zCpT02Gk0a/52sOH2CDphB4ftmtnAIo7Q6wZYXr3aUCJpDWv
         VilzyR4CpTym+zjbcIg+uKjGKNxBJgYkVhWcxcvl2Q0pRdhEiudVrP3ndlNEDtstkd+Y
         TW9Nu7H89gC2NC4Bt4KMCwJ1xLvhXxZ1qIiuV4wkVwcLsb2alQw94nryvv59VEUUQxje
         V4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+gzwZ+GVL/HnJJ2Ggtgyw16DZMXF2l13HXz40MqkfTs=;
        b=fNpmddy805KVysZNUAfk6LIGCaRIGc3u3/PLntHqLE1gYb+er3wV2Z8o9rQcJsgh6z
         MzBjlQfLGydTylpxW9tSOdeRgUko+DegqIJa6tGEFXFTaLr74DKI0qxYLbx/BCTJV2ez
         P6AHN6CuwD7at/gvr6/tK1cKpa48PIZLtt3lP6MgH/rsvdcebBM59KP7+vDy0ZnZPGcA
         dL4mqhIu4c8o4igVibXTdMTDUkexq7W5vFI54RljMtjwz+smVSM7I+52pHmb7/vTbU/x
         XvF0amIbrOBcwl0+0KRq/0BmER7OnbLxSc68xhFyu4E7F+Q84MOd8Kz8dyQZK833QmQp
         2gVw==
X-Gm-Message-State: AOAM530fBuknCwQKLyhOmVPKoknzyraad9Lekhguciojy4ykzAJVuy7N
        zxJ9a/L2YdbakG6nF5uDGflDCg==
X-Google-Smtp-Source: ABdhPJxvT5tF8Mpqwaj0xczrxZInUWDnMzOZ1fVUBkKbhh8C40jwkuQWYhBfCgps2rMX/rPKvW0BSA==
X-Received: by 2002:adf:f582:: with SMTP id f2mr3135953wro.204.1591253079333;
        Wed, 03 Jun 2020 23:44:39 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id q13sm6319606wrn.84.2020.06.03.23.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 23:44:38 -0700 (PDT)
Date:   Thu, 4 Jun 2020 07:44:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Keerthy <j-keerthy@ti.com>, Axel Lin <axel.lin@ingics.com>
Subject: Re: [RFC 4/4] regulator: lp87565: add LP87524-Q1 variant
Message-ID: <20200604064435.GR3714@dell>
References: <20200603200319.16184-1-luca@lucaceresoli.net>
 <20200603200319.16184-5-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200603200319.16184-5-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jun 2020, Luca Ceresoli wrote:

> Add support for the LP87524B/J/P-Q1 Four 4-MHz Buck Converter. This is a
> variant of the LP87565 having 4 single-phase outputs and up to 10 A of
> total output current.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/mfd/lp87565.c       | 4 ++++
>  include/linux/mfd/lp87565.h | 1 +

Again, this is an MFD patch.  Please change the subject line.

>  2 files changed, 5 insertions(+)

Once changed, please re-submit with my:

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
