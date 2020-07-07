Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB2AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38607206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcaw/YUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGGHtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGHtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:49:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC55C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:49:06 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so42223379wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W6+Y6r86ImCcZkb8aCBe4d7KrulRrBvaqwJn2RJAx2I=;
        b=tcaw/YUxKfebdDxQAgl2sSg95mNElUbe0CpVC/1QaHP6xpMsX7cyHGHPdZx3l8sTkB
         oTfpYuQfn/DPl9VW3f0ntYe0Nx2eefJqSklbScz6DfSIUDv9WLjm9gBosIbBgvEx9lmd
         4b+d6fQ6ft2nXKX4rDYtmPp940l71i6aaz4Oa6HdRy0QrwBd/AouJdvI7zEMCLgEMqEX
         6xkbNHlL3MM2OouSgN/+IIWdrU8R2qyqDGOB1Ao/QJJ1QK8NKGTfQPf7fell7AWWXpbz
         ++grSOp6Smmt/NommWyiTeDtG06M7kyq1nO9LKrITHABgmPedfLWDwLly+y1XlVIe1a0
         padg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W6+Y6r86ImCcZkb8aCBe4d7KrulRrBvaqwJn2RJAx2I=;
        b=ixY3BaOXSKzMdnDwssFvUetM49C/gRBQ8vNsFTr5Kdd1TZBNr86BMStbmD4RFT+Q/1
         1dATezYGc/tUf6ofh8SsxrvSK/egGUYveTHCf22YaB34Df8XLvVI+cXbq5Wg37tbl33e
         jzjY1ZvNSdr5OFzJK/myxOW92nVMyJSZh71Vc/ZRn+np03gwdtlI/laQ8TPR2gWE/qT4
         zDOvs/4yIFUiUCWz6++487fPElCvpH2wgGyS/jBiafvNqM3PWTZm5T9gi/CbRZZiWvSQ
         ZINUbExuvi36MtIKWcMFSF3AFV61HKXTp6V5L9nAecAVs2XjB8QboudFqJakolgbeoEW
         de8A==
X-Gm-Message-State: AOAM530OIrFWH4dxOYEGo6hVCSp2g2kmZQVrABUoBKpapisQojTO8u9R
        E+KREaKkENlwa2JTepJpeYb3ag==
X-Google-Smtp-Source: ABdhPJxlTAnK74t7RP9hVg3Y0wreglxIGiI5qQ2LKCzjT+MV3zeWcXMYNEwuQNr0MbBQZgl0t+b1GQ==
X-Received: by 2002:a05:600c:2050:: with SMTP id p16mr2684476wmg.44.1594108145512;
        Tue, 07 Jul 2020 00:49:05 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id j16sm27308528wrt.7.2020.07.07.00.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 00:49:04 -0700 (PDT)
Date:   Tue, 7 Jul 2020 08:49:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [PATCH 04/30] usb: misc: sisusbvga: sisusb_init: Mark all
 'static const' arrays as __maybe_unused
Message-ID: <20200707074902.GD3500@dell>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
 <20200703174148.2749969-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200703174148.2749969-5-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jul 2020, Lee Jones wrote:

> drivers/usb/misc/sisusbvga/sisusb_init.h is included by a few
> source files.  Most of which do not use the majority of the
> shared static const arrays which have been declared.  This
> causes the build system to spew 100's of warnings.
> 
> Fixes the following W=1 kernel build warning(s) - and a whole lot more:
> 
>  In file included from drivers/usb/misc/sisusbvga/sisusb.c:54:
>  drivers/usb/misc/sisusbvga/sisusb_init.h:695:34: warning: ‘SiSUSB_VCLKData’ defined but not used [-Wunused-const-variable=]
>  695 | static const struct SiS_VCLKData SiSUSB_VCLKData[] = {
>  | ^~~~~~~~~~~~~~~
> [10's of lines snipped]
>  drivers/usb/misc/sisusbvga/sisusb_init.h:206:28: warning: ‘SiS_VGA_DAC’ defined but not used [-Wunused-const-variable=]
>  206 | static const unsigned char SiS_VGA_DAC[] = {
>  | ^~~~~~~~~~~
> [10's of lines snipped]
>  drivers/usb/misc/sisusbvga/sisusb_init.h:171:29: warning: ‘ModeIndex_1280x1024’ defined but not used [-Wunused-const-variable=]
>  171 | static const unsigned short ModeIndex_1280x1024[] = { 0x3a, 0x4d, 0x00, 0x65 };
>  | ^~~~~~~~~~~~~~~~~~~
> [10's of lines snipped]
> 
> Cc: Thomas Winischhofer <thomas@winischhofer.net>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/misc/sisusbvga/sisusb_init.h | 66 ++++++++++++------------
>  1 file changed, 33 insertions(+), 33 deletions(-)

Greg,

Please drop this patch.  I have a new solution.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
