Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963DDC4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E85721744
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Moy0oe77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgBZCzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:55:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38403 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbgBZCzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:55:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id p7so669734pli.5;
        Tue, 25 Feb 2020 18:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bfSVMJ6Zntz6A9BJaM12dNm4EQGGybEoHbVncbTsUMA=;
        b=Moy0oe77F1nP33WomY+/yVeQF9YOUm9A+K2Dmya3vWO3y1gDf7kXx+ARQoGIqJsbcn
         sPDlocDXHhiYZjO+XyXUp5tQV8BJw2C7x+2ghY8gYyPWFQ7qduGfKCkjbgpdinZcGNjB
         WxhCMHnCKG0c8t5hywtULwpBqj4C0bP6PHBAoxnZH9WUICVJuyrYV1mqj2wAShGjfCs6
         tIJzuV4Fe3jr6nyPLQ/HjFbLHYzt3rgUTWbLX8hMswIRiB57T3uJgkHbl/XIWiXtE5Fv
         PNehsU30K6Pj2wGG2X6MPSgieuIgHYhU1Oya8m/3JHtMlRpQXMzTlhwP7/IXW+Pi/+xR
         gauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bfSVMJ6Zntz6A9BJaM12dNm4EQGGybEoHbVncbTsUMA=;
        b=p6PhwdoPvYhil7uwcUiyDhj5j4tHyq5dQrRnqoyHVa/7S+0aQnqcVeIkCDZQ3sXDD+
         QqN5R5QgPd2bKb89fOEF/dAD1dOcAFvjioy1d76ncB8bLuHoSNJ/wfkus1kzmviYQgxp
         YuDIRYMIbDQzad61PB3Aw3SYyisHCpHAIHgezonQl+LeoqOECpSkNJQK5Rk4fBLCm80J
         MJJShjqvGfR7k26/VQZcC73fXeVTxV4HsbWn8vajvRIv+9y9MNKu3UhVuQO7N3CkGB36
         A4h+VnhnNwkhOk3AKFbC6qdnXsvOtzaUFtKg4AFoGM8IyGiA63M3rz1gMWPay2WyPfPZ
         WyFw==
X-Gm-Message-State: APjAAAVtGVJvA5DV3E1gxt8PuWR6ImdURGWh4IM8FxxUEpj4qaiSOJ/j
        9k88X3XVkeNOFXivL6j1B/67paZijCk=
X-Google-Smtp-Source: APXvYqxX5rlyRMCuaRBBYuYMduxdjpm5x24xmrS5n9R3CJux7Jc4o6x9N7kxgP+pNGY/fDI9hDV73g==
X-Received: by 2002:a17:902:9f88:: with SMTP id g8mr1790693plq.100.1582685743306;
        Tue, 25 Feb 2020 18:55:43 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id l13sm444798pjq.23.2020.02.25.18.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Feb 2020 18:55:43 -0800 (PST)
Date:   Tue, 25 Feb 2020 18:55:40 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] ASoC: fsl_easrc: Add EASRC ASoC CPU DAI and
 platform drivers
Message-ID: <20200226025540.GA22445@Asurada-Nvidia.nvidia.com>
References: <VE1PR04MB6479BCA376502F6F1251602BE3EC0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20200225080350.GA11332@Asurada>
 <CAA+D8AMFzDs8uXiR-N8harRVmhC+3i8p9HdO2CgxOCX8WVfXAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AMFzDs8uXiR-N8harRVmhC+3i8p9HdO2CgxOCX8WVfXAw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 09:51:39AM +0800, Shengjiu Wang wrote:
> > > > > +static const struct regmap_config fsl_easrc_regmap_config = {
> > > > > +     .readable_reg = fsl_easrc_readable_reg,
> > > > > +     .volatile_reg = fsl_easrc_volatile_reg,
> > > > > +     .writeable_reg = fsl_easrc_writeable_reg,
> > > >
> > > > Can we use regmap_range and regmap_access_table?
> > > >
> > >
> > > Can the regmap_range support discontinuous registers?  The
> > > reg_stride = 4.
> >
> > I think it does. Giving an example here:
> > https://github.com/torvalds/linux/blob/master/drivers/mfd/da9063-i2c.c
> 
> The register in this i2c driver are continuous,  from 0x00, 0x01, 0x02...
> 
> But our case is 0x00, 0x04, 0x08, does it work?

Ah...I see your point now. I am not very sure -- have only used
in I2C drivers. You can ignore if it doesn't likely work for us.
