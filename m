Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4538C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE9C2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596227194;
	bh=PxT0jVwjdkx7THGQpKx/aFcEEzkZRoIpqvI4/H7Vwzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EGtRkCcdX1XFdOSq+e0dk85j5b84Y3PHdfJpK/TJ0em8dpelKQWf6bmCGDfB73Nsx
	 kR2yEIH+bitZxDEyriif6iMcklfd0s14HnsEkhKnZHtn0NWibeIAR5mH6pVOZqPc7z
	 HzEDJ+EEY5CgQ5BMnE6Z2XuWzawinVPZogR4kRnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgGaU0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:26:33 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41911 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaU0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:26:33 -0400
Received: by mail-io1-f68.google.com with SMTP id g19so20823614ioh.8;
        Fri, 31 Jul 2020 13:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AiMGdmCb+bz6YVV8Hxa7igAvU6qudkwfV+tj6X7dOh4=;
        b=uZFfWSqu1QFP7S56tWlq79piShbs2hZ7yscV+BgjNVBPopSH38s4gio6+FjsnvNSYg
         o6f1bLPBOE+weldN+KEX6/IcPWuBuYgwNrHuY4h5c0MyXPTwvb7CtIIOfQ1xsbtg2BZn
         ue1MJSOEM3vQG4arFJKLzN0WOt90T577IabgoCDeDTtsSu2NNWZme5SJHlO8pCsBuj7c
         R8bq3Xj79wM1L/sLv9R0YT6OgPvlzFszUlBwxfrcsdZQSLqBMHUac2YPP80oTFzSIstT
         CvO3LiBw7Jgwo/EPd2JFKYRMsvl3xfj+ezn1Tr84HJ4Bng+D2PACrMorhQDJ3vZAk+Yk
         g4Lg==
X-Gm-Message-State: AOAM533U7J5M8iwAIMjGXYj6SX49ib4ZVzHIRP8+xOyKnJ5dp9vLwwzZ
        5JQhS8M6PLxVuZ4pDmCorA==
X-Google-Smtp-Source: ABdhPJxPe/ccy6ODQW2ezEBqzYMhTdtl0ygSHo9crgD2bv3oq38Q3L9HvFzQgv5RMZ2ASGAI4iFJsg==
X-Received: by 2002:a6b:b74b:: with SMTP id h72mr2738365iof.52.1596227192057;
        Fri, 31 Jul 2020 13:26:32 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d125sm4827878iof.32.2020.07.31.13.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 13:26:31 -0700 (PDT)
Received: (nullmailer pid 723736 invoked by uid 1000);
        Fri, 31 Jul 2020 20:26:28 -0000
Date:   Fri, 31 Jul 2020 14:26:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        martin.botka1@gmail.com, Xiaozhe Shi <xiaozhes@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Harigovindan P <harigovi@codeaurora.org>,
        Felipe Balbi <balbi@kernel.org>,
        freedreno@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, David Airlie <airlied@linux.ie>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-usb@vger.kernel.org, zhengbin <zhengbin13@huawei.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Sean Paul <sean@poorly.run>, Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 3/9] drivers: usb: dwc3-qcom: Add sdm660 compatible
Message-ID: <20200731202628.GA723682@bogus>
References: <20200726111215.22361-1-konradybcio@gmail.com>
 <20200726111215.22361-4-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726111215.22361-4-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 13:12:00 +0200, Konrad Dybcio wrote:
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
>  drivers/usb/dwc3/dwc3-qcom.c                         | 1 +
>  2 files changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
