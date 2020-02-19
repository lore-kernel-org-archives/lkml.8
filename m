Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44533C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1022722B48
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582081427;
	bh=mVR+NZQneoCo48GbuZCZUtB9WfA6V/1A87KPT/VW/Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IkPfwuLHZO29APWG/+Iv1qyFxtX1ZlAaeseew/kpkqqFI9nBIYQqLWflqlRkru2zr
	 MvaUUvZcBqYzYzb0jrkcIv6lI+TQMsa4ZBJag6sEx+c3PdqVwCT0yTgCrZKwEDcG7v
	 ouCrmjZub8GI3VGU+F+BMSaSYhoJtUvodo1t5n4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgBSDDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:03:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42686 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgBSDDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:03:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so21734742otd.9;
        Tue, 18 Feb 2020 19:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3ww9jD9BZoI0pj8Fh4zqJj/5ENJzlS5CiCEh5EfEMME=;
        b=RjtHgSawD+scBXOI9PMJe6xpfQvwRUKvXw7aPcr57p8lKoyK11jGlQbDrp6hlA0cpE
         QVbLSuhrIb8OlhhiwkEe6pFY6Rb2Jt6jDEUToMHHLT3THkk2We7Fl25DxE7tQIN6eRDC
         nPhfaGLmo3sGMYCwOkAzHWLtMpYasUW+Z+DsKhlMVwVgZYe55tuH4Aj1BS8OnUK47X2O
         mDB8h5JXb/YAKFHvdargGEm3IgUBgmLdiQxLwLLHCObRgq32JXPuWs+dwiR7p15qDlcm
         sOpmJ2YfwOdQN6++s21RJv2NSmf066bZDyDTuseLA8wl6rRR4NvAy4WYi34BIZMFDgs8
         Gb4w==
X-Gm-Message-State: APjAAAXjSlAl++gcZW60MxfJ3M0oTcDfeEJma0n1BOW4EilUwZfsJlrD
        h+pu3n1+/hzKoZ3TcMn1OQ==
X-Google-Smtp-Source: APXvYqzTdqeuboLoLPJb+yflZq5A5EEQsO0iTNPuA/QcWSn7buqxIsiMpRFFdj7EAa+AdIsqcpxByw==
X-Received: by 2002:a9d:48d:: with SMTP id 13mr16994562otm.249.1582081423252;
        Tue, 18 Feb 2020 19:03:43 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u18sm211383otq.26.2020.02.18.19.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 19:03:42 -0800 (PST)
Received: (nullmailer pid 16790 invoked by uid 1000);
        Wed, 19 Feb 2020 03:03:41 -0000
Date:   Tue, 18 Feb 2020 21:03:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V3 RESEND 2/7] ARM: dts: imx6sx: Add missing UART RTS/CTS
 pins mux
Message-ID: <20200219030341.GA16734@bogus>
References: <1581938021-16259-1-git-send-email-Anson.Huang@nxp.com>
 <1581938021-16259-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1581938021-16259-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 19:13:36 +0800, Anson Huang wrote:
> Some of UART RTS/CTS pins' DCE/DTE mux function are missing,
> add them.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> No change.
> ---
>  arch/arm/boot/dts/imx6sx-pinfunc.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
