Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDD9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD12208A9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZDJL8G2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgHTRJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730423AbgHTRIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:08:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0BBC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:08:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so2279541wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/R0k1jGWuhMoblqt/y/Rxs518YQHPPA6fBEtJHgtyO8=;
        b=sZDJL8G2LfU/6BRu0eKseTlgdQByMRU40zPpzst1uny/m8nTPOncCx5nHSPisw+m1g
         4py17touSYiqoYFABUof5XWPk1yi2mV8BWjgQ4ZpFiA+dgrVgu9aQvDJm3t9FUVRSZMT
         a43MfyC9LoMebQyjh93lIS9SRJOZ15G9Le26Ntg8wbn75qbt4wJcIEyvTFF2xvrxqND9
         lHpWeg/QCRKlvAiin/QIyOe+mbCvJ3vUDn0MXORn3YpTqK3abccdpfiPgsrb/2qHK2UA
         32BwTAtT6SUSfkiWtn977+lSApwriSRvtcopuHAVP7DumSl0u5UmEp5Ny6FYpo6ViqPl
         ycQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/R0k1jGWuhMoblqt/y/Rxs518YQHPPA6fBEtJHgtyO8=;
        b=CCrLlZz/X4z6MV11NvruFaPm+sgOChfeBakA6yR9HYx+y78DaaHJTV92MJYPKGvKlH
         LowWYbMAHUghy1VVv9HKbp6eveI+KUQUyMO9onzGlqML6EfHZd5TPyq1DVaOjVVXP9/Y
         zWciL1QbNFRLmUl3Vw4AcP28dwyQOZJPSd4/QcmGPSw5by5SURTRsRJN5I90kRnfipbQ
         viKeiGcHLv9//uSZU5qGJeUh5tKVe8wj2cFzBBKKCsVxVVQ591Ql8P9CkSV3rjLfDtfw
         K9HzpfLcno4Ig++4d7GuG5/A7AOteN0mRVWENwku0mgHwsBloFk4nuLBHTM24awJP446
         LAzw==
X-Gm-Message-State: AOAM531TkFDWkukjOY5hnUDMlybBECASDdXOYxw2L11caNBlMUkDMhDx
        RNoY4kuKgG65qRz8vvSc/ms=
X-Google-Smtp-Source: ABdhPJyCV7zixOANhMWBD58S+ejf6+iFl/heYqQfFEISdtKbwuXzkMs6dVm0+YL1sOHG4mTA6Zr+Og==
X-Received: by 2002:a1c:4b0d:: with SMTP id y13mr4338861wma.6.1597943318553;
        Thu, 20 Aug 2020 10:08:38 -0700 (PDT)
Received: from medion (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id z12sm5359904wrp.20.2020.08.20.10.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 10:08:37 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Thu, 20 Aug 2020 18:08:35 +0100
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: brcmstb_dpfe: Fix memory leak
Message-ID: <20200820170835.eos4mia5aokkikog@medion>
References: <20200818110201.69933-1-alex.dewar90@gmail.com>
 <20200820152944.GB17144@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820152944.GB17144@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 05:29:44PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Aug 18, 2020 at 12:02:01PM +0100, Alex Dewar wrote:
> > In brcmstb_dpfe_download_firmware(), memory is allocated to variable fw by
> > firmware_request_nowarn(), but never released. Fix up to release fw on
> > all return paths.
> > 
> > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> > ---
> >  drivers/memory/brcmstb_dpfe.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
> > index 60e8633b1175..f24a9dc65f3c 100644
> > --- a/drivers/memory/brcmstb_dpfe.c
> > +++ b/drivers/memory/brcmstb_dpfe.c
> > @@ -616,7 +616,7 @@ static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
> >  	const u32 *dmem, *imem;
> >  	struct init_data init;
> >  	const void *fw_blob;
> > -	int ret;
> > +	int ret = 0;
> 
> This does not look needed. Why initializing it? You cannot jump to
> release_fw label or reach it without going through assignment.
> 
> Best regards,
> Krzysztof

Good spot! I'll send a v2.

> 
> >  
> >  	/*
> >  	 * Skip downloading the firmware if the DCPU is already running and
> > @@ -647,8 +647,10 @@ static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
> >  		return (ret == -ENOENT) ? -EPROBE_DEFER : ret;
> >  
> >  	ret = __verify_firmware(&init, fw);
> > -	if (ret)
> > -		return -EFAULT;
> > +	if (ret) {
> > +		ret = -EFAULT;
> > +		goto release_fw;
> > +	}
> >  
> >  	__disable_dcpu(priv);
> >  
> > @@ -667,18 +669,20 @@ static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
> >  
> >  	ret = __write_firmware(priv->dmem, dmem, dmem_size, is_big_endian);
> >  	if (ret)
> > -		return ret;
> > +		goto release_fw;
> >  	ret = __write_firmware(priv->imem, imem, imem_size, is_big_endian);
> >  	if (ret)
> > -		return ret;
> > +		goto release_fw;
> >  
> >  	ret = __verify_fw_checksum(&init, priv, header, init.chksum);
> >  	if (ret)
> > -		return ret;
> > +		goto release_fw;
> >  
> >  	__enable_dcpu(priv);
> >  
> > -	return 0;
> > +release_fw:
> > +	release_firmware(fw);
> > +	return ret;
> >  }
> >  
> >  static ssize_t generic_show(unsigned int command, u32 response[],
> > -- 
> > 2.28.0
> > 
