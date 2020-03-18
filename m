Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3585EC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F892076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="YQZyAox1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgCRI2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:28:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39096 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgCRI2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 04:28:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id a2so418911ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 01:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzaS2e/XdZpUtzF616elOdAAPbhPZrej3K/evwYVIEM=;
        b=YQZyAox1qVRZw1QkCUb5HF0ehx5/zSENEbTNgYqxSu1U53i4/8ykPHc6HyuvRUwx3K
         +qQBIuTSJn4LSj961MijUmv/I2qY+6T9RY4d8B9y/Gj+99CZsl77yNfmLqrIxnvY0n4L
         q9TyitjevfqJwFXqgMCfn6f5wJgIejbXI1Qld3MnMvE2vo/d/SglXm69FyeUVFF4GPmc
         55G9BwXgaIVYYZaoENAbP2ljhHQfAx1Sla0cy5Qkq4TblJT4fLMcLqsOCgX8e4NS360h
         TwgtvR6t5qwKd9egoLLlFa1JiAHUuv1Gdz0m+eT4b+QWi51tyQU+xozKaMvIVOi4Bvu0
         lrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzaS2e/XdZpUtzF616elOdAAPbhPZrej3K/evwYVIEM=;
        b=GoyVLjuu8tfQmfdNdb9uP1cM470skFHqZe4ELQ46nBFf6kVr23kP5obkEdcxANAe/8
         NcUgZWsPLgP2sXEh8zWrLlQI1LUVQblSG7UAUSlG9Uh3M+QUhLgMgLyi2lCWVSVmp8P/
         +pW/7Es92nVc+zxMJr+V/Kai8YshRu/uW7vhEZwzfN/8rA3V1CcHElgGO/rY1+ft14Ed
         KY90W8Lp324odekHtob/SghfQVL4yHCK2t0Xfd8TW3QRRLAYBKATU1hfhg/YrCmpNIIK
         e7XKAMrzCRThqzWt7ByjKV1jFZqci0Sabc23g1bMs0HOYsYo4CM0A3KO/Hz8NmnO1yQU
         graQ==
X-Gm-Message-State: ANhLgQ1+2pTztRfqE+UdMa46j/UsO/YnZ1aHUZ9TYwVi2afucmCKrW4L
        TJ8EENrDHdN6Wb5aIxUq2fQwoogkminz7b6Z9R71GQ==
X-Google-Smtp-Source: ADFU+vstaPio4DgQjZBcZ6ke0vdqic5ns/5uMmDF4KiVhTeFUCGYD6+i5x/xuLKooeFxPoxk6UpLTOxWif0VXPGmoqQ=
X-Received: by 2002:a05:651c:2007:: with SMTP id s7mr1764988ljo.214.1584520084172;
 Wed, 18 Mar 2020 01:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <1584463806-15788-1-git-send-email-martin.fuzzey@flowbird.group> <VI1PR0402MB3600DC7BB937553785165C2AFFF70@VI1PR0402MB3600.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB3600DC7BB937553785165C2AFFF70@VI1PR0402MB3600.eurprd04.prod.outlook.com>
From:   "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
Date:   Wed, 18 Mar 2020 09:27:53 +0100
Message-ID: <CANh8QzwPmbfr1y9Yz7ctbannX3gOWZBQG1_xDM6xit=3ZXD+pg@mail.gmail.com>
Subject: Re: [EXT] [PATCH 0/4] Fix Wake on lan with FEC on i.MX6
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,


On Wed, 18 Mar 2020 at 07:28, Andy Duan <fugang.duan@nxp.com> wrote:
>
>
> The most of code is reused from nxp internal tree,
> If you refer the patches from nxp kernel tree, please
> keep the signed-off with original author.
>

Ok, looks like it was originally from you, should I add your current
email address or the one at the time (B38611@freescale.com)?

Actually I don't have the NXP tree but a Digi tree, which is probably
based on it.

I think, generally, this is a bit of a grey area.

While I would always keep a SoB if I base a patch on an old mailing
list patch submission (and contact the person if possible first to
ask) I'm not sure if a SoB from a "random git tree" indicates they
wish a mainline submission with their name (some people may want
credit and others not want to be considered responsible for bugs...).
I didn't see a submission of this version (with the gpr information
coming from the DT) on the mailing lists, only the initial version
using the platform callback that was NAKd (I may have missed it
though).

Regards,

Martin
