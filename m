Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20F6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DB021744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596219614;
	bh=MMimNrtOYqKqibATfJa6jO1nG6aIx4hrl7GwCpQdRas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ly8jezh86w23SVJRIyfORjGLiJNxwiLKuXUux7dO42fjRSLS3QWfmNr11pO3rRlvW
	 sgLKI4dGK8TxpgGKb/rlLVlR6RQ8Oe3gHSgkVYOAhwx6wQwVlerfKT74QpJQWB+JbF
	 ycrdTY7Ggyj1WwtUWedJAreFC9p1Z9ISHtvnhG0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbgGaSUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:20:14 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45735 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbgGaSUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:20:13 -0400
Received: by mail-il1-f196.google.com with SMTP id f68so4219496ilh.12;
        Fri, 31 Jul 2020 11:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yFfu3F+vbrc8SiAkq2yn5UuF04SFvlMO0yhutjm3ZV8=;
        b=O5niCAASGyfwrQ1ZspPFqOHqIs+kdnI7HaPsx8gCiodjqSlenLRK3T4DuioGk6klHw
         VTyokP4Ngwa/i0rdY17BLlpEkWGzlITW0PJDHIv3/rGCbR5CNLqCogPJInZtCzsRfmFQ
         zOh5Mno3yU2kvmHDpdPMkdQPg/hcBZEKX75NPRl7u2Yq5mL9Z5ln+NEBFiUPq0BglnxZ
         WUVSk1LZX+X/vPI+yYPXAuYHDYFSHqiVjLVfvuUJkr+PrGssW0ny1ma2xXWVlj1T4ELk
         aM9cZvOuZiiEdA9eDm8YY1I1XSYrrPQBGCz2m97p3CTI1zGtcilOgsZikD1UShATNerm
         pUhw==
X-Gm-Message-State: AOAM533rm4YQC64E94MINynLhy8QmhlAf3gtVqP65/tSqtESADQDDLTl
        rYGWemFE/+TK/3Vimoo4Xg==
X-Google-Smtp-Source: ABdhPJzsDsQfz5c08h7mARWBIkKqw/C7dbApEepczZpEhotj2Qs0fLmikCGoRDqtCZq3ebnbDHUorg==
X-Received: by 2002:a92:60d:: with SMTP id x13mr4786610ilg.214.1596219612363;
        Fri, 31 Jul 2020 11:20:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y80sm5277766ilk.82.2020.07.31.11.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 11:20:11 -0700 (PDT)
Received: (nullmailer pid 520384 invoked by uid 1000);
        Fri, 31 Jul 2020 18:20:09 -0000
Date:   Fri, 31 Jul 2020 12:20:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Fugang Duan <fugang.duan@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 10/17] Documentation: bindings: clk: Add bindings for
 i.MX BLK_CTRL
Message-ID: <20200731182009.GA520030@bogus>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
 <1596024483-21482-11-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596024483-21482-11-git-send-email-abel.vesa@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 15:07:56 +0300, Abel Vesa wrote:
> Document the i.MX BLK_CTRL with its devicetree properties.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../bindings/clock/fsl,imx-blk-ctrl.yaml           | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.example.dts:19.23-24 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:315: recipe for target 'Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1338304

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

