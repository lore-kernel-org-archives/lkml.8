Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28003C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1122072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T5wSGnt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgCSRsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:48:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34875 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgCSRsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:48:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id u68so1816049pfb.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=iWUSd6tNelA3B2gV8L14dd3S0Goj3iWlFgAqgwk5kPw=;
        b=T5wSGnt2PrWmaej5pxTQjA5iZ75Iq5B8ryc8SsC0GZUqDnlwetsWMpCtffoLmhaty7
         MEpRGQOi8ly0/vnWHX7gn8Je3y5VDnIUpNcgALh6uSrWPV9q0Ly1fiQ5RC4Xi02iZE6W
         JyMt029uRbZPrTBbpHeGtn40yI63DT1zUUIhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=iWUSd6tNelA3B2gV8L14dd3S0Goj3iWlFgAqgwk5kPw=;
        b=cH+pCYk4xbRLm+gL33MLyYNiZp80pZRV88MxUsX3IJPWpGP1qeDoSVSIm6ZINnX1F1
         Ox42iQCnGCIuWwt0GOvnchbXora3eMA2H8rhQBnxgO23cYVLI/sms/yqA7lp69eNoDjw
         J9wzXMvjFfSeN1g60oXdNrzB81/QZ7FsI8LmeW/PPbyGTixWAjHVBoQYTk1bsidkZ4GI
         CKNL3g9Gux7fZk7LYsj3D1uYNgzhqWKFC91WOTH8RBP5oPG9C/ea66KIb8L7CaJOY0K4
         Rjdk1miffLhFgkU/P2pNngxnfqToM0GpOCEcdmiTCpyajHI9Ohp6zsBDZz+aegfIS9kh
         icbw==
X-Gm-Message-State: ANhLgQ1A65hg99g70OTOuAav6GY3QhAdSiZiI/XK6AUq7kO+Z3HS9fhD
        tjlqjgQ1vTp5MNKmzqFN4xmtgg==
X-Google-Smtp-Source: ADFU+vut6Lso223EbxYK+y4BZyU7C3AfV3mD375ioWsMfGKfgEhQlPlHMn0XJNEJoyfTIpfVnP8PYA==
X-Received: by 2002:a63:c811:: with SMTP id z17mr4386751pgg.41.1584640092091;
        Thu, 19 Mar 2020 10:48:12 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h11sm2990799pfq.56.2020.03.19.10.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:48:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1584356562-13181-1-git-send-email-mkrishn@codeaurora.org>
References: <1584356562-13181-1-git-send-email-mkrishn@codeaurora.org>
Subject: Re: [v2] arm64: dts: sc7180: modify assigned clocks for sc7180 target
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Krishna Manikandan <mkrishn@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        kalyan_t@codeaurora.org, nganji@codeaurora.org
To:     Krishna Manikandan <mkrishn@codeaurora.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Date:   Thu, 19 Mar 2020 10:48:10 -0700
Message-ID: <158464009041.152100.18425074316530931981@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject could be "sc7180: update DPU assigned clocks"

Quoting Krishna Manikandan (2020-03-16 04:02:42)
> Add DISP_CC_MDSS_ROT_CLK and DISP_CC_MDSS_AHB_CLK
> in the assigned clocks list for sc7180 target.

Why?

>=20
> Signed-off-by: Krishna Manikandan <mkrishn@codeaurora.org>

Does this need a Fixes: tag?

> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/q=
com/sc7180.dtsi
> index 998f101..e3b60f1 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1544,8 +1544,12 @@
>                                 clock-names =3D "iface", "rot", "lut", "c=
ore",
>                                               "vsync";
>                                 assigned-clocks =3D <&dispcc DISP_CC_MDSS=
_MDP_CLK>,
> -                                                 <&dispcc DISP_CC_MDSS_V=
SYNC_CLK>;
> +                                                 <&dispcc DISP_CC_MDSS_V=
SYNC_CLK>,
> +                                                 <&dispcc DISP_CC_MDSS_R=
OT_CLK>,
> +                                                 <&dispcc DISP_CC_MDSS_A=
HB_CLK>;
>                                 assigned-clock-rates =3D <300000000>,
> +                                                      <19200000>,
> +                                                      <19200000>,
>                                                        <19200000>;
> =20
>                                 interrupt-parent =3D <&mdss>;
