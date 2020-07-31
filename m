Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2A5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D91B22B43
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596220042;
	bh=0eqxh09ZP94CYeqLKpIF+pTKJVrdYDpmTViNSv/5i6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l+qVN/zxcQ/DwEqhrDIXUdTuQxspbkCNO3WnNS1LGVs/xVBXJTQMO3JEFuoWBxg6y
	 F3qH9pnsXiB3dOckW2D7Qz+cEkWO3oiPQuN/hsmgOTLcdQVPeOAEWOIKGW2g6aWODY
	 dqf3vkfHNjBrcmDOZsjjVdSerCvnmUFH0G4Y0kFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbgGaS1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:27:20 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36028 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387652AbgGaS1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:27:18 -0400
Received: by mail-il1-f196.google.com with SMTP id z3so15896674ilh.3;
        Fri, 31 Jul 2020 11:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oaGd/EIUlumWQy9Pm41SRzZ2KAZopmVPZLx/MEhynr0=;
        b=kShlmu3FVoVFTJ6GuQ7F/6RxrX/aStKvv30Rv+uUEZK/j9GgpEMx0QDpt+qDr5XfoT
         J3i8ooYMIZoKRF4WuHpUbsRvzV+ykQZGBj0UfOM4htuUZmuPkDP+kaNa0jH4pk4XWJcm
         Ic0rhRARIvf720G5sJ2Jy6l8kx+8nJr8cF1/gQ1lwlUblxRgeLPm5DAGtNAo9wFlpOG5
         80PhGV3KUR1ggz5zu3m2GItf91/it2lP1Voyd2vfISzKFiYMP7KwldRB/FMICt8L0KTp
         RQhaSyX2oM/fj0Xxo6iS4AWDKaQ57EpD0VJA21Bxfp7kbZ4T45E2rxxwVbAYpz2/mKan
         YJbg==
X-Gm-Message-State: AOAM530yCyH4+XyiinCColhJkpJ2o0x0R360rv/CqwZXYwQsN6ur51mZ
        S3s9OB5Vj0EBZI0/B2wjNQ==
X-Google-Smtp-Source: ABdhPJwhIJ+PDeIEqoO3CED9uAsxszMYrDBCUOFn0M8IR4v2vZ7/a/swVVxxCF7eIePjl8Q3S2U52Q==
X-Received: by 2002:a92:660e:: with SMTP id a14mr5080012ilc.262.1596220037143;
        Fri, 31 Jul 2020 11:27:17 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u6sm5014967ilk.13.2020.07.31.11.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 11:27:16 -0700 (PDT)
Received: (nullmailer pid 531811 invoked by uid 1000);
        Fri, 31 Jul 2020 18:27:12 -0000
Date:   Fri, 31 Jul 2020 12:27:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     dgreid@chromium.org, Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, tzungbi@chromium.org,
        dianders@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v3 1/2] ASoC: qcom: dt-bindings: Add sc7180 machine
 bindings
Message-ID: <20200731182712.GA531472@bogus>
References: <20200731084023.2678931-1-cychiang@chromium.org>
 <20200731084023.2678931-2-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731084023.2678931-2-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 16:40:22 +0800, Cheng-Yi Chiang wrote:
> Add devicetree bindings documentation file for sc7180 sound card.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  .../bindings/sound/qcom,sc7180.yaml           | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/sound/qcom,sc7180.example.dts:32.24-41.15: Warning (unit_address_vs_reg): /example-0/sound/dai-link@0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/sound/qcom,sc7180.example.dts:43.24-52.15: Warning (unit_address_vs_reg): /example-0/sound/dai-link@1: node has a unit name, but no reg or ranges property


See https://patchwork.ozlabs.org/patch/1339316

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

