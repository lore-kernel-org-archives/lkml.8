Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7C1C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679902073D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583244492;
	bh=2Qt0S2CAnG/9u9THs9lOi1Z43JyQqdojRSwZB5RzZGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hXTJsTYnrsX2UBd/yyRE2PRVjtndpZvd9xrPOMnvH5vHgjRZIdiazYyIJJPOdjDmu
	 zKCgb2GGW/JGNJgRLr8xa+mNE1ivx0y994fkrgflRoSjkceBY6FwGvwrmAnzwHpr4Z
	 A1ha+fBDAd3oe3A5ldx++caFd3UobIw/eKDTnS54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgCCOIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:08:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37193 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbgCCOIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:08:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id b3so3102319otp.4;
        Tue, 03 Mar 2020 06:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A6D7BAvLXVxbOhgFZuE5YkQz9saZEQT0SY2WSIxoYms=;
        b=fnvLu5QWc92XtnyNwo9ZuAWOiu37QzOOmO1THAiQVKXELhTeZ8/N4O3WGHDXD26EUl
         sbEfnugxCOgOjItn1YZprK9HhG5JhMMP42Z+9dqbDGFALxz4qN0Ovi31wpDSUWywSMmJ
         DceigBuJdSWs0GGdMtIhtTPpajUMT6p9Z3GUehNu125WlF4OlAUohuGSKIH0zL9GrtWS
         +1OXCkARf4TRH5cIpJRCaN6WBXkV2v/7bnjlF2HEvQj3rX0Li1SAhNrCdC22j+TRUAVb
         WzhbOlOGD3TTsMd9eYwu9SdBEO3ppvTAZeIo9QNnr792cHwvhODrDSK4xIhLflMLU27R
         Q5PQ==
X-Gm-Message-State: ANhLgQ3Yo7re+QXrZ/7Xkj0ALx021CrhvSuRicuZuQMW/D1WixO9t/Yu
        QYe4PzxXAHbNjGeEfUT9DQ==
X-Google-Smtp-Source: ADFU+vvkMEkR7BL4iTZjxNIvbB4DYEW/CEbDIVdqPTncHsW1UQynHr6EDwGrjmGqJGu5UcxNd7n+sg==
X-Received: by 2002:a9d:19e9:: with SMTP id k96mr3589819otk.68.1583244490218;
        Tue, 03 Mar 2020 06:08:10 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n27sm7664536oie.18.2020.03.03.06.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:08:09 -0800 (PST)
Received: (nullmailer pid 24903 invoked by uid 1000);
        Tue, 03 Mar 2020 14:08:08 -0000
Date:   Tue, 3 Mar 2020 08:08:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 2/4] dt-bindings: reset: imx7: Document usage on i.MX8MP
 SoC
Message-ID: <20200303140808.GA24845@bogus>
References: <1582708431-14161-1-git-send-email-Anson.Huang@nxp.com>
 <1582708431-14161-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582708431-14161-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 17:13:49 +0800, Anson Huang wrote:
> The driver now supports i.MX8MP, so update bindings accordingly.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/reset/fsl,imx7-src.txt     |  4 +-
>  include/dt-bindings/reset/imx8mp-reset.h           | 50 ++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/reset/imx8mp-reset.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
