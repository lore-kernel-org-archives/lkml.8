Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FD0C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324A72173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aq5w/piH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgA1Hiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:38:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50176 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgA1Hit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:38:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so1350751wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 23:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7GokS7CdGeZZPn1PrPOCpSW46TjRecT73s9cRiHualM=;
        b=Aq5w/piHruuGbRmgv2bptrp+x3Rne0Dds30PKNJDd+TQX6uSVzfNvVGDZ5dGmxw06n
         ka7bPmWRge0gXpL7diWJGs4suptUJBHoUjL2JILNDtKmDb7RtAZoAgmbuXttgYRsjMSv
         y8YRti/wIOZ5TE5fTYdDFqDSGH/UkZDiFHRDvKnBiaXWd2i3uTXG14V+DLJMvRsXFq0H
         u4K/4d4TKrH8J6SdWziqPMVN20kBc8KyvvCIU41/1y7mmbOdKaO521gnsck3mCQNsC5p
         ltwoUPfpgXITfVZcvW8G2jgOIhBas+jV7K08IKXtL8MyShFp0TigB0Dh6bCC0G+J0d4p
         yf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7GokS7CdGeZZPn1PrPOCpSW46TjRecT73s9cRiHualM=;
        b=cwNOo8jcMF/4iggX4lI92T9skZS0QXjhQlpfby66llfirM26AlPmHWn75ABF2PqjzF
         mWMkNPvoTQtABCj8/vBLpxzmAdjLpNlY7qlLMrzMQ06ypuObaH0j8i8TBbKeq47n0YcB
         EobpbFfROUSct6R19a5I9szUofv2cxWf1QWqi63j6tOgFJayjNxmnf5GsbidVTc5HBBm
         PDDVSXH11jpW03W996YSjhoF16yuMzPZ95iEJPLu1rg1oIk+X3w/HMoeV1vuKx2BIlE5
         hdepfkU83ZcB1Tt7xzyadTS2+fWRMLtfAUFiNdh2ON6cp0rDf3LuMiGyslAPT3TD5+CM
         dNcA==
X-Gm-Message-State: APjAAAVVsC3Z9IsFd3/bN1YvwT1qESPNmLG55lpu3pEGsNg+AaYGITsb
        fVY8nVPtz2HxnCdAGxAFbLJrIQ==
X-Google-Smtp-Source: APXvYqwrMMc5NSaCSwiz7Idymm7eGqj7dO9/KFj2t5izUkAQHpe5nczm+vvnroV1+xYW6bFEoBrFuw==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr3417536wml.83.1580197128140;
        Mon, 27 Jan 2020 23:38:48 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id c17sm23961385wrr.87.2020.01.27.23.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 23:38:47 -0800 (PST)
Date:   Tue, 28 Jan 2020 07:39:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Axel Lin <axel.lin@ingics.com>
Subject: Re: linux-next: manual merge of the mfd tree with the
 regulator-fixes tree
Message-ID: <20200128073901.GB3548@dell>
References: <20200128120220.53494c29@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200128120220.53494c29@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020, Stephen Rothwell wrote:

> Hi all,
> 
> Today's linux-next merge of the mfd tree got a conflict in:
> 
>   drivers/regulator/bd718x7-regulator.c
> 
> between commit:
> 
>   b389ceae4a8f ("regulator: bd718x7: Simplify the code by removing struct bd718xx_pmic_inits")
> 
> from the regulator-fixes tree and commit:
> 
>   1b1c26b24a6e ("mfd: Rohm PMICs: Use platform_device_id to match MFD sub-devices")
> 
> from the mfd tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

A pull-request was sent out to avoid this.

If Mark pulls it, this should just go away.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
