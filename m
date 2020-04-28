Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B48C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB1F206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588068172;
	bh=6EvPvDn4hfJc3RQhxMxOiskjhaR1xPJY2/XDcNYu2y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p3AA1RR78eF3TIxdO9EeLje1back2LW0uXZnHc1hMYz+aE7HjdsK0/H0PYbn5xckp
	 5p2P72WtMu5HXzR7rJut1OaoE5Gf0Q0DlF0OrdJgBqzL/veaZJCmy5qpi9UpXnzatz
	 QM511tOwCIwQF0BJ+GCLI+2TlpqCRJlmFljqnFSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgD1KCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:02:52 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:45327 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgD1KCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:02:51 -0400
Received: by mail-ej1-f67.google.com with SMTP id rh22so16762387ejb.12;
        Tue, 28 Apr 2020 03:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FdgTZhQz7Q5QmkJw9fgTQ4qIxRdbshIzbPzMNz/iR0Y=;
        b=X2JgyMsXfBDE8/GIlhbuG3Tsyi+wiUAsL8avvBVkK3Ja6w9ReUF0cZ6PZII/OVkPFZ
         Rlq+Jvv02hEg4V82/XrLBz3gLfzRIPawD/pso/AOxtrQAUmErrICkPpgYb9ieGuaLLNx
         t/KEPc2zvGeGe7EdL1KtXyIRYruFtsagEU+bHVUXTot21Vg72wJuHGM80WMExQcADbUF
         716n8pyEoBHCi8BIx8IBR9zOLyc0T0AweVVydD9A6AeeSk7fSRuupZhOvW347Ahm5lUC
         Y+nBTYkiH+m5el/HjCz1Jv+4SmDMpZzH228fac+RqhAYLkmjavy4m2WtCjXesojmXZy2
         YZow==
X-Gm-Message-State: AGi0PuZvVUmrpB8BO8eTmPCmSOeS+NpHuxASKYwIKDtp9B0g3DwME4UB
        Wu5SaSyXBSLS/NLEhNKFJ0k=
X-Google-Smtp-Source: APiQypLNHR35H8mMj7YM6wlGtmknjJpqsf8ucJzMlAVC6jgxX/rMDRMP53hjmGcXj1nX3rrXkSLHYQ==
X-Received: by 2002:a17:906:a39a:: with SMTP id k26mr22838875ejz.172.1588068166900;
        Tue, 28 Apr 2020 03:02:46 -0700 (PDT)
Received: from kozik-lap ([194.230.155.237])
        by smtp.googlemail.com with ESMTPSA id ks10sm402601ejb.89.2020.04.28.03.02.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 03:02:46 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:02:44 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kgene@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] arm: dts: s5pv210: fascinate4g: Add sleep GPIO
 configuration
Message-ID: <20200428100244.GA23963@kozik-lap>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <BN6PR04MB0660532FF97089208CCEEB2AA3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0660532FF97089208CCEEB2AA3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 11:35:53AM -0700, Jonathan Bakker wrote:
> In order to minimize leakage current during sleep, set a config
> for sleep GPIOs.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  arch/arm/boot/dts/s5pv210-fascinate4g.dts | 242 ++++++++++++++++++++++
>  1 file changed, 242 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> index 07a8d9bbe5b8..94dcb9b64b9a 100644
> --- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> +++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> @@ -36,3 +36,245 @@
>  		};
>  	};
>  };
> +
> +&pinctrl0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sleep_cfg>;
> +
> +	sleep_cfg: sleep-cfg {
> +		PIN_SLP(gpa0-0, PREV, NONE);
> +		PIN_SLP(gpa0-1, PREV, NONE);
> +		PIN_SLP(gpa0-2, PREV, NONE);
> +		PIN_SLP(gpa0-3, OUT1, NONE);

I would be happy to see some reasoning why certain pins have disabled
pull down (e.g. they are not connected or you use the same configuration
as running one) and why you set them as output.

> +		PIN_SLP(gpa0-4, PREV, NONE);
> +		PIN_SLP(gpa0-5, PREV, NONE);
> +		PIN_SLP(gpa0-6, PREV, NONE);
> +		PIN_SLP(gpa0-7, PREV, NONE);
> +
> +		PIN_SLP(gpa1-0, INPUT, DOWN);
> +		PIN_SLP(gpa1-1, OUT0, NONE);
> +		PIN_SLP(gpa1-2, INPUT, DOWN);
> +		PIN_SLP(gpa1-3, OUT0, NONE);
> +
> +		PIN_SLP(gpb-0, OUT0, NONE);
> +		PIN_SLP(gpb-1, OUT1, NONE);
> +		PIN_SLP(gpb-2, OUT0, NONE);
> +		PIN_SLP(gpb-3, PREV, NONE);
> +		PIN_SLP(gpb-4, INPUT, NONE);
> +		PIN_SLP(gpb-5, PREV, NONE);
> +		PIN_SLP(gpb-6, INPUT, DOWN);
> +		PIN_SLP(gpb-7, OUT0, NONE);
> +
> +		PIN_SLP(gpc0-0, OUT0, NONE);
> +		PIN_SLP(gpc0-1, INPUT, DOWN);
> +		PIN_SLP(gpc0-2, OUT0, NONE);
> +		PIN_SLP(gpc0-3, INPUT, DOWN);
> +		PIN_SLP(gpc0-4, OUT0, NONE);
> +
> +		PIN_SLP(gpc1-0, INPUT, DOWN);
> +		PIN_SLP(gpc1-1, INPUT, DOWN);
> +		PIN_SLP(gpc1-2, INPUT, DOWN);
> +		PIN_SLP(gpc1-3, INPUT, DOWN);
> +		PIN_SLP(gpc1-4, INPUT, DOWN);
> +
> +		PIN_SLP(gpd0-0, INPUT, DOWN);
> +		PIN_SLP(gpd0-1, OUT0, NONE);
> +		PIN_SLP(gpd0-2, INPUT, DOWN);
> +		PIN_SLP(gpd0-3, INPUT, DOWN);
> +
> +		PIN_SLP(gpd1-0, INPUT, NONE);
> +		PIN_SLP(gpd1-1, INPUT, NONE);
> +		PIN_SLP(gpd1-2, INPUT, DOWN);
> +		PIN_SLP(gpd1-3, INPUT, DOWN);
> +		PIN_SLP(gpd1-4, INPUT, DOWN);
> +		PIN_SLP(gpd1-5, INPUT, DOWN);
> +
> +		PIN_SLP(gpe0-0, INPUT, DOWN);
> +		PIN_SLP(gpe0-1, INPUT, DOWN);
> +		PIN_SLP(gpe0-2, INPUT, DOWN);
> +		PIN_SLP(gpe0-3, INPUT, DOWN);
> +		PIN_SLP(gpe0-4, INPUT, DOWN);
> +		PIN_SLP(gpe0-5, INPUT, DOWN);
> +		PIN_SLP(gpe0-6, INPUT, DOWN);
> +		PIN_SLP(gpe0-7, INPUT, DOWN);
> +
> +		PIN_SLP(gpe1-0, INPUT, DOWN);
> +		PIN_SLP(gpe1-1, INPUT, DOWN);
> +		PIN_SLP(gpe1-2, INPUT, DOWN);
> +		PIN_SLP(gpe1-3, OUT0, NONE);
> +		PIN_SLP(gpe1-4, INPUT, DOWN);
> +
> +		PIN_SLP(gpf0-0, OUT0, NONE);
> +		PIN_SLP(gpf0-1, OUT0, NONE);
> +		PIN_SLP(gpf0-2, OUT0, NONE);
> +		PIN_SLP(gpf0-3, OUT0, NONE);
> +		PIN_SLP(gpf0-4, OUT0, NONE);
> +		PIN_SLP(gpf0-5, OUT0, NONE);
> +		PIN_SLP(gpf0-6, OUT0, NONE);
> +		PIN_SLP(gpf0-7, OUT0, NONE);
> +
> +		PIN_SLP(gpf1-0, OUT0, NONE);
> +		PIN_SLP(gpf1-1, OUT0, NONE);
> +		PIN_SLP(gpf1-2, OUT0, NONE);
> +		PIN_SLP(gpf1-3, OUT0, NONE);
> +		PIN_SLP(gpf1-4, OUT0, NONE);
> +		PIN_SLP(gpf1-5, OUT0, NONE);
> +		PIN_SLP(gpf1-6, OUT0, NONE);
> +		PIN_SLP(gpf1-7, OUT0, NONE);
> +
> +		PIN_SLP(gpf2-0, OUT0, NONE);
> +		PIN_SLP(gpf2-1, OUT0, NONE);
> +		PIN_SLP(gpf2-2, OUT0, NONE);
> +		PIN_SLP(gpf2-3, OUT0, NONE);
> +		PIN_SLP(gpf2-4, OUT0, NONE);
> +		PIN_SLP(gpf2-5, OUT0, NONE);
> +		PIN_SLP(gpf2-6, OUT0, NONE);
> +		PIN_SLP(gpf2-7, OUT0, NONE);
> +
> +		PIN_SLP(gpf3-0, OUT0, NONE);
> +		PIN_SLP(gpf3-1, OUT0, NONE);
> +		PIN_SLP(gpf3-2, OUT0, NONE);
> +		PIN_SLP(gpf3-3, OUT0, NONE);
> +		PIN_SLP(gpf3-4, PREV, NONE);
> +		PIN_SLP(gpf3-5, INPUT, DOWN);
> +
> +		PIN_SLP(gpg0-0, INPUT, DOWN);
> +		PIN_SLP(gpg0-1, INPUT, DOWN);
> +		PIN_SLP(gpg0-2, INPUT, NONE);
> +		PIN_SLP(gpg0-3, INPUT, DOWN);
> +		PIN_SLP(gpg0-4, INPUT, DOWN);
> +		PIN_SLP(gpg0-5, INPUT, DOWN);
> +		PIN_SLP(gpg0-6, INPUT, DOWN);
> +
> +		PIN_SLP(gpg1-0, OUT0, NONE);
> +		PIN_SLP(gpg1-1, OUT1, NONE);
> +		PIN_SLP(gpg1-2, PREV, NONE);
> +		PIN_SLP(gpg1-3, OUT1, NONE);
> +		PIN_SLP(gpg1-4, OUT1, NONE);
> +		PIN_SLP(gpg1-5, OUT1, NONE);
> +		PIN_SLP(gpg1-6, OUT1, NONE);
> +
> +		PIN_SLP(gpg2-0, OUT0, NONE);
> +		PIN_SLP(gpg2-1, OUT0, NONE);
> +		PIN_SLP(gpg2-2, INPUT, NONE);
> +		PIN_SLP(gpg2-3, OUT0, NONE);
> +		PIN_SLP(gpg2-4, OUT0, NONE);
> +		PIN_SLP(gpg2-5, OUT0, NONE);
> +		PIN_SLP(gpg2-6, OUT0, NONE);
> +
> +		PIN_SLP(gpg3-0, PREV, UP);
> +		PIN_SLP(gpg3-1, PREV, UP);
> +		PIN_SLP(gpg3-2, INPUT, NONE);
> +		PIN_SLP(gpg3-3, INPUT, DOWN);
> +		PIN_SLP(gpg3-4, OUT0, NONE);
> +		PIN_SLP(gpg3-5, OUT0, NONE);
> +		PIN_SLP(gpg3-6, INPUT, DOWN);
> +
> +		PIN_SLP(gpi-0, PREV, NONE);

No such name. Did you mean gpgi?


> +		PIN_SLP(gpi-1, INPUT, DOWN);
> +		PIN_SLP(gpi-2, PREV, NONE);
> +		PIN_SLP(gpi-3, PREV, NONE);
> +		PIN_SLP(gpi-4, PREV, NONE);
> +		PIN_SLP(gpi-5, INPUT, DOWN);
> +		PIN_SLP(gpi-6, INPUT, DOWN);
> +
> +		PIN_SLP(gpj0-0, INPUT, NONE);
> +		PIN_SLP(gpj0-1, INPUT, NONE);
> +		PIN_SLP(gpj0-2, INPUT, NONE);
> +		PIN_SLP(gpj0-3, INPUT, NONE);
> +		PIN_SLP(gpj0-4, INPUT, NONE);
> +		PIN_SLP(gpj0-5, INPUT, DOWN);
> +		PIN_SLP(gpj0-6, OUT0, NONE);
> +		PIN_SLP(gpj0-7, INPUT, NONE);
> +
> +		PIN_SLP(gpj1-0, OUT1, NONE);
> +		PIN_SLP(gpj1-1, OUT0, NONE);
> +		PIN_SLP(gpj1-2, INPUT, DOWN);
> +		PIN_SLP(gpj1-3, PREV, NONE);
> +		PIN_SLP(gpj1-4, PREV, NONE);
> +		PIN_SLP(gpj1-5, OUT0, NONE);
> +
> +		PIN_SLP(gpj2-0, INPUT, DOWN);
> +		PIN_SLP(gpj2-1, INPUT, DOWN);
> +		PIN_SLP(gpj2-2, OUT0, NONE);
> +		PIN_SLP(gpj2-3, INPUT, DOWN);
> +		PIN_SLP(gpj2-4, INPUT, DOWN);
> +		PIN_SLP(gpj2-5, PREV, NONE);
> +		PIN_SLP(gpj2-6, PREV, NONE);
> +		PIN_SLP(gpj2-7, INPUT, DOWN);
> +
> +		PIN_SLP(gpj3-0, INPUT, NONE);
> +		PIN_SLP(gpj3-1, INPUT, NONE);
> +		PIN_SLP(gpj3-2, OUT0, NONE);
> +		PIN_SLP(gpj3-3, INPUT, DOWN);
> +		PIN_SLP(gpj3-4, INPUT, NONE);
> +		PIN_SLP(gpj3-5, INPUT, NONE);
> +		PIN_SLP(gpj3-6, INPUT, NONE);
> +		PIN_SLP(gpj3-7, INPUT, NONE);
> +
> +		PIN_SLP(gpj4-0, INPUT, NONE);
> +		PIN_SLP(gpj4-1, INPUT, DOWN);
> +		PIN_SLP(gpj4-2, PREV, NONE);
> +		PIN_SLP(gpj4-3, INPUT, NONE);
> +		PIN_SLP(gpj4-4, INPUT, DOWN);
> +
> +		PIN_SLP(mp01-0, OUT1, NONE);
> +		PIN_SLP(mp01-1, OUT0, NONE);
> +		PIN_SLP(mp01-2, INPUT, DOWN);
> +		PIN_SLP(mp01-3, INPUT, DOWN);
> +		PIN_SLP(mp01-4, OUT1, NONE);
> +		PIN_SLP(mp01-5, INPUT, DOWN);
> +		PIN_SLP(mp01-6, INPUT, DOWN);
> +		PIN_SLP(mp01-7, INPUT, DOWN);
> +
> +		PIN_SLP(mp02-0, INPUT, DOWN);
> +		PIN_SLP(mp02-1, INPUT, DOWN);
> +		PIN_SLP(mp02-2, INPUT, NONE);
> +		PIN_SLP(mp02-3, INPUT, DOWN);
> +
> +		PIN_SLP(mp03-0, INPUT, DOWN);
> +		PIN_SLP(mp03-1, INPUT, DOWN);
> +		PIN_SLP(mp03-2, OUT1, NONE);
> +		PIN_SLP(mp03-3, OUT0, NONE);
> +		PIN_SLP(mp03-4, INPUT, NONE);
> +		PIN_SLP(mp03-5, OUT0, NONE);
> +		PIN_SLP(mp03-6, INPUT, DOWN);
> +		PIN_SLP(mp03-7, INPUT, DOWN);
> +
> +		PIN_SLP(mp04-0, INPUT, DOWN);
> +		PIN_SLP(mp04-1, OUT0, NONE);
> +		PIN_SLP(mp04-2, INPUT, DOWN);
> +		PIN_SLP(mp04-3, OUT0, NONE);
> +		PIN_SLP(mp04-4, INPUT, DOWN);
> +		PIN_SLP(mp04-5, INPUT, DOWN);
> +		PIN_SLP(mp04-6, OUT0, NONE);
> +		PIN_SLP(mp04-7, INPUT, DOWN);
> +
> +		PIN_SLP(mp05-0, INPUT, NONE);
> +		PIN_SLP(mp05-1, INPUT, NONE);
> +		PIN_SLP(mp05-2, INPUT, NONE);
> +		PIN_SLP(mp05-3, INPUT, NONE);
> +		PIN_SLP(mp05-4, INPUT, DOWN);
> +		PIN_SLP(mp05-5, OUT0, NONE);
> +		PIN_SLP(mp05-6, INPUT, DOWN);
> +		PIN_SLP(mp05-7, PREV, NONE);
> +
> +		PIN_SLP(mp06-0, INPUT, DOWN);
> +		PIN_SLP(mp06-1, INPUT, DOWN);
> +		PIN_SLP(mp06-2, INPUT, DOWN);
> +		PIN_SLP(mp06-3, INPUT, DOWN);
> +		PIN_SLP(mp06-4, INPUT, DOWN);
> +		PIN_SLP(mp06-5, INPUT, DOWN);
> +		PIN_SLP(mp06-6, INPUT, DOWN);
> +		PIN_SLP(mp06-7, INPUT, DOWN);
> +
> +		PIN_SLP(mp07-0, INPUT, DOWN);
> +		PIN_SLP(mp07-1, INPUT, DOWN);
> +		PIN_SLP(mp07-2, INPUT, DOWN);
> +		PIN_SLP(mp07-3, INPUT, DOWN);
> +		PIN_SLP(mp07-4, INPUT, DOWN);
> +		PIN_SLP(mp07-5, INPUT, DOWN);
> +		PIN_SLP(mp07-6, INPUT, DOWN);
> +		PIN_SLP(mp07-7, INPUT, DOWN);
> +	};

What about gphX?

Best regards,
Krzysztof

> +};
> -- 
> 2.20.1
> 
