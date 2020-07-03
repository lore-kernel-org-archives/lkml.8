Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB83C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF61120899
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJg2Hr28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgGCTo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCTo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:44:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6FDC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 12:44:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so33868793wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=F3b2vOuE0IiTF4n5D1mX7a/OT5cq2aJSt3VlxRKtnS4=;
        b=IJg2Hr28t8MBlJ38XwGDbawIOS0VXTGu6C2fVNa2Cn4FxhLyOfZV4PRhmxLzkvhx1h
         h0KlcVDXfpcmRwS4Wnm5rvhXEKAP2m73t5UQLBNKGIeZF1id7D6A+2MmhfQVS9Jp/4ax
         n6MwmCFNOkrc8nsX5bf2pF0N6kzpfCI66jFn5yPzD9s5NlpVNUwkHD1/nIHhehfNS4yJ
         h69ic3rtWrhtmvUUVMMfCbASJKgvpAJeKnKDm6GCb3F8IuNMjb+JdEzQ5azKvaK9/nKd
         /r3OnvFHZFzXM7tu0Gb6YF7ouZMgYJnKMldGQDLvq2g4/0yb0FRFgJXG4vrfNZzi/y/y
         PEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F3b2vOuE0IiTF4n5D1mX7a/OT5cq2aJSt3VlxRKtnS4=;
        b=Lw4snP3jmsnzTd0aCqWbpMHTj7k/Fehr0j4Sn666+0iA9mGMU/HU5VYoOQ63V2sdOr
         Y9mQ7LqKxKKAWhsZJtqAF6gZf+4B2ccrYWS2hkFSTFcz7N83yHhKnmTJbznIjZPaIP5x
         2Leuf+h1LwjeLlqFaEwhwRWP/SwM3vTOYiCY4/zNQVrb1LjnTbb5JWK3bZ1wj8bIluTG
         Hm+J64iEWhZKfvt1qia5BQvzrUrbNuLczDFgOcujjIYiittp3J9DSybIIyQ5IpoEEU+O
         44gq6CCrq+4GtT/fqbVbyS2EHoO9q/sdeb1pVYTAqJMwXOfdjaqVJfKuvt9Wq77mXSv+
         /c+A==
X-Gm-Message-State: AOAM5309I5Pe6z+h7rvy01eYcHCbZ8APG0T/gkIgtt3BF8W1XBXPqSMA
        jroVNSXqPDCZZXUeYc7aKe7teg==
X-Google-Smtp-Source: ABdhPJxmI5XKxMwwvm/6A65zIhp6cs4iNAqe7col6ivLMh3hoqJWKRSLujYTZrqKsS+LfOwNZ3AmcQ==
X-Received: by 2002:adf:f311:: with SMTP id i17mr39822583wro.237.1593805494725;
        Fri, 03 Jul 2020 12:44:54 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id f16sm14235349wmh.27.2020.07.03.12.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 12:44:54 -0700 (PDT)
Date:   Fri, 3 Jul 2020 20:44:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [PATCH 04/30] usb: misc: sisusbvga: sisusb_init: Mark all
 'static const' arrays as __maybe_unused
Message-ID: <20200703194452.GF2743379@dell>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
 <20200703174148.2749969-5-lee.jones@linaro.org>
 <af66b6e94a26ebd500c1376631891b0bdd0912f0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af66b6e94a26ebd500c1376631891b0bdd0912f0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jul 2020, Joe Perches wrote:

> On Fri, 2020-07-03 at 18:41 +0100, Lee Jones wrote:
> > drivers/usb/misc/sisusbvga/sisusb_init.h is included by a few
> > source files.  Most of which do not use the majority of the
> > shared static const arrays which have been declared.  This
> > causes the build system to spew 100's of warnings.
> > 
> > Fixes the following W=1 kernel build warning(s) - and a whole lot more:
> > 
> >  In file included from drivers/usb/misc/sisusbvga/sisusb.c:54:
> >  drivers/usb/misc/sisusbvga/sisusb_init.h:695:34: warning: ‘SiSUSB_VCLKData’ defined but not used [-Wunused-const-variable=]
> >  695 | static const struct SiS_VCLKData SiSUSB_VCLKData[] = {
> >  | ^~~~~~~~~~~~~~~
> > [10's of lines snipped]
> >  drivers/usb/misc/sisusbvga/sisusb_init.h:206:28: warning: ‘SiS_VGA_DAC’ defined but not used [-Wunused-const-variable=]
> >  206 | static const unsigned char SiS_VGA_DAC[] = {
> >  | ^~~~~~~~~~~
> > [10's of lines snipped]
> >  drivers/usb/misc/sisusbvga/sisusb_init.h:171:29: warning: ‘ModeIndex_1280x1024’ defined but not used [-Wunused-const-variable=]
> >  171 | static const unsigned short ModeIndex_1280x1024[] = { 0x3a, 0x4d, 0x00, 0x65 };
> >  | ^~~~~~~~~~~~~~~~~~~
> > [10's of lines snipped]
> 
> They are not __maybe_unused, they _are_ used.

Potentially not by every consumer of this header file.

> I think these instead should be moved to where
> they are used instead of being declared in an
> #include file.

That works if they are being used by only one source file.

I'll look into it for this instance and get back to you.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
