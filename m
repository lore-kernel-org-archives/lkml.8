Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6012BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B3B206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDycELU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFPICf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPICe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:02:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97680C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:02:33 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u26so1670741wmn.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DG9CsBoSold8ADvr08jzS2w4s4f2Yjsljc/HghN3K7E=;
        b=MDycELU7Yw9Bm0J8WL/xNoYK3RlcszGjNFK7EtI8mK4zRoh+fLTtLSpSMJ/3VoqdjR
         QSltXb2CyfvzxQJubpJfDmYVP1z0vJ8aZCSgbmAz0mJYl+Hf5GfF1Im9mjK8rcqEhvDg
         sRZFCujj8lwYEkNCWZFgvgTUv8owD3NS1VATRJ64gQsTopI59EY0fXYLnpPMrbayHz11
         ADcuzxP54LmUnotsEuMH0b9a6bb5wO2cZ5pW5vRNlqj/j4izem04ROUYxE60C9W/wdNX
         Aa+2LAH5axN3l3/BGVgQv6LTldXomMViD5BS01AaHnqtDKpYPgAkP9M6u1Uz2/Uygu6+
         49ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DG9CsBoSold8ADvr08jzS2w4s4f2Yjsljc/HghN3K7E=;
        b=aN5o6Hz+AAerD6lanTeR9wrUlSQU43+XEWYd8eVxT097z2tKAO/q3uPVlW5bIu5dWN
         OsGjhqOxvraBqiuxoKq2UIGcr1E61C9yrdgoMVmjj3p19RruheUeAN1VswnyOhL0K2yf
         FU7m4hzuy+90gewmycNPaIZbAE8Q8kkr1spKP2yKlitua4UHq7BrF7rrU7k3fVyNCVge
         GXnZZUuDaFwbhKOicInx5RwBpx03XA2KCtlEUz6fd0YC5JOzLwvh9ApfhyIrqeEQyLo5
         K1u8ucRcZwF4umJ5UA1LPjVpBxigwVphhETp8AWdctWGKyfEriTsFSdMJxP0mCrq4dWt
         WBBA==
X-Gm-Message-State: AOAM530XigdshXaywsEU2t2VsEnsBAwQds/5n2dti62tdfH7aSzFFcMa
        BDRwc75URFG23UhW6LAi8dZlpw==
X-Google-Smtp-Source: ABdhPJyz5STsSla8W9UIPdsl1rSlPo7Ad+1h++GCogywTejE1j4K8ojs6WkURTJdt6isSgLQ8BNklw==
X-Received: by 2002:a7b:c212:: with SMTP id x18mr1847740wmi.119.1592294549564;
        Tue, 16 Jun 2020 01:02:29 -0700 (PDT)
Received: from dell ([109.180.115.156])
        by smtp.gmail.com with ESMTPSA id s72sm2823327wme.35.2020.06.16.01.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:02:28 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:02:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     s.nawrocki@samsung.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2 4/4] mfd: madera: Fix minor formatting issues
Message-ID: <20200616080227.GJ2608702@dell>
References: <20200615135323.15215-1-ckeepax@opensource.cirrus.com>
 <20200615135323.15215-4-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615135323.15215-4-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020, Charles Keepax wrote:

> The mfd_cell structures inconsistently use commas on single entries in
> the table, make this consistent by always using a comma. Also remove an
> extra blank line.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v1:
>  - Added some additional commit description.
>  - Move the removing and unused forward declaration into a new patch.
> 
> Thanks,
> Charles
> 
>  drivers/mfd/madera-core.c | 12 ++++++------
>  drivers/mfd/madera-i2c.c  |  1 -
>  2 files changed, 6 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
