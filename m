Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549EFC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207ED2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595883977;
	bh=yxXkkE7/udko/+wboOBIMBvUEKDxQ5STwaBcFO9W2kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v3fNUQp5UAK8T480HKJQWgh/eSpsBhMBno/WpZazrxtvMa/5dLS7UAwVYOWIAvM/l
	 6RI8yuHe3oNsDc4muLb8CAGJipLl/bgzqpajuERHWz5sY0toOkXUpMqaW/x2UakuTW
	 SK81cLtZ1pAPe5ZVHJY9rZdzp9TfmR0WecXXmZOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgG0VGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:06:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40736 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0VGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:06:15 -0400
Received: by mail-io1-f65.google.com with SMTP id l17so18504502iok.7;
        Mon, 27 Jul 2020 14:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uNJA6hxthLWoViobyjxlj8lWj83PnXb0wbDuaLutL0g=;
        b=fPxyzRBlynkJidQedSj5ed1NNy3iuxi9NfxByVdR5U3Ce4diS6BeB/AI+OG2f5azzB
         +rTkY8oGQ9kU5VmfMQBCPu8CkTud4DoswDFidrL4QpqLfbFghokn75JR3eOHpq5ZBsox
         xnbtQr3CRsoOtbV++sPUOPjAqztRz5QT+/2bZczLXda3ED4pa2SbquWTOX2QFUfSYn+U
         hy6WnTHuZVRgO4yrpIFPK3rPY0DzIKum+WBseR1VMcbTPySHx6wUmDeWb9QdDz3c4Rtk
         h+cyoEWB2fqnDRqTOnbWvZzdsgyi7omu0v7+2xW3c3CDLfaUXGt+Xndcqj99L9496tL4
         uSng==
X-Gm-Message-State: AOAM532sd1QMYkvifB/ulmUrvSwl5igAFqLIM6lLgfD9Wn6r4jIzuWnp
        BFAh62eKgKiqjSm8XrHrbg==
X-Google-Smtp-Source: ABdhPJzzDamUTYXPVSulEAobeeT0K3y18tYf5sifUQBFezxPTGh0WBwGZkAmII2vPYeUhpNHtG2pZA==
X-Received: by 2002:a5d:9a86:: with SMTP id c6mr11888011iom.27.1595883974742;
        Mon, 27 Jul 2020 14:06:14 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l11sm4997492ioh.52.2020.07.27.14.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:06:14 -0700 (PDT)
Received: (nullmailer pid 871469 invoked by uid 1000);
        Mon, 27 Jul 2020 21:06:12 -0000
Date:   Mon, 27 Jul 2020 15:06:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: sound: convert Everest ES8316 binding to
 yaml
Message-ID: <20200727210612.GA871439@bogus>
References: <20200724155933.1040501-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724155933.1040501-1-katsuhiro@katsuster.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 00:59:33 +0900, Katsuhiro Suzuki wrote:
> This patch converts Everest Semiconductor ES8316 low power audio
> CODEC binding to DT schema.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> 
> ---
> 
> Changes in v2:
>   - Change maintainers from Mark to Daniel and me
> ---
>  .../bindings/sound/everest,es8316.txt         | 23 ---------
>  .../bindings/sound/everest,es8316.yaml        | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/everest,es8316.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/everest,es8316.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
