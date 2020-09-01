Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E698C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EAFF206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbS++nkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgIAH3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAH3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:29:51 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DECCC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 00:29:51 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d11so177019ejt.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 00:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7DysICoorfZUUUIF+WpJaAVpr1xSSxTvFAEY3lBDX5U=;
        b=hbS++nkxV7r4hrc5mADMRlI0aoeJGkpoGtGhsbvCJETmC5+uwfdTl3r8Qv2FTRx9DE
         Cp+6c/529ATrN3XZmbNP7HzIaqWETtMBLIjBb3yxLRGqMdDnKQfTjoAzCRHw8nq4rZO0
         8micol+BGeCoIuVKZ5mjc78MAnf6rpxLnzUGIMDkI2nS6bR+NMArVPJlDkNuEC2Vv+vB
         Heqj3PyH1Npfv+6l0NhkThlcrIlw+ZM7BaEKvlsMUM5kQLOvid//fGoUk1FESUGOz3DR
         Jt83fD0F3yCpb/x11mFuDZoUQundFTQ5xlYdQsXfEjV8Dc1EMngImDA3axkMA7zQJ97B
         Y33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7DysICoorfZUUUIF+WpJaAVpr1xSSxTvFAEY3lBDX5U=;
        b=pYghMMMOIQ98R6UtssUIy89YTZSyzwl3rr5ECGz4ui1pXU/xUgBH1JtSbS6qbtcRqu
         +z/2ym7TfDKHEmEde5SeP3uD3TFbDIx3LnDnKOynGyf3Z47Hd7lvXzoPN00CPXkWsPhB
         0pt+OTmL24vtcfKNJ9fJHzgmF/pJ7y5qAiOSW68MV4G0VGXcEJweJzgv33WJShSp0LwL
         Eww+h6RrAqosa8/uN36kHFoO/KdMmCL57ILA3fqFaeqXkmWCBPkx4PdN2nGV6l+hAzYY
         UBOk+1Hc52rbxdyvCjWSW/+ZsRxuT+ewn03LcMEFdwWTvFECojrk+EF+2KOUDVDLFqHV
         dT1g==
X-Gm-Message-State: AOAM530CYz5lmtl4FbfIzmyGE77+es9c6TwQsFRgTZmFkf8iAj29F332
        vSZkbAdhTmv+UD2F00O19Fvgnq98ltioUg==
X-Google-Smtp-Source: ABdhPJzcEvNnP11aPaOGDAzf9tv6YNP8kpZaQNGAOH/ks5gp7+aVtUsoe1pCyEiwyiD3WLsrno1MlQ==
X-Received: by 2002:a17:906:f1cf:: with SMTP id gx15mr308395ejb.241.1598945389872;
        Tue, 01 Sep 2020 00:29:49 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:cd1b:84f5:8ffb:1aa3? (p200300ea8f235700cd1b84f58ffb1aa3.dip0.t-ipconnect.de. [2003:ea:8f23:5700:cd1b:84f5:8ffb:1aa3])
        by smtp.googlemail.com with ESMTPSA id g5sm430031ejk.52.2020.09.01.00.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 00:29:49 -0700 (PDT)
Subject: Re: [PATCH] drivers: reduce the param length of the line
To:     Tong Chen <tongchen@whu.edu.cn>
Cc:     nic_swsd@realtek.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
References: <20200901022811.8675-1-tongchen@whu.edu.cn>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <2552dde8-7d2a-03f9-79cc-07dd506d8b41@gmail.com>
Date:   Tue, 1 Sep 2020 09:29:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901022811.8675-1-tongchen@whu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.2020 04:28, Tong Chen wrote:
> Reduce the param length of the line from 79 chars to 52 chars,
> which complies with kernel preferences.

Apart from formal issues with the patch (missing net/net-next
annotation, wrong prefix): Did you get a checkpatch warning?
Or what's the source of your assumed kernel preference?

> Signed-off-by: Tong Chen <tongchen@whu.edu.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_phy_config.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
> index 913d030d73eb..f4b738cf8ad7 100644
> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
> @@ -1302,7 +1302,8 @@ static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
>  	rtl8125b_config_eee_phy(phydev);
>  }
>  
> -void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
> +void r8169_hw_phy_config(struct rtl8169_private *tp,
> +			 struct phy_device *phydev,
>  			 enum mac_version ver)
>  {
>  	static const rtl_phy_cfg_fct phy_configs[] = {
> 

