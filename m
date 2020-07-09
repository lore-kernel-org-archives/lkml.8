Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B804C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F5F1206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594326372;
	bh=cITVT+0Hmjc0/8RxgoF23JFYOMYqwmrkEtcPGiYLk10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1duZYGgpQpZqtfYfo4ky5CsIm/Arr+QZYuypt8BxlM+IlTxcZ+oEmMa5J2n92EgyV
	 6tT4S95v4WxZb0XGNKfAjFRPYm7hfQB5ePbKZMuRv2gq7Zzq7aheqoeO2VKF/eblBo
	 aLcl2lPskOnI5FsiC4MJxDtce47UZPyrKiAlUmxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgGIU0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:26:11 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43733 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgGIU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:26:10 -0400
Received: by mail-il1-f195.google.com with SMTP id i18so3153365ilk.10;
        Thu, 09 Jul 2020 13:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pbqcota+uxMHedfTegltZRxrsC6vfzXshLlXxe0iuA8=;
        b=MA3r+Apiiwt047W2N6FfWHbA84e+aBRwYnvrLTWrC/+sxIGvuWI8AZOX/82FKw+Z1J
         XhZG960jao2bJi20ykLXPrHAPmow0MXBoB9URKaPSb6wig23KoZxyqSzwCdf34FLQ09r
         Q+OEnO8nBtTa24TPVoKlgOKJ75eLh2IL/5+ZaWULq/VF56UBgDWIz9l5eW9tlGnwIwEV
         HBd+ek9KbUM/5i3vOciANbOIg1ulsHDrHue0J5qFGMg6ytLnCBAycaNkitvFgkymN9Xz
         w2Ds448FnfESmcaSsw9ArgL+zXxjlDi5KK4AEUj4F8JTJt4T7w5T56Gvb48lXNqAEE9s
         o8qw==
X-Gm-Message-State: AOAM532zMLpbiQViSN5oydu83ybvbWjDK/5JoPXqnWcRayphpycNsqcp
        WFfsniLLkR5I67sxOUR35sQ6e6hL9Q==
X-Google-Smtp-Source: ABdhPJz/rrxaNaSnbsqf9KR30EyQSwsbmLE+U5dYgyuILwBQnI28nLIAJh6GSc0L5Paa1d13u6Lulg==
X-Received: by 2002:a92:89da:: with SMTP id w87mr14231050ilk.236.1594326369801;
        Thu, 09 Jul 2020 13:26:09 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id s17sm2788133ioj.10.2020.07.09.13.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:26:09 -0700 (PDT)
Received: (nullmailer pid 830691 invoked by uid 1000);
        Thu, 09 Jul 2020 20:26:08 -0000
Date:   Thu, 9 Jul 2020 14:26:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, f.fainelli@gmail.com, robh+dt@kernel.org,
        jonas.gorski@gmail.com, linux-mips@vger.kernel.org
Subject: Re: [PATCH v7 2/9] dt-bindings: reset: add BCM6345 reset controller
 bindings
Message-ID: <20200709202608.GA830643@bogus>
References: <20200617105042.3824116-1-noltari@gmail.com>
 <20200617105042.3824116-3-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200617105042.3824116-3-noltari@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 12:50:34 +0200, Álvaro Fernández Rojas wrote:
> Add device tree binding documentation for BCM6345 reset controller.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  v7: no changes
>  v6: no changes
>  v5: no changes
>  v4: change license and fix maxItems.
>  v3: no changes
>  v2: no changes
> 
>  .../bindings/reset/brcm,bcm6345-reset.yaml    | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
