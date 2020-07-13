Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB2AC433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D4620663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594655560;
	bh=40qtcbwFchqJ8vBUEk4KEu6k8zSbgF/WxMSY8WBbSRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ndp+hybEGL5ZqGJIpdPzK5LzJCFAS6+eHcV2nS++I8BvhkFcQTvvn+Xt8W+tbXN6u
	 lUevL+bSDj1AS+T3BUUhVK02eRogD+pcb1pADwE0+zxa+5gPkN6dJKZhxcBYPuV/Y3
	 CaUNokpMl3R7KPCG+V/kjPfsNG5Z1ZuhuLRNMmcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgGMPwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:52:39 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45039 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbgGMPwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:52:38 -0400
Received: by mail-io1-f66.google.com with SMTP id i4so13959205iov.11;
        Mon, 13 Jul 2020 08:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Og7BkYL+oiNLDgCfsnUgO6NhQoUD5ht+hSYNasuYtP8=;
        b=W8QSNCm/PZfsK/SMS7AXJXrE3PRMZSuZykCYrtOI6Hl6IiF48OtRw5WpKlUna3bm1e
         S5vCmR0L/SD8GTKhLigbbXz3XfU6gSZJI4CGo+GC7GIosEwvy8HYVPLhXCJ5AWtv9nMt
         vi+cIq2hKCLAZU7xUoq7ifwHxuNrCMe457+RYS2i5unag8zFbTJ8iJRRi4Fug5xp+f3v
         wBhgrqYSv5WURlgrlpJH/T+EJtGDuz8aaV0pvQ+9/us/d9dLwzOh+uIxUsB20Ebc65Gh
         q8n4fJFBS4jtQxZaidZBP4eF7dgb1WHH8nbfjzEs5kod4kke39MxXjwafRpIbi09kc+h
         JUXA==
X-Gm-Message-State: AOAM530RVqLLT2xOeLyBqHb+76PNTi5FdC3LkH2IIyfhEV080lxZ7ICQ
        5rOW4dxxYE8F/t4oHUzu8g==
X-Google-Smtp-Source: ABdhPJz2hs8g3YQG4YgdiIDD9SU9toPlQEztr/OyGHwPf0X0T3cCrlIrG9PmjDn1Fn0Y+t09ixjo1w==
X-Received: by 2002:a5e:9b0e:: with SMTP id j14mr297203iok.169.1594655557525;
        Mon, 13 Jul 2020 08:52:37 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t14sm8930940ilk.17.2020.07.13.08.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 08:52:36 -0700 (PDT)
Received: (nullmailer pid 280514 invoked by uid 1000);
        Mon, 13 Jul 2020 15:52:35 -0000
Date:   Mon, 13 Jul 2020 09:52:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     devicetree@vger.kernel.org, dongsheng.qiu@ingenic.com,
        sernia.zhou@foxmail.com, tglx@linutronix.de, aric.pzqi@ingenic.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, zhenwenjin@gmail.com, yanfei.li@ingenic.com,
        rick.tyliu@ingenic.com, robh+dt@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: timer: Add Ingenic X1000 OST
 bindings.
Message-ID: <20200713155235.GA280416@bogus>
References: <20200710170259.29028-1-zhouyanjie@wanyeetech.com>
 <20200710170259.29028-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200710170259.29028-2-zhouyanjie@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jul 2020 01:02:58 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add the OST bindings for the X10000 SoC from Ingenic.
> 
> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v1->v2:
>     No change.
> 
>     v2->v3:
>     Fix wrong parameters in "clocks".
> 
>     v3->v4:
>     1.Rename "ingenic,ost.yaml" to "ingenic,sysost.yaml".
>     2.Rename "ingenic,ost.h" to "ingenic,sysost.h".
>     3.Modify the description in "ingenic,sysost.yaml".
> 
>     v4->v5:
>     No change.
> 
>     v5->v6:
>     1.Drop "oneOf" and the blank line.
>     2.Add "additionalProperties: false".
> 
>  .../devicetree/bindings/timer/ingenic,sysost.yaml  | 63 ++++++++++++++++++++++
>  include/dt-bindings/clock/ingenic,sysost.h         | 12 +++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>  create mode 100644 include/dt-bindings/clock/ingenic,sysost.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
