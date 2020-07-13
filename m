Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B645C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 057F42075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594654376;
	bh=KMIxXHhJSiZOt+YONyXAp0P4mS2E+tKeUFxTgk+27xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HKalQ6teNXaQRU6A9QNfrUWr9Ema5r6r/D79B8s83/+vmT8aswdSbpsgOSCdzs/0c
	 EkD8xcQlsCcX2iEQgW8sIq5SMMgmauI5Qngxq0piv+MJEMKzehVWdL7tmiCiCB6oeN
	 +H7JBfUe/JZk8hsC7IYgwANhq/CYo+A0JQ9ZoxF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgGMPcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:32:55 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45578 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbgGMPcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:32:54 -0400
Received: by mail-il1-f194.google.com with SMTP id o3so11494916ilo.12;
        Mon, 13 Jul 2020 08:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D1tx9I3fZDjlF0pxo8uh6cSHEqys5YBQnDDIQmH6Gw8=;
        b=aWQXgk+a+3hMUX6tClqQXyCZEoibqPW9ETtNkBR1CjbCNI4dgwf0H7WmC86JM35los
         3nbOVcW3Gm3TEeeUSesOh/V/H97EKccv/DJuwm1P1YbXPhM9QLSiQ4ljxVjqmd5E49AC
         Fya3r9PA7c3wjVSfl8+URViqaGQBxd8Gs065rg6mxq0fA7KbK7npCx5xLbqjgDs8QWzS
         qopDDwPqhf4y+6e+iUDP0LXel9sH5RYR+kPUxmUy4zgHxIxcjnDznhLv7jrc4KmRpAQx
         WA2sp4oXAkq2chmIqMCY/3xJ2FvW24ZVpx32QtjU4ohJAkWo17A6UzlA4szx8tdJtiOI
         xzDQ==
X-Gm-Message-State: AOAM5313youHmHf9UlkC7ImkNuk24/2MYJC5Gn5JKqiAPrX7zyhj0bdd
        NYqyLJEAR17wwExaZs8eemZGe0xvDg==
X-Google-Smtp-Source: ABdhPJxKTHA7bNx4G/OWSSgNsTP8b05VDOnDOIJQcqflQPpRVeP2ky7Ls2heOxKe88WifuGN+VIkRQ==
X-Received: by 2002:a92:40d1:: with SMTP id d78mr266816ill.14.1594654373965;
        Mon, 13 Jul 2020 08:32:53 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w10sm8450823ilo.10.2020.07.13.08.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 08:32:53 -0700 (PDT)
Received: (nullmailer pid 238882 invoked by uid 1000);
        Mon, 13 Jul 2020 15:32:52 -0000
Date:   Mon, 13 Jul 2020 09:32:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>, od@zcrc.me,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] dt-bindings: pinctrl: Convert
 ingenic,pinctrl.txt to YAML
Message-ID: <20200713153252.GA234029@bogus>
References: <20200622113740.46450-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622113740.46450-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 01:37:40PM +0200, Paul Cercueil wrote:
> Convert the ingenic,pinctrl.txt doc file to ingenic,pinctrl.yaml.
> 
> In the process, some compatible strings now require a fallback, as the
> corresponding SoCs are pin-compatible with their fallback variant.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: - Use 'pinctrl' instead of 'pin-controller' as the node name
>         - remove 'additionalProperties: false' since we will have pin conf nodes

What do those look like? They need to be described, but that can be a 
follow-up. 

Rob
