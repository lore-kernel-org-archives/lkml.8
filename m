Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FAFC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162BB206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ranq0WLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgAPNWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:22:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37838 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgAPNWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:22:54 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so3792122wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YSdGbyz4cAulbJtXxaRPqLeCVXowQPtOo42gy8TEczA=;
        b=Ranq0WLA1uu0HiM6WvTKGe2oXravJHsDL3dTHoeOm6b8VZwoDtcTvOdi7sVtVC8uF2
         WsOdhbzQsuiXkAeKt9dxaeHua9qs+BpOcmqKmiyz42tpL8leLCNSpIvYhbE/Zm5X4egH
         jRU+BV9fMZ/vsfv59hrBJ74Lf4ZTHuEIsKoHFoBHe/wEQ5EJcmU3pGrjSsS4G4rXvUsl
         Kr46kZewS6tGgdyHkTgThm5RwLkxtjOM31SxPdOyc58lN49McAbWMUXUuZFOTr/LDk8D
         Yai0qsBQc2D7AMuzThTQhfnXmCV7TMzq7UuLxw5UB6y9MI45dExi8Vrk4FWDwhyF5w6N
         095A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YSdGbyz4cAulbJtXxaRPqLeCVXowQPtOo42gy8TEczA=;
        b=clzasheQah85hgY3hK0/l1JYQOjFhCNocyvfF7PKjuh4cuzFYxyvX45flS2iuwANKt
         HEP57NGez9pHBQENhVo/EPqfWuPjJGAtfR1KioTHKc635tLNBeAPlqyhZdu1Bh5c19iC
         O2EHGLNiWtNWw5+2C5hftLAaNcwElQ25zDwIff0WrMvg3ql+xIvVAvLBTAZsSenerzza
         0nLhynFGIjBD4DvAC7is29HPSlayOOyveoin5i5P3OyPM56fqi7fRTB+XFaFv/a8xCyt
         ak0gGUFu3Lc5tStNqZzi5v8Aut/BZ+0dXB9B7ffXUYvYeVakzJwz75pvnS01eJsfqTPp
         AM9g==
X-Gm-Message-State: APjAAAXlLxCNGQdzLWeyyktwcgsCrvMrbsai66lGo5vEfIB0q6gElZWz
        DlUNUxY90TDOhzhK5S/Ge8/owhyxhA4=
X-Google-Smtp-Source: APXvYqyegg4fv22A4mzkGZTi+FEK/MG0s3X/hV45khQTWD7H31khgUc1Pf4GP4r6RA3yTNynh1gdSQ==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr6317885wmj.90.1579180972252;
        Thu, 16 Jan 2020 05:22:52 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id s128sm4730518wme.39.2020.01.16.05.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:22:51 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:23:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH RESEND 2/3] mfd: madera: Wait for boot done before
 accessing any other registers
Message-ID: <20200116132309.GJ325@dell>
References: <20200114151048.20282-1-ckeepax@opensource.cirrus.com>
 <20200114151048.20282-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200114151048.20282-2-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020, Charles Keepax wrote:

> It is advised to wait for the boot done bit to be set before reading
> any other register, update the driver to respect this.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> This patch can be applied separately from the other patches in the series,
> if needed. Just resending to keep everything together in one chain.
> 
> Thanks,
> Charles
> 
>  drivers/mfd/madera-core.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Just applied v1 of this.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
