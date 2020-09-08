Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B07C2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562F92080C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599601817;
	bh=P/WNSzEYsVzsqxadhnsOZzSm3CVxvDpCaSSae7XwOqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gyU+7lpAleSvr0XaZ+4pLQzpEX7z6zOrEMRIUu3ICps1S6ycdF5f9RSe7EMuqa7az
	 2kK3oy0/NvtKtPlZVfsbdLXc3eHXgB8YM+zSuPYA8W4HA/8JU0muAWZcpYp/YsCQoL
	 PiHLcvBNNGzF0v0SDf7XXattumMm9sETidJ270eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgIHVuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:50:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40073 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgIHVuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 17:50:15 -0400
Received: by mail-io1-f67.google.com with SMTP id j2so989088ioj.7;
        Tue, 08 Sep 2020 14:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=shpHGPudo4d9G1LgLy9sXEgqpkCmEAyFPt2SZvRURXs=;
        b=LxviYg8TKl+cU91O+ZJmOBYUV78j+peU7+67PpFEboyfc3T1Cb3B/2f4dleX2pfZD0
         bYJJf5BIhpzO/+FnyJYGV2CsKZ4amN0OoZqBd0D8FYilUr73vHfb5eGbCk74/KcQeJLr
         TkFaYo0ifwCy7ZOBhVxCLICOq+ZuuVPsVvQ7hza8j3F/71wJFC1IW9nNnAF2osAsw8yL
         HchmW6pTKpmJfpOEO91jdyzndhUOaELIKRizN8Ap8WuUtP+izlujgWHHWTusjH8zV5GS
         TrW6QSi4CqS06gKVrxvmhyfQRucPkaLhqIvz17NZ0Ufl7jiVfFqYXxCy18fVsE8OdGCK
         GqlA==
X-Gm-Message-State: AOAM5338Z2DjI0IGkcmwEvMls4RecPWio1LbW5xvyDJkndmKUAcpjIbf
        mvA6GkOYjn5TMILsX+a3NQ==
X-Google-Smtp-Source: ABdhPJztHbGunEEtcZCeK7/v7wNaCgAwGb2KmWS/rtPe0EOYJTJDR8/udRm2/SaK7gqlUOOmvddWSQ==
X-Received: by 2002:a6b:5a0d:: with SMTP id o13mr877903iob.186.1599601814235;
        Tue, 08 Sep 2020 14:50:14 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l2sm257270ilk.19.2020.09.08.14.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 14:50:13 -0700 (PDT)
Received: (nullmailer pid 989673 invoked by uid 1000);
        Tue, 08 Sep 2020 21:50:11 -0000
Date:   Tue, 8 Sep 2020 15:50:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, od@zcrc.me,
        Noralf Tronnes <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/6] dt-bindings: display: Document NewVision NV3052C
 DT node
Message-ID: <20200908215011.GA989643@bogus>
References: <20200822163250.63664-1-paul@crapouillou.net>
 <20200822163250.63664-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822163250.63664-2-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Aug 2020 18:32:45 +0200, Paul Cercueil wrote:
> Add documentation for the Device Tree node for LCD panels based on the
> NewVision NV3052C controller.
> 
> v2: - Support backlight property
>     - Add *-supply properties for the 5 different power supplies.
>       Either they must all be present, or 'power-supply' must be
>       present.
>     - Reword description to avoid confusion about 'driver'
>     - Use 4-space indent in example
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../display/panel/newvision,nv3052c.yaml      | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/newvision,nv3052c.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
