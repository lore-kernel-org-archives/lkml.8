Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EADC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 129E820663
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590601632;
	bh=5VxCXvAj6aDukKPijoSypqC4kGrO/DrClTUlm9JSe0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vm3PdxxTWGNJAmasWhlZbqkeAL9ihHgKtUfImFZJukO1JFfswXzWI3UPAEVRqKixF
	 hgeNBl/AFzBDDED/sRwCdNzTin61dC/IKmrG1afjHi208RGmAlltwihgxiQ8tdR7P0
	 dOeYz47+ZPb2Sijp3Qg0mdGDqNq0lu+P49sWIddM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgE0RrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:47:11 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:34138 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE0RrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:47:11 -0400
Received: by mail-il1-f194.google.com with SMTP id v11so7571599ilh.1;
        Wed, 27 May 2020 10:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aqkEwVdA1wt3FjG3A29T2ee9+BnpM4koBMcGVMs69dM=;
        b=tb6yOWoeVuUlnUOEIlGruDehTVzu2E+1QzyVJ0HXpX1/FhAqhwXS/Sx5l8oHMLvrlN
         LNK32qdyIAgMGcCwD3bVaOtezzDoFV45jBaqMB516FrLC+5Wx+RNvQZHfzHtE2X7r9CW
         6Ys83m6i02ogFuhyPWPY+K9LsecOaHaWhT5jTnocE5/OuAL5otIwbv3zl6TDzNN6dC0e
         BXtCL5J3/fLP6iy7ON3CXKIZR2dpP3601yItmpzr8lKF+/Nldq4FzDQc/AIJqwJZvsfy
         +dLYObizwngnMrtdvaDe6qJY/aHAEl0oltgoHiBClnAxqb80dh1HAAgVRsvtXbiriB6Y
         d+4Q==
X-Gm-Message-State: AOAM5329C8uqtj0eUvn7JRXqDdu59+EBUgRTO/vRdCCgCtYTIRbcc3UH
        9aTmdfxeUTTSO7ec6cR+oQ==
X-Google-Smtp-Source: ABdhPJyaTGqh9Yr0+nPqPhbyUoyWDSOLqZBoeTmTM2m4olfJsrzgApWv00Qlz3J4eEGf4QhzNm6IBw==
X-Received: by 2002:a92:cac8:: with SMTP id m8mr7030263ilq.198.1590601629431;
        Wed, 27 May 2020 10:47:09 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r20sm2003649ilk.44.2020.05.27.10.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:47:08 -0700 (PDT)
Received: (nullmailer pid 2441728 invoked by uid 1000);
        Wed, 27 May 2020 17:47:07 -0000
Date:   Wed, 27 May 2020 11:47:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        jdelvare@suse.com, lee.jones@linaro.org, broonie@kernel.org,
        patches@opensource.cirrus.com, sboyd@kernel.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, linux@roeck-us.net
Subject: Re: [PATCH v3 3/5] pinctrl: lochnagar: Move binding over to dtschema
Message-ID: <20200527174707.GA2441590@bogus>
References: <20200512152359.11839-1-ckeepax@opensource.cirrus.com>
 <20200512152359.11839-3-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512152359.11839-3-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 16:23:56 +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v2:
>  - Removed description for gpio-controller
>  - Force pin node to be called pin-settings
>  - Simplify -pins pattern
>  - Add additional blank line
> 
> Thanks,
> Charles
> 
>  .../bindings/pinctrl/cirrus,lochnagar.txt          | 141 ---------------
>  .../bindings/pinctrl/cirrus,lochnagar.yaml         | 190 +++++++++++++++++++++
>  2 files changed, 190 insertions(+), 141 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
> 

Applied, thanks!
