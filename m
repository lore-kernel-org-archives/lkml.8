Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900EDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68729207CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590633305;
	bh=1lIgsT3ymlS/hqSUYPftVc8Iz6I8WCHZhaukJZLfYCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jIa5DNT7NIcKqB7bRz/epBPe1oqIsXZzRBAcncbEvOlkuHMOAaaWCd5YyqVgNNNpW
	 AO3vx5WuBJW6X5GawQKg3fLd42RXHJ6V0AHJjif1AaaUeGvGEZ0sY6Eht00P0Y1k3E
	 kKZt7ciLTDg9NSWomCZ+fSwQ5sQHQYnaMoP82wCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgE1CfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:35:04 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45675 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1CfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:35:04 -0400
Received: by mail-il1-f194.google.com with SMTP id 9so7684845ilg.12;
        Wed, 27 May 2020 19:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+HJbk5g0ST/4Otc39ie7CifyJoFcOzLYgoaQM29oswM=;
        b=AGlbDqso4hJLdiYsFb/0NRKRYlqmC5Dy0N6wO2KdeqAk/DSP9Xc3cUw56ZJsFy4hYy
         yw/WL58tc9E2s92N2B5tAUsR2bOCVq4aDXA4w3b2rn7eXaRNXNezJYU1uqz9Eb3h1+mI
         ZH0TLQx28b0i6cXiOWwVllFrCPpi7j5a0yE6gzfEIIO3KYBQ4o4GHxPnDnEtFnaOmuDx
         iBFJZo589do7Pqm8xuoKqOGhwcnJRFXjbv0XH1DjsZJE75QxsYQO1AWyi1MgMNRa3wIg
         8LWdC3XPcWU8v7Yq/D1EiH2nwgcbTYPD9z2yIQWVAJkDMpJi/nGfDhH/j07zFkdr94Jb
         b2Eg==
X-Gm-Message-State: AOAM531jqfuTnlQ+4nFHvzowJTB53RRqmSrLDwvUsqx9/cSR63ell3mp
        lddSP8rTP1m13d2dMN5Q3Q==
X-Google-Smtp-Source: ABdhPJzzo84mO5duo62U3QW5I2buoA6AGiCvIAH2LuLBgukRzVpqwyRFtBX9F8xpXlcOINhdBlBrbA==
X-Received: by 2002:a92:988a:: with SMTP id a10mr1097868ill.301.1590633303037;
        Wed, 27 May 2020 19:35:03 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i78sm2558342ile.87.2020.05.27.19.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:35:02 -0700 (PDT)
Received: (nullmailer pid 3251507 invoked by uid 1000);
        Thu, 28 May 2020 02:35:01 -0000
Date:   Wed, 27 May 2020 20:35:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, cw00.choi@samsung.com, broonie@kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        myungjoo.ham@samsung.com
Subject: Re: [PATCH v3 6/7] pinctrl: madera: Move binding over to dtschema
Message-ID: <20200528023501.GB3251118@bogus>
References: <20200513095720.8867-1-ckeepax@opensource.cirrus.com>
 <20200513095720.8867-6-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095720.8867-6-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 10:57:19 +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v2:
>  - Remove some more redundant descriptions
>  - Force pinctrl node to be called "pin-settings"
>  - Force suffix on individual config nodes to -pins
> 
> Thanks,
> Charles
> 
>  .../bindings/pinctrl/cirrus,madera-pinctrl.txt     |  99 -----------------
>  .../devicetree/bindings/pinctrl/cirrus,madera.yaml | 122 +++++++++++++++++++++
>  2 files changed, 122 insertions(+), 99 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
> 

Applied, thanks!
