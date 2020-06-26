Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ECDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 09:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3171521548
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 09:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dse56/1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgFZJg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgFZJg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 05:36:27 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D29BC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 02:36:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so8181576wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 02:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3LBYu141hw98E13UOqnhZDFHzSPEWWQdWTb2aMJ0PXc=;
        b=Dse56/1U1D2T0Y1skuDJhQdTlSUJqIVZqsM/aEuZIY8lqGruPDrJYz9JcYDshNuS1B
         TDPtY2nxjGyr7g45HhIHm9tpHkHMWojL9mQCEQ/aOqvZYEmTEGyScVdsDtaBRO18NTWw
         Ard+MEfbJVIPuf88i7HRWDt6XQHLwhKaqoDJydRIoHoBf/I/2hX7wsFj2QxzTX6QDeQb
         HZJSDvfC3kXD2FjtfKNgitWk4zpEe2hIXtOxpkzpfw7YsllmFoPYc3KIGUS1EMUOJrqB
         RC9LDz/NT70QXNa2dyilSOd+hl1QgvtKfctmWmEFvQY8m7r1KIE311VZWTgnHnXF3rq9
         7klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3LBYu141hw98E13UOqnhZDFHzSPEWWQdWTb2aMJ0PXc=;
        b=sVBYmuUFzqImjMd77WZ1NrpK956+7pPuEQj2U7ZFGtF7BxRN7E+pE5dx5aeW+LFATR
         8oMyDNsnyqWt57SKjfWZNPeoO9KoW1Kyg0HxtiFDv/He6lbzjENvIqSLIR3bXXzODz0d
         /ZTQUbeBqHJ4bxTOJ/c1bsEK99WrAhiaOrkjNYVGBjJQ0YgjXBEeDp57xbkChE4x9CSI
         g0S5b7b9G7JnAvJmu5iKGWDMS7tfBe0nHfdSHLdk5L5fEPkNqUkpnJWbnAIIVV3oriH/
         ghhKB8ng5dM4D+4Vt41qo7lkNFlV4Y+ybXTBNA0QiJaSS12ntTPGYYlxJylfdTaA+ZPu
         2u/A==
X-Gm-Message-State: AOAM532Cgq02IJQ7SWPJP0f3GFahkeogOTsTlxY8475zy1JvehGjOQQ/
        TFOCNYy1HZCrQTCr1ofsMPCPDg==
X-Google-Smtp-Source: ABdhPJxr03d5woJLtnz3iceqifNbq3DT2NdKMPDe9g7cAjFXbPsn73tBJ2RMZdvlVrCRYoTwh//5bA==
X-Received: by 2002:a1c:790a:: with SMTP id l10mr2316176wme.80.1593164185762;
        Fri, 26 Jun 2020 02:36:25 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id a3sm16143214wmb.7.2020.06.26.02.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 02:36:25 -0700 (PDT)
Date:   Fri, 26 Jun 2020 10:36:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND 00/10] Fix a bunch of W=1 warnings in Regulator
Message-ID: <20200626093623.GZ954398@dell>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
 <20200625194813.GI5686@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625194813.GI5686@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020, Mark Brown wrote:

> On Thu, Jun 25, 2020 at 08:16:58PM +0100, Lee Jones wrote:
> > Attempting to clean-up W=1 kernel builds, which are currently
> > overwhelmingly riddled with niggly little warnings.
> > 
> > Resent to include patch contributors/maintainers/MLs.
> 
> Is this an actual resend or did you fix the issues I raised?

They're fixed.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
