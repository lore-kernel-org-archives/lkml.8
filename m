Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610C9C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF4D207BB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcw0sJSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbgGANzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730856AbgGANzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:55:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE86C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 06:55:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so23905203wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tZA0kVR3xCCFIYtUwYwPILn1i0vUXmdDgHdSXpdeSdg=;
        b=vcw0sJSo8k83zlgzu7fvPmz7e5cvM9oDmDuPhT64ivZAkTCsO4uqKYwnoPH83yGaa9
         Mlk4RKqG9KeK08ri6Lim/Q3VSj0pDHIncbyxp0jpxMKj+DPly7Kgb6GnksCEVADrl8k4
         zZFGe8fZXj6JEYQxh8gysxX6L65Z3gEZPof62QLQ8D4a+cOV4SyvvR8K/luJRwRq/HmX
         QiZc5QLr5g2Jp6N9IOHIykinLaRoaPnv6AlTVM7uE59KzuKxzqI1pb9Zn9mDLEkTUrCc
         3jC+05Za7i51W45wDMNVa82p4MmJ5ArXjsO6sxUDb4HHEJeo3f82BYrVSVPw1/BbKPVs
         umbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tZA0kVR3xCCFIYtUwYwPILn1i0vUXmdDgHdSXpdeSdg=;
        b=M9eaHs/ndvZChwNmD5mBJXcXQ1lV9o+jwJR2ynk/1KLPiqlIODl6JtCLSHlnERCzVi
         NRua3sboeAnxG8oZ8S5U5cpwDrhokhnqx0NxWwQPm7li0eJo9B8GGyeNbANJeVnjPxfB
         Lc+TT+A6GqbJdkl4BWlUp6JXsfxqRa+va+VgfT7U/NziKyRfbnCBx3CO01yDgO5aXkmq
         DWIxGvzTa6lR++bYa2ToI9RxUednItAZYZQPwz3ELS2EDWBnp2/wmVUMgkq709LCcA0w
         EEe4HaSFj37bKRTVe24706RHcXgllW7r+n3/GZoPe4NF2jjX4Qb7OAGKBJqJlSBH0idl
         qXsA==
X-Gm-Message-State: AOAM533stRV+hMFMet+ajFSRYAODANwxSrIBYaDBvKeuPgH6wKTsaIV7
        N+IPgVdZ/iEV4jeexf6ISyHRiUltXzM=
X-Google-Smtp-Source: ABdhPJwB+zqWg9EOlTzl8yu+xdYIeoW14/j6960GX8cYVIoLWV1mkYu3fBrhf8dNiWpxHTj0X1l2ZQ==
X-Received: by 2002:a05:6000:ca:: with SMTP id q10mr27761924wrx.135.1593611701991;
        Wed, 01 Jul 2020 06:55:01 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id m16sm2283208wro.0.2020.07.01.06.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:55:01 -0700 (PDT)
Date:   Wed, 1 Jul 2020 14:54:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: lm3533: expand control-bank accessors
Message-ID: <20200701135459.GH1179328@dell>
References: <20200630083948.6987-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200630083948.6987-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020, Johan Hovold wrote:

> Expand the control-bank accessors that were implemented using macros.
> This allows the definitions of these exported functions to be found more
> easily and specifically avoids a W=1 compiler warning due to the
> redundant brightness sanity check:
> 
> drivers/mfd/lm3533-ctrlbank.c: In function 'lm3533_ctrlbank_set_brightness':
> drivers/mfd/lm3533-ctrlbank.c:98:10: warning: comparison is always false due to limited range of data type [-Wtype-limits]
>    98 |  if (val > LM3533_##_NAME##_MAX)     \
>       |          ^
> drivers/mfd/lm3533-ctrlbank.c:125:1: note: in expansion of macro 'lm3533_ctrlbank_set'
>   125 | lm3533_ctrlbank_set(brightness, BRIGHTNESS);
>       | ^~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/mfd/lm3533-ctrlbank.c | 94 +++++++++++++++++++++--------------
>  1 file changed, 56 insertions(+), 38 deletions(-)

That'll work.  Thanks Johan.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
