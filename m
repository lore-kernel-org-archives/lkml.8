Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2B6C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99531206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594847282;
	bh=EBmLbTlSMK0R6vQ7jmSE2L4gma2Vkoyzioh0GCdfGY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=taHyWfv7V+Xg7wI0e1Koa83l72jEOfnxbNjh/ynAqE7sZyA5UeFPHrBzuoPoOkzcq
	 /wmnrOWXUnOkzBxnGkdzxsgndZnS9VO4pbOJiuEdRzGkT7X0mMJeRRPGIO1VVzsjZu
	 yzj2dB2kSjcivAcS0mWgg9YJAWCSZHrLjH83Vojc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGOVIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:08:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39900 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOVIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:08:00 -0400
Received: by mail-io1-f65.google.com with SMTP id f23so3773269iof.6;
        Wed, 15 Jul 2020 14:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KjCMCoW7QDdmcFgzIcem7O98IMC/DL0hnlshYNlIU/Q=;
        b=FI3nxx3ezb4/JJRc4X9SmY1Qr7EPITBu8Ij7zRVLLL2IbgpTZZbPCOjuOZEvmz+9OP
         dFZV1sGbegRBQyDSL8eHC09gbv5GJbOa1vScToPsOFMZDDM7IEyeLmKtzu7R5kGEQ/a0
         HlKCSBtqJQE3mg9XIIga6VAp9tVV58X5BZzGBJ314i+K+LTa2Lqaelu4BJnib/OiTgcq
         5dfotMMe5+/FhqeKuBc/FY5MAE6rhJ+7z2WQ8DfoaUR/x1U8XpA4BsxvQRsuu/m8XglS
         fQlpX90utEL7580ATaTx0NlnmpclR+ro05tz9p8vvN6cAug+KSVqe8iqqJrHyopviS3Y
         3sGQ==
X-Gm-Message-State: AOAM530+J3uFGAdD/rh9D/z7MnK7Ia+JzMUlAnyooeEIy7tCPB4Gck7e
        mGIl0UOKsyTW9XeZST5cbQ==
X-Google-Smtp-Source: ABdhPJzEQjcFBWmWE376+W3/jvXjGaojoc/mmDz/tY6q3QXK03YBPeISo9pECab3cFblZ38C0GtHEw==
X-Received: by 2002:a02:9f8e:: with SMTP id a14mr1443823jam.95.1594847279881;
        Wed, 15 Jul 2020 14:07:59 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u5sm1663421ili.33.2020.07.15.14.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 14:07:59 -0700 (PDT)
Received: (nullmailer pid 818071 invoked by uid 1000);
        Wed, 15 Jul 2020 21:07:58 -0000
Date:   Wed, 15 Jul 2020 15:07:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: Fix example in nwl-dsi.yaml
Message-ID: <20200715210758.GA818016@bogus>
References: <20200703114717.2140832-1-megous@megous.com>
 <20200703114717.2140832-2-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703114717.2140832-2-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jul 2020 13:47:16 +0200, Ondrej Jirman wrote:
> The example is now validated against rocktech,jh057n00900 schema
> that was ported to yaml, and didn't validate with:
> 
> - '#address-cells', '#size-cells', 'port@0' do not match any of
>   the regexes: 'pinctrl-[0-9]+'
> - 'vcc-supply' is a required property
> - 'iovcc-supply' is a required property
> - 'reset-gpios' is a required property
> 
> Fix it.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../devicetree/bindings/display/bridge/nwl-dsi.yaml      | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
