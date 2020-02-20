Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F17C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8852B208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nOW1dJSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgBTTd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:33:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54533 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgBTTd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:33:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id n3so3269678wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 11:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=E5S9aNFqrzMweT/fLedmBehI6zV6DT/E9arXjx8LiL0=;
        b=nOW1dJSzVFvP0XctGEk9bOJKCW15bXfIREw5h2tgDjQ7/Hy8IEAJb5xaKyMhtkXjx1
         zf6LOVFL1PjyR7nlfG8EuK4rtTnOanIvbqjgbBwBrAx4mjbJ2JEJjs7uehAUoeK7tB95
         fDZ4tbWQqoy4/TpwsJQMQiV/kE5TMUjp3ze8Yia7KWyx070YH2eGHlts6U9lccd7ct/B
         5Ullq95LMHp9mv1E73Yo8t5A1A8jZb66djGqxV4gy2dF/w7u4ycUdO2FiuSz7/dkbw4I
         eSzjvIHL1p/ecO+ONVa928EumIhfe/+oaG5d2PBDNKCf9V35Q50WJzrsr4maUjBrbwCA
         qRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=E5S9aNFqrzMweT/fLedmBehI6zV6DT/E9arXjx8LiL0=;
        b=AggoTu0Vqvy/Sx785J2cLwi8tpTQk1/BJZtuZoy+Bpo5jGuqZDJL5e9aanB4yvywOf
         tyM80EedCiDOYkZ+w4C54l2vGU648XTklTxBl2TTEMx4aPQwJAAkanab2vXfa67NNvMT
         qEycL2ms+O01ITViKpqLfLs4w0+d8J93OymE3ox1lW6vkk8JYZq3vJOeWzNhE+skeFOc
         uu39/IjKGkuiNF1fnT2MWaAd9mNrVCizqn2WfKENBHCzwr8pZnioaAq6cY8jRVdNPiLr
         CcYFfPIvyNlEqCnTj6f89ymIqSItu1TlLfkDH3gZw+HmXSmY8An8OKmEoTxzdBfk9Gvc
         utNA==
X-Gm-Message-State: APjAAAVgUiFk4HSh29I7C+Fua047UuMRXMNzMTICari0+i3QOuJCuaGu
        wFfMEasCWp1bt8C1a4p3QVrq8d2UsGU/Iw==
X-Google-Smtp-Source: APXvYqxe0BOqNhTYK0A0EeE+usRWZgwZqrZrRH7ay8qcw1krcOJVLuutSOD8sd+Ax/AYw3YPnyYC2g==
X-Received: by 2002:a1c:ddc3:: with SMTP id u186mr6081797wmg.103.1582227236703;
        Thu, 20 Feb 2020 11:33:56 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local ([2a01:e35:2ec0:82b0:3115:825f:fd46:f0e9])
        by smtp.gmail.com with ESMTPSA id q1sm694991wrw.5.2020.02.20.11.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 11:33:56 -0800 (PST)
Subject: Re: [PATCH 2/4] drm/meson: add Amlogic Video FBC registers
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
References: <20200220162758.13524-1-narmstrong@baylibre.com>
 <20200220162758.13524-3-narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <85b7dab4-0941-d31b-bcd7-3589d5040064@baylibre.com>
Date:   Thu, 20 Feb 2020 20:33:53 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200220162758.13524-3-narmstrong@baylibre.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 20/02/2020 à 17:27, Neil Armstrong a écrit :
> Add the registers of the VPU VD1 Amlogic FBC decoder module, and routing
> register.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_registers.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
> index 8ea00546cd4e..f784d7d1fe2e 100644
> --- a/drivers/gpu/drm/meson/meson_registers.h
> +++ b/drivers/gpu/drm/meson/meson_registers.h
> @@ -144,10 +144,15 @@
>  #define		VIU_SW_RESET_OSD1               BIT(0)
>  #define VIU_MISC_CTRL0 0x1a06
>  #define		VIU_CTRL0_VD1_AFBC_MASK         0x170000
> +#define		VIU_CTRL0_AFBC_TO_VD1		BIT(20)
>  #define VIU_MISC_CTRL1 0x1a07
>  #define		MALI_AFBC_MISC			GENMASK(15, 8)
>  #define D2D3_INTF_LENGTH 0x1a08
>  #define D2D3_INTF_CTRL0 0x1a09
> +#define VD1_AFBCD0_MISC_CTRL 0x1a0a
> +#define		VD1_AXI_SEL_AFB			(1 << 12)
---------------------------------------/\
				Missing 'C'

Thanks Christian for reporting.... last minute checkpatch fix gone wrong.

Will fix either in v2 or when applying.

Neil

> +#define		AFBC_VD1_SEL			(1 << 10)
> +#define VD2_AFBCD1_MISC_CTRL 0x1a0b
>  #define VIU_OSD1_CTRL_STAT 0x1a10
>  #define		VIU_OSD1_OSD_BLK_ENABLE         BIT(0)
>  #define		VIU_OSD1_OSD_MEM_MODE_LINEAR	BIT(2)
> @@ -365,6 +370,23 @@
>  #define VIU_OSD1_OETF_LUT_ADDR_PORT 0x1add
>  #define VIU_OSD1_OETF_LUT_DATA_PORT 0x1ade
>  #define AFBC_ENABLE 0x1ae0
> +#define AFBC_MODE 0x1ae1
> +#define AFBC_SIZE_IN 0x1ae2
> +#define AFBC_DEC_DEF_COLOR 0x1ae3
> +#define AFBC_CONV_CTRL 0x1ae4
> +#define AFBC_LBUF_DEPTH 0x1ae5
> +#define AFBC_HEAD_BADDR 0x1ae6
> +#define AFBC_BODY_BADDR 0x1ae7
> +#define AFBC_SIZE_OUT 0x1ae8
> +#define AFBC_OUT_YSCOPE 0x1ae9
> +#define AFBC_STAT 0x1aea
> +#define AFBC_VD_CFMT_CTRL 0x1aeb
> +#define AFBC_VD_CFMT_W 0x1aec
> +#define AFBC_MIF_HOR_SCOPE 0x1aed
> +#define AFBC_MIF_VER_SCOPE 0x1aee
> +#define AFBC_PIXEL_HOR_SCOPE 0x1aef
> +#define AFBC_PIXEL_VER_SCOPE 0x1af0
> +#define AFBC_VD_CFMT_H 0x1af1
>  
>  /* vpp */
>  #define VPP_DUMMY_DATA 0x1d00
> 
