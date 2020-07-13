Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54512C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302F020B80
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594676491;
	bh=s21nN0PoT4wYXHHvEcseQ4YAZuyB4muxRpazrtUW9g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xEW2sJQclWwS7t4FwbquRxSDKaFDGwn2nhWNvpYa9st2LkhJMuYXLy4+dB6DPAwxx
	 S4Gyc27Xzp9z0AtQdVLof8ysTAGhjAbP+qnuOPLMim1ds+ooe+mSrz4gGlbSgPlgm2
	 4Fq57KuAJltpbhap4bbYxbq/zNZkiPjZ7RjHyEW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGMVl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:41:29 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43812 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGMVl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 17:41:29 -0400
Received: by mail-il1-f194.google.com with SMTP id i18so12535835ilk.10;
        Mon, 13 Jul 2020 14:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MnRt+eOdMAkvcPxA/OIYcge3ggOA8Or7nQ7c1V/nZW4=;
        b=VmnoK5M6/qhbg36I7nwI2cqHPk0dwrYxKznBK84S6dJCl+2KksWs/ODQ7gnjWjPoAo
         E1sm+RvnjpfYgO0x8s32nx1U09kCEfqzI+xn9SwoVUjI8YjWdKAjUGu74fH8jhtA6bJ4
         1Db7GkcRYIVbsiBvrBbLjN9AkGD0AHFcQkJj8aNmfiNTIPYX9TMOk2Yj8dOlr36QVMFy
         h1cDf4VIuB4uSkI8dYkFI20TjaLPYQGTPDHSjCSxAcLklRfb8K0FCjz33ukjYxT9BLgx
         GBr732hebDrGuRM82bNYvTei8CqMs6PB/ZP01rZzEpjFD6GjkzSZPdOiclWPtX9ymdQ4
         x4hQ==
X-Gm-Message-State: AOAM532gJcxW8e26Y3tArPzHY5tKwkEMiXXyYS4q/bXh2CT6oLW503Hf
        JOUEyNsZ7mKHZVrGgPv4Nw==
X-Google-Smtp-Source: ABdhPJzfU6/JPJV1rhOxooZnGqbXB9+2KWa1AwQGdCgoztDDyS/knMygq+4uWLe3oZf4ufr4oMDV0w==
X-Received: by 2002:a05:6e02:11a6:: with SMTP id 6mr1729560ilj.64.1594676488177;
        Mon, 13 Jul 2020 14:41:28 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f9sm8790295ilq.9.2020.07.13.14.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 14:41:27 -0700 (PDT)
Received: (nullmailer pid 776787 invoked by uid 1000);
        Mon, 13 Jul 2020 21:41:26 -0000
Date:   Mon, 13 Jul 2020 15:41:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 8/8] dt-bindings: interrupt-controller: Fix typos in
 loongson,liointc.yaml
Message-ID: <20200713214126.GA774746@bogus>
References: <1594087972-21715-1-git-send-email-yangtiezhu@loongson.cn>
 <1594087972-21715-9-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594087972-21715-9-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 10:12:52AM +0800, Tiezhu Yang wrote:
> Fix the following two typos in loongson,liointc.yaml:
> fron -> from
> connected -> connect
> it's -> its
> 
> Fixes: b6280c8bb6f5 ("dt-bindings: interrupt-controller: Add Loongson LIOINTC")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/interrupt-controller/loongson,liointc.yaml    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> index b1db21e..732ad9a 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> @@ -51,8 +51,8 @@ properties:
>      description: |
>        This property points how the children interrupts will be mapped into CPU
>        interrupt lines. Each cell refers to a parent interrupt line from 0 to 3
> -      and each bit in the cell refers to a children interrupt fron 0 to 31.
> -      If a CPU interrupt line didn't connected with liointc, then keep it's
> +      and each bit in the cell refers to a children interrupt from 0 to 31.

While at it, s/children/child/

> +      If a CPU interrupt line didn't connect with liointc, then keep its
>        cell with zero.
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      minItems: 4
> -- 
> 2.1.0
> 
