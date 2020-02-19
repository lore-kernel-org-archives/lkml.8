Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00E1C7619D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3180206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU1uqUYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgBSX6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:58:19 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40141 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgBSX6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 18:58:19 -0500
Received: by mail-oi1-f195.google.com with SMTP id a142so25705086oii.7;
        Wed, 19 Feb 2020 15:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BX9+oiU9NUzGK1+aV9/Uah0G+lhW9/DtCwBAHxWnn3I=;
        b=KU1uqUYVxkoQfS26YEi+ztZu7uQD6NmCYAjnD4WbMrS3FbUgBPMQxL4cToOQRD6Uov
         nHqZX7QwUxnmIRKEcKaP8NEsh/58I2e78+wWxDrpu1BXApMDiJMolk2hwg9CzqcOf9sW
         YE4tYRCZaEyh/x1674lcZY1l/H0F0ArPvwmZIxON3DfEjagSV1uN/AxJKPXKBeA241xL
         WqwyGwfYPVg0aO9XUojnJGQxro+u25NEoqXrbNR09NiA6eBYzNO4I80Q2dLPiRbdLZkb
         04tkTaqeTm6+rrMCyLbyFF+HCBtuFvxa0v0YSX5dAdbBWko9TEenvJpgjmfSY9CevQ+/
         hitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BX9+oiU9NUzGK1+aV9/Uah0G+lhW9/DtCwBAHxWnn3I=;
        b=M/VKtYr5IUMKwGD5odp0XvHvaoe8o3lESFzKYG/iV6lwy8S7p3dq+jrdlt5Ef71VT9
         yMuM7Xb683bDcg6i+VnR+pfPJfXq391UVdiZQDnjn+/MRArlIdLJeh6qErvA3983LPud
         vBcz4FDJLqP7zmqb6r6U18o05NFCtlX3MVMjxWEv+bS/8L+dvZFkvQOJgzugwOjMhA3V
         gXJxcZRcHmcozN/9D9WxHlsvo0H2Tsy8nF5Dqa0A2qftHA7KNgVPsarsX9PV0RBt/mW5
         yWF7eNPP9kEGjwWyTWqlMQtWcB3ulG3cV1AeKpX82boBIyxTjGU56HohsLBZN59iWIsd
         pA3g==
X-Gm-Message-State: APjAAAVAGhtbVde3ljRursK6Ova5VxM0tbgd8SJAuYAz++mPCDY0s0Wo
        6avAN6w5llkezO2tQg7Rin2FwtNnZ2fTi4GHEM4=
X-Google-Smtp-Source: APXvYqwRxzwlvasanDAZCzqmiAcIi+8du+kTb0XmBWuXgm+lcYoRDBqJdLFMRLpwiKeOks5taARgUtmAle4aHBvqjI0=
X-Received: by 2002:aca:ddc2:: with SMTP id u185mr185041oig.24.1582156697455;
 Wed, 19 Feb 2020 15:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20200215065826.739102-1-gch981213@gmail.com> <20200218125557.GD4232@sirena.org.uk>
In-Reply-To: <20200218125557.GD4232@sirena.org.uk>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 20 Feb 2020 07:58:06 +0800
Message-ID: <CAJsYDVL03KJv7eewGekBPCfpbOuTX0tJ6qZaydvJnBDzZ5vEwg@mail.gmail.com>
Subject: Re: [PATCH 0/2] rewrite mtk-quadspi spi-nor driver with spi-mem
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Feb 18, 2020 at 8:55 PM Mark Brown <broonie@kernel.org> wrote:
> This is an ABI break so you shouldn't be doing this, if the existing
> binding works it should continue to work.

The missing spi-max-frequency is the only part preventing old
device tree to work with this driver.
If the goal is to make existing dt binding work, I could patch dt using
of_add_property in v2. I saw similar device tree patching for legacy
bindings in pinctrl-single driver.

>
> > 3. removing the old driver. I'll create this commit after 1 and 2 are
> >    applied to avoid possible rebasing due to any changes in the old
> >    driver.
>
> This isn't great as it means we have a period with two drivers for the
> same thing in tree which is at best going to be confusing.  There's no
> advantage to splitting this out.

Got it. I'll add this patch in v2.

--
Regards,
Chuanhong Guo
