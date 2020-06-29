Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01934C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAC42065D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593468134;
	bh=CgI9fUnKVI9FX5o6Sd6RRXh0KWVYE3/ydmsVQ/5vujo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s8VGAj1u0lVEr/nnqnX8zbX4QZGBoqrEryhxm1FXVTxRrmVUIF5f55Frq5itbDJyU
	 ghncb2TxF2FGb1ZtVt7yqgavDx1Xr4Bbf94CkA+XVlVuvPCRkdZaFlzZj78rCRQDhZ
	 eH4uB1AnqYDB2zNCfv3b/zcH0HQ1fwiRQoDfg/Mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733310AbgF2WCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:02:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41644 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731128AbgF2WCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:02:05 -0400
Received: by mail-io1-f66.google.com with SMTP id o5so18818253iow.8;
        Mon, 29 Jun 2020 15:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=afHxHL0q+snXSn6eqMofpQn9E+vOARFOoJK6e5NkoNw=;
        b=Ph11iOFcwWjLhWnHjb1YGp0kqHieIAGtPJi3ogpRF+U8SPCC8/jiKAEPDMYqV7ozzQ
         LwFuR60+P3jL0rdKssgSI4CAX1kMiI2aokiwGWJerhPIk0nZKTmfrS7d51QGxVxv6HHK
         wl4c+CpHokhqVGvKKT6EGnEJfuddameNPvupJupkRrj9VqE4xBoQfOkb7akde4SAm684
         TyMqQUCaLNuLw16S+RN072NmzlIs36VlFX465OfkNm3SvbSsNE+GGRhIP98aFmRapbRG
         jJJxbXscw9Qoo8MXhbKXtS9llK5D8cd7VpN/jceFRfy+B+RTtx9uNsqE6JPtsn1uywjz
         zKqw==
X-Gm-Message-State: AOAM530c62ZxYFRwSG1TeLhR26u37Mc+mAOj7F1sshrzQJJq82G48rMs
        vy1d7PnEbcHo6nhz8Yo4UA==
X-Google-Smtp-Source: ABdhPJzNeftMTga51dXNHRUX/fn+A9lDrm0VXYGRr6pcoNF6w2ldgkuAEULLK7lIiqDvpGlizdPAfw==
X-Received: by 2002:a5d:9313:: with SMTP id l19mr18548979ion.150.1593468124734;
        Mon, 29 Jun 2020 15:02:04 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id w16sm543971iom.27.2020.06.29.15.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 15:02:04 -0700 (PDT)
Received: (nullmailer pid 3014786 invoked by uid 1000);
        Mon, 29 Jun 2020 22:02:02 -0000
Date:   Mon, 29 Jun 2020 16:02:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     aric.pzqi@ingenic.com, devicetree@vger.kernel.org,
        paul@crapouillou.net, tglx@linutronix.de, robh+dt@kernel.org,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com,
        daniel.lezcano@linaro.org, dongsheng.qiu@ingenic.com,
        linux-kernel@vger.kernel.org, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com
Subject: Re: [PATCH v2 1/2] dt-bindings: timer: Add Ingenic X1000 OST
 bindings.
Message-ID: <20200629220202.GA3013651@bogus>
References: <20200625175714.57271-1-zhouyanjie@wanyeetech.com>
 <20200625175714.57271-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625175714.57271-2-zhouyanjie@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 01:57:13 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add the OST bindings for the X10000 SoC from Ingenic.
> 
> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
> 
> Notes:
>     v1->v2:
>     No change.
> 
>  .../devicetree/bindings/timer/ingenic,ost.yaml     | 62 ++++++++++++++++++++++
>  include/dt-bindings/clock/ingenic,ost.h            | 12 +++++
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,ost.yaml
>  create mode 100644 include/dt-bindings/clock/ingenic,ost.h
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/ingenic,ost.example.dt.yaml: timer@12000000: clocks: [[4294967295, 34]] is too short


See https://patchwork.ozlabs.org/patch/1317097

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

