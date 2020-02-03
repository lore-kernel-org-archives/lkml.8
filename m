Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD303C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F02120658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqgNs19b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgBCIkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:40:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33471 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBCIkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:40:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so3509187wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 00:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7iMUUuqhP7ZUA/guDhJyWKC3bMbNC5iG2m7Q5NlpRzI=;
        b=kqgNs19b923xDrGRXumenA5Qc2g0OHW1+kcozElwiJ8X4/B9KmSnm/GMzT8IFx5IXx
         Q2m0Z00FPcJPmikhX5vmETINiT/SS53QL6eJSErAWa+KkamrPOxUoWVRB6fQYa4yiPL6
         swZ3dRJenlpJGCtxF6ayEO294fkuZYmy3PWAG8sDz3tNmIZa4ngaekV/DC/hZRQyc23I
         y5WTnRH9CrGNXJpZyP/S30RnQr2PKn9s7fj9y4HGYM7WFnMOTsN763rDRDraXIhOMvCw
         S3amwt7Ny4axnsz/ddFKPhZTIV8hpEmlO0mw93l1FMeDPGSh0EB82yDv3QOcPgReUzHQ
         esBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7iMUUuqhP7ZUA/guDhJyWKC3bMbNC5iG2m7Q5NlpRzI=;
        b=QyM0aLAs58nfMtHJD35vFhbocBXXUPPoHL+Ow8eNKxeyuBKw//P3WjPCrsJcm4ezjN
         M9lGhSXzeVlQGziief3ynY4JbCciQoxH71Mh2rsjeOH7i5/ulNFymqE0iDaerJ9fLZei
         vpbO3nPuQYoa1FvyyMAXP3PexxnM009M1q8+mdJ3BnlJCOPDIGYwgru5b12W01weHm5+
         WBWkgwFpaqmAFc5j3hnQDJRTyItMUwHxkeAahrh+uGnPtWiK2MK0DwZ8Hy3/zbzY3wSz
         tScIjQrq1Lo1y+Qz+jPX139+39AlayHZKr7Zcd+0x+5H+fMtQpqCNDb0zjByXLSqAKEp
         FaMA==
X-Gm-Message-State: APjAAAXPEQQrVItqPj6v0OHwo4Denj9cyfFiIaXCqmKVhqYWJXbJfIkW
        wZj+yW4q9mfL4X6gtHOqBpVpsw==
X-Google-Smtp-Source: APXvYqwUEO75VZX36Ds2VGmBJNQLMhkTV1nh5CeCQ4yxpfg36hLtm/wfQ1slP8TD6qTmmK3mUkDmVg==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr14220230wrn.135.1580719240030;
        Mon, 03 Feb 2020 00:40:40 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id g2sm23857518wrw.76.2020.02.03.00.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 00:40:39 -0800 (PST)
Date:   Mon, 3 Feb 2020 08:40:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Orson Zhai <orson.zhai@unisoc.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: syscon: Fix syscon_regmap_lookup_by_phandle_args()
 dummy
Message-ID: <20200203084049.GA15069@dell>
References: <20200130125529.2304-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200130125529.2304-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020, Geert Uytterhoeven wrote:

> If CONFIG_MFD_SYSCON=n:
> 
>     include/linux/mfd/syscon.h:54:23: warning: ‘syscon_regmap_lookup_by_phandle_args’ defined but not used [-Wunused-function]
> 
> Fix this by adding the missing inline keyword.
> 
> Fixes: 6a24f567af4accef ("mfd: syscon: Add arguments support for syscon reference")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/linux/mfd/syscon.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
