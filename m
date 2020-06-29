Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F9FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289FF206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wArtOsXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbgF2TNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbgF2TMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CC3C014A49
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:14:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so15194506wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Eu8OtrlLnu2y39+RYRYUmyijmTp/DaN6tPPo1iZ5gVo=;
        b=wArtOsXxZjgrh5I1yKTeEpd/qgfBAs/GpVy7kBtRJjUPuu9WXbEtQnJs8nURZSV9o/
         76XbYrZGmTHpxyW9hEIi32LRersdf4EgYNqwt8/8AHZ/50VmfVs1IteEKmwvbYW1q3Rc
         dRPFVL0FH9Zg1kyLRIEVrnuaFtGPN5wZuxKs7ZAKd0Zh85UD4WFZtN+TrE7e3UkhgpP8
         fJ1+JUsP7VcBo+TmeNi7wCdmsslAhUfRAmSf158OeIdWPP0NPxlnyb2yU9jPRb68tWjv
         MXdS88FKuoqTp6cJrvZgBzCyUnUxobcRslifswcwmk3HWJ1twxG8IpdUZHQeyk2Esopk
         mUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Eu8OtrlLnu2y39+RYRYUmyijmTp/DaN6tPPo1iZ5gVo=;
        b=NINxGnrPhpcwUFxXZogvtcvUELgg3USRki2aGiAFegePskf5/nuXrrEp2Z2zfpocfb
         UmhLfiMchgLrhXU8bYQ57/d72fzfG59QIJAA5Er24ApEo3G+XZ3tHzsTPjItu4mnfbE3
         rYZiTOZdRLdivqGJIYMw3rJ6lGEuylr2TfQgvhosP78vMvlqwn7JlJPpYzq0ImTVXSgF
         fPNefNUvYfOCjtp3Z2TlX/2VIxSYQ+A3CP+WOgrfH2vfhKl0x3N5Lfl0z0d8tVuFV3d6
         apz/U82owPxubqyzicZKQ58mttYavLWcLWgWVKCjgPEewFJ0Y+7r5h/tc0X4O7NJV+mU
         I+QA==
X-Gm-Message-State: AOAM530clobfdF2+aJjMGCQ+M6IFSA8DkltXWbqyPPo1nF42wWWfvMk1
        DCihNTZIUQG+U02IXqJUQxbmtg==
X-Google-Smtp-Source: ABdhPJx3bP6Cpaq/EZ+1Uho3iFBaMLJrhrRGmtfXOZl+wrkBz1dt2CXCgSbGUBhftwy3njQHvPCCTw==
X-Received: by 2002:a1c:b182:: with SMTP id a124mr14791259wmf.114.1593418479525;
        Mon, 29 Jun 2020 01:14:39 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 22sm11577124wmb.11.2020.06.29.01.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 01:14:38 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:14:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] misc: eeprom: eeprom_93cx6: Repair function arg
 descriptions
Message-ID: <20200629081436.GH177734@dell>
References: <20200626130525.389469-1-lee.jones@linaro.org>
 <20200626130525.389469-7-lee.jones@linaro.org>
 <20200627203357.GA954@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200627203357.GA954@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jun 2020, Wolfram Sang wrote:

> > @@ -270,7 +270,7 @@ EXPORT_SYMBOL_GPL(eeprom_93cx6_readb);
> >   * @eeprom: Pointer to eeprom structure
> >   * @byte: Index from where we should start reading
> >   * @data: target pointer where the information will have to be stored
> > - * @words: Number of bytes that should be read.
> > + * @bytes: Number of bytes that should be read.
> 
> Now we have 'byte' and 'bytes' here as arguments which is confusing. I
> think renaming 'words' into 'num_bytes' would be even better.

I await your patch with bated breath. :)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
