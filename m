Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE414C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A540620866
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy7jjy9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgHPTXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 15:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHPTXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 15:23:41 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9181AC061786;
        Sun, 16 Aug 2020 12:23:40 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t15so10597542edq.13;
        Sun, 16 Aug 2020 12:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OI2ilMyT/T1bEBIiLjqqyPUgBfPn1XCfDm/gphRm5kg=;
        b=Wy7jjy9Gv9ZxM3v3dIC72o7hwek0w6VthWQA6+9Rhgr0UP6FbU6fRqt+unlz20F1Nl
         ntLm4n3zhGJiyeQUS3OwrfN1eE5QJc/oJibwlek9/ZJrbfCv3rS7C1TyWoAC68wixtV+
         2mO+VM2PXpe6Kx/PTnqvaw+Pi88NIAaopHQyUJQddN7fpxtPJyRUdOewpr1I8CTJXMX9
         2Uj4Y3RpPkGK9QLSSTdWxSEGxqeW1Q95YbYYb1grTJG5NHI2253mPW5qIt+8jCrb+20V
         vVp+/XNv+AfhZYgzTP+7yu2X6476i5Fj1qbCdA+FtmONj2OllsNzBIyaW9fzeSuQdt7I
         lVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OI2ilMyT/T1bEBIiLjqqyPUgBfPn1XCfDm/gphRm5kg=;
        b=pDu/jf5+Scd6//TuLq8QgC5v6qhjz0NwNEnvLPfp3A7Nijl8G0/yVXZIAr4jS1on2G
         V2eRnmyGMp6f70XoBc8klv17WKivLpHesTAk+ixD9FyIp7pi2HTiWhoDaMSFnnjUE2uZ
         RC6yWNd1kZ2rUoAKddqKQYxRrft2yESfbKKjhnIXrfpxdNHgp+3hBKCmh4kxkfUZWD3W
         CD1aVnq+8uaHl1KS2JJ/jvgd572zspfIaAv/spCGbf653ZNt2M++JbS3TorR+62VGVgx
         7K2Wj02kT8zs4O6B4ZtIu13/+UIfki+mt+TEzDgBwFvUIUEJmhwIfe755Nj7sdwvPKrZ
         Ze7A==
X-Gm-Message-State: AOAM531iUV/ZmQrdQRZp+n4JRHV/uEqn4NH1tWvghPZhbWtJ942dSQiS
        HD8u20o+NEC8lSH+bmNfx7g=
X-Google-Smtp-Source: ABdhPJxKWoES0hitdZBraV7D3zk3EQ6vqSWM5VgAcaUp0prurr7PKW8o5uA2fGbnR0sfGdHRProVYw==
X-Received: by 2002:a05:6402:7d5:: with SMTP id u21mr12493663edy.341.1597605819001;
        Sun, 16 Aug 2020 12:23:39 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id dr21sm13649255ejc.112.2020.08.16.12.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2020 12:23:38 -0700 (PDT)
Subject: Re: [PATCH 1/3] usb: dwc3: of-simple: Add compatible for rk3328
To:     Cameron Nemo <cnemo@tutanota.com>,
        Devicetree <devicetree@vger.kernel.org>,
        Linux Arm Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Rockchip <linux-rockchip@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     robh+dt@kernel.org, Heiko <heiko@sntech.de>, balbi@kernel.org,
        gregkh@linuxfoundation.org
References: <MEsGWB_--3-2@tutanota.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <4482f04a-d75d-6ede-acae-eb3fc7364130@gmail.com>
Date:   Sun, 16 Aug 2020 21:23:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <MEsGWB_--3-2@tutanota.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cameron,

Use plain text mode for patches.

Before you introduce a new compatible string, your patch serie must
change the documents first in version 2.
See:

dwc3.txt
rockchip,dwc3.txt

(TODO but not now) Both documents are in need for a conversion to yaml.

Also sort nodes without reg alphabetically in rk3328-rock64.dts.

&u2phy {}
&uart2 {}
&usb20_otg {}
&usbdrd3 {}
&usbdrd_dwc3 {}
&usb_host0_ehci {}
&usb_host0_ohci {}

On 8/16/20 7:16 PM, Cameron Nemo wrote:
> Add a compatible to be hooked into by the Rockchip rk3328 device tree.
> 
> The rk3399 compatible cannot be reused because the rk3328 SoCs may
> require a specialized driver in the future, and old device trees must
> remain commpatible with newer kernels.
> 
> Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
> ---
> drivers/usb/dwc3/dwc3-of-simple.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> index 7df115012935..54f38e434028 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -49,7 +49,8 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
> * Some controllers need to toggle the usb3-otg reset before trying to
> * initialize the PHY, otherwise the PHY times out.
> */
> -	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))

> +	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3") ||
> +	    of_device_is_compatible(np, "rockchip,rk3328-dwc3"))

sort alphabetically.

> simple->need_reset = true;
> 
> simple->resets = of_reset_control_array_get(np, false, true,
> @@ -171,6 +172,7 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
> };
> 
> static const struct of_device_id of_dwc3_simple_match[] = {
> +	{ .compatible = "rockchip,rk3328-dwc3" },
> { .compatible = "rockchip,rk3399-dwc3" },
> { .compatible = "xlnx,zynqmp-dwc3" },
> { .compatible = "cavium,octeon-7130-usb-uctl" },
> --
> 2.28.0
> 
> 
> 

