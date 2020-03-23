Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF61BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D1C20786
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585001077;
	bh=AOPBox0FGNwadNDBx5AibYFv7qRynIoProGlTcDXSJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dSuhrCWqOvpUck+ujrKKqZ/LKTZ5kNhi6G/1J/2OhudFBLgalOh3f7QhvrEp/hZeo
	 MQrgAdGMK7rFB0VjidWX0wBDntZrmzVoFlq8GuxTfPyRLUqFuG2ov2gh86Q0/8Uf/F
	 NjdKcbhnhNCdj6fDDPH+QK9fRpgrbdz6MohrC7Hk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCWWEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 18:04:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38607 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgCWWEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 18:04:36 -0400
Received: by mail-io1-f66.google.com with SMTP id m15so10982364iob.5;
        Mon, 23 Mar 2020 15:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OxmWLYX7moIPVGiIwbbFxtiUZQmEPG+TJ66GSCPnfpE=;
        b=hEzLAQh429bRt5qFBFddLX4wUIPoTFol5g1/1nunTlcI3TRNGYkyI8tUXp3khlv5QH
         +vbd7H/k1yuGS4iUrwUYa0RB+Vpwop737tDa2S4ZC9HngJp2VRkF8qK77zK5aaLsZuDf
         vGDoXGqBBL7FsbED6RWOXvoRHg6Nvirv/euDFUtqYjoHX/Vgyjt4VFeTAol8XfOb16el
         kEAllQ25A8l9QR/fOdh9IHktLqsMMfzlStjeXA8lWfKbleVq2CtbxJwrzvu5sNp1Lz2F
         BaDQGJhw6X6zAv52Zj8h/Oq77o+fZ4DR0XlNhmFi9anE8W3ke44vANOUwD6c3hQqa+ig
         ABkw==
X-Gm-Message-State: ANhLgQ2fvm1QQ1segwMH3cw3tzuezrhpFMcrG5vCxuYWJ9JncIOcWEQV
        6R0a60JUFatqwnseeoT1Yg==
X-Google-Smtp-Source: ADFU+vvj1yTP/dxc/c85bcfJYJQxOiDFkLfIs3nP/BoYkiG+qoSkVWyO+SkPv3v6lQjXgahyel2PfA==
X-Received: by 2002:a02:390b:: with SMTP id l11mr7659387jaa.111.1585001075011;
        Mon, 23 Mar 2020 15:04:35 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c28sm5728899ilf.26.2020.03.23.15.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 15:04:34 -0700 (PDT)
Received: (nullmailer pid 17421 invoked by uid 1000);
        Mon, 23 Mar 2020 22:04:33 -0000
Date:   Mon, 23 Mar 2020 16:04:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Phong LE <ple@baylibre.com>
Cc:     narmstrong@baylibre.com, airlied@linux.ie, daniel@ffwll.ch,
        mark.rutland@arm.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, sam@ravnborg.org, mripard@kernel.org,
        heiko.stuebner@theobroma-systems.com, linus.walleij@linaro.org,
        stephan@gerhold.net, icenowy@aosc.io, broonie@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: add ITE vendor
Message-ID: <20200323220432.GA16431@bogus>
References: <20200311125135.30832-1-ple@baylibre.com>
 <20200311125135.30832-2-ple@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311125135.30832-2-ple@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 01:51:32PM +0100, Phong LE wrote:
> Add ITE Tech Inc. prefix "ite" in vendor-prefixes. More information on:
> http://www.ite.com.tw/
> 
> Signed-off-by: Phong LE <ple@baylibre.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Already have a patch for this queued for 5.7.

Rob
