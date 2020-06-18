Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D43C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46C0D208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592505426;
	bh=IHSg7lrBwuQ14jZuv3YABsiAz3/2MFfyoMLk+VJ10Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uoi1u/V4AWDBSEGSwZoP0mtCyo91S7rbnOfjobQ2PBBiNpMItMTLEv7IrgMszi2Sw
	 Z2UT3mEevJPmRDHT2deVg8jkPG4XNkpH/xOOziuu4mj228rqzzJvqxoHELNjVb/Awk
	 CEwOuz06t2JHS6OPFdhfMvIup4JgyqRmTL6BBuYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgFRShE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:37:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38879 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgFRShD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 14:37:03 -0400
Received: by mail-io1-f65.google.com with SMTP id h4so590595ior.5;
        Thu, 18 Jun 2020 11:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wygYqTNT6G3QvAJfF7oyk+ZOc5oZNOBZOOgIykuzly8=;
        b=unuRsbLiDXvXXT4IYidu/5EkWcPMQFSxjt5hnnLEKBV5bIJwNGn3CpjiuJhFC9r4QU
         7p1OVF0/JU5gpuccqE77VqIn1PUeQEFm/Ws3yuybb/jOAyuEGycCSvUFSk9I5NHsj3UD
         udWG3BEH+IRvy1R7s0f12EfqJ4AvRnmBlea4OzIGB9KJPmdzHjlyrAdqAnjcgrWFsIEU
         9mSVZ2koLW96gpFhhgCtGGW/axwnhEEdzIhI1O6LL1eJt8xI8ZBTFiYloGyILdBqz2uU
         6IZXcLvjY0fAQkQqnlMtYx891zqN+qEZUcYLrcgYEqDzTHCsnDNWjh6rqZYXUFr1rM59
         QCtA==
X-Gm-Message-State: AOAM53043od1TP61ZvFsiqL1DegUmM6l7Wp0wuSdzVd94XwW69O0mmbT
        r3358PgRij8v0sbcHSpv8A==
X-Google-Smtp-Source: ABdhPJx7xeR3+HQ8b4NxOi/J+ZFJIhmbXIg3/1OQ2uZoV0cZx8iWwPc1ZPoV9VCjHN+gnoYYhdUOlw==
X-Received: by 2002:a02:844d:: with SMTP id l13mr5723498jah.105.1592505422376;
        Thu, 18 Jun 2020 11:37:02 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b8sm2065295ior.35.2020.06.18.11.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 11:37:01 -0700 (PDT)
Received: (nullmailer pid 679615 invoked by uid 1000);
        Thu, 18 Jun 2020 18:36:59 -0000
Date:   Thu, 18 Jun 2020 12:36:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     linux-gpio@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v1] doc: devicetree: bindings: fix spelling mistake
Message-ID: <20200618183659.GA679453@bogus>
References: <20200615075835.15202-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615075835.15202-1-f.suligoi@asem.it>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 09:58:35 +0200, Flavio Suligoi wrote:
> Fix typo: "triger" --> "trigger"
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> Acked-by: Guo Ren <guoren@kernel.org>
> ---
> 
> v1: add Acked-by: Guo Ren <guoren@kernel.org>
> 
>  Documentation/devicetree/bindings/gpio/mediatek,mt7621-gpio.txt | 2 +-
>  .../devicetree/bindings/interrupt-controller/csky,mpintc.txt    | 2 +-
>  Documentation/devicetree/bindings/timer/csky,mptimer.txt        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks!
