Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71194C2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4C120738
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586020057;
	bh=GVJdlPKE74D0zBgxmHwnhBnH5yHWcuhbsE4qN3hu5vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qXEZmTukX2O2U8fygmiA9kzo+Hmfw7vQERgDkFT6Ep355I0HHvVvDydw4wY8mTTId
	 HWJ7ajEJeIPXM3LjrWoeihvBTHQgV9SXKcKynOccAYZndIwSZmwpNfIcr/HsMc1Zpj
	 6xhRsPJsOkmH+saEDMMRiZp8o7i+/vYlyEmxE29I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgDDRHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:07:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33591 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgDDRHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:07:36 -0400
Received: by mail-io1-f66.google.com with SMTP id o127so11112655iof.0;
        Sat, 04 Apr 2020 10:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fliXeMdHr+M/rYKcSqGUk8u9+7r0oaRLxYIvrYTczFY=;
        b=nXvgRF18gXqfwpBE4QraxxtRCx/DxZFfjg6nskWtzouZTvuM6SMZTyGa+6MhrEFKrw
         0Bv53utl6zyyJ245CbZJk344AOCwXCK16tHEQ5X1e8SVnvVZ8OOdPU9qnCB3/TxYsfmT
         gOFcnD32aGsKebCgb+0obn/ib5mkVmzZ8DQmKskCSXKTaVxkmYslETuRQDKHiHPS4qJs
         mWD1ugK6v6BF9NcUvOSO3t/XUtPbSpGg0yROLmVINgwkdIMgjoxTRW2HjY3eJLX0dzV5
         muAW4bMS/eY+DzW7gRFm3wVd4tOgMBEFQQcqctOfayFxPr2f+oS8uUVBKlKakRNHCyFc
         ggBg==
X-Gm-Message-State: AGi0PuZWDQv0F0IV1GwcQrtU9nf/+c/sCerWyu2VEYtFpmVTFCHN0B8S
        Sub9fLQ4KX9rySRxNPZFMQ==
X-Google-Smtp-Source: APiQypIub4s0Bp1CfLKbsO4dVJKL9eNc+mhnXTzj6jZgRKWyhzgQnbGTfYKmYPMuAzkKAwcC9wYTug==
X-Received: by 2002:a6b:b989:: with SMTP id j131mr12788243iof.6.1586020053378;
        Sat, 04 Apr 2020 10:07:33 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f80sm4157509ild.25.2020.04.04.10.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 10:07:32 -0700 (PDT)
Received: (nullmailer pid 5535 invoked by uid 1000);
        Sat, 04 Apr 2020 17:07:30 -0000
Date:   Sat, 4 Apr 2020 11:07:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        John Crispin <john@phrozen.org>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH v6 2/3] dt-bindings: phy-qcom-ipq4019-usb: add binding
 document
Message-ID: <20200404170730.GA3746@bogus>
References: <20200401163542.83278-1-robert.marko@sartura.hr>
 <20200401163542.83278-2-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401163542.83278-2-robert.marko@sartura.hr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 06:35:43PM +0200, Robert Marko wrote:
> This patch adds the binding documentation for the HS/SS USB PHY found
> inside Qualcom Dakota SoCs.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> ---
> Changes from v5 to v6:
> * Add missing include for reset defines in example
> * Fix warning for missing # in #phy-cells
> 
> Changes from v4 to v5:
> * Replace tabs with whitespaces
> * Add maintainer property
> 
>  .../bindings/phy/qcom-usb-ipq4019-phy.yaml    | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
