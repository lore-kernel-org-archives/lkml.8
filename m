Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23880C47255
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB8CD206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589249054;
	bh=7YBaUlSQ2mAFg2CL1OKbYZ73v7Yk9V0neuGRBcix9us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1zdlsotacRYygHZsQE/VSx2abEQJKe8pGtTEqHVj/MIsm27EFar2WT6aiu9YTHTZl
	 tAZFww47Uqt1oKWMSqPLjeBRQBPopDGMXp+mZ94cpTVKni+dmD4qlS3J9Rp7yw1N6N
	 RggN3K8SfBLCLp+cnSTFF9dFoRz0Y/zneSxMF0+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgELCEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 22:04:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36829 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgELCEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:04:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id t3so9290864otp.3;
        Mon, 11 May 2020 19:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mEwM+2uX3fa1aRUqepH4yi3FVz4o6k87xu3sEDscF+k=;
        b=l3662VNp4zCUvwEUNxGdb4DNukh72iRrjMzfTdyFYDBV2tmLl1ydqlz9o7E6lgseA4
         by0KFTalW2vd3iMycwmRzWuA8MHau0H2JxMNVp+JtfYNcxf85puhreO7WLqI16b64VYt
         DkezG6pfN2WLzMkQNqJGy46hNygbGVulaRLMn8rtSupTxXvKzlzLFzv26bQz1Rx4az9V
         wo3/dCwHIgqy0pyfE5hCap2Ct/WNDSWa/y5+toEU9YZJDTfVp7qaS401fiactdbk89zD
         C53ZPjXLasOzBVJxXOxht93m1ZV7S50vnzRr6SRgeFGuYVWgj5K88goPm6fpFgplTXrV
         6IkQ==
X-Gm-Message-State: AGi0PuZtJ9Ei0O2Q66p+tsWQS8/M36z18aRg1/lFRgXJWiv8PecKWJnN
        GZv5W2VHw8d7GuFCBs/dlw==
X-Google-Smtp-Source: APiQypLlnpOh6fBGkDv/pYSFX86wYZ0uIGXViDNOoB6reFNK7XbZ1KD8v3HlCd7AUUrCyj+vvJs2TQ==
X-Received: by 2002:a9d:4794:: with SMTP id b20mr15415762otf.40.1589249051881;
        Mon, 11 May 2020 19:04:11 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v207sm5046244oie.3.2020.05.11.19.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 19:04:11 -0700 (PDT)
Received: (nullmailer pid 30803 invoked by uid 1000);
        Tue, 12 May 2020 02:04:10 -0000
Date:   Mon, 11 May 2020 21:04:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 3/3] dt-bindings: phy: Convert UniPhier USB3-PHY
 conroller to json-schema
Message-ID: <20200512020410.GA30758@bogus>
References: <1588055690-13200-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1588055690-13200-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588055690-13200-3-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 15:34:50 +0900, Kunihiko Hayashi wrote:
> Convert the UniPhier USB3-PHY controller for SS/HS to DT schema format.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../phy/socionext,uniphier-usb3hs-phy.yaml         | 104 +++++++++++++++++++++
>  .../phy/socionext,uniphier-usb3ss-phy.yaml         |  97 +++++++++++++++++++
>  .../bindings/phy/uniphier-usb3-hsphy.txt           |  69 --------------
>  .../bindings/phy/uniphier-usb3-ssphy.txt           |  58 ------------
>  4 files changed, 201 insertions(+), 127 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
>  create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
>  delete mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt
> 

Applied, thanks!
