Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16A6C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788AD20775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588023213;
	bh=jQGfdOOR0x2hadI+LwY3LK9pxGyQ+lqOTwryW7RLnwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TuwcXpBEIlJIaXJLX+TWMRFl6JPpODKdbHr/ztvTS8Kl8/9K0wsfpq1L6z54XqMTh
	 8prVMp2t0usqVCZt8i9RD2kaKiOuvfhk0BmbWmoFJe8aPw/va29R925Q6lHG0GA3P/
	 mu475CdfVhHkSxewSZUAcHTJQrcmlImnzoZhc5ZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgD0Vdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:33:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33292 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgD0Vdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:33:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id j26so28979011ots.0;
        Mon, 27 Apr 2020 14:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=obA990z8OJleBnpKtdw+eeF7m9Ujcg/6PH3LdKUCACk=;
        b=XsBW0h3r6qwCC+BbYS1nt3qBaOzbFr433P5vTx/1/KnBTd3Pu1Dyl36QBU434eOnMH
         OrIaQ5FgNFBERu6um0SKbKjKCOffhbgrnB2mLCc83mCuochZT8Gnmceu7C1ZahVszXt4
         fVp9blfcC6xOIjTcPxWC9uGgBCbvtfCr2aVY2RYL/T/ut/7FgQPHUycqSpLLfNfO+qMw
         3gcHoOxfJrNumjRwLu52LzxTpM7Yq4jIQsR48OBKTowYTIZEYqrXUbh7dlYLDnKx4SQ1
         Mdq7UMdbtcRrnrj5QZWEa7iJLPbiySSFU8DOX5BfyKEUMM4zCGGZHJs8Tjvb6odWR614
         ZGPg==
X-Gm-Message-State: AGi0PuYIdYlzy1WLnwzB2X3Oi0LGjQL5Crp0Fb8cD6OdYbLuVht1H1ym
        Dyht/UbfYV2zgbHNypA4gw==
X-Google-Smtp-Source: APiQypKzJKtr9ww00Gp25Z/3kTPkp/Xy6KxA4pc69SBeGjzz5+ZOtZDiTRA3EvrAU8JA4MmlxGOexw==
X-Received: by 2002:a05:6830:2317:: with SMTP id u23mr21214818ote.203.1588023211391;
        Mon, 27 Apr 2020 14:33:31 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d18sm4364822otk.63.2020.04.27.14.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 14:33:30 -0700 (PDT)
Received: (nullmailer pid 1330 invoked by uid 1000);
        Mon, 27 Apr 2020 21:33:29 -0000
Date:   Mon, 27 Apr 2020 16:33:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Vivek Unune <npcomplete13@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/db9000: Add bindings documentation for LCD
 controller
Message-ID: <20200427213329.GA651@bogus>
References: <1587975709-2092-1-git-send-email-gareth.williams.jx@renesas.com>
 <1587975709-2092-3-git-send-email-gareth.williams.jx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587975709-2092-3-git-send-email-gareth.williams.jx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 09:21:48 +0100, Gareth Williams wrote:
> Add the DT bindings information for the Digital Blocks DB9000 LCD
> controller. Also include documentation for the Renesas RZN1 specific
> compatible string.
> 
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> ---
>  .../devicetree/bindings/display/db9000,du.yaml     | 87 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml       |  2 +
>  2 files changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/db9000,du.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/db9000,du.example.dts:28.35-30.15: Warning (unit_address_vs_reg): /example-0/drm@53004000/port/endpoint@0: node has a unit name, but no reg or ranges property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/db9000,du.example.dt.yaml: drm@53004000: clock-names:0: 'lcd_eclk' was expected

See https://patchwork.ozlabs.org/patch/1277401

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
