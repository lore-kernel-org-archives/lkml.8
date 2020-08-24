Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D5BC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA3720656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598308334;
	bh=4Yr/wi3AkENLWFJAQSa32KjuiVmHIp5vs3AyvjLxqs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kb7OBLuHMcRpishzXYn3ucS9/UY9Jo8AgOFZy14rM+k/ituH1bapbHssc5zznwl21
	 SW/BKUBs4N/I82LmtbtxeNUi8LJWW41/hdmYU1pSu0WPAQTTzXt0TBbKcUH7My9Ap9
	 am/anKoQ73TJsetpOayCHNHEj0D5Jdi+xfnK4ACg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHXWcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:32:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46416 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXWcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:32:12 -0400
Received: by mail-io1-f66.google.com with SMTP id d18so1141250iop.13;
        Mon, 24 Aug 2020 15:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7GOlv4yP4CAwOVfNjNFni4AU3fJZ+QQ+53L/TEB0AXc=;
        b=XVT7Pj3kvgCp4W5RgKLAk/Nss1llE/TVIdJwAKWh36sXJ2WxsKmBPNqzgq0Z5mjnsp
         L7daoaSM9uiM1S0H8xzzy3s+W9McwAuhNv5oInLMKwyl4FCcge1V94cq4DZt4AIEsQmi
         kXg4q6Yxex0rz/7gVTVrufoM4wn+qvb3Eg+Caj8izdiuCnxl5f7u6zOvk63hsWkIrFU6
         gq88hfYlPqE8y1u9NTCIw1Y+vOqq0jImnWxf2RZOVuBk5ha2bjIAc8qD6kOYGYzjDAjt
         n9pcbzMDo92DNbyygfla7L6nFMchFojV19dZRKZK8EQlVmrORhZwaGHtG7HTANVtX1IU
         n3Yg==
X-Gm-Message-State: AOAM5321RS8MlVyayzsJ9sO/ihf0vpqtA9Xl65OdMaeBLottbuvPeRJP
        s/lT+Fp06ypxj++TCWXZbw==
X-Google-Smtp-Source: ABdhPJxzhnRw08Jdre0AL6bo7DaBmWE+/fpQBJIESCpHF83NqG/EcpDmuVtkbdbNlf83c5aoBf1LWQ==
X-Received: by 2002:a6b:6515:: with SMTP id z21mr6629569iob.71.1598308331437;
        Mon, 24 Aug 2020 15:32:11 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id a9sm7452434iol.9.2020.08.24.15.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 15:32:10 -0700 (PDT)
Received: (nullmailer pid 3439585 invoked by uid 1000);
        Mon, 24 Aug 2020 22:32:07 -0000
Date:   Mon, 24 Aug 2020 16:32:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] ite-it6505 change trigger conditions
Message-ID: <20200824223126.GA3434984@bogus>
References: <1597054312-25538-1-git-send-email-allen.chen@ite.com.tw>
 <1597054312-25538-2-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597054312-25538-2-git-send-email-allen.chen@ite.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 06:11:15PM +0800, allen wrote:
> it6505 changes trigger conditions.

Patches must have a Signed-off-by with a full name.


> ---
>  Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> index 2c50016..bf0e889 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> @@ -73,7 +73,7 @@ examples:
>  
>          dp-bridge@5c {
>              compatible = "ite,it6505";
> -            interrupts = <152 IRQ_TYPE_EDGE_FALLING 152 0>;
> +            interrupts = <152 IRQ_TYPE_LEVEL_LOW 152 0>;

How does this have 2 interrupts which are the same irq number, but 
different flags?

>              reg = <0x5c>;
>              pinctrl-names = "default";
>              pinctrl-0 = <&it6505_pins>;
> -- 
> 1.9.1
> 
