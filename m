Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B677C352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AD6217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580922210;
	bh=gEvy1hMNe3TSgP4o9uJ0oduLLzcHA2zBxfSPWN8InRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AiqTgVKxegWygMWoFt5ROQRGzn+5yJXi/dwVW1NZIplCsjE94cWnM17qQd7qFicQQ
	 UpjafZXLSAlvht3cc15EY2YmQKs9JNlGkqXtCYSwqZVU7lTQeoalnwxG2HJeGD12R2
	 qs+WAyJgVeUc4kvsyu/P23b0BMo2BL84p6RKOaR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBERD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:03:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50956 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgBERD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:03:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so3300457wmb.0;
        Wed, 05 Feb 2020 09:03:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fRIQiMPnzfOfDPSTsa46DUjk5WLP3W3ziTqGF6fOQ3o=;
        b=S5J9k33glQ5y83L8pkaqZh/vyykT77Y26BHIvrbuwm0jPJYKvdtIKwzss/Jebcv57n
         f1HwhAIqxK6rv/iaCTW8dNpcbK1yTOWWfjPC2nXrKHKRF7hgrWD3QiZXMn8l7JqOJcv5
         1nkbmNo8Zr+A/YK8n8f4xc3Jg3b9MMxQViNd/TS0hIzlJ/szAuFb1bTqoOPl1afMbuHM
         zTiKOLBNx3rE/4KXNrFs8fnAEwtVle3qvNBktflDkMtpFPmQVXkO9CQMcpoxonKPSaLm
         F2GPyWSTTAIt/bgaPhhCBUwgR4/kDgjP9Ev3Rqfn0+EEfGiXdoU4QZEKhDS9HA6Ria8y
         F1Cw==
X-Gm-Message-State: APjAAAVsp7/vOHPZFutAgW5xlOLFvGUeoTZVsbSKpeVbJK6pHUUHEzFe
        u9URDWO1dm6ZyE49Id9tvw==
X-Google-Smtp-Source: APXvYqzv/UDVHl5gkQROxHuLAIfZru2WQcfHUc076e5lTJSilhpuQmDeQl259nyCa8fC1tWGkA83Uw==
X-Received: by 2002:a1c:688a:: with SMTP id d132mr7176382wmc.189.1580922207661;
        Wed, 05 Feb 2020 09:03:27 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id i204sm189506wma.44.2020.02.05.09.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 09:03:27 -0800 (PST)
Received: (nullmailer pid 19258 invoked by uid 1000);
        Wed, 05 Feb 2020 17:03:25 -0000
Date:   Wed, 5 Feb 2020 17:03:25 +0000
From:   Rob Herring <robh@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, kernel@collabora.com, dafna3@gmail.com
Subject: Re: [PATCH] dt-bindings: convert google,cros-ec-pwm.txt to yaml
 format
Message-ID: <20200205170325.GA19200@bogus>
References: <20200127103441.4618-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127103441.4618-1-dafna.hirschfeld@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020 11:34:41 +0100, Dafna Hirschfeld wrote:
> Convert the binding file google,cros-ec-pwm.txt to yaml format.
> 
> This was tested and verified on ARM64 with:
> 
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
>  .../bindings/pwm/google,cros-ec-pwm.txt       | 23 -----------
>  .../bindings/pwm/google,cros-ec-pwm.yaml      | 40 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
