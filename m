Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ABEC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F5220644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HXnMIBLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505151AbgDNTo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440692AbgDNToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:44:07 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DE3C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:44:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a13so417864pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=VbtTAnrt40z6tPxpWEZvoewnWhsSpl940nLeLk/aZs4=;
        b=HXnMIBLCMj8Xz+aXGEJ8YsgpiE9MRABN++ki0Yxg0qmvHDq2ZE/0xLTjUn7/VKHqm8
         HU4ja01m9CzqgP8xULfiY9Uet8Q0l1SMN78aKYhe6kleUE6XPMeyprxdMR8kDKmbmLl+
         eWAhCCx/DLHRRdw+ui1cKx6bEenVcV1+eFntc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=VbtTAnrt40z6tPxpWEZvoewnWhsSpl940nLeLk/aZs4=;
        b=Wu/JENCL0lr/cZ0AmZA54UBycRD/uPAWiNKJ/OBa/g2KV2De/EYWzcPGO359HSdmYw
         Lu6zrPGKy0LSHqUDinMfHlkuAocqTqGKl6Kx0OWwnC5gQRLiqHnl4qn00zgYy86uBVo2
         ZjFuaxLtqeXTaofQTBxkU58xmSm40lbJUnJGKQFqj/xB2ZBNybJQYLKqxRe5uExu3//A
         ZAoDZggFvSDpZx/IAqQgZWo2MPKMrFFEV0Flf7KxR/QKBu8U0U7+gSyBcQ/KU2R7p1UT
         jK8kG+XKcJS1zPBMsJWs/Au1HgCRdiHAGOEOym5imRHHo0uVyGi7BousOhv4ZrBmhQp1
         pTNA==
X-Gm-Message-State: AGi0PuaS7rNtaKDgtHcG2jlBTNxItClXlZVSAW5v2a1beu5wqzLi/nJo
        SAw79iul9JMDi5cYRS4b8HLzoA==
X-Google-Smtp-Source: APiQypI19hmEasOLVbF+NjBLSG3rtOoCjwF9p246fz6LzJ2gVKLHeYMvSplzv1Cy2N7YqG8m2mQFew==
X-Received: by 2002:a63:ca41:: with SMTP id o1mr24256005pgi.419.1586893446374;
        Tue, 14 Apr 2020 12:44:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y25sm9049090pfr.44.2020.04.14.12.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:44:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200414104120.1.Ic70288f256ff0be65cac6a600367212dfe39f6c9@changeid>
References: <20200414104120.1.Ic70288f256ff0be65cac6a600367212dfe39f6c9@changeid>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Factor "tcs_reg_addr" and "tcs_cmd_addr" calculation
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mkshah@codeaurora.org, mka@chromium.org, joe@perches.com,
        evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Tue, 14 Apr 2020 12:44:04 -0700
Message-ID: <158689344462.84447.17260207632295085186@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-14 10:41:34)
> We can make some of the register access functions more readable by
> factoring out the calculations a little bit.
>=20
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>=20
>  drivers/soc/qcom/rpmh-rsc.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 732316bb67dc..de1f9c7732e1 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -136,36 +136,45 @@
>   *  +---------------------------------------------------+
>   */
> =20
> +static inline void __iomem *
> +tcs_reg_addr(struct rsc_drv *drv, int reg, int tcs_id)

const drv?

> +{
> +       return drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg;
> +}
> +
> +static inline void __iomem *
> +tcs_cmd_addr(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)

const drv?

> +{
> +       return tcs_reg_addr(drv, reg, tcs_id) + RSC_DRV_CMD_OFFSET * cmd_=
id;
> +}
> +
