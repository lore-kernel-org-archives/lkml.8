Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781F2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D122206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597261471;
	bh=te33EoPc+Iz5uxZ9KIQiSsxB+yOdodisP4m1q+Ea38A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DkuoAKkLi6UfbJQ23KShz0QDozjpKPY9qkj5hAbgSDd5kreZaAyDpk6X4UUKQOaUt
	 ijsOJ3rnIPJJecMY0S/fenjotlfa90j7yjZ+ScmmU2PzMrwj/Oh/bEttyfUCb1bYTK
	 d9RwQSUSYjXoRojTnQaRiaVP5cthkvxHEOkmoaMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHLToa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:44:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41991 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgHLTo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:44:29 -0400
Received: by mail-io1-f66.google.com with SMTP id j8so4275396ioe.9;
        Wed, 12 Aug 2020 12:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PI60pBGvyY4YK8WMXJBtlmGtDEkgGzmHg6VvPJsaQpE=;
        b=VI8TkoCAWHmXRNWnVSOtPSHzOP19XClJNzHauG2MBv4GYmrB7c7Wh9Tlk5QShe0HSa
         j0WnUHuaa5gP3rMEEhvc1uWlGY7h1VtTLCstorz17CFwZlyZvHNiyzLH6UzDzZjPSbcZ
         UEOTBRLxPT8bTVjHmCzxsqNL5ObnvaA9+LKNY6rxYhizDGGdyluDQPZzYyZnYo30d4EW
         AUiYW0qozM1Ov1Et8qRe2L5sL1xAMJMHEUrC6+kFaiFkseB1EF9rIn67nI5IrpJx5VQP
         zdXIqibDymFpKTayZAIoa18es9BDK3BYkQNyoIn429noWMaIAwUbCID7iaFaRIuVAG4y
         /sag==
X-Gm-Message-State: AOAM531AwY8fiLPneBuhxDFPPtq+/anttgmYgwm5I6NKAEva2YvKyGbo
        DXWNMLVaIHTdQ+rzGqceUA==
X-Google-Smtp-Source: ABdhPJxtdZ8IsN1XGqyW7GSknz7VmFg9WPtG4jxsvpLrp0sWIqvvPreSCVcRhSyLZtRAjKXTfLscmA==
X-Received: by 2002:a6b:6c13:: with SMTP id a19mr1392236ioh.31.1597261468379;
        Wed, 12 Aug 2020 12:44:28 -0700 (PDT)
Received: from xps15 ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m7sm1540808ilq.45.2020.08.12.12.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 12:44:27 -0700 (PDT)
Received: (nullmailer pid 2587368 invoked by uid 1000);
        Wed, 12 Aug 2020 19:44:23 -0000
Date:   Wed, 12 Aug 2020 13:44:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com,
        linus.walleij@linaro.org, srv_heupstream@mediatek.com,
        jg_poxu@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-gpio@vger.kernel.org, seiya.wang@mediatek.com,
        eddie.huang@mediatek.com, biao.huang@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        sin_jieyang@mediatek.com, erin.lo@mediatek.com,
        sj.huang@mediatek.com, chuanjia.liu@mediatek.com,
        devicetree@vger.kernel.org, sean.wang@kernel.org,
        linux-arm-kernel@lists.infradead.org, hongzhou.yang@mediatek.com,
        hui.liu@mediatek.com
Subject: Re: [PATCH v3 1/3] dt-bindings: pinctrl: mt8192: add pinctrl file
Message-ID: <20200812194423.GA2587320@bogus>
References: <20200807074905.23468-1-zhiyong.tao@mediatek.com>
 <20200807074905.23468-2-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807074905.23468-2-zhiyong.tao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Aug 2020 15:49:03 +0800, Zhiyong Tao wrote:
> This patch adds pinctrl file for mt8192.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  include/dt-bindings/pinctrl/mt8192-pinfunc.h | 1344 ++++++++++++++++++
>  1 file changed, 1344 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/mt8192-pinfunc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
