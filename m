Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D7AC3404C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EDD22B48
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582081408;
	bh=K+/aQsUKLhihHcUnsqZKw0YW0QkO5gUQeJbYcnbpUxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DZBfC35Xo1YdPN/uDWNHPRYHg/sOK7UoBWIRoeomL/saZ/pgS+rGJ8psjNu5ESkW3
	 mwt1C61mN/Lg08zL4bHU3S1+pYGTZOjQ+IsaK443uTaPIA0wxxcJDD5ThaL1M7GqQ/
	 0WGIVBdif/m+RA6Z/ylqwmrUdJGwerksnvxp6mRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgBSDD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:03:27 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36228 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgBSDD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:03:27 -0500
Received: by mail-oi1-f194.google.com with SMTP id c16so22415937oic.3;
        Tue, 18 Feb 2020 19:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Hf1f6QP19rHdaFJBEywe6mRYXkeEBsQdT49X3f8AQCs=;
        b=H/XKDpEcVj7/zmIpp/5BaRREy75rk04rHToY9ka8cP703S/Ly/sOFqIqa2h2TFc5xw
         PnyxUvUavmlI9p4+1IE3GsAQV6oDEHYaWIwySy96k4ExN0QIFlA2eYOJDTmWK/Q+hUzN
         CpxrLHP1SKy+xcah8HKgsVILLW83L2jk4p012WNR7nxOF56B02XrZhXo6pEbOkDpo2+D
         1H8eWYzMCT55NbsVzyjZExhC0ZE80YkakaC0Gap6DdkDtM0NxqlGh4oexLjbRZvALRlF
         rqUcHNnLwVhDivWuUFBauRmraP6iYfDg+0o+8gRRe3IFLzjnzLJqMII3A1s3CQmZ2X8l
         /mSA==
X-Gm-Message-State: APjAAAXKGo5vt8UTj6b4/VYYB3D8S27WeW0D1ZTT9+W14i2lFi0wCaN8
        VK0/lcZg0heI5izlQi9QWw==
X-Google-Smtp-Source: APXvYqzb9WboKkTWigfur8GY+H5M6QkRTHO++ZcVsbVhsDtpZ0hlIVyOR7AyTXVJ5W9SnTQCgMCmfQ==
X-Received: by 2002:aca:4c90:: with SMTP id z138mr3411041oia.140.1582081406582;
        Tue, 18 Feb 2020 19:03:26 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b145sm303254oii.31.2020.02.18.19.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 19:03:26 -0800 (PST)
Received: (nullmailer pid 16294 invoked by uid 1000);
        Wed, 19 Feb 2020 03:03:24 -0000
Date:   Tue, 18 Feb 2020 21:03:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V3 RESEND 1/7] ARM: dts: imx6sx: Improve UART pins macro
 defines
Message-ID: <20200219030324.GA16230@bogus>
References: <1581938021-16259-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1581938021-16259-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 19:13:35 +0800, Anson Huang wrote:
> Add DCE/DTE to UART pins macro defines to distinguish the
> DCE and DTE functions, keep old defines at the end of file
> for some time to make it backward compatible.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Changes since V2:
> 	- Adjust the definitions order to make DCE always before DTE, no other change.
> ---
>  arch/arm/boot/dts/imx6sx-pinfunc.h | 260 +++++++++++++++++++++++++------------
>  1 file changed, 174 insertions(+), 86 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
