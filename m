Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7316C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B531720CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578952061;
	bh=4bLAkwPUPzdXlAHdorU0yNPmSzIzFNXzZyF9iMgLKIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VSbT50ImOCTAQ/ZFJRpHU/j5gip/12GK8F5Fe5d6pTD/le86UPlZ249laB74I4PFa
	 p3sSPmOxlkVIaeYX6ExDV2ylWE6W1RcZPocMyl1RFDySUjuRvvzW789xOWFXZi0p3W
	 VbNup6iGRB1Drpikru9O6IoDIy+7jKlakznvqUQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgAMVrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:47:40 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39116 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgAMVrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 16:47:40 -0500
Received: by mail-oi1-f194.google.com with SMTP id a67so9829942oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 13:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pxveT8kmVAy+6NNs/m6VYBrLz6raLXBMbZxaVD7AKwA=;
        b=IQvJdPDCCOYBm013GL31PHaWvukIg6QH7iLUM/GRP7TZfnjIY7IJHh20yM0vDPkBax
         Ej4Fg8J+36mXbNcME7vSnfd3fns2lT07nWftlRKqHHidPn8tKkixVJ6NzFhSp2h56LSb
         UeFk54e1pvvIlwwtbrFwbisXJG7QS6YK1Bs7+QyV1fUPCAVE/OL/pTGJ3ZyJ4KoAfdUW
         Ult4fGENSd9Hw/fJYdz47IuNoQAj4yGpAZlt2sloZIht3GcqqtynWYxhZUkPAM/UXVnA
         QUzRa6Js99+E0zDEUw8sSgyNGyAcVad/1KbKAVm4GO+Yi/GSKMHHvtrEDzlMPCtSUDZP
         xIBQ==
X-Gm-Message-State: APjAAAUFTthsByauvOMGAV9gQxQtW7cRx2DhMibTXsNsWAkWf1FwzGXq
        0gSgS1P+D3Bo07pm8+5Jiy3hXrg=
X-Google-Smtp-Source: APXvYqxZC6jBFjKDA1Tl85THJrKxgNRmIv503x8VS6PqrGv/Tp2V0HsF7LHIfHF9bDdHAPKxTlbX0g==
X-Received: by 2002:aca:ac0c:: with SMTP id v12mr13413024oie.123.1578952058676;
        Mon, 13 Jan 2020 13:47:38 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d11sm4582135otl.20.2020.01.13.13.47.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:47:37 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 15:47:36 -0600
Date:   Mon, 13 Jan 2020 15:47:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, vkoul@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, broonie@kernel.org,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        rjones@gateworks.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, aisheng.dong@nxp.com,
        richard.hu@technexion.com, angus@akkea.ca, cosmin.stoica@nxp.com,
        l.stach@pengutronix.de, rabeeh@solid-run.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 7/7] dt-bindings: arm: imx: Add the i.MX8MP EVK board
Message-ID: <20200113214736.GA12301@bogus>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
 <1578893602-14395-7-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578893602-14395-7-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020 13:33:22 +0800, Anson Huang wrote:
> Add board binding for i.MX8MP EVK board.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
