Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79159C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50BF4206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591999082;
	bh=uYvKKcTsqnKzG0/nyMwAdM7ex0nYDWD29hyPT9y+VGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PKtbfM19hlk5HQR8+j+r6kkQp98FkvWP4j3i0XfcHCRqxZUD7V9lgOmC3TGtyEu9t
	 aaFlTXDmfTDjndPR/9x5XGcnOCzLMlDD+McYdTJNDu+buLUHPFxeh0iaiZflaxHqfj
	 xLzs68loXx1P8f/trrJ+rXoYtapy/Z2yHsM0eCcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFLV6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:58:00 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39076 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgFLV57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:57:59 -0400
Received: by mail-il1-f194.google.com with SMTP id p5so10172800ile.6;
        Fri, 12 Jun 2020 14:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pHM8XJGvKsIRTe5Lbde6U7kTbIk7zcl36QwVvwup0ds=;
        b=L3aHZvhKkswZ0b/3sHXFkQkg7nozcA//ugqDcMbPk2K23LeNnpD3X5/T3Vu8udSrA0
         3hr2gVZZQp7bygwy3+2JnhSzxanq/IibjYj6wn4YZUwnSHwUdQ6t9GVNtfAsQCxqSwCm
         tKAI4juC5gbnE98s7JFmMfMvcgTgPFWNf/TCC+FB+neRJWkcdTD/q22ZYzKC8CAwNcfK
         ICwiSRBoJ/weHrJYd8DeOis4UwmzF6Fhn3tYDWYtlb9DmdY/8LLAXSOYjxLjbJK0g9oq
         /t0nCshblrnhNSkreIYYPh+oTCFT0fKRt+YVdWDGShCzl8CG1w79a4BczAE3JuD7wk1w
         LgnA==
X-Gm-Message-State: AOAM530w0VGvJO8LSYdVqwgvzFCkJmoGEJCty3T7qMmNJWHX7BERrkpl
        CAABCjcmTMvPEm7RebkWpCHQKH0=
X-Google-Smtp-Source: ABdhPJwBJXZ6qTpr5XlJxsK2J385TrPIpiF/xFJhD82gzE+m5HxhdWCL2zvhNJ1usQLjPmuIcGi6NA==
X-Received: by 2002:a92:506:: with SMTP id q6mr15430299ile.107.1591999078426;
        Fri, 12 Jun 2020 14:57:58 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id c5sm2702304ioq.9.2020.06.12.14.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 14:57:57 -0700 (PDT)
Received: (nullmailer pid 3885581 invoked by uid 1000);
        Fri, 12 Jun 2020 21:57:56 -0000
Date:   Fri, 12 Jun 2020 15:57:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        jonas.gorski@gmail.com, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, robh+dt@kernel.org,
        tsbogend@alpha.franken.de
Subject: Re: [PATCH v3 2/9] dt-bindings: reset: add BCM6345 reset controller
 bindings
Message-ID: <20200612215756.GA3884504@bogus>
References: <20200609160244.4139366-1-noltari@gmail.com>
 <20200610172859.466334-1-noltari@gmail.com>
 <20200610172859.466334-3-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200610172859.466334-3-noltari@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 19:28:52 +0200, Álvaro Fernández Rojas wrote:
> Add device tree binding documentation for BCM6345 reset controller.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/reset/brcm,bcm6345-reset.yaml    | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.example.dt.yaml: reset-controller@10000010: reg: [[268435472, 4]] is too short


See https://patchwork.ozlabs.org/patch/1307115

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

