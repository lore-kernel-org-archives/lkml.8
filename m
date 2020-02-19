Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF38C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47625206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YCNX2wA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgBSOOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:14:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45928 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbgBSOOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:14:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id g3so670663wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 06:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uXdoUR0XgCTZxVCtiaoQw/MLf4PcvBIvxwOCFYMZSP4=;
        b=YCNX2wA3dQsIG79xa3IR2n26dg4q4qH4bLfM+AsKqKBeX+9bmOyQfTcjNEkW9xgBli
         112xTlYPCu30nelz2okdUFmsEHxE//hPaSQcYQ+5lwcZXnc2TtGmyrOrIl8s2Rh7RAiQ
         P9JbEbYbEHPamAv8Bh0EKOAfhYI8zqIz5Q0qMqYZ8hmvaQ0cAaDlcds0bNZjXQjxH+vM
         fWVFii766TV10fLkrzbUCCNn11lhjWZU8rZ1dZzGjyse844SxJWwUzzCIUW/brG3tjJP
         zlK76put0XMuKjQ1+ZSBQG5FRwPQHXQiFS7BjPDVd5/PfN0JwAUF4pTKVMLZXz19F47n
         7VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uXdoUR0XgCTZxVCtiaoQw/MLf4PcvBIvxwOCFYMZSP4=;
        b=guwbb/VKsiXp5bm+jxnfDmdbsaR6tnJeRV0TdIiYAM34r6/voGRU1bqUMr5mxuBuGd
         XfDaPexcgP1XAUJ/fXvzWkLdmJQeoOczMnnI31ia8IUwnjs0QhL29btKSvdm+obih+6z
         dMijfIkwfpuTdxtkCJiX+V88jfBbBK9bUun6IWHH2SNUBs5HIV2ujVlhVyoIHEtixe08
         me2Tlxc121HPgKMekoN74+DkWS2O9LouTLqcc+60BGzIEWVKjkQPDzeOsLYkvGsteeBF
         yu6SmAfjeKTW9nFXP4pl3X0CQspTHDTpxKYaHV+mha4MwHYa1cWae8xO2b+a7Qkg5xT2
         NTJw==
X-Gm-Message-State: APjAAAUamTaCKL5/21Fk5+G10nFUAQ+aaQOwAbgj+c6QEiRADAHg3SBI
        eJyrChWofp335UwcvikXcMME4Q==
X-Google-Smtp-Source: APXvYqxH9nOzidlAyGIVX7T2P8TGUAvMVJctZqUzmF3PYX7tf9LOYHAVrfPBg9SG1BZGGlCJf/qmDg==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr35086030wro.375.1582121648290;
        Wed, 19 Feb 2020 06:14:08 -0800 (PST)
Received: from ?IPv6:2a01:e35:2ec0:82b0:510e:e29a:93ab:74c3? ([2a01:e35:2ec0:82b0:510e:e29a:93ab:74c3])
        by smtp.gmail.com with ESMTPSA id 5sm3254394wrc.75.2020.02.19.06.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 06:14:07 -0800 (PST)
Subject: Re: [PATCH] usb: dwc3: meson-g12a: Don't use ret uninitialized in
 dwc3_meson_g12a_otg_init
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Hanjie Lin <hanjie.lin@amlogic.com>,
        kbuild test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yue Wang <yue.wang@amlogic.com>,
        clang-built-linux@googlegroups.com,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20200210225816.36598-1-natechancellor@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <d47c9cb2-9458-afc7-e91b-1a56ad87d1be@baylibre.com>
Date:   Wed, 19 Feb 2020 15:14:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210225816.36598-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2020 23:58, Nathan Chancellor wrote:
> Clang warns:
> 
> ../drivers/usb/dwc3/dwc3-meson-g12a.c:421:6: warning: variable 'ret' is
> used uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>         if (priv->otg_mode == USB_DR_MODE_OTG) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/usb/dwc3/dwc3-meson-g12a.c:455:9: note: uninitialized use
> occurs here
>         return ret;
>                ^~~
> ../drivers/usb/dwc3/dwc3-meson-g12a.c:421:2: note: remove the 'if' if
> its condition is always true
>         if (priv->otg_mode == USB_DR_MODE_OTG) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/usb/dwc3/dwc3-meson-g12a.c:415:9: note: initialize the
> variable 'ret' to silence this warning
>         int ret, irq;
>                ^
>                 = 0
> 1 warning generated.
> 
> It is not wrong, ret is only used when that if statement is true. Just
> directly return 0 at the end to avoid this.
> 
> Fixes: 729149c53f04 ("usb: dwc3: Add Amlogic A1 DWC3 glue")
> Reported-by: kbuild test robot <lkp@intel.com>
> Link: https://groups.google.com/d/msg/clang-built-linux/w5iBENco_m4/PPuXreAxBQAJ
> Link: https://github.com/ClangBuiltLinux/linux/issues/869
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> Note: This patch is against Felipe's testing/next branch.
> 
>  drivers/usb/dwc3/dwc3-meson-g12a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index 70d24b98fcad..902553f39889 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -452,7 +452,7 @@ static int dwc3_meson_g12a_otg_init(struct platform_device *pdev,
>  	if (IS_ERR(priv->role_switch))
>  		dev_warn(dev, "Unable to register Role Switch\n");
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int dwc3_meson_g12a_probe(struct platform_device *pdev)
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
