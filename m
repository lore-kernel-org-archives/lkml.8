Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572F3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F1620748
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YMevjxcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgETGOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgETGOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:14:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE88C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 23:14:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t40so774354pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 23:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wMChkmNgO38kmLmBamx1KyuI/0Qmetg62NTnm+IHgR8=;
        b=YMevjxcGr0pBC5pur4aECmA4953I9pPKEaB7XzAdeyG/MuEmsu97dZru1srzGFctvh
         BgKJvCF+oHQDKRZoJiOljLMD5h/ZYOTqGbOagOeMH+94Es9oZJSCVq7Br28VtLC/3Hrc
         6piDPFLUeotpbrjBN0Wi2DtXtcg6ZroHY70KVglpS16ija0//aLlHZKnduRLQhGWyLeA
         33NfZ4nKJFpf8tt7FMBL1VNBxr7Y/hJ1edQBIFVGM9IcBcA7PZQSTttChfyeG8PnV7V5
         dNF0l1nbRTlf6CuPbwczsPy1806kE3HNEnI9EYtur8flLzQxwNk5T14Dy3WwSqt25BH+
         hVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wMChkmNgO38kmLmBamx1KyuI/0Qmetg62NTnm+IHgR8=;
        b=d0Rkw3lBsJhA1tDZeYmyWflzjcuwsC8fGAbyIl2WljMZMxN3a2qTGq/KB6j/MC4yU8
         gJ3KwcHn/1AxVx9FRbUGvXkdhvSZcf5Mgtvtc4owKmDepfat2ujYOvmZHwfpwWCz7Jm0
         ylRikzUvz/znoxvTojxjAdsjVj3dBiloy3ZID56ilvMKfOcX5XtdA1Gq9VWV9TXbCo11
         8u9VFQUCbilDhNn2CQ2AYSJErei7fjqnT6wQN2O+sbd4CTTp4OvGcX9AR5Rhrbv8QXCw
         yirLfaU8/KIIubXerYBVxF8wHiWWrlgocIjavrtcPhFTLwR0jxAF/H0GYUDDPqh5Qt/1
         DWAQ==
X-Gm-Message-State: AOAM531uFgt7TEcCtW05HR6tZ5RQn9PKIvvEhXFcw96yNAo8WvCPVROk
        Ch4/8zI+jujvIF/5v4TEOqSnDA==
X-Google-Smtp-Source: ABdhPJz2dv2yzNLD7cibiASunEXoep0JLsfaI6ofpzIrW+Jcy2OaJDiqObZ6z54bqyX+f8mX7BhZzA==
X-Received: by 2002:a17:90a:36a9:: with SMTP id t38mr3586040pjb.48.1589955259196;
        Tue, 19 May 2020 23:14:19 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a16sm1162808pfl.167.2020.05.19.23.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 23:14:18 -0700 (PDT)
Date:   Tue, 19 May 2020 23:14:16 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Eli Riggs <eli@rje.li>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/3] arm64: dts: qcom: Add initial sm6125 SoC support
Message-ID: <20200520061416.GB11847@yoga>
References: <20200517115410.3374-1-eli@rje.li>
 <20200517115410.3374-2-eli@rje.li>
 <20200519060848.GB2165@builder.lan>
 <20200519041846.3892747b@casper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519041846.3892747b@casper>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 May 04:18 PDT 2020, Eli Riggs wrote:

> On Mon, 18 May 2020 23:08:48 -0700
> Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> 
> > Please use dual GPL/BSD license for dts files, if you can.
> 
> Unfortunately the downstream tree I ported has a GPL-2-only header.
> 
> > [...review]
> 
> OK
> 
> > Given that you won't get very far without GCC and e.g.  pinctrl
> > driver I would prefer to see some patches for those as well, to
> > ensure that this will be able to go beyond basic UART.
> 
> Cleaning up my gcc and clk-smd-rpm drivers now, as well as another
> patchset for pm6125, qusb2-phy, dwc3, and sdhci. TLMM in the vague
> future.
> 

Looking forward to review these!

Regards,
Bjorn
