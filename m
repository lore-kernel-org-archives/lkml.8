Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3A5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63FAB22B40
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596492848;
	bh=YfJIEaY8Ug2uDEyGRd3itmgtlYwhVCYKqav6mAcchhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KTxUu4zNxQ4N6dvBm+5NSMMGPKLmuWoda+dSdxTvOQYrV9MY1l07hd9vHAwWp69uT
	 RVcU+nY18vSFF0wTSa0zCxsSaGOiHSVOV0S3l1+Wu9Aj041TUlaVhn2vmG0EJ0pIv2
	 xhdcuZ/jUL+3K30VTLIGly9w0MtFiZP0PunKa/Z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgHCWOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:14:07 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37179 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgHCWOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:14:07 -0400
Received: by mail-io1-f66.google.com with SMTP id w12so26573780iom.4;
        Mon, 03 Aug 2020 15:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gQc8TDHPO1L4jx6dYg2XXah3+mAXU/VRekRjI0UZ6XQ=;
        b=Zgn2RuHiS/nLLHiXorb43sFhBLVZ9aUz7w/mUbitz4FoJWS5eRERovJEcrsKXoKU5W
         95CJ+ObFxg2Y33im4zaTCJSmEX0RtE/kys4cIjCBwaPmIFkkyqdpoUhRwzyBS65xTyex
         +oD4zhQfMUnlXOcEt2umfMwB75AQldicq79f/1BAdNeqOBj1oHNaSMdyREBqQZrHNgdV
         FJbpZIhqubC5YH5FwjgXdAXG0Iee8PovFtokEFI+HZr0vuvP0y6cl8fX0mq8NZ+SuuVc
         I6RGb35wHftmhuVBiXvFcYNH2/sHHoaMFpVUgYDL6i++uObKCDiK75/Ao3YG1JF+coag
         rfHA==
X-Gm-Message-State: AOAM530kMjRFgaRtIQBsVuZBWLrDAYoyjy47h7SICHSpCd0MG+z3QNGV
        4ZaqOb/eGpfH31XV8acwIKBK8uV6wg==
X-Google-Smtp-Source: ABdhPJzpznUql9H7bhkLuBBuKVKgrvW8AdA65dU8mJLpwunqwvF1TSdIIz1drDEhsQZn4padD3jvUA==
X-Received: by 2002:a02:6d5d:: with SMTP id e29mr2054986jaf.139.1596492846294;
        Mon, 03 Aug 2020 15:14:06 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k7sm3651363ilq.36.2020.08.03.15.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 15:14:05 -0700 (PDT)
Received: (nullmailer pid 3231948 invoked by uid 1000);
        Mon, 03 Aug 2020 22:14:03 -0000
Date:   Mon, 3 Aug 2020 16:14:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     broonie@kernel.org, yibin.gong@nxp.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Linux-imx@nxp.com, robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: regulator: Convert pfuze100 to json-schema
Message-ID: <20200803221403.GA3231880@bogus>
References: <1596421439-19591-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596421439-19591-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Aug 2020 10:23:59 +0800, Anson Huang wrote:
> Convert the pfuze100 regulator binding to DT schema format using
> json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/regulator/pfuze100.txt     | 394 ---------------------
>  .../devicetree/bindings/regulator/pfuze100.yaml    | 186 ++++++++++
>  2 files changed, 186 insertions(+), 394 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/pfuze100.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/pfuze100.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
