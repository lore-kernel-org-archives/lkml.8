Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FC6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD56206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZsjT0iHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGOO5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgGOO5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:57:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217CBC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 07:57:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so5898412wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=f2CbQp7JxGal1BdX0jNapHeOunGDBGdvrvEEUG5tMLY=;
        b=ZsjT0iHq1P3/z04/ctVDlAEdshwpCt+0LY1xJUraexpA6ESa5Cm58MH/VggfjMie2p
         DOXKxhzgpER0jwoId2TfiZ7bP2lxQamHk6c00FR8KAo3oRjGLunRTgHaTiaWwJ1RoBye
         NT2cC3p2k719f8CdUvoM00VKA07EH+SwOqplybI3qZ5o0OTFHyFwQutxrvDQFS1Fv7hX
         aiCn7Z1/PH66m09Sjab0iSZeCdbwagDQwX2flcM1C75VDJu6POrFGhk8WYATSbMbSA2F
         tCMNIbyhqfX3pLEYCnPjB/pKUTz76+kzImWY/838nep6Gfa00aA6aa3s740UTDF8Jcdd
         IxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=f2CbQp7JxGal1BdX0jNapHeOunGDBGdvrvEEUG5tMLY=;
        b=HLCmDujiZBKz4eFq4I/E0G9Yyo9zijXSqx/FvcaHEMlJcvh1a9giZvmyS8+pPJwXpD
         I43zlO+3j33H/VBtM4jBAWgFl6b+SGjl3j8tOkBlHXThmUlXbpunEIgzHiBMYN+9Qtgx
         O6qQRBpeFWYP/cKefGaLhKI4q1br4QC3TQdJWla5mkzQU1W66CN46RCEbiiMg41AV/hA
         UwOWPte1gd9Q/gUeZwfH+ZMl7+RQc5CIsdtBZgVryLHyZXj+CUL6CBtPKFYQ/8ZJJmN4
         HGyIJH1ZOt35L2JmIfVTGBuJp/jTE72p2q3dM5hEjHhcLFRHOM6i8Imktas6RhyUDxLB
         +VXQ==
X-Gm-Message-State: AOAM531OOfECrnO3pH4LLnQDklRv0Jfbs7YFKvViecQfPxO7pi9SX5Cz
        Wf/wL13prNnIy3JlziWJPkNAtg==
X-Google-Smtp-Source: ABdhPJwcQKIqBh34jcnUoTZ3kXw7R8fUZWe+6TCuYehKA+AQH/THmFlpQIeXdrAeHkNAbd82o6RElA==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr8828248wmb.75.1594825033869;
        Wed, 15 Jul 2020 07:57:13 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a22sm3624918wmj.9.2020.07.15.07.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:57:13 -0700 (PDT)
Date:   Wed, 15 Jul 2020 15:57:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] ASoC: fsl: fsl-asoc-card: Trivial: Fix misspelling
 of 'exists'
Message-ID: <20200715145711.GI3165313@dell>
References: <20200715094447.3170843-1-lee.jones@linaro.org>
 <20200715142651.GA44014@sirena.org.uk>
 <20200715145516.GH3165313@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715145516.GH3165313@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020, Lee Jones wrote:

> On Wed, 15 Jul 2020, Mark Brown wrote:
> 
> > On Wed, Jul 15, 2020 at 10:44:47AM +0100, Lee Jones wrote:
> > 
> > >  /*
> > > - * This dapm route map exits for DPCM link only.
> > > + * This dapm route map exists for DPCM link only.
> > >   * The other routes shall go through Device Tree.
> > 
> > This doesn't apply against current code, please check and resend.
> 
> What is 'current code'?  It's applied against today's -next.

Hmm... something went wrong.  Stand by ...

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
