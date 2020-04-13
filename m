Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975FDC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 727882072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVh1MHnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbgDMRUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732579AbgDMRUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:20:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98C5C0A3BDC;
        Mon, 13 Apr 2020 10:20:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k11so10316307wrp.5;
        Mon, 13 Apr 2020 10:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kWgwtw6mnshP7OT2kiE97Ap+wsoZZptwcvaDrs1tDsI=;
        b=bVh1MHnIU7qEHoYKTXnX8K/41raLAhstyBAr9OgkIlaMU8CkeYDVbSuj2MVqY6E5dC
         qLA+7Z8aDDgXtfRRRqEt0JirV+9D3Kq0As4DptSjqE9XC0ru6jAEs0RursW6IqmT1Zig
         sI5edIfwkeSg6nTxBG35L3EVBdv/yJQ/xXc/2hlNlq1c87BhsJFy0UQbTYqwrCW9wi+m
         +UMcaGJA1UvnpJqFD/eQh1Kb4j9Rttzq1LN53LMaa6FQiRsPQtUzk7u8/c6uuQi/fWnZ
         FUJhWMCikBA3WxTFmBgTIrX+2cTVVd4s1z5j5ATbYWQ5BQnVkFcCL7dNGbK7P1nIsN/d
         axFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kWgwtw6mnshP7OT2kiE97Ap+wsoZZptwcvaDrs1tDsI=;
        b=Ryse9ZksgEQsHvy42kpIfmiCut9nMkbLvkhedcFApneXqfMbKjjRGT2dBss9OhBdKY
         clNF4UZtfNhAfHFfPHQ9n5RZ9i5SogpdMPcsSWcnF0uE19hI+yrbJUGpiwQCVBZk51Qz
         rzsKLAE+RNZgsrdmhF3WrDAkFgxJGbpESOB/1bnNGlAc+B4v6wCNlPxi3E/JtsUuYKXb
         L+7BfTYC6iWdMVnGM2ZIzfl0V9xvv6RjIOPg7u8rEQ2XPkzqSncdRyOA5YFPMmw/beFY
         a+7b+mTzXy/GN+KpRdFiai7kHFrEvwKgvu7NB8A0e5eFZrn8oXHiy35eYfiaPmwAUup1
         u2Rg==
X-Gm-Message-State: AGi0PubrV/S4wvGM7Ky18UmX0W9CSLYZMUFXsHFtE6Db3as99yGKwGOK
        D4G6qV3F1sqd1H+yJQlZ4WM=
X-Google-Smtp-Source: APiQypIs6QMkRZ3InN+DdxIArcJcpkp8vBmkZ8YZyLT4LbLHkZc845IeZsR13A1TTF2jkLK0weALmQ==
X-Received: by 2002:a5d:698f:: with SMTP id g15mr5867707wru.135.1586798448730;
        Mon, 13 Apr 2020 10:20:48 -0700 (PDT)
Received: from linux-gy6r.site ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id d13sm6835546wmb.39.2020.04.13.10.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 10:20:48 -0700 (PDT)
Subject: Re: [PATCH v7 5/5] media: mtk-mdp: Use correct aliases name
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
References: <20200210063523.133333-1-hsinyi@chromium.org>
 <20200210063523.133333-6-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
X-Pep-Version: 2.0
Message-ID: <7f08c5a8-8635-7e97-9585-601ac9c21ded@gmail.com>
Date:   Mon, 13 Apr 2020 19:20:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200210063523.133333-6-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/20 7:35 AM, Hsin-Yi Wang wrote:
> aliases property name must include only lowercase and '-'. Fix in dts
> and driver.
>=20
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/me=
dia/platform/mtk-mdp/mtk_mdp_comp.c
> index 9afe8161a8c0..0c4788af78dd 100644
> --- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
> +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c

When resubmitting this, please make sure to use
scripts/get_maintainer.pl

The To and CC list are missing the relevant people and mailinglists,
porbably that's why you never got a response. The patch is trivial feel
free to add:

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> @@ -15,10 +15,10 @@
> =20
> =20
>  static const char * const mtk_mdp_comp_stem[MTK_MDP_COMP_TYPE_MAX] =3D=
 {
> -	"mdp_rdma",
> -	"mdp_rsz",
> -	"mdp_wdma",
> -	"mdp_wrot",
> +	"mdp-rdma",
> +	"mdp-rsz",
> +	"mdp-wdma",
> +	"mdp-wrot",
>  };
> =20
>  struct mtk_mdp_comp_match {
>=20

