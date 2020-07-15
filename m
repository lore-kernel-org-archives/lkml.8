Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DD2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E206206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZ7zMteF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGOOzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgGOOzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:55:21 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFE0C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 07:55:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so3025608wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Xx3joU+7lj4tPv3i1MBeu7gIGjv2jVS4xXq0wsixJEw=;
        b=mZ7zMteF9Dkbv4smJYU6GqQ+rNM4I9cTbn4pjKCwKenfFj3y8WMi6xF/5lDE87m0mn
         0ipw1YhEn3wMmPaqWymXg7qytDbvgBHRAmy0zz1wWns9j+WrdH3Hr0dkvY3bzZC8Y8cc
         rak79OzoglUWnTrb3nQGygOzoyTJ8+F0sb9OTXIRFkfcLdTB9yhGDUy+7aV9jFXsXhu/
         j6gvw1HI5lHnqNVrqLdvgwYJ0JR+kzUEHZqeYlDPG7AJFP8aMG2u4Wg0aXFp00ezS96E
         3TRB6il2spjRMxMrg0mN0LPgz0Dq9Og+iXFLR/R5sfl0SaYoRYSB/Hp4LCKsSAhE/EhW
         fA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Xx3joU+7lj4tPv3i1MBeu7gIGjv2jVS4xXq0wsixJEw=;
        b=NFbEiA6OhBAcBr8Fq+et2v+UPdcE+c2jqpW9QOsPRaJW+5BcX94gbAZScRS2GTVmGH
         QUPTpp7PrV928yAPOV5rcGBVPyjOwTm62AEySLqLS7Xb6lKx+TlGJYjYAGoXqnaKfeZp
         0O/84yW4DcjRRq+T7GJua0XotLLHgS+u7kBRmTGNVzhqRFnGxYGCpbvI+EgPCNVpz9Og
         KHrAuy2vLBXIoJHXJ0DlMGMnIs7bpYBu6v3iqpDahmcqYFVjbjp5t6Ey4xhcN5D5VKkQ
         A87Rw5JuP/KIxnALcuNlWpGXg50hXRMLR+y3Jpe4hGStanFQyix37i1uWS4C0ABhuNIM
         swLQ==
X-Gm-Message-State: AOAM5316uw0U4ckGwa0u49MZnDBLodARR5Ucl9SqKkiXSYQ5R+MqSyHp
        AQHRucPP9wItnjN9SdLdec8dpA==
X-Google-Smtp-Source: ABdhPJweQjLfl3Z2I4EIWZw8pwB7r6eyoCyj4BdjN5QJI5YwTdyLpOuupQoYb9sgXDe+xqjyl9/7CA==
X-Received: by 2002:a5d:628b:: with SMTP id k11mr11838681wru.107.1594824919525;
        Wed, 15 Jul 2020 07:55:19 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id c15sm3733251wme.23.2020.07.15.07.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:55:18 -0700 (PDT)
Date:   Wed, 15 Jul 2020 15:55:16 +0100
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
Message-ID: <20200715145516.GH3165313@dell>
References: <20200715094447.3170843-1-lee.jones@linaro.org>
 <20200715142651.GA44014@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715142651.GA44014@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020, Mark Brown wrote:

> On Wed, Jul 15, 2020 at 10:44:47AM +0100, Lee Jones wrote:
> 
> >  /*
> > - * This dapm route map exits for DPCM link only.
> > + * This dapm route map exists for DPCM link only.
> >   * The other routes shall go through Device Tree.
> 
> This doesn't apply against current code, please check and resend.

What is 'current code'?  It's applied against today's -next.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
