Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6033EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3838720870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDaVq8t1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgCXLFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:05:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41061 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgCXLFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:05:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9so20845697wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 04:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=G3sOKfxAiTkgMzwoQvFSfy7O4/M81GdK6MDeVbYl4ik=;
        b=bDaVq8t1q87wO1/aQ+z0qhYyrE5upfY7ktRhrPBlWmSSloDVy2/dlXSJGaqy+/+F9o
         4Ba7cHRQMKmzpZKbg+S27CiUIBaEfOFLln5Y+s1lfxQqPVNnlluGXrQvWD3m2R7jcEBO
         zBfszPriPgQ+b+W5ghF2wYR7DKAfWYsXWQFYodcsONAta6CJWqV0/ZYPqTDXIpI/WX8i
         /ltryVnJQZkJjDTMcr9OJ/aaUHJfg2ZurriQLbLEeEgafQ/WqjJ/GCbKVl535RVhEJL0
         boMUWR1p6gBbyM2ZUO+5d39/wyTdlZIg6DzSba4jUyPnf+Ek3j52BYmNHIxibhNmvp4G
         Rp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=G3sOKfxAiTkgMzwoQvFSfy7O4/M81GdK6MDeVbYl4ik=;
        b=lu77uxcDTKL5vScR1FqBP1/TMCXLqBjZeZY8zIgLoHdEIfp9R8BQPpyJzCh0z+17kd
         YitDrKqxsWg0IoXEfgrJc/f7eXbconYGMKlxKcDOSHB48yMXpU+CA9W2a2rLzhkETWRI
         5z1X9XPPDfRw4/2LYQWG1zJS+2FYMkqhocoK80LE470kYqlIBY3DN1/vAc35shZgotUr
         HDD36bitVSTMG5fpXENj3gUZlQO3pxP/0uvQAo2s4rywhqlGTGMkvbKJdgXQPbLW7DWK
         JA6nRYPs5WcqkZqzSjpeaWEzatMoki/u+KfY+nX60JV8HT6JjeiKUEkSHRlw4YyY0x/A
         KJUQ==
X-Gm-Message-State: ANhLgQ0HL3mJfFW3Ab0AR72IOUyfcHSstiwh+HeoISxOTdrqGAvJ/Hnc
        /KjgzW8Dn+s4iEpiVoWc2riVgA==
X-Google-Smtp-Source: ADFU+vsqkxx0FE6VDtzLflUP6KQEoIBVv3Qm57V2Wz7s8smAbZIezE8pE9zVtUUy+E72r3qDRN2HqQ==
X-Received: by 2002:adf:9ccb:: with SMTP id h11mr15761030wre.22.1585047905050;
        Tue, 24 Mar 2020 04:05:05 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id v10sm3810994wml.44.2020.03.24.04.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 04:05:04 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:05:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Shreyas Joshi <shreyasjoshi15@gmail.com>
Cc:     Support.Opensource@diasemi.com,
        Adam.Thomson.Opensource@diasemi.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org,
        Shreyas Joshi <shreyas.joshi@biamp.com>
Subject: Re: [PATCH V6] mfd: da9062: Add support for interrupt polarity
 defined in device tree
Message-ID: <20200324110553.GK5477@dell>
References: <AM6PR10MB22635CBCBF559AEB9A5C2BFF80120@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200226010722.2042-1-shreyas.joshi@biamp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226010722.2042-1-shreyas.joshi@biamp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020, Shreyas Joshi wrote:

> The da9062 interrupt handler cannot necessarily be low active.
> Add a function to configure the interrupt type based on what is defined in the device tree.
> The allowable interrupt type is either low or high level trigger.
> 
> Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
> ---
> 
> V6:
>   Changed regmap_reg_range to exclude DA9062AA_CONFIG_B for writeable
>   Added regmap_reg_range DA9062AA_CONFIG_A for readable
> 
> V5:
>   Added #define for DA9062_IRQ_HIGH and DA9062_IRQ_LOW 
> 
> V4:
>   Changed return code to EINVAL rather than EIO for incorrect irq type
>   Corrected regmap_update_bits usage
>   
> V3:
>   Changed regmap_write to regmap_update_bits
> 
> V2:
>   Added function to update the polarity of CONFIG_A IRQ_TYPE
>   
>  drivers/mfd/da9062-core.c | 44 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
