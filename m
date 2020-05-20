Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C645C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7A820842
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjwc5wdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgETC5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgETC5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:57:41 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4C6C061A0E;
        Tue, 19 May 2020 19:57:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g1so1895402ljk.7;
        Tue, 19 May 2020 19:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KC6GGjoH8hnfhD8tdDUja14o6OUOJAOHW0azVQUnXI=;
        b=sjwc5wdXqJ/WxyozE/wXmrHsKhLNAFb3bRpSeOy331LwXuMTGqG836DVyBaOP6/Wbq
         Oeo5+wgEw0e/PkaVz7JR+moTkU16FJ3Y6B0vi33gNGrDrb28jHDHzfAsQD2jlBvkm5ok
         fqXs2mnILImPvEb84vfaxlykXWnoP/R4b6Q7eJ8tBJVMAbTKMVsTiA9CMJLaENAGYHgR
         aNl94nge9+6wylZDT9dWe8RbMQbIetNoH2kygBWxvj0NwGCz0VzaQcjMOrDu5Gxn093U
         DdrHix38kXpLE2L9owgtJwpJWRvEjN9vTprpUPUhzX/dv6CTpRTmdYhyOC4u9S73di8+
         ttlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KC6GGjoH8hnfhD8tdDUja14o6OUOJAOHW0azVQUnXI=;
        b=HMnymBDMGYkU9z5tsL98dggYqwxb2b3bxDGGAspjA0uRnHM7uH5CbJ7IyihO6rQbMI
         CamuFQ8vih1tldSKXF1GEqwjWWdYlUtRyHJQaV46shABMwAt+PVtnmlWfKPlik1Vi92w
         usHMJDbUt0+uEb1jAmJrA866xbJWPIvxv7ejVMqG9qLtK7SJLwlA+sB4VeWyxSPd2rl6
         Yj4+K3r/+Ij4ZTdVGovsUqnZ8Z5ANL1i+3T/+8bfcGcb+A0sHtOXg++kAoSW7xyv1wpE
         OvOkRbxnrlZhYl/+CwynAAsSzAj4eXWDsmPwZZHGETolj5aUkBGpEqVcmbv6UjziJwwR
         mn9Q==
X-Gm-Message-State: AOAM532VZG5GOejNnNvmtnGzAYz9sUzD0/58y6wcX4sT8xFVh7+SYdDV
        iOVjbQ/huJB3qsuabmlkJPs4kh5H+Xc/mkv0C7U=
X-Google-Smtp-Source: ABdhPJwrTDhzAMOEdHdxMqT7mpDPk3dUGrskOlhpIObxl2pTn9btFcVuWwRV37VDRLjBTmtcxE6FMBvOjbNoa71R6EI=
X-Received: by 2002:a2e:920e:: with SMTP id k14mr1459145ljg.288.1589943459875;
 Tue, 19 May 2020 19:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <1589940278-3680-1-git-send-email-peng.fan@nxp.com> <1589940278-3680-4-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1589940278-3680-4-git-send-email-peng.fan@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 19 May 2020 23:59:00 -0300
Message-ID: <CAOMZO5BPPRy_XGHHyZfE3eOrmCwW_VytueY-An8qqke6HU06TQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: imx8mp: add mu node
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Tue, May 19, 2020 at 11:15 PM <peng.fan@nxp.com> wrote:

> +                       mu: mailbox@30aa0000 {
> +                               compatible = "fsl,imx6sx-mu";

This should be better described as:

compatible = "fsl,imx8mp-mu", "fsl,imx6sx-mu";

From Documentation/devicetree/bindings/mailbox/fsl,mu.txt:

"The "fsl,imx6sx-mu" compatible is seen as generic and should
be included together with SoC specific compatible."
