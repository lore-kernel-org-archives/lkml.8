Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B656CC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4AA24655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtiotwLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCJGsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:48:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37252 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgCJGsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:48:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id b23so6931866edx.4;
        Mon, 09 Mar 2020 23:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0u5iRMi6e4nX2w7kF0dC+JMM932v3kVJ1e2J7tVdKIQ=;
        b=gtiotwLoSufBZBUWX2dcLwMbsjpmDgqr3iHtOqNUF4aai33R6GNPvaRKcSi3eE/rov
         rTKZYFnBPF/+rWZdA1/PNXHOBWLS/NlKjrRWDlRw9F2TNzJ0JoceoMOM89vpib6AgZ60
         QRBYsxrcO2ZO6aAcv64h4IQpI4r5BhqO/LSzEkB7SyrtiDp7RaJ5oWaxN/gzmddjqCzq
         llsCD/9qTzQ2rGSf2iq43yxZWRiyebjJ/tz0RMyIZEIzQqlnxaBNQXkp++Aa0+dZjStd
         zac2rIKHswbbrIpPYxnVPgp8Lv0SRjmeHVdnvdkG/rAkJTxu+i1V1Rpi9H8i5+YcSG6Q
         3Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0u5iRMi6e4nX2w7kF0dC+JMM932v3kVJ1e2J7tVdKIQ=;
        b=UbXQjHsNK/D5tCbr4inuaipc4MtEDXMo2hoC3gi8BMpMTCNa33rqloFs9MvFbgExik
         h31F2Ut8zeCAVu/SzvdkZnQ6WFFJkm48afnHXENCFNmXQIIAtQDBd8WboZz8RmdCwGmT
         CX8YYiDhgpYr2OFepHtJKCg2u43HXQ37aqKpu4lXYX6BPDEQlFws2Qj7kMb4PVBlezVu
         yBJuk0hm9I+scmwql/RFG7v7A+esFdUVSiDru1g53BBGw0DLFDx26TmwUa2Jqlnymern
         Apz1eIxSAULD1tafMeWP8AUAjslP+CUkJHxY7jzfMYtdbTkRS1A4//B3WeC5ok97R6yZ
         mbVw==
X-Gm-Message-State: ANhLgQ3tSBOd1KNYKZ1GfQzPIEDwDP2sHfWlfae3FB7AXOnCJ0GL3gzo
        elVqt3ii3e2X49rcq2Yb2nc=
X-Google-Smtp-Source: ADFU+vuE6XSn9RDSDLCaLJELrTnGl6XaoofUPaXqsbj93WYS5wEyiNUMzfn1/zrYbyrCxRJDYY8swg==
X-Received: by 2002:a17:906:680c:: with SMTP id k12mr6610870ejr.237.1583822928797;
        Mon, 09 Mar 2020 23:48:48 -0700 (PDT)
Received: from felia ([2001:16b8:2d3d:f300:b903:a662:c2f7:f5c9])
        by smtp.gmail.com with ESMTPSA id o88sm3991240eda.41.2020.03.09.23.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 23:48:47 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 10 Mar 2020 07:48:40 +0100 (CET)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] MAINTAINERS: include GOOGLE FIRMWARE entry
In-Reply-To: <69ed8a468b3e4776d277292a2e4b2f9b3c266f23.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2003100745590.2788@felia>
References: <20200308195116.12836-1-lukas.bulwahn@gmail.com> <CABXOdTcrxoBCz24Ap=YJYZnr+oLAmaR10xZ9ar2mYbE1=RAoug@mail.gmail.com> <5129f7dbd8506cc9fd5a8f76dc993d789566af6c.camel@perches.com> <alpine.DEB.2.21.2003090702440.3325@felia> <20200309070534.GA4093795@kroah.com>
 <alpine.DEB.2.21.2003092035300.2953@felia> <69ed8a468b3e4776d277292a2e4b2f9b3c266f23.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Mar 2020, Joe Perches wrote:

> On Mon, 2020-03-09 at 22:03 +0100, Lukas Bulwahn wrote:
> > I am starting with the "bigger" clustered files in drivers, and then try 
> > > > to look at files in include and Documentation/ABI/.
> 
> If you want to spend the time tracking stuff down,
> it may be best to to
> start with include/
>

Thanks for the guidance. I will do that, and we will see if others 
appreciate that or not.


Lukas
